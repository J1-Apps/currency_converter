import "package:currency_converter/data/model/cc_error.dart";
import "package:currency_converter/data/repository/defaults.dart";
import "package:currency_converter/data/source/local_language_source/local_language_source.dart";
import "package:currency_converter/data/source/util/preferences_source.dart";

const _languageKey = "ccLanguage";

class PreferencesLocalLanguageSource extends PreferencesSource implements LocalLanguageSource {
  PreferencesLocalLanguageSource({super.preferences});

  @override
  Future<String> getLanguage() {
    return getItem(_languageKey, ErrorCode.source_local_language_readError, (preferences) async {
      final languageJson = await preferences.getString(_languageKey);

      if (languageJson == null || languageJson.isEmpty) {
        return defaultLanguage;
      }

      return languageJson;
    });
  }

  @override
  Future<void> updateLanguage(String language) async {
    await saveItem(_languageKey, ErrorCode.source_local_language_writeError, (preferences) async {
      await preferences.setString(_languageKey, language);
    });
  }
}
