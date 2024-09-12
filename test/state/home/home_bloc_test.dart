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
  {CurrencyCode.KRW, CurrencyCode.EUR},
);

final _testSnapshot0 = ExchangeRateSnapshot(
  DateTime.now().toUtc(),
  CurrencyCode.USD,
  {CurrencyCode.KRW: 1000.0, CurrencyCode.EUR: 1.0},
);

final _testSnapshot1 = ExchangeRateSnapshot(
  DateTime.now().toUtc(),
  CurrencyCode.USD,
  {CurrencyCode.KRW: 1100.0, CurrencyCode.EUR: 1.1},
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
      when(appStorage.getFavoritesStream).thenAnswer((_) => Stream<List<CurrencyCode>>.value([]));

      when(appStorage.getCurrentConfiguration).thenAnswer((_) async {
        await waitMs();
        return _testConfig;
      });

      when(() => exchangeRate.getExchangeRateSnapshot(CurrencyCode.USD)).thenAnswer((_) async {
        await waitMs();
        return _testSnapshot0;
      });

      final bloc = HomeBloc();

      final initial = await bloc.stream.first;
      expect(
        initial,
        const HomeState(
          HomeLoadingState.loadingConfig,
          null,
          null,
          [],
          null,
        ),
      );

      final configured = await bloc.stream.first;
      expect(
        configured,
        const HomeState(
          HomeLoadingState.loadingSnapshot,
          _testConfig,
          null,
          [],
          null,
        ),
      );

      final loaded = await bloc.stream.first;
      expect(
        loaded,
        HomeState(
          HomeLoadingState.loaded,
          _testConfig,
          _testSnapshot0,
          [],
          null,
        ),
      );

      bloc.close();
    });

    test("handles initial configuration load error", () async {
      when(appStorage.getFavoritesStream).thenAnswer((_) => Stream<List<CurrencyCode>>.value([]));

      when(appStorage.getCurrentConfiguration).thenAnswer((_) async {
        await waitMs();
        throw StateError("test error");
      });

      when(() => exchangeRate.getExchangeRateSnapshot(CurrencyCode.USD)).thenAnswer((_) async {
        await waitMs();
        return _testSnapshot0;
      });

      final bloc = HomeBloc();

      final initial = await bloc.stream.first;
      expect(
        initial,
        const HomeState(
          HomeLoadingState.loadingConfig,
          null,
          null,
          [],
          null,
        ),
      );

      final configured = await bloc.stream.first;
      expect(
        configured,
        const HomeState(
          HomeLoadingState.loadingSnapshot,
          defaultConfiguration,
          null,
          [],
          CcError(
            ErrorCode.common_unknown,
            message: "Bad state: test error",
          ),
        ),
      );

      final loaded = await bloc.stream.first;
      expect(
        loaded,
        HomeState(
          HomeLoadingState.loaded,
          defaultConfiguration,
          _testSnapshot0,
          [],
          null,
        ),
      );

      bloc.close();
    });

    test("handles initial configuration and snapshot load error", () async {
      when(appStorage.getFavoritesStream).thenAnswer((_) => Stream<List<CurrencyCode>>.value([]));

      when(appStorage.getCurrentConfiguration).thenAnswer((_) async {
        await waitMs();
        throw StateError("test configuration error");
      });

      when(() => exchangeRate.getExchangeRateSnapshot(CurrencyCode.USD)).thenAnswer((_) async {
        await waitMs();
        throw StateError("test snapshot error");
      });

      final bloc = HomeBloc();

      final initial = await bloc.stream.first;
      expect(
        initial,
        const HomeState(
          HomeLoadingState.loadingConfig,
          null,
          null,
          [],
          null,
        ),
      );

      final configured = await bloc.stream.first;
      expect(
        configured,
        const HomeState(
          HomeLoadingState.loadingSnapshot,
          defaultConfiguration,
          null,
          [],
          CcError(
            ErrorCode.common_unknown,
            message: "Bad state: test configuration error",
          ),
        ),
      );

      final loaded = await bloc.stream.first;
      expect(
        loaded,
        const HomeState(
          HomeLoadingState.snapshotError,
          defaultConfiguration,
          null,
          [],
          CcError(
            ErrorCode.common_unknown,
            message: "Bad state: test snapshot error",
          ),
        ),
      );

      bloc.close();
    });

    test("reloads snapshot", () async {
      when(appStorage.getFavoritesStream).thenAnswer((_) => Stream<List<CurrencyCode>>.value([]));
      when(appStorage.getCurrentConfiguration).thenAnswer((_) async => _testConfig);
      when(() => exchangeRate.getExchangeRateSnapshot(CurrencyCode.USD)).thenAnswer((_) async => _testSnapshot0);

      final bloc = HomeBloc();

      final loaded = await bloc.stream.firstWhere((state) => state.loadingState == HomeLoadingState.loaded);
      expect(
        loaded,
        HomeState(
          HomeLoadingState.loaded,
          _testConfig,
          _testSnapshot0,
          [],
          null,
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
          HomeLoadingState.loadingSnapshot,
          _testConfig,
          _testSnapshot0,
          [],
          null,
        ),
      );

      final reloaded = await bloc.stream.first;
      expect(
        reloaded,
        HomeState(
          HomeLoadingState.loaded,
          _testConfig,
          _testSnapshot1,
          [],
          null,
        ),
      );

      bloc.close();
    });

    test("handles reload snapshot error", () async {
      when(appStorage.getFavoritesStream).thenAnswer((_) => Stream<List<CurrencyCode>>.value([]));
      when(appStorage.getCurrentConfiguration).thenAnswer((_) async => _testConfig);
      when(() => exchangeRate.getExchangeRateSnapshot(CurrencyCode.USD)).thenAnswer((_) async => _testSnapshot0);

      final bloc = HomeBloc();

      final loaded = await bloc.stream.firstWhere((state) => state.loadingState == HomeLoadingState.loaded);
      expect(
        loaded,
        HomeState(
          HomeLoadingState.loaded,
          _testConfig,
          _testSnapshot0,
          [],
          null,
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
          HomeLoadingState.loadingSnapshot,
          _testConfig,
          _testSnapshot0,
          [],
          null,
        ),
      );

      final error = await bloc.stream.first;
      expect(
        error,
        HomeState(
          HomeLoadingState.loaded,
          _testConfig,
          _testSnapshot0,
          [],
          const CcError(
            ErrorCode.common_unknown,
            message: "Bad state: test error",
          ),
        ),
      );

      bloc.close();
    });

    test("updates base value", () async {
      when(appStorage.getFavoritesStream).thenAnswer((_) => Stream<List<CurrencyCode>>.value([]));
      when(appStorage.getCurrentConfiguration).thenAnswer((_) async => _testConfig);
      when(() => exchangeRate.getExchangeRateSnapshot(CurrencyCode.USD)).thenAnswer((_) async => _testSnapshot0);

      final bloc = HomeBloc();

      final loaded = await bloc.stream.firstWhere((state) => state.loadingState == HomeLoadingState.loaded);
      expect(
        loaded,
        HomeState(
          HomeLoadingState.loaded,
          _testConfig,
          _testSnapshot0,
          [],
          null,
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
          HomeLoadingState.loaded,
          _testConfig.copyWith(baseValue: 2.0),
          _testSnapshot0,
          [],
          null,
        ),
      );

      final error = await bloc.stream.first;
      expect(
        error,
        HomeState(
          HomeLoadingState.loaded,
          _testConfig.copyWith(baseValue: 2.0),
          _testSnapshot0,
          [],
          const CcError(
            ErrorCode.common_unknown,
            message: "Bad state: test error",
          ),
        ),
      );

      bloc.close();
    });

    test("updates base value and handles save error", () async {
      when(appStorage.getFavoritesStream).thenAnswer((_) => Stream<List<CurrencyCode>>.value([]));
      when(appStorage.getCurrentConfiguration).thenAnswer((_) async => _testConfig);
      when(() => exchangeRate.getExchangeRateSnapshot(CurrencyCode.USD)).thenAnswer((_) async => _testSnapshot0);

      final bloc = HomeBloc();

      final loaded = await bloc.stream.firstWhere((state) => state.loadingState == HomeLoadingState.loaded);
      expect(
        loaded,
        HomeState(
          HomeLoadingState.loaded,
          _testConfig,
          _testSnapshot0,
          [],
          null,
        ),
      );

      bloc.add(const HomeUpdateBaseValueEvent(2.0));

      final updated = await bloc.stream.first;
      expect(
        updated,
        HomeState(
          HomeLoadingState.loaded,
          _testConfig.copyWith(baseValue: 2.0),
          _testSnapshot0,
          [],
          null,
        ),
      );

      bloc.close();
    });
  });
}
