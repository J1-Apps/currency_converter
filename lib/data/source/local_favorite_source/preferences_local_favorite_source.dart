import "package:currency_converter/data/model/cc_error.dart";
import "package:currency_converter/data/model/currency.dart";
import "package:currency_converter/data/repository/defaults.dart";
import "package:currency_converter/data/source/local_favorite_source/local_favorite_source.dart";
import "package:currency_converter/data/source/util/preferences_source.dart";

const _favoritesKey = "ccFavorites";

class PreferencesLocalFavoriteSource extends PreferencesSource implements LocalFavoriteSource {
  PreferencesLocalFavoriteSource({super.preferences});

  @override
  Future<List<CurrencyCode>> getFavorites() async {
    return getItem(_favoritesKey, ErrorCode.source_local_favorite_readError, (preferences) async {
      final favoritesJson = await preferences.getStringList(_favoritesKey);

      if (favoritesJson == null || favoritesJson.isEmpty) {
        return defaultFavorites;
      }

      return favoritesJson.map(CurrencyCode.fromValue).toList();
    });
  }

  @override
  Future<void> updateFavorites(List<CurrencyCode> favorites) async {
    await saveItem(_favoritesKey, ErrorCode.source_local_favorite_writeError, (preferences) async {
      await preferences.setStringList(
        _favoritesKey,
        favorites.map((favorite) => favorite.toValue()).toList(),
      );
    });
  }
}
