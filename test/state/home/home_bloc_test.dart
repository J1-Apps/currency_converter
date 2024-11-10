import "dart:async";

import "package:currency_converter/data/model/cc_error.dart";
import "package:currency_converter/data/model/configuration.dart";
import "package:currency_converter/data/model/currency.dart";
import "package:currency_converter/data/model/exchange_rate.dart";
import "package:currency_converter/data/repository/configuration_repository.dart";
import "package:currency_converter/data/repository/data_state.dart";
import "package:currency_converter/data/repository/exchange_repository.dart";
import "package:currency_converter/data/repository/favorite_repository.dart";
import "package:currency_converter/state/home/home_bloc.dart";
import "package:currency_converter/state/home/home_event.dart";
import "package:currency_converter/state/home/home_state.dart";
import "package:flutter_test/flutter_test.dart";
import "package:j1_environment/j1_environment.dart";
import "package:mocktail/mocktail.dart";
import "package:rxdart/subjects.dart";

import "../../testing_utils.dart";
import "../../testing_values.dart";

void main() {
  final configuration = MockConfigurationRepository();
  final exchange = MockExchangeRepository();
  final favorite = MockFavoriteRepository();

  setUpAll(() {
    locator.registerSingleton<ConfigurationRepository>(configuration);
    locator.registerSingleton<ExchangeRepository>(exchange);
    locator.registerSingleton<FavoriteRepository>(favorite);

    registerFallbackValue(testConfig0);
    registerFallbackValue(testSnapshot0);
  });

  tearDown(() {
    reset(configuration);
    reset(exchange);
    reset(favorite);
  });

  tearDownAll(() async {
    await locator.reset();
  });

  group("Home Bloc", () {
    test("loads initial configuration and snapshot", () async {
      when(() => configuration.currentConfigurationStream).thenAnswer(
        (_) => Stream.value(const DataSuccess(testConfig0)),
      );

      when(configuration.loadCurrentConfiguration).thenAnswer((_) => Future.value());

      when(() => exchange.exchangeRateStream).thenAnswer(
        (_) => Stream.value(DataSuccess(testSnapshot0)),
      );

      when(exchange.loadExchangeRate).thenAnswer((_) => Future.value());

      when(() => favorite.favoritesStream).thenAnswer(
        (_) => Stream.value(const DataSuccess(testFavorites0)),
      );

      when(favorite.loadFavorites).thenAnswer((_) => Future.value());

      final bloc = HomeBloc();
      expect(
        bloc.stream,
        emitsInOrder(
          [
            const HomeState.loading(),
            HomeState.fromValues(configuration: testConfig0, exchange: testSnapshot0, favorites: testFavorites0),
          ],
        ),
      );

      bloc.add(const HomeLoadEvent());
      await waitMs();

      bloc.close();
    });

    test("handles initial configuration and snapshot load error", () async {
      when(() => configuration.currentConfigurationStream).thenAnswer(
        (_) => Stream.value(const DataEmpty<Configuration>()),
      );

      when(configuration.loadCurrentConfiguration).thenAnswer((_) => Future.value());

      when(() => exchange.exchangeRateStream).thenAnswer(
        (_) => Stream.value(const DataEmpty<ExchangeRateSnapshot>()),
      );

      when(exchange.loadExchangeRate).thenAnswer((_) => Future.value());

      when(() => favorite.favoritesStream).thenAnswer(
        (_) => Stream.value(const DataSuccess(testFavorites0)),
      );

      when(favorite.loadFavorites).thenAnswer((_) => Future.value());

      final bloc = HomeBloc();
      expect(
        bloc.stream,
        emitsInOrder(
          [
            const HomeState.loading(),
            const HomeState.error(),
          ],
        ),
      );

      bloc.add(const HomeLoadEvent());
      await waitMs();

      bloc.close();
    });

    test("reloads snapshot", () async {
      final exchangeController = BehaviorSubject<DataState<ExchangeRateSnapshot>>.seeded(DataSuccess(testSnapshot0));

      when(() => configuration.currentConfigurationStream).thenAnswer(
        (_) => Stream.value(const DataSuccess(testConfig0)),
      );

      when(configuration.loadCurrentConfiguration).thenAnswer((_) => Future.value());

      when(() => exchange.exchangeRateStream).thenAnswer((_) => exchangeController.stream);

      when(exchange.loadExchangeRate).thenAnswer((_) => Future.value());

      when(() => favorite.favoritesStream).thenAnswer(
        (_) => Stream.value(const DataSuccess(testFavorites0)),
      );

      when(favorite.loadFavorites).thenAnswer((_) => Future.value());

      final bloc = HomeBloc();
      expect(
        bloc.stream,
        emitsInOrder(
          [
            const HomeState.loading(),
            HomeState.fromValues(configuration: testConfig0, exchange: testSnapshot0, favorites: testFavorites0),
            HomeState.fromValues(
              configuration: testConfig0,
              exchange: testSnapshot0,
              favorites: testFavorites0,
            ).copyWith(refresh: HomeRefresh(isRefreshing: true, refreshed: testSnapshot0.timestamp)),
            HomeState.fromValues(configuration: testConfig0, exchange: testSnapshot1, favorites: testFavorites0),
          ],
        ),
      );

      bloc.add(const HomeLoadEvent());
      await waitMs();

      bloc.add(const HomeRefreshEvent());
      exchangeController.add(DataSuccess(testSnapshot1));
      await waitMs();

      bloc.close();
      exchangeController.close();
    });

    test("handles reload snapshot error", () async {
      final exchangeController = BehaviorSubject<DataState<ExchangeRateSnapshot>>.seeded(DataSuccess(testSnapshot0));

      when(() => configuration.currentConfigurationStream).thenAnswer(
        (_) => Stream.value(const DataSuccess(testConfig0)),
      );

      when(configuration.loadCurrentConfiguration).thenAnswer((_) => Future.value());

      when(() => exchange.exchangeRateStream).thenAnswer((_) => exchangeController.stream);

      when(exchange.loadExchangeRate).thenAnswer((_) => Future.value());

      when(() => favorite.favoritesStream).thenAnswer(
        (_) => Stream.value(const DataSuccess(testFavorites0)),
      );

      when(favorite.loadFavorites).thenAnswer((_) => Future.value());

      final bloc = HomeBloc();
      expect(
        bloc.stream,
        emitsInOrder(
          [
            const HomeState.loading(),
            HomeState.fromValues(configuration: testConfig0, exchange: testSnapshot0, favorites: testFavorites0),
            HomeState.fromValues(
              configuration: testConfig0,
              exchange: testSnapshot0,
              favorites: testFavorites0,
            ).copyWith(refresh: HomeRefresh(isRefreshing: true, refreshed: testSnapshot0.timestamp)),
            HomeState.fromValues(configuration: testConfig0, exchange: testSnapshot0, favorites: testFavorites0),
            HomeState.fromValues(
              configuration: testConfig0,
              exchange: testSnapshot0,
              favorites: testFavorites0,
            ).copyWith(error: const CcError(ErrorCode.source_remote_exchange_httpError)),
          ],
        ),
      );

      bloc.add(const HomeLoadEvent());
      await waitMs();

      bloc.add(const HomeRefreshEvent());
      exchangeController.add(DataSuccess(testSnapshot0));
      exchangeController.addError(const CcError(ErrorCode.source_remote_exchange_httpError));
      await waitMs();

      bloc.close();
      exchangeController.close();
    });

    test("updates base value", () async {
      final configurationController = BehaviorSubject<DataState<Configuration>>.seeded(const DataSuccess(testConfig0));

      when(() => configuration.currentConfigurationStream).thenAnswer((_) => configurationController.stream);

      when(configuration.loadCurrentConfiguration).thenAnswer((_) => Future.value());

      when(() => exchange.exchangeRateStream).thenAnswer(
        (_) => Stream.value(DataSuccess(testSnapshot0)),
      );

      when(exchange.loadExchangeRate).thenAnswer((_) => Future.value());

      when(() => favorite.favoritesStream).thenAnswer(
        (_) => Stream.value(const DataSuccess(testFavorites0)),
      );

      when(favorite.loadFavorites).thenAnswer((_) => Future.value());

      final bloc = HomeBloc();
      expect(
        bloc.stream,
        emitsInOrder(
          [
            const HomeState.loading(),
            HomeState.fromValues(configuration: testConfig0, exchange: testSnapshot0, favorites: testFavorites0),
            HomeState.fromValues(
              configuration: testConfig0.copyWith(baseValue: 10.0),
              exchange: testSnapshot0,
              favorites: testFavorites0,
            ),
          ],
        ),
      );

      bloc.add(const HomeLoadEvent());
      await waitMs();

      when(() => exchange.exchangeRate).thenAnswer((_) => DataSuccess(testSnapshot0));
      when(() => configuration.updateCurrentBaseValue(10.0)).thenAnswer((_) => Future.value());

      bloc.add(const HomeUpdateBaseValueEvent(CurrencyCode.USD, 10.0));
      configurationController.add(DataSuccess(testConfig0.copyWith(baseValue: 10.0)));
      await waitMs();

      bloc.close();
      configurationController.close();
    });

    test("updates base value and handles save error", () async {
      final configurationController = BehaviorSubject<DataState<Configuration>>.seeded(const DataSuccess(testConfig0));

      when(() => configuration.currentConfigurationStream).thenAnswer((_) => configurationController.stream);

      when(configuration.loadCurrentConfiguration).thenAnswer((_) => Future.value());

      when(() => exchange.exchangeRateStream).thenAnswer(
        (_) => Stream.value(DataSuccess(testSnapshot0)),
      );

      when(exchange.loadExchangeRate).thenAnswer((_) => Future.value());

      when(() => favorite.favoritesStream).thenAnswer(
        (_) => Stream.value(const DataSuccess(testFavorites0)),
      );

      when(favorite.loadFavorites).thenAnswer((_) => Future.value());

      final bloc = HomeBloc();
      expect(
        bloc.stream,
        emitsInOrder(
          [
            const HomeState.loading(),
            HomeState.fromValues(configuration: testConfig0, exchange: testSnapshot0, favorites: testFavorites0),
            HomeState.fromValues(
              configuration: testConfig0,
              exchange: testSnapshot0,
              favorites: testFavorites0,
            ).copyWith(error: const CcError(ErrorCode.source_local_configuration_currentWriteError)),
            HomeState.fromValues(
              configuration: testConfig0.copyWith(baseValue: 10.0),
              exchange: testSnapshot0,
              favorites: testFavorites0,
            ),
          ],
        ),
      );

      bloc.add(const HomeLoadEvent());
      await waitMs();

      when(() => exchange.exchangeRate).thenAnswer((_) => DataSuccess(testSnapshot0));
      when(() => configuration.updateCurrentBaseValue(10.0)).thenThrow(
        const CcError(ErrorCode.source_local_configuration_currentWriteError),
      );

      bloc.add(const HomeUpdateBaseValueEvent(CurrencyCode.USD, 10.0));
      configurationController.add(DataSuccess(testConfig0.copyWith(baseValue: 10.0)));
      await waitMs();

      bloc.close();
      configurationController.close();
    });

    test("updates base currency", () async {
      final configurationController = BehaviorSubject<DataState<Configuration>>.seeded(const DataSuccess(testConfig0));

      when(() => configuration.currentConfigurationStream).thenAnswer((_) => configurationController.stream);

      when(configuration.loadCurrentConfiguration).thenAnswer((_) => Future.value());

      when(() => exchange.exchangeRateStream).thenAnswer(
        (_) => Stream.value(DataSuccess(testSnapshot0)),
      );

      when(exchange.loadExchangeRate).thenAnswer((_) => Future.value());

      when(() => favorite.favoritesStream).thenAnswer(
        (_) => Stream.value(const DataSuccess(testFavorites0)),
      );

      when(favorite.loadFavorites).thenAnswer((_) => Future.value());

      final bloc = HomeBloc();
      expect(
        bloc.stream,
        emitsInOrder(
          [
            const HomeState.loading(),
            HomeState.fromValues(configuration: testConfig0, exchange: testSnapshot0, favorites: testFavorites0),
            HomeState.fromValues(
              configuration: testConfig0.copyWith(baseCurrency: CurrencyCode.KRW, baseValue: 10.0),
              exchange: testSnapshot0,
              favorites: testFavorites0,
            ),
          ],
        ),
      );

      bloc.add(const HomeLoadEvent());
      await waitMs();

      when(() => exchange.exchangeRate).thenAnswer((_) => DataSuccess(testSnapshot0));
      when(
        () => configuration.updateCurrentBaseCurrency(
          CurrencyCode.KRW,
          testSnapshot0.getTargetValue(CurrencyCode.USD, CurrencyCode.KRW, 1.0),
        ),
      ).thenAnswer((_) => Future.value());

      bloc.add(const HomeUpdateBaseCurrencyEvent(CurrencyCode.KRW));
      configurationController.add(DataSuccess(testConfig0.copyWith(baseCurrency: CurrencyCode.KRW, baseValue: 10.0)));
      await waitMs();

      bloc.close();
      configurationController.close();
    });

    test("handles update base currency config error", () async {
      final configurationController = BehaviorSubject<DataState<Configuration>>.seeded(const DataSuccess(testConfig0));

      when(() => configuration.currentConfigurationStream).thenAnswer((_) => configurationController.stream);

      when(configuration.loadCurrentConfiguration).thenAnswer((_) => Future.value());

      when(() => exchange.exchangeRateStream).thenAnswer(
        (_) => Stream.value(DataSuccess(testSnapshot0)),
      );

      when(exchange.loadExchangeRate).thenAnswer((_) => Future.value());

      when(() => favorite.favoritesStream).thenAnswer(
        (_) => Stream.value(const DataSuccess(testFavorites0)),
      );

      when(favorite.loadFavorites).thenAnswer((_) => Future.value());

      final bloc = HomeBloc();
      expect(
        bloc.stream,
        emitsInOrder(
          [
            const HomeState.loading(),
            HomeState.fromValues(configuration: testConfig0, exchange: testSnapshot0, favorites: testFavorites0),
            HomeState.fromValues(
              configuration: testConfig0,
              exchange: testSnapshot0,
              favorites: testFavorites0,
            ).copyWith(error: const CcError(ErrorCode.source_local_configuration_currentWriteError)),
            HomeState.fromValues(
              configuration: testConfig0.copyWith(baseCurrency: CurrencyCode.KRW, baseValue: 10.0),
              exchange: testSnapshot0,
              favorites: testFavorites0,
            ),
          ],
        ),
      );

      bloc.add(const HomeLoadEvent());
      await waitMs();

      when(() => exchange.exchangeRate).thenAnswer((_) => DataSuccess(testSnapshot0));
      when(
        () => configuration.updateCurrentBaseCurrency(
          CurrencyCode.KRW,
          testSnapshot0.getTargetValue(CurrencyCode.USD, CurrencyCode.KRW, 1.0),
        ),
      ).thenThrow(const CcError(ErrorCode.source_local_configuration_currentWriteError));

      bloc.add(const HomeUpdateBaseCurrencyEvent(CurrencyCode.KRW));
      configurationController.add(DataSuccess(testConfig0.copyWith(baseCurrency: CurrencyCode.KRW, baseValue: 10.0)));
      await waitMs();

      bloc.close();
      configurationController.close();
    });

    test("handles toggle current currency", () async {
      final configurationController = BehaviorSubject<DataState<Configuration>>.seeded(const DataSuccess(testConfig0));

      when(() => configuration.currentConfigurationStream).thenAnswer((_) => configurationController.stream);

      when(configuration.loadCurrentConfiguration).thenAnswer((_) => Future.value());

      when(() => exchange.exchangeRateStream).thenAnswer(
        (_) => Stream.value(DataSuccess(testSnapshot0)),
      );

      when(exchange.loadExchangeRate).thenAnswer((_) => Future.value());

      when(() => favorite.favoritesStream).thenAnswer(
        (_) => Stream.value(const DataSuccess(testFavorites0)),
      );

      when(favorite.loadFavorites).thenAnswer((_) => Future.value());

      final bloc = HomeBloc();
      expect(
        bloc.stream,
        emitsInOrder(
          [
            const HomeState.loading(),
            HomeState.fromValues(configuration: testConfig0, exchange: testSnapshot0, favorites: testFavorites0),
            HomeState.fromValues(
              configuration: testConfig0.copyWith(currencies: [CurrencyCode.EUR]),
              exchange: testSnapshot0,
              favorites: testFavorites0,
            ),
          ],
        ),
      );

      bloc.add(const HomeLoadEvent());
      await waitMs();

      when(() => exchange.exchangeRate).thenAnswer((_) => DataSuccess(testSnapshot0));
      when(() => configuration.toggleCurrentCurrency(CurrencyCode.KRW)).thenAnswer((_) => Future.value());

      bloc.add(const HomeToggleCurrencyEvent(CurrencyCode.KRW));
      configurationController.add(DataSuccess(testConfig0.copyWith(currencies: [CurrencyCode.EUR])));
      await waitMs();

      bloc.close();
      configurationController.close();
    });

    test("handles toggle current currency error", () async {
      final configurationController = BehaviorSubject<DataState<Configuration>>.seeded(const DataSuccess(testConfig0));

      when(() => configuration.currentConfigurationStream).thenAnswer((_) => configurationController.stream);

      when(configuration.loadCurrentConfiguration).thenAnswer((_) => Future.value());

      when(() => exchange.exchangeRateStream).thenAnswer(
        (_) => Stream.value(DataSuccess(testSnapshot0)),
      );

      when(exchange.loadExchangeRate).thenAnswer((_) => Future.value());

      when(() => favorite.favoritesStream).thenAnswer(
        (_) => Stream.value(const DataSuccess(testFavorites0)),
      );

      when(favorite.loadFavorites).thenAnswer((_) => Future.value());

      final bloc = HomeBloc();
      expect(
        bloc.stream,
        emitsInOrder(
          [
            const HomeState.loading(),
            HomeState.fromValues(configuration: testConfig0, exchange: testSnapshot0, favorites: testFavorites0),
            HomeState.fromValues(
              configuration: testConfig0,
              exchange: testSnapshot0,
              favorites: testFavorites0,
            ).copyWith(error: const CcError(ErrorCode.source_local_configuration_currentWriteError)),
            HomeState.fromValues(
              configuration: testConfig0.copyWith(currencies: [CurrencyCode.EUR]),
              exchange: testSnapshot0,
              favorites: testFavorites0,
            ),
          ],
        ),
      );

      bloc.add(const HomeLoadEvent());
      await waitMs();

      when(() => exchange.exchangeRate).thenAnswer((_) => DataSuccess(testSnapshot0));
      when(() => configuration.toggleCurrentCurrency(CurrencyCode.KRW)).thenThrow(
        const CcError(ErrorCode.source_local_configuration_currentWriteError),
      );

      bloc.add(const HomeToggleCurrencyEvent(CurrencyCode.KRW));
      configurationController.add(DataSuccess(testConfig0.copyWith(currencies: [CurrencyCode.EUR])));
      await waitMs();

      bloc.close();
      configurationController.close();
    });

    test("handles update current currency", () async {
      final configurationController = BehaviorSubject<DataState<Configuration>>.seeded(const DataSuccess(testConfig0));

      when(() => configuration.currentConfigurationStream).thenAnswer((_) => configurationController.stream);

      when(configuration.loadCurrentConfiguration).thenAnswer((_) => Future.value());

      when(() => exchange.exchangeRateStream).thenAnswer(
        (_) => Stream.value(DataSuccess(testSnapshot0)),
      );

      when(exchange.loadExchangeRate).thenAnswer((_) => Future.value());

      when(() => favorite.favoritesStream).thenAnswer(
        (_) => Stream.value(const DataSuccess(testFavorites0)),
      );

      when(favorite.loadFavorites).thenAnswer((_) => Future.value());

      final bloc = HomeBloc();
      expect(
        bloc.stream,
        emitsInOrder(
          [
            const HomeState.loading(),
            HomeState.fromValues(configuration: testConfig0, exchange: testSnapshot0, favorites: testFavorites0),
            HomeState.fromValues(
              configuration: testConfig0.copyWith(currencies: [CurrencyCode.EUR, CurrencyCode.MXN]),
              exchange: testSnapshot0,
              favorites: testFavorites0,
            ),
          ],
        ),
      );

      bloc.add(const HomeLoadEvent());
      await waitMs();

      when(() => exchange.exchangeRate).thenAnswer((_) => DataSuccess(testSnapshot0));
      when(() => configuration.updateCurrentCurrency(CurrencyCode.MXN, 1)).thenAnswer((_) => Future.value());

      bloc.add(const HomeUpdateCurrencyEvent(1, CurrencyCode.MXN));
      configurationController.add(DataSuccess(testConfig0.copyWith(currencies: [CurrencyCode.EUR, CurrencyCode.MXN])));
      await waitMs();

      bloc.close();
      configurationController.close();
    });

    test("handles update current currency error", () async {
      final configurationController = BehaviorSubject<DataState<Configuration>>.seeded(const DataSuccess(testConfig0));

      when(() => configuration.currentConfigurationStream).thenAnswer((_) => configurationController.stream);

      when(configuration.loadCurrentConfiguration).thenAnswer((_) => Future.value());

      when(() => exchange.exchangeRateStream).thenAnswer(
        (_) => Stream.value(DataSuccess(testSnapshot0)),
      );

      when(exchange.loadExchangeRate).thenAnswer((_) => Future.value());

      when(() => favorite.favoritesStream).thenAnswer(
        (_) => Stream.value(const DataSuccess(testFavorites0)),
      );

      when(favorite.loadFavorites).thenAnswer((_) => Future.value());

      final bloc = HomeBloc();
      expect(
        bloc.stream,
        emitsInOrder(
          [
            const HomeState.loading(),
            HomeState.fromValues(configuration: testConfig0, exchange: testSnapshot0, favorites: testFavorites0),
            HomeState.fromValues(
              configuration: testConfig0,
              exchange: testSnapshot0,
              favorites: testFavorites0,
            ).copyWith(error: const CcError(ErrorCode.source_local_configuration_currentWriteError)),
            HomeState.fromValues(
              configuration: testConfig0.copyWith(currencies: [CurrencyCode.EUR, CurrencyCode.MXN]),
              exchange: testSnapshot0,
              favorites: testFavorites0,
            ),
          ],
        ),
      );

      bloc.add(const HomeLoadEvent());
      await waitMs();

      when(() => exchange.exchangeRate).thenAnswer((_) => DataSuccess(testSnapshot0));
      when(() => configuration.updateCurrentCurrency(CurrencyCode.MXN, 1)).thenThrow(
        const CcError(ErrorCode.source_local_configuration_currentWriteError),
      );

      bloc.add(const HomeUpdateCurrencyEvent(1, CurrencyCode.MXN));
      configurationController.add(DataSuccess(testConfig0.copyWith(currencies: [CurrencyCode.EUR, CurrencyCode.MXN])));
      await waitMs();

      bloc.close();
      configurationController.close();
    });
  });
}
