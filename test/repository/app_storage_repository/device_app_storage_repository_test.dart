import "package:currency_converter/model/currency.dart";
import "package:currency_converter/repository/app_storage_repository/device_app_storage_repository.dart";
import "package:currency_converter/repository/app_storage_repository/realm/realm_color_scheme.dart";
import "package:currency_converter/repository/app_storage_repository/realm/realm_favorites.dart";
import "package:currency_converter/repository/app_storage_repository/realm/realm_language.dart";
import "package:currency_converter/repository/app_storage_repository/realm/realm_page_transition.dart";
import "package:currency_converter/repository/app_storage_repository/realm/realm_text_theme.dart";
import "package:currency_converter/ui/theme/color_schemes.dart";
import "package:currency_converter/ui/theme/text_themes.dart";
import "package:flutter/material.dart";
import "package:flutter_test/flutter_test.dart";
import "package:j1_theme/j1_theme.dart";
import "package:realm/realm.dart";

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

void main() {
  group("Device App Storage Repository", () {
    late Realm realm;

    setUp(() {
      realm = Realm(Configuration.inMemory([
        RealmColorScheme.schema,
        RealmTextTheme.schema,
        RealmTextStyle.schema,
        RealmPageTransition.schema,
        RealmFavorites.schema,
        RealmLanguage.schema,
      ]));
    });

    tearDown(() {
      realm.close();
    });

    test("gets and sets theme data", () async {
      final repository = DeviceAppStorageRepository(realm: realm);

      expect(repository.getColorStream(), emitsInOrder([defaultColorScheme, _testColorScheme]));
      expect(repository.getTextStream(), emitsInOrder([defaultTextTheme, _testTextTheme]));
      expect(repository.getTransitionStream(), emitsInOrder([J1PageTransition.cupertino, J1PageTransition.zoom]));

      await repository.setColorScheme(_testColorScheme);
      await repository.setTextTheme(_testTextTheme);
      await repository.setPageTransition(J1PageTransition.zoom);

      repository.dispose();
    });

    test("gets and sets favorites", () async {
      final repository = DeviceAppStorageRepository(realm: realm);

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

      await repository.setFavorite(CurrencyCode.USD);
      await repository.setFavorite(CurrencyCode.EUR);
      await repository.setFavorite(CurrencyCode.GBP);

      await repository.removeFavorite(CurrencyCode.GBP);
      await repository.removeFavorite(CurrencyCode.EUR);
      await repository.removeFavorite(CurrencyCode.USD);

      repository.dispose();
    });

    test("gets and sets language", () async {
      final repository = DeviceAppStorageRepository(realm: realm);

      expect(repository.getLanguagesStream(), emitsInOrder(["en", "ko"]));
      await repository.setLanguage("ko");

      repository.dispose();
    });
  });
}
