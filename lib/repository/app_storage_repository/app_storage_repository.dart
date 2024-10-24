import "package:j1_theme/j1_theme.dart";

abstract class AppStorageRepository extends J1ThemeRepository {
  // Language
  Future<void> setLanguage(String languageCode);
  Stream<String> getLanguagesStream();
}
