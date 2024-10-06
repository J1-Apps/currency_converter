import "package:currency_converter/model/configuration.dart";
import "package:currency_converter/model/currency.dart";
import "package:currency_converter/model/exchange_rate.dart";
import "package:currency_converter/repository/app_storage_repository/app_storage_repository.dart";
import "package:currency_converter/repository/app_storage_repository/defaults.dart";
import "package:currency_converter/repository/exchange_rate_repository/exchange_rate_repository.dart";
import "package:currency_converter/state/home/home_bloc.dart";
import "package:currency_converter/state/home/home_event.dart";
import "package:currency_converter/state/home/home_state.dart";
import "package:currency_converter/util/errors/cc_error.dart";
import "package:flutter_test/flutter_test.dart";
import "package:j1_environment/j1_environment.dart";
import "package:mocktail/mocktail.dart";

import "../../testing_utils.dart";

const _testConfig = Configuration(
  "test config",
  1.0,
  CurrencyCode.USD,
  [CurrencyCode.KRW, CurrencyCode.EUR],
);

final _testSnapshot0 = ExchangeRateSnapshot(
  DateTime.now().toUtc(),
  {CurrencyCode.KRW: 1000.0, CurrencyCode.EUR: 1.0},
);

final _testSnapshot1 = ExchangeRateSnapshot(
  DateTime.now().toUtc(),
  {CurrencyCode.KRW: 1100.0, CurrencyCode.EUR: 1.1},
);

final _testSnapshot2 = ExchangeRateSnapshot(
  DateTime.now().toUtc(),
  {CurrencyCode.USD: 0.001, CurrencyCode.EUR: 0.001},
);

void main() {
  final appStorage = MockAppStorageRepository();
  final exchangeRate = MockExchangeRateRepository();

  setUpAll(() {
    locator.registerSingleton<AppStorageRepository>(appStorage);
    locator.registerSingleton<ExchangeRateRepository>(exchangeRate);

    registerFallbackValue(_testConfig);
  });

  tearDown(() {
    reset(appStorage);
  });

  tearDownAll(() async {
    await locator.reset();
  });

  group("Home Bloc", () {
    test("loads initial configuration and snapshot", () async {
      when(appStorage.getCurrentConfiguration).thenAnswer((_) async {
        await waitMs();
        return _testConfig;
      });

      when(() => exchangeRate.getExchangeRateSnapshot(CurrencyCode.USD)).thenAnswer((_) async {
        await waitMs();
        return _testSnapshot0;
      });

      final bloc = HomeBloc();

      final configured = await bloc.stream.first;
      expect(
        configured,
        const HomeState(
          status: HomeStatus.loading,
          configuration: _testConfig,
          snapshot: null,
        ),
      );

      final loaded = await bloc.stream.first;
      expect(
        loaded,
        HomeState(
          status: HomeStatus.loaded,
          configuration: _testConfig,
          snapshot: _testSnapshot0,
        ),
      );

      bloc.close();
    });

    test("handles initial configuration load error", () async {
      when(appStorage.getCurrentConfiguration).thenAnswer((_) async {
        await waitMs();
        throw StateError("test error");
      });

      when(() => exchangeRate.getExchangeRateSnapshot(CurrencyCode.USD)).thenAnswer((_) async {
        await waitMs();
        return _testSnapshot0;
      });

      final bloc = HomeBloc();

      final configured = await bloc.stream.first;
      expect(
        configured,
        const HomeState(
          status: HomeStatus.loading,
          configuration: defaultConfiguration,
          snapshot: null,
          error: CcError(
            ErrorCode.common_unknown,
            message: "Bad state: test error",
          ),
        ),
      );

      final loaded = await bloc.stream.first;
      expect(
        loaded,
        HomeState(
          status: HomeStatus.loaded,
          configuration: defaultConfiguration,
          snapshot: _testSnapshot0,
        ),
      );

      bloc.close();
    });

    test("handles initial configuration and snapshot load error", () async {
      when(appStorage.getCurrentConfiguration).thenAnswer((_) async {
        await waitMs();
        throw StateError("test configuration error");
      });

      when(() => exchangeRate.getExchangeRateSnapshot(CurrencyCode.USD)).thenAnswer((_) async {
        await waitMs();
        throw StateError("test snapshot error");
      });

      final bloc = HomeBloc();

      final configured = await bloc.stream.first;
      expect(
        configured,
        const HomeState(
          status: HomeStatus.loading,
          configuration: defaultConfiguration,
          snapshot: null,
          error: CcError(
            ErrorCode.common_unknown,
            message: "Bad state: test configuration error",
          ),
        ),
      );

      final loaded = await bloc.stream.first;
      expect(
        loaded,
        const HomeState(
          status: HomeStatus.error,
          configuration: defaultConfiguration,
          snapshot: null,
          error: CcError(
            ErrorCode.common_unknown,
            message: "Bad state: test snapshot error",
          ),
        ),
      );

      bloc.close();
    });

    test("reloads snapshot", () async {
      when(appStorage.getCurrentConfiguration).thenAnswer((_) async => _testConfig);
      when(() => exchangeRate.getExchangeRateSnapshot(CurrencyCode.USD)).thenAnswer((_) async => _testSnapshot0);

      final bloc = HomeBloc();

      final loaded = await bloc.stream.firstWhere((state) => state.status == HomeStatus.loaded);
      expect(
        loaded,
        HomeState(
          status: HomeStatus.loaded,
          configuration: _testConfig,
          snapshot: _testSnapshot0,
        ),
      );

      when(() => exchangeRate.getExchangeRateSnapshot(CurrencyCode.USD)).thenAnswer((_) async {
        await waitMs();
        return _testSnapshot1;
      });

      bloc.add(const HomeLoadSnapshotEvent());

      final loading = await bloc.stream.first;
      expect(
        loading,
        HomeState(
          status: HomeStatus.loading,
          configuration: _testConfig,
          snapshot: _testSnapshot0,
        ),
      );

      final reloaded = await bloc.stream.first;
      expect(
        reloaded,
        HomeState(
          status: HomeStatus.loaded,
          configuration: _testConfig,
          snapshot: _testSnapshot1,
        ),
      );

      bloc.close();
    });

    test("handles reload snapshot error", () async {
      when(appStorage.getCurrentConfiguration).thenAnswer((_) async => _testConfig);
      when(() => exchangeRate.getExchangeRateSnapshot(CurrencyCode.USD)).thenAnswer((_) async => _testSnapshot0);

      final bloc = HomeBloc();

      final loaded = await bloc.stream.firstWhere((state) => state.status == HomeStatus.loaded);
      expect(
        loaded,
        HomeState(
          status: HomeStatus.loaded,
          configuration: _testConfig,
          snapshot: _testSnapshot0,
        ),
      );

      when(() => exchangeRate.getExchangeRateSnapshot(CurrencyCode.USD)).thenAnswer((_) async {
        await waitMs();
        throw StateError("test error");
      });

      bloc.add(const HomeLoadSnapshotEvent());

      final loading = await bloc.stream.first;
      expect(
        loading,
        HomeState(
          status: HomeStatus.loading,
          configuration: _testConfig,
          snapshot: _testSnapshot0,
        ),
      );

      final error = await bloc.stream.first;
      expect(
        error,
        HomeState(
          status: HomeStatus.loaded,
          configuration: _testConfig,
          snapshot: _testSnapshot0,
          error: const CcError(
            ErrorCode.common_unknown,
            message: "Bad state: test error",
          ),
        ),
      );

      bloc.close();
    });

    test("updates base value", () async {
      when(appStorage.getCurrentConfiguration).thenAnswer((_) async => _testConfig);
      when(() => exchangeRate.getExchangeRateSnapshot(CurrencyCode.USD)).thenAnswer((_) async => _testSnapshot0);

      final bloc = HomeBloc();

      final loaded = await bloc.stream.firstWhere((state) => state.status == HomeStatus.loaded);
      expect(
        loaded,
        HomeState(
          status: HomeStatus.loaded,
          configuration: _testConfig,
          snapshot: _testSnapshot0,
        ),
      );

      when(() => appStorage.updateCurrentConfiguration(any())).thenAnswer((_) async {
        await waitMs();
        throw StateError("test error");
      });

      bloc.add(const HomeUpdateBaseValueEvent(2.0));

      final updated = await bloc.stream.first;
      expect(
        updated,
        HomeState(
          status: HomeStatus.loaded,
          configuration: _testConfig.copyWith(baseValue: 2.0),
          snapshot: _testSnapshot0,
        ),
      );

      final error = await bloc.stream.first;
      expect(
        error,
        HomeState(
          status: HomeStatus.loaded,
          configuration: _testConfig.copyWith(baseValue: 2.0),
          snapshot: _testSnapshot0,
          error: const CcError(
            ErrorCode.common_unknown,
            message: "Bad state: test error",
          ),
        ),
      );

      bloc.close();
    });

    test("updates base value and handles save error", () async {
      when(appStorage.getCurrentConfiguration).thenAnswer((_) async => _testConfig);
      when(() => exchangeRate.getExchangeRateSnapshot(CurrencyCode.USD)).thenAnswer((_) async => _testSnapshot0);

      final bloc = HomeBloc();

      final loaded = await bloc.stream.firstWhere((state) => state.status == HomeStatus.loaded);
      expect(
        loaded,
        HomeState(
          status: HomeStatus.loaded,
          configuration: _testConfig,
          snapshot: _testSnapshot0,
        ),
      );

      bloc.add(const HomeUpdateBaseValueEvent(2.0));

      final updated = await bloc.stream.first;
      expect(
        updated,
        HomeState(
          status: HomeStatus.loaded,
          configuration: _testConfig.copyWith(baseValue: 2.0),
          snapshot: _testSnapshot0,
        ),
      );

      bloc.close();
    });

    test("updates base currency", () async {
      when(appStorage.getCurrentConfiguration).thenAnswer((_) async => _testConfig);
      when(() => exchangeRate.getExchangeRateSnapshot(CurrencyCode.USD)).thenAnswer((_) async => _testSnapshot0);

      final bloc = HomeBloc();

      final loaded = await bloc.stream.firstWhere((state) => state.status == HomeStatus.loaded);
      expect(
        loaded,
        HomeState(
          status: HomeStatus.loaded,
          configuration: _testConfig,
          snapshot: _testSnapshot0,
        ),
      );

      when(() => exchangeRate.getExchangeRateSnapshot(CurrencyCode.KRW)).thenAnswer((_) async {
        await waitMs();
        return _testSnapshot2;
      });

      when(() => appStorage.updateCurrentConfiguration(any())).thenAnswer((_) async {
        await waitMs();
      });

      bloc.add(const HomeUpdateBaseCurrencyEvent(CurrencyCode.KRW));

      final updated = await bloc.stream.first;
      expect(
        updated,
        HomeState(
          status: HomeStatus.loaded,
          configuration: _testConfig.copyWith(baseCurrency: CurrencyCode.KRW),
          snapshot: _testSnapshot2,
        ),
      );

      bloc.close();
    });

    test("handles update base currency exchange error", () async {
      when(appStorage.getCurrentConfiguration).thenAnswer((_) async => _testConfig);
      when(() => exchangeRate.getExchangeRateSnapshot(CurrencyCode.USD)).thenAnswer((_) async => _testSnapshot0);

      final bloc = HomeBloc();

      final loaded = await bloc.stream.firstWhere((state) => state.status == HomeStatus.loaded);
      expect(
        loaded,
        HomeState(
          status: HomeStatus.loaded,
          configuration: _testConfig,
          snapshot: _testSnapshot0,
        ),
      );

      when(() => exchangeRate.getExchangeRateSnapshot(CurrencyCode.KRW)).thenAnswer((_) async {
        await waitMs();
        throw StateError("test error");
      });

      when(() => appStorage.updateCurrentConfiguration(any())).thenAnswer((_) async {
        await waitMs();
      });

      bloc.add(const HomeUpdateBaseCurrencyEvent(CurrencyCode.KRW));

      final error = await bloc.stream.first;
      expect(
        error,
        HomeState(
          status: HomeStatus.loaded,
          configuration: _testConfig,
          snapshot: _testSnapshot0,
          error: const CcError(
            ErrorCode.common_unknown,
            message: "Bad state: test error",
          ),
        ),
      );

      bloc.close();
    });

    test("handles update base currency config error", () async {
      when(appStorage.getCurrentConfiguration).thenAnswer((_) async => _testConfig);
      when(() => exchangeRate.getExchangeRateSnapshot(CurrencyCode.USD)).thenAnswer((_) async => _testSnapshot0);

      final bloc = HomeBloc();

      final loaded = await bloc.stream.firstWhere((state) => state.status == HomeStatus.loaded);
      expect(
        loaded,
        HomeState(
          status: HomeStatus.loaded,
          configuration: _testConfig,
          snapshot: _testSnapshot0,
        ),
      );

      when(() => exchangeRate.getExchangeRateSnapshot(CurrencyCode.KRW)).thenAnswer((_) async {
        await waitMs();
        return _testSnapshot2;
      });

      when(() => appStorage.updateCurrentConfiguration(any())).thenAnswer((_) async {
        await waitMs();
        throw StateError("test error");
      });

      bloc.add(const HomeUpdateBaseCurrencyEvent(CurrencyCode.KRW));

      final updated = await bloc.stream.first;
      expect(
        updated,
        HomeState(
          status: HomeStatus.loaded,
          configuration: _testConfig.copyWith(baseCurrency: CurrencyCode.KRW),
          snapshot: _testSnapshot2,
        ),
      );

      final error = await bloc.stream.first;
      expect(
        error,
        HomeState(
          status: HomeStatus.loaded,
          configuration: _testConfig.copyWith(baseCurrency: CurrencyCode.KRW),
          snapshot: _testSnapshot2,
          error: const CcError(
            ErrorCode.common_unknown,
            message: "Bad state: test error",
          ),
        ),
      );

      bloc.close();
    });

    test("handles toggle current currency", () async {
      when(appStorage.getCurrentConfiguration).thenAnswer((_) async => _testConfig);
      when(() => exchangeRate.getExchangeRateSnapshot(CurrencyCode.USD)).thenAnswer((_) async => _testSnapshot0);

      final bloc = HomeBloc();

      final loaded = await bloc.stream.firstWhere((state) => state.status == HomeStatus.loaded);
      expect(
        loaded,
        HomeState(
          status: HomeStatus.loaded,
          configuration: _testConfig,
          snapshot: _testSnapshot0,
        ),
      );

      when(() => appStorage.updateCurrentConfiguration(any())).thenAnswer((_) async {
        await waitMs();
      });

      bloc.add(const HomeToggleCurrencyEvent(CurrencyCode.KRW));

      final removed = await bloc.stream.first;
      expect(
        removed,
        HomeState(
          status: HomeStatus.loaded,
          configuration: _testConfig.copyWith(currencies: [CurrencyCode.EUR]),
          snapshot: _testSnapshot0,
        ),
      );

      bloc.add(const HomeToggleCurrencyEvent(CurrencyCode.KRW));

      final added = await bloc.stream.first;
      expect(
        added,
        HomeState(
          status: HomeStatus.loaded,
          configuration: _testConfig.copyWith(currencies: [CurrencyCode.EUR, CurrencyCode.KRW]),
          snapshot: _testSnapshot0,
        ),
      );

      bloc.add(const HomeToggleCurrencyEvent(CurrencyCode.MXN));

      final updated = await bloc.stream.first;
      expect(
        updated,
        HomeState(
          status: HomeStatus.loaded,
          configuration: _testConfig.copyWith(currencies: [CurrencyCode.EUR, CurrencyCode.KRW, CurrencyCode.MXN]),
          snapshot: _testSnapshot0,
        ),
      );

      bloc.close();
    });

    test("handles toggle current currency error", () async {
      when(appStorage.getCurrentConfiguration).thenAnswer((_) async => _testConfig);
      when(() => exchangeRate.getExchangeRateSnapshot(CurrencyCode.USD)).thenAnswer((_) async => _testSnapshot0);

      final bloc = HomeBloc();

      final loaded = await bloc.stream.firstWhere((state) => state.status == HomeStatus.loaded);
      expect(
        loaded,
        HomeState(
          status: HomeStatus.loaded,
          configuration: _testConfig,
          snapshot: _testSnapshot0,
        ),
      );

      when(() => appStorage.updateCurrentConfiguration(any())).thenAnswer((_) async {
        await waitMs();
        throw StateError("test error");
      });

      bloc.add(const HomeToggleCurrencyEvent(CurrencyCode.KRW));

      final removed = await bloc.stream.first;
      expect(
        removed,
        HomeState(
          status: HomeStatus.loaded,
          configuration: _testConfig.copyWith(currencies: [CurrencyCode.EUR]),
          snapshot: _testSnapshot0,
        ),
      );

      final error = await bloc.stream.first;
      expect(
        error,
        HomeState(
          status: HomeStatus.loaded,
          configuration: _testConfig.copyWith(currencies: [CurrencyCode.EUR]),
          snapshot: _testSnapshot0,
          error: const CcError(
            ErrorCode.common_unknown,
            message: "Bad state: test error",
          ),
        ),
      );

      bloc.close();
    });
  });
}
