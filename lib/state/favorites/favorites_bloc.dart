import "dart:async";

import "package:bloc_concurrency/bloc_concurrency.dart";
import "package:currency_converter/data/model/currency.dart";
import "package:currency_converter/data/repository/currency_repository.dart";
import "package:currency_converter/data/repository/data_state.dart";
import "package:currency_converter/data/repository/favorite_repository.dart";
import "package:currency_converter/state/favorites/favorites_event.dart";
import "package:currency_converter/state/favorites/favorites_state.dart";
import "package:currency_converter/util/analytics.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:j1_environment/j1_environment.dart";
import "package:j1_logger/j1_logger.dart";
import "package:rxdart/rxdart.dart";

class FavoritesBloc extends Bloc<FavoritesEvent, FavoritesState> {
  final FavoriteRepository _favorite;
  final CurrencyRepository _currency;
  final J1Logger _logger;

  StreamSubscription? _subscription;

  FavoritesBloc({
    FavoriteRepository? favorite,
    CurrencyRepository? currency,
    J1Logger? logger,
  })  : _favorite = favorite ?? locator.get<FavoriteRepository>(),
        _currency = currency ?? locator.get<CurrencyRepository>(),
        _logger = logger ?? locator.get<J1Logger>(),
        super(const FavoritesState.initial()) {
    on<FavoritesLoadEvent>(_handleLoad, transformer: droppable());
    on<FavoritesToggleEvent>(_handleToggle);

    on<FavoritesSuccessDataEvent>(_handleSuccessData, transformer: droppable());
    on<FavoritesErrorDataEvent>(_handleErrorData, transformer: sequential());
  }

  Future<void> _handleLoad(FavoritesLoadEvent event, Emitter<FavoritesState> emit) async {
    _subscription?.cancel();

    emit(const FavoritesState.loading());

    await Future.wait(
      [
        _favorite.loadFavorites(),
        _currency.loadAllCurrencies(),
      ],
    );

    _subscription = CombineLatestStream.combine2(
      _favorite.favoritesStream.handleError(
        (e) => _streamError(e, FavoritesErrorCode.loadFavorites),
      ),
      _currency.allCurrenciesStream.handleError(
        (e) => _streamError(e, FavoritesErrorCode.loadCurrencies),
      ),
      (favorites, allCurrencies) => (favorites, allCurrencies),
    ).listen(_handleData);
  }

  void _handleData((DataState<List<CurrencyCode>>, DataState<List<CurrencyCode>>) data) {
    final (favoritesData, currenciesData) = data;
    final favorites = favoritesData is DataSuccess<List<CurrencyCode>> ? favoritesData.data : <CurrencyCode>[];
    final currencies =
        currenciesData is DataSuccess<List<CurrencyCode>> ? currenciesData.data : CurrencyCode.sortedValues();

    final nonFavorites = [...currencies];
    nonFavorites.removeWhere(favorites.contains);

    add(FavoritesSuccessDataEvent(FavoritesState.loaded(favorites: favorites, nonFavorites: nonFavorites)));
  }

  Future<void> _handleToggle(FavoritesToggleEvent event, Emitter<FavoritesState> emit) async {
    try {
      if (event.isFavorite) {
        await _favorite.addFavorite(event.code);
      } else {
        await _favorite.removeFavorite(event.code);
      }
    } catch (e) {
      _logError(e);
      emit(state.copyWith(error: FavoritesErrorCode.saveFavorite));
    }
  }

  void _handleSuccessData(FavoritesSuccessDataEvent event, Emitter<FavoritesState> emit) {
    emit(event.next);
  }

  void _handleErrorData(FavoritesErrorDataEvent event, Emitter<FavoritesState> emit) {
    emit(state.copyWith(error: event.error));
  }

  void _logError(Object e) {
    _logger.logBloc(
      bloc: Analytics.favoritesBloc,
      name: Analytics.errorEvent,
      params: {Analytics.errorParam: e},
    );
  }

  void _streamError(Object e, FavoritesErrorCode result) {
    _logError(e);
    add(FavoritesErrorDataEvent(result));
  }

  @override
  Future<void> close() {
    _subscription?.cancel();
    return super.close();
  }
}
