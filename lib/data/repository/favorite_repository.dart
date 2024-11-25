import "package:currency_converter/data/model/cc_error.dart";
import "package:currency_converter/data/model/currency.dart";
import "package:currency_converter/data/repository/data_state.dart";
import "package:currency_converter/data/source/local_favorite_source/local_favorite_source.dart";
import "package:j1_environment/j1_environment.dart";

class FavoriteRepository {
  final LocalFavoriteSource _localSource;
  final DataSubject<List<CurrencyCode>> _favoritesSubject;

  Stream<DataState<List<CurrencyCode>>> get favoritesStream => _favoritesSubject.stream;

  FavoriteRepository({
    LocalFavoriteSource? localSource,
    List<CurrencyCode>? initialState,
  })  : _localSource = localSource ?? locator.get<LocalFavoriteSource>(),
        _favoritesSubject = DataSubject.initial(initialState);

  Future<void> loadFavorites({bool forceRefresh = false}) async {
    if (_favoritesSubject.value is DataSuccess<List<CurrencyCode>> && !forceRefresh) {
      return;
    }

    try {
      _favoritesSubject.addSuccess(await _localSource.getFavorites());
    } catch (e) {
      _favoritesSubject.addEmpty();
      _favoritesSubject.addErrorEvent(CcError.fromObject(e));
    }
  }

  Future<void> addFavorite(CurrencyCode favorite) async {
    final dataValue = _favoritesSubject.dataValue;

    if (dataValue == null) {
      _favoritesSubject.addErrorEvent(const CcError(ErrorCode.repository_favorite_notSeededError));
      return;
    }

    final favorites = [...dataValue];
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

    if (dataValue == null) {
      _favoritesSubject.addErrorEvent(const CcError(ErrorCode.repository_favorite_notSeededError));
      return;
    }

    final favorites = [...dataValue];
    favorites.remove(favorite);
    _favoritesSubject.addSuccess(favorites);

    try {
      await _localSource.updateFavorites(favorites);
    } catch (e) {
      _favoritesSubject.addErrorEvent(CcError.fromObject(e));
    }
  }

  Future<void> clearFavorites() async {
    _favoritesSubject.addSuccess([]);

    try {
      await _localSource.updateFavorites([]);
    } catch (e) {
      _favoritesSubject.addErrorEvent(CcError.fromObject(e));
    }
  }

  void dispose() {
    _favoritesSubject.close();
  }
}
