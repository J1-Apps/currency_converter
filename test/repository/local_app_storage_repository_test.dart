import "package:currency_converter/models/currency.dart";
import "package:currency_converter/repository/app_storage_repository/local_app_storage_repository.dart";
import "package:currency_converter/ui/themes/color_schemes.dart";
import "package:currency_converter/ui/themes/text_themes.dart";
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
            ["USD"],
            ["USD", "EUR"],
            ["USD", "EUR", "GBP"],
            ["USD", "EUR"],
            ["USD"],
            [],
          ],
        ),
      );

      await repository.setFavorite(CurrencyCode.USD.name);
      await repository.setFavorite(CurrencyCode.EUR.name);
      await repository.setFavorite(CurrencyCode.GBP.name);

      await Future.delayed(const Duration(milliseconds: 1));
      repository.removeFavorite(CurrencyCode.GBP.name);
      await Future.delayed(const Duration(milliseconds: 1));
      repository.removeFavorite(CurrencyCode.EUR.name);
      await Future.delayed(const Duration(milliseconds: 1));
      repository.removeFavorite(CurrencyCode.USD.name);

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
