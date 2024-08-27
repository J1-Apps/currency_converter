import "package:realm/realm.dart";
// ignore: unnecessary_import
import "package:realm_common/realm_common.dart";

part "realm_catalog.realm.dart";

@RealmModel()
class _RealmPageTransition {
  @PrimaryKey()
  late String key;

  String pageTransition = "cupertino";
}

@RealmModel()
class _RealmFavorites {
  @PrimaryKey()
  late String key;

  List<String> favorites = [];
}

@RealmModel()
class _RealmLanguage {
  @PrimaryKey()
  late String key;

  String language = "en";
}
