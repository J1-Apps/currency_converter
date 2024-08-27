import "package:currency_converter/models/currency.dart";
import "package:realm/realm.dart";
// ignore: unnecessary_import, depend_on_referenced_packages
import "package:realm_common/realm_common.dart";

part "realm_favorites.realm.dart";

@RealmModel()
class _RealmFavorites {
  @PrimaryKey()
  late String key;

  List<String> favorites = [];
}

extension RealmFavoritesExtensions on RealmFavorites {
  List<CurrencyCode> toFavorites() {
    return favorites.map(CurrencyCode.fromCode).toList();
  }

  static RealmFavorites fromFavorites(String key, List<CurrencyCode> favorites) {
    return RealmFavorites(key, favorites: favorites.map((favorite) => favorite.name));
  }
}
