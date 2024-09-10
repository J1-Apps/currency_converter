import "dart:async";

import "package:bloc_concurrency/bloc_concurrency.dart";
import "package:currency_converter/state/home/home_event.dart";
import "package:currency_converter/state/home/home_state.dart";
import "package:currency_converter/model/currency.dart";
import "package:currency_converter/repository/app_storage_repository/app_storage_repository.dart";
import "package:currency_converter/repository/app_storage_repository/defaults.dart";
import "package:currency_converter/repository/exchange_rate_repository/exchange_rate_repository.dart";
import "package:currency_converter/util/errors/cc_error.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:j1_environment/j1_environment.dart";

const _initialState = HomeState(HomeLoadingState.loadingConfig, null, null, null, null);

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final AppStorageRepository _appStorage;
  final ExchangeRateRepository _exchangeRate;

  late final StreamSubscription<List<CurrencyCode>> _favoritesSubscription;

  HomeBloc({
    AppStorageRepository? appStorage,
    ExchangeRateRepository? exchangeRate,
  })  : _appStorage = appStorage ?? locator.get<AppStorageRepository>(),
        _exchangeRate = exchangeRate ?? locator.get<ExchangeRateRepository>(),
        super(_initialState) {
    on<HomeLoadConfigurationEvent>(_handleLoadConfiguration, transformer: droppable());
    on<HomeLoadSnapshotEvent>(_handleLoadSnapshot, transformer: droppable());
    on<HomeUpdateBaseValueEvent>(_handleUpdateBaseValue, transformer: sequential());
    on<HomeUpdateBaseCurrencyEvent>(_handleUpdateBaseCurrency, transformer: sequential());
    on<HomeToggleCurrencyEvent>(_handleToggleCurrency, transformer: sequential());
    on<HomeUpdateFavoritesEvent>(_handleUpdateFavorites, transformer: sequential());

    _favoritesSubscription = _appStorage.getFavoritesStream().listen(
          (favorites) => add(HomeUpdateFavoritesEvent(favorites)),
        );

    add(const HomeLoadConfigurationEvent());
  }

  Future<void> _handleLoadConfiguration(HomeLoadConfigurationEvent event, Emitter<HomeState> emit) async {
    if (state.loadingState != HomeLoadingState.loadingConfig) {
      return;
    }

    try {
      final configuration = await _appStorage.getCurrentConfiguration() ?? defaultConfiguration;

      emit(state.copyWith(configuration: configuration));
    } catch (e) {
      emit(
        state.copyWith(
          configuration: defaultConfiguration,
          error: CcError.fromObject(e).code,
        ),
      );
    }

    add(const HomeLoadSnapshotEvent());
  }

  Future<void> _handleLoadSnapshot(HomeLoadSnapshotEvent event, Emitter<HomeState> emit) async {
    final configuration = state.configuration;

    if (configuration == null) {
      return;
    }

    emit(state.copyWith(loadingState: HomeLoadingState.loadingSnapshot, snapshot: null));

    try {
      final snapshot = await _exchangeRate.getExchangeRateSnapshot(configuration.baseCurrency);
      emit(state.copyWith(loadingState: HomeLoadingState.loaded, snapshot: snapshot));
    } catch (e) {
      final snapshot = state.snapshot;

      if (snapshot == null) {
        emit(
          state.copyWith(
            loadingState: HomeLoadingState.snapshotError,
            error: CcError.fromObject(e).code,
          ),
        );
      } else {
        emit(
          state.copyWith(
            loadingState: HomeLoadingState.loaded,
            snapshot: snapshot,
            error: CcError.fromObject(e).code,
          ),
        );
      }
    }
  }

  Future<void> _handleUpdateBaseValue(HomeUpdateBaseValueEvent event, Emitter<HomeState> emit) async {
    final config = state.configuration?.copyWith(baseValue: event.value);

    if (config == null) {
      return;
    }

    emit(state.copyWith(configuration: config));

    try {
      await _appStorage.updateCurrentConfiguration(config);
    } catch (e) {
      emit(state.copyWith(error: CcError.fromObject(e).code));
    }
  }

  Future<void> _handleUpdateBaseCurrency(HomeUpdateBaseCurrencyEvent event, Emitter<HomeState> emit) async {
    final config = state.configuration;

    if (config == null) {
      return;
    }

    try {
      final snapshot = await _exchangeRate.getExchangeRateSnapshot(event.code);
      final updatedConfig = config.copyWith(baseCurrency: event.code);
      emit(state.copyWith(configuration: updatedConfig, snapshot: snapshot));
      await _appStorage.updateCurrentConfiguration(updatedConfig);
    } catch (e) {
      emit(state.copyWith(error: CcError.fromObject(e).code));
    }
  }

  Future<void> _handleToggleCurrency(HomeToggleCurrencyEvent event, Emitter<HomeState> emit) async {
    final config = state.configuration;

    if (config == null) {
      return;
    }

    var currencies = config.currencies;
    if (currencies.contains(event.code)) {
      currencies.remove(event.code);
    } else {
      currencies = {...currencies, event.code};
    }

    final updatedConfig = config.copyWith(currencies: currencies);
    emit(state.copyWith(configuration: updatedConfig));

    try {
      await _appStorage.updateCurrentConfiguration(updatedConfig);
    } catch (e) {
      emit(state.copyWith(error: CcError.fromObject(e).code));
    }
  }

  Future<void> _handleUpdateFavorites(HomeUpdateFavoritesEvent event, Emitter<HomeState> emit) async {
    emit(state.copyWith(favorites: event.favorites));
  }

  @override
  Future<void> close() {
    _favoritesSubscription.cancel();
    return super.close();
  }
}
