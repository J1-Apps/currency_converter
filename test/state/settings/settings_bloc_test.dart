import "package:currency_converter/model/configuration.dart";
import "package:currency_converter/model/currency.dart";
import "package:currency_converter/repository/app_storage_repository/app_storage_repository.dart";
import "package:currency_converter/repository/app_storage_repository/defaults.dart";
import "package:currency_converter/repository/app_storage_repository/local_app_storage_repository.dart";
import "package:currency_converter/state/settings/settings_bloc.dart";
import "package:currency_converter/state/settings/settings_event.dart";
import "package:currency_converter/state/settings/settings_state.dart";
import "package:currency_converter/model/cc_error.dart";
import "package:flutter_test/flutter_test.dart";
import "package:j1_environment/j1_environment.dart";

const _testConfig = Configuration(
  "test config",
  1.0,
  CurrencyCode.USD,
  [CurrencyCode.KRW, CurrencyCode.EUR],
);

const _saveError = CcError(ErrorCode.source_appStorage_writeError);

void main() {
  final appStorage = LocalAppStorageRepository();

  setUpAll(() {
    locator.registerSingleton<AppStorageRepository>(appStorage);
  });

  tearDown(appStorage.reset);

  tearDownAll(() async {
    await locator.reset();
  });

  group("Settings Bloc", () {
    test("toggles favorites", () async {
      final bloc = SettingsBloc();

      bloc.add(const SettingsToggleFavoriteEvent(CurrencyCode.USD));

      final added0 = await bloc.stream.first;
      expect(added0, const SettingsState([CurrencyCode.USD], [], "en", null));

      bloc.add(const SettingsToggleFavoriteEvent(CurrencyCode.EUR));

      final added1 = await bloc.stream.first;
      expect(added1, const SettingsState([CurrencyCode.USD, CurrencyCode.EUR], [], "en", null));

      bloc.add(const SettingsToggleFavoriteEvent(CurrencyCode.USD));

      final removed = await bloc.stream.first;
      expect(removed, const SettingsState([CurrencyCode.EUR], [], "en", null));

      bloc.close();
    });

    test("handles toggle favorite error", () async {
      appStorage.shouldThrow = true;

      final bloc = SettingsBloc();

      bloc.add(const SettingsToggleFavoriteEvent(CurrencyCode.USD));

      final error = await bloc.stream.first;
      expect(error, const SettingsState([], [], "en", _saveError));

      bloc.close();
    });

    test("updates configurations", () async {
      final bloc = SettingsBloc();

      bloc.add(const SettingsSaveConfigurationEvent(defaultConfiguration));

      final added0 = await bloc.stream.first;
      expect(added0, const SettingsState([], [defaultConfiguration], "en", null));

      bloc.add(const SettingsSaveConfigurationEvent(_testConfig));

      final added1 = await bloc.stream.first;
      expect(added1, const SettingsState([], [defaultConfiguration, _testConfig], "en", null));

      bloc.add(const SettingsRemoveConfigurationEvent(defaultConfiguration));

      final removed = await bloc.stream.first;
      expect(removed, const SettingsState([], [_testConfig], "en", null));

      bloc.close();
    });

    test("handles save configuration error", () async {
      appStorage.shouldThrow = true;

      final bloc = SettingsBloc();

      bloc.add(const SettingsSaveConfigurationEvent(defaultConfiguration));

      final error = await bloc.stream.first;
      expect(error, const SettingsState([], [], "en", _saveError));

      bloc.close();
    });

    test("handles remove configuration error", () async {
      final bloc = SettingsBloc();

      bloc.add(const SettingsSaveConfigurationEvent(defaultConfiguration));

      final added = await bloc.stream.first;
      expect(added, const SettingsState([], [defaultConfiguration], "en", null));

      appStorage.shouldThrow = true;

      bloc.add(const SettingsRemoveConfigurationEvent(defaultConfiguration));

      final error = await bloc.stream.first;
      expect(error, const SettingsState([], [defaultConfiguration], "en", _saveError));

      bloc.close();
    });

    test("handles toggle favorite error", () async {
      appStorage.shouldThrow = true;

      final bloc = SettingsBloc();

      bloc.add(const SettingsToggleFavoriteEvent(CurrencyCode.USD));

      final error = await bloc.stream.first;
      expect(error, const SettingsState([], [], "en", _saveError));

      bloc.close();
    });

    test("updates language", () async {
      final bloc = SettingsBloc();

      bloc.add(const SettingsUpdateLanguageEvent("ko"));

      final updated0 = await bloc.stream.first;
      expect(updated0, const SettingsState([], [], "ko", null));

      bloc.add(const SettingsUpdateLanguageEvent("en"));

      final updated1 = await bloc.stream.first;
      expect(updated1, const SettingsState([], [], "en", null));

      bloc.close();
    });

    test("handles update language error", () async {
      appStorage.shouldThrow = true;

      final bloc = SettingsBloc();

      bloc.add(const SettingsUpdateLanguageEvent("ko"));

      final updated0 = await bloc.stream.first;
      expect(updated0, const SettingsState([], [], "en", _saveError));

      bloc.close();
    });
  });
}
