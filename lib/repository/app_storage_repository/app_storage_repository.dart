import "package:j1_theme/j1_theme.dart";

abstract class AppStorageRepository extends J1ThemeRepository {
  // Favorites
  Future<void> setFavorite(String code);
  Future<void> removeFavorite(String code);
  Stream<List<String>> getFavoritesStream();

  // Language
  Future<void> setLanguage(String languageCode);
  Stream<String> getLanguagesStream();
}
