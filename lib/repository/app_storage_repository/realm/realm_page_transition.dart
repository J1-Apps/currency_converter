import "package:j1_theme/j1_theme.dart";
import "package:realm/realm.dart";
// ignore: unnecessary_import, depend_on_referenced_packages
import "package:realm_common/realm_common.dart";

part "realm_page_transition.realm.dart";

@RealmModel()
class _RealmPageTransition {
  @PrimaryKey()
  late String key;

  String pageTransition = "cupertino";
}

extension RealmPageTransitionExtensions on RealmPageTransition {
  J1PageTransition toPageTransition() {
    return switch (pageTransition.toLowerCase()) {
      "zoom" => J1PageTransition.zoom,
      _ => J1PageTransition.cupertino,
    };
  }

  static RealmPageTransition fromPageTransition(String key, J1PageTransition pageTransition) {
    return RealmPageTransition(key, pageTransition: pageTransition.name);
  }
}
