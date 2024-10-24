import "dart:async";

import "package:bloc_concurrency/bloc_concurrency.dart";
import "package:currency_converter/model/configuration.dart";
import "package:currency_converter/model/exchange_rate.dart";
import "package:currency_converter/state/home/home_event.dart";
import "package:currency_converter/state/home/home_state.dart";
import "package:currency_converter/repository/app_storage_repository/app_storage_repository.dart";
import "package:currency_converter/repository/app_storage_repository/defaults.dart";
import "package:currency_converter/repository/exchange_rate_repository/exchange_rate_repository.dart";
import "package:currency_converter/model/cc_error.dart";
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
    emit(const HomeState(status: HomeStatus.loading, configuration: null, snapshot: null));

    Configuration? configuration;
    ExchangeRateSnapshot? snapshot;
    CcError? error;

    try {
      await Future.wait([
        Future(() async {
          try {
            configuration = await _appStorage.getCurrentConfiguration() ?? defaultConfiguration;
          } catch (e) {
            configuration = defaultConfiguration;
            rethrow;
          }
        }),
        Future(() async {
          try {
            snapshot = await _exchangeRate.getExchangeRateSnapshot();
          } catch (e) {
            snapshot = await _appStorage.getCurrentExchangeRate();
            rethrow;
          }
        }),
      ]);
    } catch (e) {
      error = CcError.fromObject(e);
    }

    if (snapshot == null) {
      emit(HomeState(status: HomeStatus.error, configuration: null, snapshot: null, error: error));
    } else {
      emit(HomeState(status: HomeStatus.loaded, configuration: configuration, snapshot: snapshot, error: error));
    }
  }

  Future<void> _handleRefreshSnapshot(HomeRefreshSnapshotEvent event, Emitter<HomeState> emit) async {
    final configuration = state.configuration;
    final snapshot = state.snapshot;

    if (state.status != HomeStatus.loaded || configuration == null || snapshot == null) {
      return;
    }

    emit(state.copyWith(isRefreshing: true));

    ExchangeRateSnapshot refreshedSnapshot;
    CcError? error;

    try {
      refreshedSnapshot = await _exchangeRate.getExchangeRateSnapshot();
    } catch (e) {
      error = CcError.fromObject(e);
      refreshedSnapshot = snapshot;
    }

    emit(state.copyWith(status: HomeStatus.loaded, isRefreshing: false, snapshot: refreshedSnapshot, error: error));

    if (snapshot != refreshedSnapshot) {
      try {
        await _appStorage.updateCurrentExchangeRate(refreshedSnapshot);
      } catch (e) {
        emit(state.copyWith(error: CcError.fromObject(e)));
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
      emit(state.copyWith(error: CcError.fromObject(e)));
    }
  }

  Future<void> _handleUpdateBaseCurrency(HomeUpdateBaseCurrencyEvent event, Emitter<HomeState> emit) async {
    final config = state.configuration;
    final snapshot = state.snapshot;

    if (config == null || snapshot == null) {
      return;
    }

    try {
      final newBaseIndex = config.currencies.indexOf(event.code);
      final newBaseValue = snapshot.getTargetValue(config.baseCurrency, event.code, config.baseValue);
      final updatedCurrencies = [...config.currencies];

      if (newBaseIndex > -1) {
        updatedCurrencies[newBaseIndex] = config.baseCurrency;
      }

      final updatedConfig = config.copyWith(
        baseCurrency: event.code,
        baseValue: newBaseValue,
        currencies: updatedCurrencies,
      );

      emit(state.copyWith(configuration: updatedConfig));

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
