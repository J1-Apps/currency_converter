import "package:currency_converter/model/currency.dart";
import "package:j1_theme/j1_theme.dart";

abstract class AppStorageRepository extends J1ThemeRepository {
  // Favorites
  Future<void> setFavorite(CurrencyCode code);
  Future<void> removeFavorite(CurrencyCode code);
  Stream<List<CurrencyCode>> getFavoritesStream();

  // Language
  Future<void> setLanguage(String languageCode);
  Stream<String> getLanguagesStream();
}
