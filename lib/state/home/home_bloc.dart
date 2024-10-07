import "dart:async";

import "package:bloc_concurrency/bloc_concurrency.dart";
import "package:currency_converter/model/configuration.dart";
import "package:currency_converter/model/exchange_rate.dart";
import "package:currency_converter/state/home/home_event.dart";
import "package:currency_converter/state/home/home_state.dart";
import "package:currency_converter/repository/app_storage_repository/app_storage_repository.dart";
import "package:currency_converter/repository/app_storage_repository/defaults.dart";
import "package:currency_converter/repository/exchange_rate_repository/exchange_rate_repository.dart";
import "package:currency_converter/util/errors/cc_error.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:j1_environment/j1_environment.dart";

const _initialState = HomeState(status: HomeStatus.initial, configuration: null, snapshot: null);

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final AppStorageRepository _appStorage;
  final ExchangeRateRepository _exchangeRate;

  HomeBloc({
    AppStorageRepository? appStorage,
    ExchangeRateRepository? exchangeRate,
  })  : _appStorage = appStorage ?? locator.get<AppStorageRepository>(),
        _exchangeRate = exchangeRate ?? locator.get<ExchangeRateRepository>(),
        super(_initialState) {
    on<HomeLoadConfigurationEvent>(_handleLoadConfiguration, transformer: droppable());
    on<HomeRefreshSnapshotEvent>(_handleRefreshSnapshot, transformer: droppable());
    on<HomeUpdateBaseValueEvent>(_handleUpdateBaseValue, transformer: sequential());
    on<HomeUpdateBaseCurrencyEvent>(_handleUpdateBaseCurrency, transformer: sequential());
    on<HomeToggleCurrencyEvent>(_handleToggleCurrency, transformer: sequential());
    on<HomeUpdateCurrencyEvent>(_handleUpdateCurrency, transformer: sequential());
  }

  Future<void> _handleLoadConfiguration(HomeLoadConfigurationEvent event, Emitter<HomeState> emit) async {
    if (state.status != HomeStatus.initial) {
      return;
    }

    Configuration configuration;
    CcError? error;

    try {
      configuration = await _appStorage.getCurrentConfiguration() ?? defaultConfiguration;
    } catch (e) {
      configuration = defaultConfiguration;
      error = CcError.fromObject(e);
    }

    emit(
      state.copyWith(
        status: HomeStatus.loading,
        configuration: configuration,
        error: error,
      ),
    );

    await _loadSnapshot(configuration, emit);
  }

  Future<void> _handleRefreshSnapshot(HomeRefreshSnapshotEvent event, Emitter<HomeState> emit) async {
    final configuration = state.configuration;

    if (configuration == null) {
      return;
    }

    emit(state.copyWith(status: HomeStatus.loading));

    await _loadSnapshot(configuration, emit);
  }

  Future<void> _loadSnapshot(Configuration configuration, Emitter<HomeState> emit) async {
    ExchangeRateSnapshot? snapshot;
    CcError? error;

    try {
      snapshot = await _exchangeRate.getExchangeRateSnapshot();
    } catch (e) {
      error = CcError.fromObject(e);
      snapshot = state.snapshot;
    }

    if (snapshot == null) {
      emit(
        state.copyWith(
          status: HomeStatus.error,
          error: error,
        ),
      );
    } else {
      emit(
        state.copyWith(
          status: HomeStatus.loaded,
          snapshot: snapshot,
          error: error,
        ),
      );
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
      emit(state.copyWith(error: CcError.fromObject(e)));
    }
  }

  Future<void> _handleUpdateBaseCurrency(HomeUpdateBaseCurrencyEvent event, Emitter<HomeState> emit) async {
    final config = state.configuration;

    if (config == null) {
      return;
    }

    try {
      final snapshot = await _exchangeRate.getExchangeRateSnapshot();
      final updatedConfig = config.copyWith(baseCurrency: event.code);
      emit(state.copyWith(configuration: updatedConfig, snapshot: snapshot));
      await _appStorage.updateCurrentConfiguration(updatedConfig);
    } catch (e) {
      emit(state.copyWith(error: CcError.fromObject(e)));
    }
  }

  Future<void> _handleToggleCurrency(HomeToggleCurrencyEvent event, Emitter<HomeState> emit) async {
    final config = state.configuration;

    if (config == null) {
      return;
    }

    try {
      final currencies = [...config.currencies];
      if (currencies.contains(event.code)) {
        currencies.remove(event.code);
      } else {
        currencies.add(event.code);
      }

      final updatedConfig = config.copyWith(currencies: currencies);
      emit(state.copyWith(configuration: updatedConfig));

      await _appStorage.updateCurrentConfiguration(updatedConfig);
    } catch (e) {
      emit(state.copyWith(error: CcError.fromObject(e)));
    }
  }

  Future<void> _handleUpdateCurrency(HomeUpdateCurrencyEvent event, Emitter<HomeState> emit) async {
    final config = state.configuration;

    if (config == null) {
      return;
    }

    try {
      final currencies = [...config.currencies];
      currencies.replaceRange(event.index, event.index + 1, [event.code]);

      final updatedConfig = config.copyWith(currencies: currencies);
      emit(state.copyWith(configuration: updatedConfig));

      await _appStorage.updateCurrentConfiguration(updatedConfig);
    } catch (e) {
      emit(state.copyWith(error: CcError.fromObject(e)));
    }
  }
}
