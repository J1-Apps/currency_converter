import "package:currency_converter/model/currency.dart";
import "package:currency_converter/source/local_favorite_source/local_favorite_source.dart";
import "package:j1_environment/j1_environment.dart";

class FavoriteRepository {
  final LocalFavoriteSource _localSource;

  FavoriteRepository({LocalFavoriteSource? localSource})
      : _localSource = localSource ?? locator.get<LocalFavoriteSource>();

  Future<List<CurrencyCode>> getFavorites() {
    return _localSource.getFavorites();
  }

  Future<void> updateFavorites(List<CurrencyCode> favorites) async {
    await _localSource.updateFavorites(favorites);
  }
}
