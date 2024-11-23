import "package:currency_converter/data/model/cc_error.dart";
import "package:currency_converter/data/repository/data_state.dart";
import "package:currency_converter/data/repository/language_repository.dart";
import "package:currency_converter/state/settings/settings_bloc.dart";
import "package:currency_converter/state/settings/settings_event.dart";
import "package:currency_converter/state/settings/settings_state.dart";
import "package:currency_converter/util/analytics.dart";
import "package:flutter_test/flutter_test.dart";
import "package:j1_environment/j1_environment.dart";
import "package:j1_logger/j1_logger.dart";
import "package:mocktail/mocktail.dart";
import "package:rxdart/subjects.dart";

import "../../testing_utils.dart";
import "../../testing_values.dart";

void main() {
  final language = MockLanguageRepository();
  final logger = MockLogger();

  setUpAll(() {
    locator.registerSingleton<LanguageRepository>(language);
    locator.registerSingleton<J1Logger>(logger);
  });

  setUp(() {
    when(() => language.languageStream).thenAnswer((_) => Stream.value(const DataSuccess(testLanguage0)));
    when(language.loadLanguage).thenAnswer((_) => Future.value());
    when(() => language.updateLanguage(any())).thenAnswer((_) => Future.value());

    when(() => logger.logBloc(name: any(named: "name"), bloc: any(named: "bloc"))).thenAnswer((_) => Future.value());
  });

  tearDown(() {
    reset(language);
    reset(logger);
  });

  tearDownAll(() async {
    await locator.reset();
  });

  group("Settings Bloc", () {
    test("loads initial language", () async {
      final bloc = SettingsBloc();
      expect(
        bloc.stream,
        emitsInOrder(
          [
            const SettingsState.loading(),
            const SettingsState.loaded(language: testLanguage0),
          ],
        ),
      );

      bloc.add(const SettingsLoadEvent());
      await waitMs();

      bloc.close();
    });

    test("handles load language error", () async {
      final languageController = BehaviorSubject<DataState<String>>.seeded(const DataSuccess(testLanguage0));

      when(() => language.languageStream).thenAnswer((_) => languageController.stream);

      final bloc = SettingsBloc();
      expect(
        bloc.stream,
        emitsInOrder(
          [
            const SettingsState.loading(),
            const SettingsState.loaded(language: testLanguage0),
            const SettingsState.loaded(language: testLanguage0, error: SettingsErrorCode.loadLanguage),
          ],
        ),
      );

      bloc.add(const SettingsLoadEvent());
      await waitMs();

      languageController.addError(const CcError(ErrorCode.source_local_language_readError));
      await waitMs();

      verify(
        () => logger.logBloc(name: Analytics.errorEvent, bloc: Analytics.settingsBloc, params: any(named: "params")),
      ).called(1);

      bloc.close();
      languageController.close();
    });

    test("updates language", () async {
      final languageController = BehaviorSubject<DataState<String>>.seeded(const DataSuccess(testLanguage0));

      when(() => language.languageStream).thenAnswer((_) => languageController.stream);

      final bloc = SettingsBloc();
      expect(
        bloc.stream,
        emitsInOrder(
          [
            const SettingsState.loading(),
            const SettingsState.loaded(language: testLanguage0),
            const SettingsState.loaded(language: testLanguage1),
          ],
        ),
      );

      bloc.add(const SettingsLoadEvent());
      await waitMs();

      when(() => language.updateLanguage(testLanguage1)).thenAnswer((_) => Future.value());

      bloc.add(const SettingsUpdateLanguageEvent(testLanguage1));
      languageController.add(const DataSuccess(testLanguage1));
      await waitMs();

      bloc.close();
      languageController.close();
    });

    test("updates language and handles save error", () async {
      final languageController = BehaviorSubject<DataState<String>>.seeded(const DataSuccess(testLanguage0));

      when(() => language.languageStream).thenAnswer((_) => languageController.stream);

      final bloc = SettingsBloc();
      expect(
        bloc.stream,
        emitsInOrder(
          [
            const SettingsState.loading(),
            const SettingsState.loaded(language: testLanguage0),
            const SettingsState.loaded(language: testLanguage0, error: SettingsErrorCode.saveLanguage),
            const SettingsState.loaded(language: testLanguage1),
          ],
        ),
      );

      bloc.add(const SettingsLoadEvent());
      await waitMs();

      when(() => language.updateLanguage(testLanguage1)).thenThrow(
        const CcError(ErrorCode.source_local_language_writeError),
      );

      bloc.add(const SettingsUpdateLanguageEvent(testLanguage1));
      languageController.add(const DataSuccess(testLanguage1));
      await waitMs();

      verify(
        () => logger.logBloc(name: Analytics.errorEvent, bloc: Analytics.settingsBloc, params: any(named: "params")),
      ).called(1);

      bloc.close();
      languageController.close();
    });
  });
}
