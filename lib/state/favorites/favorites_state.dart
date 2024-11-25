import "package:currency_converter/data/model/currency.dart";
import "package:currency_converter/state/loading_state.dart";
import "package:dart_mappable/dart_mappable.dart";

part "favorites_state.mapper.dart";

@MappableClass()
class FavoritesState with FavoritesStateMappable {
  final LoadingState status;
  final List<CurrencyCode>? favorites;
  final List<CurrencyCode>? nonFavorites;
  final FavoritesErrorCode? error;

  const FavoritesState.loaded({
    required this.favorites,
    required this.nonFavorites,
    this.error,
  }) : status = LoadingState.loaded;

  const FavoritesState.initial()
      : status = LoadingState.initial,
        favorites = null,
        nonFavorites = null,
        error = null;

  const FavoritesState.loading()
      : status = LoadingState.loading,
        favorites = null,
        nonFavorites = null,
        error = null;
}

@MappableEnum()
enum FavoritesErrorCode {
  loadFavorites,
  saveFavorite,
  loadCurrencies,
}
