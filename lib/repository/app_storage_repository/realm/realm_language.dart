import "package:realm/realm.dart";
// ignore: unnecessary_import, depend_on_referenced_packages
import "package:realm_common/realm_common.dart";

part "realm_language.realm.dart";

@RealmModel()
class _RealmLanguage {
  @PrimaryKey()
  late String key;

  String language = "en";
}

extension RealmLanguageExtensions on RealmLanguage {
  String toLanguage() {
    return language;
  }

  static RealmLanguage fromLanguage(String key, String language) {
    return RealmLanguage(key, language: language);
  }
}
