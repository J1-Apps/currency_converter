import "package:currency_converter/models/currency.dart";
import "package:currency_converter/repository/app_storage_repository/local_app_storage_repository.dart";
import "package:currency_converter/ui/themes/color_schemes.dart";
import "package:currency_converter/ui/themes/text_themes.dart";
import "package:flutter_test/flutter_test.dart";
import "package:j1_theme/models/j1_page_transition.dart";

void main() {
  group("Local App Storage Repository", () {
    test("gets and sets theme data", () async {
      final repository = LocalAppStorageRepository();

      expect(repository.getColorStream(), emits(defaultColorScheme));
      expect(repository.getTextStream(), emits(defaultTextTheme));
      expect(repository.getTransitionStream(), emits(J1PageTransition.zoom));

      await repository.setColorScheme(defaultColorScheme);
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

      expect(repository.getLanguagesStream(), emits("ko"));
      await repository.setLanguage("ko");

      repository.dispose();
    });
  });
}
