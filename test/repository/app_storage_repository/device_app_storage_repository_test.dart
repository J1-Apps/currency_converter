import "package:currency_converter/model/configuration.dart";
import "package:currency_converter/model/currency.dart";
import "package:currency_converter/repository/app_storage_repository/defaults.dart";
import "package:currency_converter/repository/app_storage_repository/device_app_storage_repository.dart";
import "package:currency_converter/util/errors/cc_error.dart";
import "package:flutter/material.dart";
import "package:flutter_test/flutter_test.dart";
import "package:j1_theme/j1_theme.dart";
import "package:mocktail/mocktail.dart";

import "../../testing_utils.dart";

final _testColorScheme = defaultColorScheme.copyWith(
  brightness: J1Brightness.dark,
  primary: Colors.black.value,
  onPrimary: Colors.black.value,
  secondary: Colors.black.value,
  onSecondary: Colors.black.value,
  tertiary: Colors.black.value,
  onTertiary: Colors.black.value,
  error: Colors.black.value,
  onError: Colors.black.value,
  surface: Colors.black.value,
  onSurface: Colors.black.value,
  background: Colors.black.value,
);

final _testTextTheme = defaultTextTheme.copyWith(
  displayLarge: const J1TextStyle.displayLarge(fontFamily: "test"),
  displayMedium: const J1TextStyle.displayMedium(fontFamily: "test"),
  displaySmall: const J1TextStyle.displaySmall(fontFamily: "test"),
  headlineLarge: const J1TextStyle.headlineLarge(fontFamily: "test"),
  headlineMedium: const J1TextStyle.headlineMedium(fontFamily: "test"),
  headlineSmall: const J1TextStyle.headlineSmall(fontFamily: "test"),
  titleLarge: const J1TextStyle.titleLarge(fontFamily: "test"),
  titleMedium: const J1TextStyle.titleMedium(fontFamily: "test"),
  titleSmall: const J1TextStyle.titleSmall(fontFamily: "test"),
  bodyLarge: const J1TextStyle.bodyLarge(fontFamily: "test"),
  bodyMedium: const J1TextStyle.bodyMedium(fontFamily: "test"),
  bodySmall: const J1TextStyle.bodySmall(fontFamily: "test"),
  labelLarge: const J1TextStyle.labelLarge(fontFamily: "test"),
  labelMedium: const J1TextStyle.labelMedium(fontFamily: "test"),
  labelSmall: const J1TextStyle.labelSmall(fontFamily: "test"),
);

const _config0 = Configuration(
  "test 0",
  1.0,
  CurrencyCode.USD,
  [CurrencyCode.EUR, CurrencyCode.KRW],
);

const _config1 = Configuration(
  "test 1",
  2.0,
  CurrencyCode.KRW,
  [CurrencyCode.EUR, CurrencyCode.USD],
);

void main() {
  group("Device App Storage Repository", () {
    final preferences = MockSharedPreferences();

    tearDown(() {
      reset(preferences);
    });

    test("seeds data", () async {
      when(() => preferences.getString("ccColorScheme")).thenAnswer((_) => Future.value(_testColorScheme.toJson()));
      when(() => preferences.getString("ccTextTheme")).thenAnswer((_) => Future.value(_testTextTheme.toJson()));
      when(() => preferences.getString("ccPageTransition")).thenAnswer(
        (_) => Future.value(J1PageTransition.zoom.toValue()),
      );
      when(() => preferences.getStringList("ccFavorites")).thenAnswer(
        (_) => Future.value([CurrencyCode.USD.toValue()]),
      );
      when(() => preferences.getStringList("ccConfigurations")).thenAnswer(
        (_) => Future.value([_config0.toJson()]),
      );
      when(() => preferences.getString("ccLanguage")).thenAnswer(
        (_) => Future.value("ko"),
      );

      final repository = DeviceAppStorageRepository(preferences: preferences);

      expect(repository.getColorStream(), emitsInOrder([defaultColorScheme, _testColorScheme]));
      expect(repository.getTextStream(), emitsInOrder([defaultTextTheme, _testTextTheme]));
      expect(repository.getTransitionStream(), emitsInOrder([J1PageTransition.cupertino, J1PageTransition.zoom]));
      expect(
        repository.getFavoritesStream(),
        emitsInOrder(
          [
            [],
            [CurrencyCode.USD],
          ],
        ),
      );
      expect(
        repository.getConfigurationsStream(),
        emitsInOrder(
          [
            [],
            [_config0],
          ],
        ),
      );
      expect(repository.getLanguagesStream(), emitsInOrder(["en", "ko"]));

      await waitMs();

      repository.dispose();
    });

    test("handles seeding errors", () async {
      when(() => preferences.getString("ccColorScheme")).thenThrow(StateError("test color scheme error"));
      when(() => preferences.getString("ccTextTheme")).thenThrow(StateError("test text theme error"));
      when(() => preferences.getString("ccPageTransition")).thenThrow(StateError("test page transition error"));
      when(() => preferences.getStringList("ccFavorites")).thenThrow(StateError("test favorites error"));
      when(() => preferences.getStringList("ccConfigurations")).thenThrow(StateError("test configurations error"));
      when(() => preferences.getString("ccLanguage")).thenThrow(StateError("test language error"));

      final repository = DeviceAppStorageRepository(preferences: preferences);

      expect(repository.getColorStream(), emitsInOrder([defaultColorScheme]));
      expect(repository.getTextStream(), emitsInOrder([defaultTextTheme]));
      expect(repository.getTransitionStream(), emitsInOrder([J1PageTransition.cupertino]));
      expect(repository.getFavoritesStream(), emitsInOrder([[]]));
      expect(repository.getConfigurationsStream(), emitsInOrder([[]]));
      expect(repository.getLanguagesStream(), emitsInOrder(["en"]));

      await waitMs();

      repository.dispose();
    });

    test("handles saving errors", () async {
      when(() => preferences.getString(any())).thenAnswer((_) => Future.value());
      when(() => preferences.getStringList(any())).thenAnswer((_) => Future.value());
      when(() => preferences.setString(any(), any())).thenAnswer((_) => Future.value());
      when(() => preferences.setStringList(any(), any())).thenAnswer((_) => Future.value());
      when(() => preferences.setString("ccColorScheme", any())).thenThrow(StateError("test color scheme error"));
      when(() => preferences.setStringList("ccFavorites", any())).thenThrow(StateError("test favorites error"));

      final repository = DeviceAppStorageRepository(preferences: preferences);

      expect(repository.getColorStream(), emitsInOrder([defaultColorScheme]));
      expect(repository.getFavoritesStream(), emitsInOrder([[]]));

      await waitMs();

      expect(
        () => repository.setColorScheme(_testColorScheme),
        throwsA(HasErrorCode(ErrorCode.repository_appStorage_savingError)),
      );

      expect(
        () => repository.setFavorite(CurrencyCode.USD),
        throwsA(HasErrorCode(ErrorCode.repository_appStorage_savingError)),
      );

      repository.dispose();
    });

    test("gets and sets theme data", () async {
      when(() => preferences.getString(any())).thenAnswer((_) => Future.value());
      when(() => preferences.getStringList(any())).thenAnswer((_) => Future.value());
      when(() => preferences.setString(any(), any())).thenAnswer((_) => Future.value());
      when(() => preferences.setStringList(any(), any())).thenAnswer((_) => Future.value());

      final repository = DeviceAppStorageRepository(preferences: preferences);

      expect(repository.getColorStream(), emitsInOrder([defaultColorScheme, _testColorScheme]));
      expect(repository.getTextStream(), emitsInOrder([defaultTextTheme, _testTextTheme]));
      expect(repository.getTransitionStream(), emitsInOrder([J1PageTransition.cupertino, J1PageTransition.zoom]));

      await waitMs();

      await repository.setColorScheme(_testColorScheme);
      await repository.setTextTheme(_testTextTheme);
      await repository.setPageTransition(J1PageTransition.zoom);

      repository.dispose();
    });

    test("gets and sets favorites", () async {
      when(() => preferences.getString(any())).thenAnswer((_) => Future.value());
      when(() => preferences.getStringList(any())).thenAnswer((_) => Future.value());
      when(() => preferences.setString(any(), any())).thenAnswer((_) => Future.value());
      when(() => preferences.setStringList(any(), any())).thenAnswer((_) => Future.value());

      final repository = DeviceAppStorageRepository(preferences: preferences);

      expect(
        repository.getFavoritesStream(),
        emitsInOrder(
          [
            [],
            [CurrencyCode.USD],
            [CurrencyCode.USD, CurrencyCode.EUR],
            [CurrencyCode.USD, CurrencyCode.EUR, CurrencyCode.GBP],
            [CurrencyCode.USD, CurrencyCode.EUR],
            [CurrencyCode.USD],
            [],
          ],
        ),
      );

      await waitMs();

      await repository.setFavorite(CurrencyCode.USD);
      await repository.setFavorite(CurrencyCode.EUR);
      await repository.setFavorite(CurrencyCode.GBP);

      await waitMs();
      await repository.removeFavorite(CurrencyCode.GBP);
      await waitMs();
      await repository.removeFavorite(CurrencyCode.EUR);
      await waitMs();
      await repository.removeFavorite(CurrencyCode.USD);

      repository.dispose();
    });

    test("doesn't save favorites if not seeded", () async {
      when(() => preferences.getString(any())).thenAnswer((_) => Future.value());
      when(() => preferences.getStringList(any())).thenAnswer((_) => Future.value());
      when(() => preferences.setString(any(), any())).thenAnswer((_) => Future.value());
      when(() => preferences.setStringList(any(), any())).thenAnswer((_) => Future.value());

      when(() => preferences.getStringList("ccFavorites")).thenThrow(StateError("test favorites error"));

      final repository = DeviceAppStorageRepository(preferences: preferences);

      expect(repository.getFavoritesStream(), emitsInOrder([[]]));

      await waitMs();

      expect(
        () async => repository.setFavorite(CurrencyCode.USD),
        throwsA(HasErrorCode(ErrorCode.repository_appStorage_seedingError)),
      );

      repository.dispose();
    });

    test("gets and updates current configuration", () async {
      when(() => preferences.getString(any())).thenAnswer((_) => Future.value());
      when(() => preferences.getStringList(any())).thenAnswer((_) => Future.value());
      when(() => preferences.setString(any(), any())).thenAnswer((_) => Future.value());
      when(() => preferences.setStringList(any(), any())).thenAnswer((_) => Future.value());

      final repository = DeviceAppStorageRepository(preferences: preferences);

      when(() => preferences.getString("ccCurrentConfiguration")).thenAnswer((_) => Future.value());

      final initialConfig = await repository.getCurrentConfiguration();
      expect(initialConfig, null);

      when(() => preferences.getString("ccCurrentConfiguration")).thenAnswer((_) => Future.value(_config0.toJson()));

      await repository.updateCurrentConfiguration(_config0);
      verify(() => preferences.setString("ccCurrentConfiguration", _config0.toJson())).called(1);

      final config0 = await repository.getCurrentConfiguration();
      expect(config0, _config0);

      when(() => preferences.getString("ccCurrentConfiguration")).thenAnswer((_) => Future.value(_config1.toJson()));

      await repository.updateCurrentConfiguration(_config1);
      verify(() => preferences.setString("ccCurrentConfiguration", _config1.toJson())).called(1);

      final config1 = await repository.getCurrentConfiguration();
      expect(config1, _config1);

      repository.dispose();
    });

    test("handles get configuration error", () async {
      when(() => preferences.getString(any())).thenAnswer((_) => Future.value());
      when(() => preferences.getStringList(any())).thenAnswer((_) => Future.value());
      when(() => preferences.setString(any(), any())).thenAnswer((_) => Future.value());
      when(() => preferences.setStringList(any(), any())).thenAnswer((_) => Future.value());

      when(() => preferences.getString("ccCurrentConfiguration")).thenThrow(StateError("test error"));

      final repository = DeviceAppStorageRepository(preferences: preferences);

      expect(
        () async => repository.getCurrentConfiguration(),
        throwsA(HasErrorCode(ErrorCode.repository_appStorage_getConfigurationError)),
      );

      repository.dispose();
    });

    test("gets and sets configurations", () async {
      when(() => preferences.getString(any())).thenAnswer((_) => Future.value());
      when(() => preferences.getStringList(any())).thenAnswer((_) => Future.value());
      when(() => preferences.setString(any(), any())).thenAnswer((_) => Future.value());
      when(() => preferences.setStringList(any(), any())).thenAnswer((_) => Future.value());

      final repository = DeviceAppStorageRepository(preferences: preferences);

      expect(
        repository.getConfigurationsStream(),
        emitsInOrder(
          [
            [],
            [_config0],
            [_config0, _config1],
            [_config1],
            [],
          ],
        ),
      );

      await waitMs();

      await repository.saveConfiguration(_config0);
      await repository.saveConfiguration(_config1);

      await waitMs();
      await repository.removeConfiguration(_config0);
      await waitMs();
      await repository.removeConfiguration(_config1);

      repository.dispose();
    });

    test("doesn't save configurations if not seeded", () async {
      when(() => preferences.getString(any())).thenAnswer((_) => Future.value());
      when(() => preferences.getStringList(any())).thenAnswer((_) => Future.value());
      when(() => preferences.setString(any(), any())).thenAnswer((_) => Future.value());
      when(() => preferences.setStringList(any(), any())).thenAnswer((_) => Future.value());

      when(() => preferences.getStringList("ccConfigurations")).thenThrow(StateError("test configurations error"));

      final repository = DeviceAppStorageRepository(preferences: preferences);

      expect(repository.getConfigurationsStream(), emitsInOrder([[]]));

      await waitMs();

      expect(
        () async => repository.saveConfiguration(_config0),
        throwsA(HasErrorCode(ErrorCode.repository_appStorage_seedingError)),
      );

      repository.dispose();
    });

    test("gets and sets language", () async {
      when(() => preferences.getString(any())).thenAnswer((_) => Future.value());
      when(() => preferences.getStringList(any())).thenAnswer((_) => Future.value());
      when(() => preferences.setString(any(), any())).thenAnswer((_) => Future.value());
      when(() => preferences.setStringList(any(), any())).thenAnswer((_) => Future.value());

      final repository = DeviceAppStorageRepository(preferences: preferences);

      expect(repository.getLanguagesStream(), emitsInOrder(["en", "ko"]));

      await waitMs();

      await repository.setLanguage("ko");

      repository.dispose();
    });
  });
}
