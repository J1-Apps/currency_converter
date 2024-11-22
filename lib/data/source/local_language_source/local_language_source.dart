abstract class LocalLanguageSource {
  Future<String> getLanguage();
  Future<void> updateLanguage(String language);
}
