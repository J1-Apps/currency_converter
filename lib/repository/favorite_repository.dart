import "package:currency_converter/model/cc_error.dart";
import "package:currency_converter/model/currency.dart";
import "package:currency_converter/repository/data_state.dart";
import "package:currency_converter/source/local_favorite_source/local_favorite_source.dart";
import "package:j1_environment/j1_environment.dart";

class FavoriteRepository {
  final LocalFavoriteSource _localSource;
  final DataSubject<List<CurrencyCode>> _favoritesSubject;

  Stream<DataState<List<CurrencyCode>>> get favorites => _favoritesSubject.stream;

  FavoriteRepository({
    LocalFavoriteSource? localSource,
    List<CurrencyCode>? initialState,
  })  : _localSource = localSource ?? locator.get<LocalFavoriteSource>(),
        _favoritesSubject = DataSubject.initial(initialState);

  Future<void> loadFavorites() async {
    try {
      _favoritesSubject.addSuccess(await _localSource.getFavorites());
    } catch (e) {
      _favoritesSubject.addEmpty();
      _favoritesSubject.addErrorEvent(CcError.fromObject(e));
    }
  }

  Future<void> addFavorite(CurrencyCode favorite) async {
    final dataValue = _favoritesSubject.dataValue;
    final favorites = dataValue == null ? null : [...dataValue];

    if (favorites == null) {
      return;
    }

    favorites.add(favorite);
    _favoritesSubject.addSuccess(favorites);

    try {
      await _localSource.updateFavorites(favorites);
    } catch (e) {
      _favoritesSubject.addErrorEvent(CcError.fromObject(e));
    }
  }

  Future<void> removeFavorite(CurrencyCode favorite) async {
    final dataValue = _favoritesSubject.dataValue;
    final favorites = dataValue == null ? null : [...dataValue];

    if (favorites == null) {
      return;
    }

    favorites.remove(favorite);
    _favoritesSubject.addSuccess(favorites);

    try {
      await _localSource.updateFavorites(favorites);
    } catch (e) {
      _favoritesSubject.addErrorEvent(CcError.fromObject(e));
    }
  }

  void dispose() {
    _favoritesSubject.dispose();
  }
}
