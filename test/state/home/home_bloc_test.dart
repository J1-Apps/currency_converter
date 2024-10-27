// import "package:currency_converter/model/currency.dart";
// import "package:currency_converter/model/exchange_rate.dart";
// import "package:currency_converter/repository/app_storage_repository/app_storage_repository.dart";
// import "package:currency_converter/repository/app_storage_repository/defaults.dart";
// import "package:currency_converter/repository/configuration_repository.dart";
// import "package:currency_converter/repository/data_state.dart";
// import "package:currency_converter/repository/exchange_repository.dart";
// import "package:currency_converter/state/home/home_bloc.dart";
// import "package:currency_converter/state/home/home_event.dart";
// import "package:currency_converter/state/home/home_state.dart";
// import "package:currency_converter/model/cc_error.dart";
// import "package:flutter_test/flutter_test.dart";
// import "package:j1_environment/j1_environment.dart";
// import "package:mocktail/mocktail.dart";

// import "../../testing_utils.dart";
// import "../../testing_values.dart";

// void main() {
//   final appStorage = MockAppStorageRepository();
//   final configuration = MockConfigurationRepository();
//   final exchange = MockExchangeRepository();

//   setUpAll(() {
//     locator.registerSingleton<AppStorageRepository>(appStorage);
//     locator.registerSingleton<ConfigurationRepository>(configuration);
//     locator.registerSingleton<ExchangeRepository>(exchange);

//     registerFallbackValue(testConfig0);
//     registerFallbackValue(testSnapshot0);
//   });

//   tearDown(() {
//     reset(appStorage);
//   });

//   tearDownAll(() async {
//     await locator.reset();
//   });

//   group("Home Bloc", () {
//     test("loads initial configuration and snapshot", () async {
//       when(configuration.getCurrentConfiguration).thenAnswer((_) async {
//         await waitMs();
//         return testConfig0;
//       });

//       when(exchange.getExchangeRateStream).thenAnswer((_) {
//         return Stream<DataState<ExchangeRateSnapshot>>.value(DataSuccess(data: testSnapshot0));
//       });

//       final bloc = HomeBloc()..add(const HomeLoadConfigurationEvent());

//       final loading = await bloc.stream.first;
//       expect(
//         loading,
//         const HomeState(
//           status: HomeStatus.loading,
//           configuration: null,
//           snapshot: null,
//         ),
//       );

//       final loaded = await bloc.stream.first;
//       expect(
//         loaded,
//         HomeState(
//           status: HomeStatus.loaded,
//           configuration: testConfig0,
//           snapshot: testSnapshot0,
//         ),
//       );

//       bloc.close();
//     });

//     test("handles initial configuration load error", () async {
//       when(configuration.getCurrentConfiguration).thenAnswer((_) async {
//         await waitMs();
//         throw StateError("test error");
//       });

//       when(exchange.getExchangeRateStream).thenAnswer((_) {
//         return Stream<DataState<ExchangeRateSnapshot>>.value(DataSuccess(data: testSnapshot0));
//       });

//       final bloc = HomeBloc()..add(const HomeLoadConfigurationEvent());

//       final loading = await bloc.stream.first;
//       expect(
//         loading,
//         const HomeState(
//           status: HomeStatus.loading,
//           configuration: null,
//           snapshot: null,
//         ),
//       );

//       final loaded = await bloc.stream.first;
//       expect(
//         loaded,
//         HomeState(
//           status: HomeStatus.loaded,
//           configuration: defaultConfiguration,
//           snapshot: testSnapshot0,
//           error: const CcError(
//             ErrorCode.common_unknown,
//             message: "Bad state: test error",
//           ),
//         ),
//       );

//       bloc.close();
//     });

//     test("handles initial configuration and snapshot load error", () async {
//       when(configuration.getCurrentConfiguration).thenAnswer((_) async {
//         await waitMs();
//         throw StateError("test configuration error");
//       });

//       when(exchange.getExchangeRateStream).thenAnswer((_) {
//         return Stream<DataState<ExchangeRateSnapshot>>.value(const DataError());
//       });

//       final bloc = HomeBloc()..add(const HomeLoadConfigurationEvent());

//       final loading = await bloc.stream.first;
//       expect(
//         loading,
//         const HomeState(
//           status: HomeStatus.loading,
//           configuration: null,
//           snapshot: null,
//         ),
//       );

//       final error = await bloc.stream.first;
//       expect(
//         error,
//         const HomeState(
//           status: HomeStatus.error,
//           configuration: null,
//           snapshot: null,
//           error: CcError(
//             ErrorCode.common_unknown,
//             message: "Bad state: test configuration error",
//           ),
//         ),
//       );

//       bloc.close();
//     });

//     test("reloads snapshot", () async {
//       when(configuration.getCurrentConfiguration).thenAnswer((_) async => testConfig0);

//       when(exchange.getExchangeRateStream).thenAnswer((_) {
//         return Stream<DataState<ExchangeRateSnapshot>>.value(DataSuccess(data: testSnapshot0));
//       });

//       final bloc = HomeBloc()..add(const HomeLoadConfigurationEvent());

//       final loaded = await bloc.stream.firstWhere((state) => state.status == HomeStatus.loaded);
//       expect(
//         loaded,
//         HomeState(
//           status: HomeStatus.loaded,
//           configuration: testConfig0,
//           snapshot: testSnapshot0,
//         ),
//       );

//       when(exchange.getExchangeRateStream).thenAnswer((_) {
//         return Stream<DataState<ExchangeRateSnapshot>>.value(DataSuccess(data: testSnapshot1));
//       });

//       bloc.add(const HomeRefreshSnapshotEvent());

//       final loading = await bloc.stream.first;
//       expect(
//         loading,
//         HomeState(
//           status: HomeStatus.loaded,
//           configuration: testConfig0,
//           snapshot: testSnapshot0,
//           isRefreshing: true,
//         ),
//       );

//       final reloaded = await bloc.stream.first;
//       expect(
//         reloaded,
//         HomeState(
//           status: HomeStatus.loaded,
//           configuration: testConfig0,
//           snapshot: testSnapshot1,
//         ),
//       );

//       bloc.close();
//     });

//     test("handles reload snapshot error", () async {
//       when(configuration.getCurrentConfiguration).thenAnswer((_) async => testConfig0);

//       when(exchange.getExchangeRateStream).thenAnswer((_) {
//         return Stream<DataState<ExchangeRateSnapshot>>.value(DataSuccess(data: testSnapshot0));
//       });

//       final bloc = HomeBloc()..add(const HomeLoadConfigurationEvent());

//       final loaded = await bloc.stream.firstWhere((state) => state.status == HomeStatus.loaded);
//       expect(
//         loaded,
//         HomeState(
//           status: HomeStatus.loaded,
//           configuration: testConfig0,
//           snapshot: testSnapshot0,
//         ),
//       );

//       when(exchange.getExchangeRateStream).thenAnswer((_) {
//         return Stream<DataState<ExchangeRateSnapshot>>.value(const DataError());
//       });

//       bloc.add(const HomeRefreshSnapshotEvent());

//       final loading = await bloc.stream.first;
//       expect(
//         loading,
//         HomeState(
//           status: HomeStatus.loaded,
//           configuration: testConfig0,
//           snapshot: testSnapshot0,
//           isRefreshing: true,
//         ),
//       );

//       final error = await bloc.stream.first;
//       expect(
//         error,
//         HomeState(
//           status: HomeStatus.loaded,
//           configuration: testConfig0,
//           snapshot: testSnapshot0,
//           error: const CcError(
//             ErrorCode.common_unknown,
//             message: "Bad state: test error",
//           ),
//         ),
//       );

//       bloc.close();
//     });

//     test("updates base value", () async {
//       when(configuration.getCurrentConfiguration).thenAnswer((_) async => testConfig0);

//       when(exchange.getExchangeRateStream).thenAnswer((_) {
//         return Stream<DataState<ExchangeRateSnapshot>>.value(DataSuccess(data: testSnapshot0));
//       });

//       final bloc = HomeBloc()..add(const HomeLoadConfigurationEvent());

//       final loaded = await bloc.stream.firstWhere((state) => state.status == HomeStatus.loaded);
//       expect(
//         loaded,
//         HomeState(
//           status: HomeStatus.loaded,
//           configuration: testConfig0,
//           snapshot: testSnapshot0,
//         ),
//       );

//       when(() => configuration.updateCurrentConfiguration(any())).thenAnswer((_) async {
//         await waitMs();
//         throw StateError("test error");
//       });

//       bloc.add(const HomeUpdateBaseValueEvent(2.0));

//       final updated = await bloc.stream.first;
//       expect(
//         updated,
//         HomeState(
//           status: HomeStatus.loaded,
//           configuration: testConfig0.copyWith(baseValue: 2.0),
//           snapshot: testSnapshot0,
//         ),
//       );

//       final error = await bloc.stream.first;
//       expect(
//         error,
//         HomeState(
//           status: HomeStatus.loaded,
//           configuration: testConfig0.copyWith(baseValue: 2.0),
//           snapshot: testSnapshot0,
//           error: const CcError(
//             ErrorCode.common_unknown,
//             message: "Bad state: test error",
//           ),
//         ),
//       );

//       bloc.close();
//     });

//     test("updates base value and handles save error", () async {
//       when(configuration.getCurrentConfiguration).thenAnswer((_) async => testConfig0);

//       when(exchange.getExchangeRateStream).thenAnswer((_) {
//         return Stream<DataState<ExchangeRateSnapshot>>.value(DataSuccess(data: testSnapshot0));
//       });

//       final bloc = HomeBloc()..add(const HomeLoadConfigurationEvent());

//       final loaded = await bloc.stream.firstWhere((state) => state.status == HomeStatus.loaded);
//       expect(
//         loaded,
//         HomeState(
//           status: HomeStatus.loaded,
//           configuration: testConfig0,
//           snapshot: testSnapshot0,
//         ),
//       );

//       bloc.add(const HomeUpdateBaseValueEvent(2.0));

//       final updated = await bloc.stream.first;
//       expect(
//         updated,
//         HomeState(
//           status: HomeStatus.loaded,
//           configuration: testConfig0.copyWith(baseValue: 2.0),
//           snapshot: testSnapshot0,
//         ),
//       );

//       bloc.close();
//     });

//     test("updates base currency", () async {
//       when(configuration.getCurrentConfiguration).thenAnswer((_) async => testConfig0);

//       when(exchange.getExchangeRateStream).thenAnswer((_) {
//         return Stream<DataState<ExchangeRateSnapshot>>.value(DataSuccess(data: testSnapshot0));
//       });

//       final bloc = HomeBloc()..add(const HomeLoadConfigurationEvent());

//       final loaded = await bloc.stream.firstWhere((state) => state.status == HomeStatus.loaded);
//       expect(
//         loaded,
//         HomeState(
//           status: HomeStatus.loaded,
//           configuration: testConfig0,
//           snapshot: testSnapshot0,
//         ),
//       );

//       when(() => configuration.updateCurrentConfiguration(any())).thenAnswer((_) async {
//         await waitMs();
//       });

//       bloc.add(const HomeUpdateBaseCurrencyEvent(CurrencyCode.KRW));

//       final updated = await bloc.stream.first;
//       expect(
//         updated,
//         HomeState(
//           status: HomeStatus.loaded,
//           configuration: testConfig0.copyWith(
//             baseCurrency: CurrencyCode.KRW,
//             baseValue: 1000,
//             currencies: [CurrencyCode.USD, CurrencyCode.EUR],
//           ),
//           snapshot: testSnapshot0,
//         ),
//       );

//       bloc.close();
//     });

//     test("handles update base currency config error", () async {
//       when(configuration.getCurrentConfiguration).thenAnswer((_) async => testConfig0);

//       when(exchange.getExchangeRateStream).thenAnswer((_) {
//         return Stream<DataState<ExchangeRateSnapshot>>.value(DataSuccess(data: testSnapshot0));
//       });

//       final bloc = HomeBloc()..add(const HomeLoadConfigurationEvent());

//       final loaded = await bloc.stream.firstWhere((state) => state.status == HomeStatus.loaded);
//       expect(
//         loaded,
//         HomeState(
//           status: HomeStatus.loaded,
//           configuration: testConfig0,
//           snapshot: testSnapshot0,
//         ),
//       );

//       when(() => configuration.updateCurrentConfiguration(any())).thenAnswer((_) async {
//         await waitMs();
//         throw StateError("test error");
//       });

//       bloc.add(const HomeUpdateBaseCurrencyEvent(CurrencyCode.KRW));

//       final updated = await bloc.stream.first;
//       expect(
//         updated,
//         HomeState(
//           status: HomeStatus.loaded,
//           configuration: testConfig0.copyWith(
//             baseCurrency: CurrencyCode.KRW,
//             baseValue: 1000,
//             currencies: [CurrencyCode.USD, CurrencyCode.EUR],
//           ),
//           snapshot: testSnapshot0,
//         ),
//       );

//       final error = await bloc.stream.first;
//       expect(
//         error,
//         HomeState(
//           status: HomeStatus.loaded,
//           configuration: testConfig0.copyWith(
//             baseCurrency: CurrencyCode.KRW,
//             baseValue: 1000,
//             currencies: [CurrencyCode.USD, CurrencyCode.EUR],
//           ),
//           snapshot: testSnapshot0,
//           error: const CcError(
//             ErrorCode.common_unknown,
//             message: "Bad state: test error",
//           ),
//         ),
//       );

//       bloc.close();
//     });

//     test("handles toggle current currency", () async {
//       when(configuration.getCurrentConfiguration).thenAnswer((_) async => testConfig0);

//       when(exchange.getExchangeRateStream).thenAnswer((_) {
//         return Stream<DataState<ExchangeRateSnapshot>>.value(DataSuccess(data: testSnapshot0));
//       });

//       final bloc = HomeBloc()..add(const HomeLoadConfigurationEvent());

//       final loaded = await bloc.stream.firstWhere((state) => state.status == HomeStatus.loaded);
//       expect(
//         loaded,
//         HomeState(
//           status: HomeStatus.loaded,
//           configuration: testConfig0,
//           snapshot: testSnapshot0,
//         ),
//       );

//       when(() => configuration.updateCurrentConfiguration(any())).thenAnswer((_) async {
//         await waitMs();
//       });

//       bloc.add(const HomeToggleCurrencyEvent(CurrencyCode.KRW));

//       final removed = await bloc.stream.first;
//       expect(
//         removed,
//         HomeState(
//           status: HomeStatus.loaded,
//           configuration: testConfig0.copyWith(currencies: [CurrencyCode.EUR]),
//           snapshot: testSnapshot0,
//         ),
//       );

//       bloc.add(const HomeToggleCurrencyEvent(CurrencyCode.KRW));

//       final added = await bloc.stream.first;
//       expect(
//         added,
//         HomeState(
//           status: HomeStatus.loaded,
//           configuration: testConfig0.copyWith(currencies: [CurrencyCode.EUR, CurrencyCode.KRW]),
//           snapshot: testSnapshot0,
//         ),
//       );

//       bloc.add(const HomeToggleCurrencyEvent(CurrencyCode.MXN));

//       final updated = await bloc.stream.first;
//       expect(
//         updated,
//         HomeState(
//           status: HomeStatus.loaded,
//           configuration: testConfig0.copyWith(currencies: [CurrencyCode.EUR, CurrencyCode.KRW, CurrencyCode.MXN]),
//           snapshot: testSnapshot0,
//         ),
//       );

//       bloc.close();
//     });

//     test("handles toggle current currency error", () async {
//       when(configuration.getCurrentConfiguration).thenAnswer((_) async => testConfig0);

//       when(exchange.getExchangeRateStream).thenAnswer((_) {
//         return Stream<DataState<ExchangeRateSnapshot>>.value(DataSuccess(data: testSnapshot0));
//       });

//       final bloc = HomeBloc()..add(const HomeLoadConfigurationEvent());

//       final loaded = await bloc.stream.firstWhere((state) => state.status == HomeStatus.loaded);
//       expect(
//         loaded,
//         HomeState(
//           status: HomeStatus.loaded,
//           configuration: testConfig0,
//           snapshot: testSnapshot0,
//         ),
//       );

//       when(() => configuration.updateCurrentConfiguration(any())).thenAnswer((_) async {
//         await waitMs();
//         throw StateError("test error");
//       });

//       bloc.add(const HomeToggleCurrencyEvent(CurrencyCode.KRW));

//       final removed = await bloc.stream.first;
//       expect(
//         removed,
//         HomeState(
//           status: HomeStatus.loaded,
//           configuration: testConfig0.copyWith(currencies: [CurrencyCode.EUR]),
//           snapshot: testSnapshot0,
//         ),
//       );

//       final error = await bloc.stream.first;
//       expect(
//         error,
//         HomeState(
//           status: HomeStatus.loaded,
//           configuration: testConfig0.copyWith(currencies: [CurrencyCode.EUR]),
//           snapshot: testSnapshot0,
//           error: const CcError(
//             ErrorCode.common_unknown,
//             message: "Bad state: test error",
//           ),
//         ),
//       );

//       bloc.close();
//     });

//     test("handles update current currency", () async {
//       when(configuration.getCurrentConfiguration).thenAnswer((_) async => testConfig0);

//       when(exchange.getExchangeRateStream).thenAnswer((_) {
//         return Stream<DataState<ExchangeRateSnapshot>>.value(DataSuccess(data: testSnapshot0));
//       });

//       final bloc = HomeBloc()..add(const HomeLoadConfigurationEvent());

//       final loaded = await bloc.stream.firstWhere((state) => state.status == HomeStatus.loaded);
//       expect(
//         loaded,
//         HomeState(
//           status: HomeStatus.loaded,
//           configuration: testConfig0,
//           snapshot: testSnapshot0,
//         ),
//       );

//       when(() => configuration.updateCurrentConfiguration(any())).thenAnswer((_) async {
//         await waitMs();
//       });

//       bloc.add(const HomeUpdateCurrencyEvent(1, CurrencyCode.JPY));

//       final updated0 = await bloc.stream.first;
//       expect(
//         updated0,
//         HomeState(
//           status: HomeStatus.loaded,
//           configuration: testConfig0.copyWith(currencies: [CurrencyCode.KRW, CurrencyCode.JPY]),
//           snapshot: testSnapshot0,
//         ),
//       );

//       bloc.add(const HomeUpdateCurrencyEvent(0, CurrencyCode.MXN));

//       final updated1 = await bloc.stream.first;
//       expect(
//         updated1,
//         HomeState(
//           status: HomeStatus.loaded,
//           configuration: testConfig0.copyWith(currencies: [CurrencyCode.MXN, CurrencyCode.JPY]),
//           snapshot: testSnapshot0,
//         ),
//       );

//       bloc.close();
//     });

//     test("handles update current currency error", () async {
//       when(configuration.getCurrentConfiguration).thenAnswer((_) async => testConfig0);

//       when(exchange.getExchangeRateStream).thenAnswer((_) {
//         return Stream<DataState<ExchangeRateSnapshot>>.value(DataSuccess(data: testSnapshot0));
//       });

//       final bloc = HomeBloc()..add(const HomeLoadConfigurationEvent());

//       final loaded = await bloc.stream.firstWhere((state) => state.status == HomeStatus.loaded);
//       expect(
//         loaded,
//         HomeState(
//           status: HomeStatus.loaded,
//           configuration: testConfig0,
//           snapshot: testSnapshot0,
//         ),
//       );

//       when(() => configuration.updateCurrentConfiguration(any())).thenAnswer((_) async {
//         await waitMs();
//         throw StateError("test error");
//       });

//       bloc.add(const HomeUpdateCurrencyEvent(1, CurrencyCode.JPY));

//       final updated0 = await bloc.stream.first;
//       expect(
//         updated0,
//         HomeState(
//           status: HomeStatus.loaded,
//           configuration: testConfig0.copyWith(currencies: [CurrencyCode.KRW, CurrencyCode.JPY]),
//           snapshot: testSnapshot0,
//         ),
//       );

//       final error = await bloc.stream.first;
//       expect(
//         error,
//         HomeState(
//           status: HomeStatus.loaded,
//           configuration: testConfig0.copyWith(currencies: [CurrencyCode.KRW, CurrencyCode.JPY]),
//           snapshot: testSnapshot0,
//           error: const CcError(
//             ErrorCode.common_unknown,
//             message: "Bad state: test error",
//           ),
//         ),
//       );

//       bloc.close();
//     });
//   });
// }
