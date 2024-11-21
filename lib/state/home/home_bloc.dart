import "dart:async";

import "package:bloc_concurrency/bloc_concurrency.dart";
import "package:currency_converter/data/model/configuration.dart";
import "package:currency_converter/data/model/currency.dart";
import "package:currency_converter/data/model/exchange_rate.dart";
import "package:currency_converter/data/repository/configuration_repository.dart";
import "package:currency_converter/data/repository/currency_repository.dart";
import "package:currency_converter/data/repository/data_state.dart";
import "package:currency_converter/data/repository/exchange_repository.dart";
import "package:currency_converter/data/repository/favorite_repository.dart";
import "package:currency_converter/state/home/home_event.dart";
import "package:currency_converter/state/home/home_state.dart";
import "package:currency_converter/state/loading_state.dart";
import "package:currency_converter/util/analytics.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:j1_environment/j1_environment.dart";
import "package:j1_logger/j1_logger.dart";
import "package:rxdart/streams.dart";

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final ConfigurationRepository _configuration;
  final CurrencyRepository _currency;
  final ExchangeRepository _exchange;
  final FavoriteRepository _favorite;
  final J1Logger _logger;

  StreamSubscription? _subscription;

  HomeBloc({
    ConfigurationRepository? configuration,
    CurrencyRepository? currency,
    ExchangeRepository? exchange,
    FavoriteRepository? favorite,
    J1Logger? logger,
  })  : _configuration = configuration ?? locator.get<ConfigurationRepository>(),
        _currency = currency ?? locator.get<CurrencyRepository>(),
        _exchange = exchange ?? locator.get<ExchangeRepository>(),
        _favorite = favorite ?? locator.get<FavoriteRepository>(),
        _logger = logger ?? locator.get<J1Logger>(),
        super(const HomeState.initial()) {
    on<HomeLoadEvent>(_handleLoad, transformer: droppable());
    on<HomeRefreshEvent>(_handleRefresh, transformer: droppable());
    on<HomeUpdateBaseValueEvent>(_handleUpdateBaseValue);
    on<HomeUpdateBaseCurrencyEvent>(_handleUpdateBaseCurrency);
    on<HomeToggleCurrencyEvent>(_handleToggleCurrency);
    on<HomeUpdateCurrencyEvent>(_handleUpdateCurrency);
    on<HomeToggleFavoriteEvent>(_handleToggleFavorite);
    on<HomeToggleExpandedEvent>(_handleToggleExpanded);

    on<HomeSuccessDataEvent>(_handleSuccessData, transformer: droppable());
    on<HomeErrorDataEvent>(_handleErrorData, transformer: sequential());
  }

  Future<void> _handleLoad(HomeLoadEvent event, Emitter<HomeState> emit) async {
    _subscription?.cancel();

    emit(const HomeState.loading());

    await Future.wait(
      [
        _configuration.loadCurrentConfiguration(),
        _exchange.loadExchangeRate(),
        _favorite.loadFavorites(),
        _currency.loadAllCurrencies()
      ],
    );

    _subscription = CombineLatestStream.combine4(
      _configuration.currentConfigurationStream.handleError(
        (e) => _streamError(e, HomeErrorCode.loadCurrentConfiguration),
      ),
      _exchange.exchangeRateStream.handleError(
        (e) => _streamError(e, HomeErrorCode.loadExchangeRate),
      ),
      _favorite.favoritesStream.handleError(
        (e) => _streamError(e, HomeErrorCode.loadFavorites),
      ),
      _currency.allCurrenciesStream.handleError(
        (e) => _streamError(e, HomeErrorCode.loadCurrencies),
      ),
      (config, exchange, favorites, allCurrencies) => (
        config,
        exchange,
        favorites,
        allCurrencies,
      ),
    ).listen(_handleData);
  }

  void _handleData(
    (
      DataState<Configuration>,
      DataState<ExchangeRateSnapshot>,
      DataState<List<CurrencyCode>>,
      DataState<List<CurrencyCode>>,
    ) data,
  ) {
    final (configurationData, exchangeData, favoritesData, currenciesData) = data;
    final configuration = configurationData is DataSuccess<Configuration> ? configurationData.data : null;
    final exchange = exchangeData is DataSuccess<ExchangeRateSnapshot> ? exchangeData.data : null;
    final favorites = favoritesData is DataSuccess<List<CurrencyCode>> ? favoritesData.data : <CurrencyCode>[];
    final currencies =
        currenciesData is DataSuccess<List<CurrencyCode>> ? currenciesData.data : CurrencyCode.sortedValues();

    if (configuration == null || exchange == null) {
      add(const HomeSuccessDataEvent(HomeState.error()));
    } else {
      add(
        HomeSuccessDataEvent(
          HomeState.fromValues(
            configuration: configuration,
            exchange: exchange,
            favorites: favorites,
            currencies: currencies,
          ),
        ),
      );
    }
  }

  Future<void> _handleRefresh(HomeRefreshEvent event, Emitter<HomeState> emit) async {
    final currentState = state;

    if (currentState.status != LoadingState.loaded) {
      return;
    }

    emit(currentState.copyWith(refresh: state.refresh?.copyWith(isRefreshing: true)));
    _exchange.loadExchangeRate();
  }

  Future<void> _handleUpdateBaseValue(HomeUpdateBaseValueEvent event, Emitter<HomeState> emit) async {
    final baseCode = state.baseCurrency?.code;
    final exchangeData = _exchange.exchangeRate;

    if (state.status != LoadingState.loaded || exchangeData is! DataSuccess<ExchangeRateSnapshot> || baseCode == null) {
      return;
    }

    try {
      final updatedBaseValue = exchangeData.data.getTargetValue(event.code, baseCode, event.value);
      await _configuration.updateCurrentBaseValue(updatedBaseValue);
    } catch (e) {
      _logError(e);
      emit(state.copyWith(error: HomeErrorCode.saveCurrentConfiguration));
    }
  }

  Future<void> _handleUpdateBaseCurrency(HomeUpdateBaseCurrencyEvent event, Emitter<HomeState> emit) async {
    final currentState = state;
    final baseCurrency = currentState.baseCurrency;

    if (currentState.status != LoadingState.loaded || baseCurrency == null) {
      return;
    }

    final exchangeData = _exchange.exchangeRate;
    final currentBase = baseCurrency.code;
    final currentValue = baseCurrency.value;

    if (exchangeData is! DataSuccess<ExchangeRateSnapshot>) {
      return;
    }

    final exchange = exchangeData.data;

    try {
      final newBaseValue = exchange.getTargetValue(currentBase, event.code, currentValue);
      await _configuration.updateCurrentBaseCurrency(event.code, newBaseValue);
    } catch (e) {
      _logError(e);
      emit(state.copyWith(error: HomeErrorCode.saveCurrentConfiguration));
    }
  }

  Future<void> _handleToggleCurrency(HomeToggleCurrencyEvent event, Emitter<HomeState> emit) async {
    try {
      await _configuration.toggleCurrentCurrency(event.code);
    } catch (e) {
      _logError(e);
      emit(state.copyWith(error: HomeErrorCode.saveCurrentConfiguration));
    }
  }

  Future<void> _handleUpdateCurrency(HomeUpdateCurrencyEvent event, Emitter<HomeState> emit) async {
    try {
      await _configuration.updateCurrentCurrency(event.code, event.index);
    } catch (e) {
      _logError(e);
      emit(state.copyWith(error: HomeErrorCode.saveCurrentConfiguration));
    }
  }

  Future<void> _handleToggleFavorite(HomeToggleFavoriteEvent event, Emitter<HomeState> emit) async {
    try {
      if (event.isFavorite) {
        await _favorite.addFavorite(event.code);
      } else {
        await _favorite.removeFavorite(event.code);
      }
    } catch (e) {
      _logError(e);
      emit(state.copyWith(error: HomeErrorCode.saveFavorite));
    }
  }

  Future<void> _handleToggleExpanded(HomeToggleExpandedEvent event, Emitter<HomeState> emit) async {
    try {
      await _configuration.toggleCurrentCurrencyExpanded(event.index);
    } catch (e) {
      _logError(e);
      emit(state.copyWith(error: HomeErrorCode.saveCurrentConfiguration));
    }
  }

  void _handleSuccessData(HomeSuccessDataEvent event, Emitter<HomeState> emit) {
    emit(event.next);
  }

  void _handleErrorData(HomeErrorDataEvent event, Emitter<HomeState> emit) {
    emit(state.copyWith(error: event.error));
  }

  void _logError(Object e) {
    _logger.logBloc(
      bloc: Analytics.homeBloc,
      name: Analytics.errorEvent,
      params: {Analytics.errorParam: e},
    );
  }

  void _streamError(Object e, HomeErrorCode result) {
    _logError(e);
    add(HomeErrorDataEvent(result));
  }

  @override
  Future<void> close() {
    _subscription?.cancel();

    return super.close();
  }
}
