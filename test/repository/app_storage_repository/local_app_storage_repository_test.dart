import "package:currency_converter/model/currency.dart";
import "package:currency_converter/repository/app_storage_repository/local_app_storage_repository.dart";
import "package:currency_converter/ui/theme/color_schemes.dart";
import "package:currency_converter/ui/theme/text_themes.dart";
import "package:flutter/material.dart";
import "package:flutter_test/flutter_test.dart";
import "package:j1_theme/models/j1_page_transition.dart";

final _testColorScheme = defaultColorScheme.copyWith(primary: Colors.black.value);

void main() {
  group("Local App Storage Repository", () {
    test("gets and sets theme data", () async {
      final repository = LocalAppStorageRepository();

      expect(repository.getColorStream(), emitsInOrder([defaultColorScheme, _testColorScheme]));
      expect(repository.getTextStream(), emitsInOrder([defaultTextTheme]));
      expect(repository.getTransitionStream(), emitsInOrder([J1PageTransition.cupertino, J1PageTransition.zoom]));

      await repository.setColorScheme(_testColorScheme);
      await repository.setTextTheme(defaultTextTheme);
      await repository.setPageTransition(J1PageTransition.zoom);

      repository.dispose();
    });

    test("gets and sets favorites", () async {
      final repository = LocalAppStorageRepository();

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

      await Future.delayed(const Duration(milliseconds: 1));
      await repository.removeFavorite(CurrencyCode.GBP);
      await Future.delayed(const Duration(milliseconds: 1));
      await repository.removeFavorite(CurrencyCode.EUR);
      await Future.delayed(const Duration(milliseconds: 1));
      await repository.removeFavorite(CurrencyCode.USD);

      repository.dispose();
    });

    test("gets and sets language", () async {
      final repository = LocalAppStorageRepository();

      expect(repository.getLanguagesStream(), emitsInOrder(["en", "ko"]));
      await repository.setLanguage("ko");

      repository.dispose();
    });
  });
}
