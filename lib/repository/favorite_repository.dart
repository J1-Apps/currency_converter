import "package:currency_converter/model/currency.dart";
import "package:currency_converter/repository/app_storage_repository/defaults.dart";
import "package:currency_converter/source/local_favorite_source/local_favorite_source.dart";
import "package:j1_environment/j1_environment.dart";
import "package:rxdart/subjects.dart";

class FavoriteRepository {
  final LocalFavoriteSource _localSource;
  final BehaviorSubject<List<CurrencyCode>?> _favoritesSubject;

  FavoriteRepository({
    LocalFavoriteSource? localSource,
    List<CurrencyCode>? initialState,
  })  : _localSource = localSource ?? locator.get<LocalFavoriteSource>(),
        _favoritesSubject = BehaviorSubject.seeded(initialState);

  Stream<List<CurrencyCode>?> getFavoritesStream() {
    return _favoritesSubject.stream;
  }

  Future<void> loadFavorites() async {
    _favoritesSubject.add(await _localSource.getFavorites());
  }

  Future<void> addFavorite(CurrencyCode favorite) async {
    final favorites = [..._favoritesSubject.value ?? defaultFavorites];
    favorites.add(favorite);
    _favoritesSubject.add(favorites);
    await _localSource.updateFavorites(favorites);
  }

  Future<void> removeFavorite(CurrencyCode favorite) async {
    final favorites = [..._favoritesSubject.value ?? defaultFavorites];
    favorites.remove(favorite);
    _favoritesSubject.add(favorites);
    await _localSource.updateFavorites(favorites);
  }

  void dispose() {
    _favoritesSubject.close();
  }
}
