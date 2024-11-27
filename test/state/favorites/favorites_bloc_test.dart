import "package:currency_converter/data/model/cc_error.dart";
import "package:currency_converter/data/model/currency.dart";
import "package:currency_converter/data/repository/currency_repository.dart";
import "package:currency_converter/data/repository/data_state.dart";
import "package:currency_converter/data/repository/favorite_repository.dart";
import "package:currency_converter/state/favorites/favorites_bloc.dart";
import "package:currency_converter/state/favorites/favorites_event.dart";
import "package:currency_converter/state/favorites/favorites_state.dart";
import "package:currency_converter/util/analytics.dart";
import "package:flutter_test/flutter_test.dart";
import "package:j1_environment/j1_environment.dart";
import "package:j1_logger/j1_logger.dart";
import "package:mocktail/mocktail.dart";
import "package:rxdart/rxdart.dart";

import "../../testing_utils.dart";
import "../../testing_values.dart";

void main() {
  final favorite = MockFavoriteRepository();
  final currency = MockCurrencyRepository();
  final logger = MockLogger();

  setUpAll(() {
    locator.registerSingleton<FavoriteRepository>(favorite);
    locator.registerSingleton<CurrencyRepository>(currency);
    locator.registerSingleton<J1Logger>(logger);
  });

  setUp(() {
    when(() => favorite.favoritesStream).thenAnswer((_) => Stream.value(const DataSuccess(testFavorites0)));
    when(favorite.loadFavorites).thenAnswer((_) => Future.value());

    when(() => currency.allCurrenciesStream).thenAnswer((_) => Stream.value(DataSuccess(testCurrencies1)));
    when(currency.loadAllCurrencies).thenAnswer((_) => Future.value());

    when(() => logger.logBloc(name: any(named: "name"), bloc: any(named: "bloc"))).thenAnswer((_) => Future.value());
  });

  tearDown(() {
    reset(favorite);
    reset(currency);
    reset(logger);
  });

  tearDownAll(() async {
    await locator.reset();
  });

  group("Favorites Bloc", () {
    test("loads initial favorites and currencies", () async {
      final bloc = FavoritesBloc();
      expect(
        bloc.stream,
        emitsInOrder(
          [
            const FavoritesState.loading(),
            const FavoritesState.loaded(
              favorites: testFavorites0,
              nonFavorites: [CurrencyCode.EUR, CurrencyCode.MXN, CurrencyCode.JPY],
            ),
          ],
        ),
      );

      bloc.add(const FavoritesLoadEvent());
      await waitMs();

      bloc.close();
    });

    test("handles initial favorites and currencies load error", () async {
      when(() => favorite.favoritesStream).thenAnswer(
        (_) => Stream.value(const DataEmpty<List<CurrencyCode>>()),
      );

      when(() => currency.allCurrenciesStream).thenAnswer(
        (_) => Stream.value(const DataEmpty<List<CurrencyCode>>()),
      );

      final bloc = FavoritesBloc();
      expect(
        bloc.stream,
        emitsInOrder(
          [
            const FavoritesState.loading(),
            FavoritesState.loaded(favorites: [], nonFavorites: testCurrencies0),
          ],
        ),
      );

      bloc.add(const FavoritesLoadEvent());
      await waitMs();

      bloc.close();
    });

    test("handles load favorites error", () async {
      final favoritesController = BehaviorSubject<DataState<List<CurrencyCode>>>.seeded(
        const DataSuccess(testFavorites0),
      );

      when(() => favorite.favoritesStream).thenAnswer((_) => favoritesController.stream);

      final bloc = FavoritesBloc();
      expect(
        bloc.stream,
        emitsInOrder(
          [
            const FavoritesState.loading(),
            const FavoritesState.loaded(
              favorites: testFavorites0,
              nonFavorites: [CurrencyCode.EUR, CurrencyCode.MXN, CurrencyCode.JPY],
            ),
            const FavoritesState.loaded(
              favorites: testFavorites0,
              nonFavorites: [CurrencyCode.EUR, CurrencyCode.MXN, CurrencyCode.JPY],
              error: FavoritesErrorCode.loadFavorites,
            ),
          ],
        ),
      );

      bloc.add(const FavoritesLoadEvent());
      await waitMs();

      favoritesController.addError(const CcError(ErrorCode.source_local_favorite_readError));
      await waitMs();

      verify(
        () => logger.logBloc(name: Analytics.errorEvent, bloc: Analytics.favoritesBloc, params: any(named: "params")),
      ).called(1);

      bloc.close();
      favoritesController.close();
    });

    test("handles load currencies error", () async {
      final currencyController = BehaviorSubject<DataState<List<CurrencyCode>>>.seeded(DataSuccess(testCurrencies1));

      when(() => currency.allCurrenciesStream).thenAnswer((_) => currencyController.stream);

      final bloc = FavoritesBloc();
      expect(
        bloc.stream,
        emitsInOrder(
          [
            const FavoritesState.loading(),
            const FavoritesState.loaded(
              favorites: testFavorites0,
              nonFavorites: [CurrencyCode.EUR, CurrencyCode.MXN, CurrencyCode.JPY],
            ),
            const FavoritesState.loaded(
              favorites: testFavorites0,
              nonFavorites: [CurrencyCode.EUR, CurrencyCode.MXN, CurrencyCode.JPY],
              error: FavoritesErrorCode.loadCurrencies,
            ),
          ],
        ),
      );

      bloc.add(const FavoritesLoadEvent());
      await waitMs();

      currencyController.addError(const CcError(ErrorCode.source_local_currency_allReadError));
      await waitMs();

      verify(
        () => logger.logBloc(name: Analytics.errorEvent, bloc: Analytics.favoritesBloc, params: any(named: "params")),
      ).called(1);

      bloc.close();
      currencyController.close();
    });

    test("handles toggle favorite", () async {
      final favoriteController = BehaviorSubject<DataState<List<CurrencyCode>>>.seeded(
        const DataSuccess(testFavorites0),
      );

      when(() => favorite.favoritesStream).thenAnswer((_) => favoriteController.stream);

      final bloc = FavoritesBloc();
      expect(
        bloc.stream,
        emitsInOrder(
          [
            const FavoritesState.loading(),
            const FavoritesState.loaded(
              favorites: testFavorites0,
              nonFavorites: [CurrencyCode.EUR, CurrencyCode.MXN, CurrencyCode.JPY],
            ),
            const FavoritesState.loaded(
              favorites: [...testFavorites0, CurrencyCode.EUR],
              nonFavorites: [CurrencyCode.MXN, CurrencyCode.JPY],
            ),
            const FavoritesState.loaded(
              favorites: testFavorites0,
              nonFavorites: [CurrencyCode.EUR, CurrencyCode.MXN, CurrencyCode.JPY],
            ),
          ],
        ),
      );

      bloc.add(const FavoritesLoadEvent());
      await waitMs();

      when(() => favorite.addFavorite(CurrencyCode.EUR)).thenAnswer((_) => Future.value());
      when(() => favorite.removeFavorite(CurrencyCode.EUR)).thenAnswer((_) => Future.value());

      bloc.add(const FavoritesToggleEvent(CurrencyCode.EUR, true));
      favoriteController.add(const DataSuccess([...testFavorites0, CurrencyCode.EUR]));

      bloc.add(const FavoritesToggleEvent(CurrencyCode.EUR, false));
      favoriteController.add(const DataSuccess(testFavorites0));
      await waitMs();

      bloc.close();
      favoriteController.close();
    });

    test("handles toggle favorite error", () async {
      final favoriteController = BehaviorSubject<DataState<List<CurrencyCode>>>.seeded(
        const DataSuccess(testFavorites0),
      );

      when(() => favorite.favoritesStream).thenAnswer((_) => favoriteController.stream);

      final bloc = FavoritesBloc();
      expect(
        bloc.stream,
        emitsInOrder(
          [
            const FavoritesState.loading(),
            const FavoritesState.loaded(
              favorites: testFavorites0,
              nonFavorites: [CurrencyCode.EUR, CurrencyCode.MXN, CurrencyCode.JPY],
            ),
            const FavoritesState.loaded(
              favorites: testFavorites0,
              nonFavorites: [CurrencyCode.EUR, CurrencyCode.MXN, CurrencyCode.JPY],
              error: FavoritesErrorCode.saveFavorite,
            ),
            const FavoritesState.loaded(
              favorites: [...testFavorites0, CurrencyCode.EUR],
              nonFavorites: [CurrencyCode.MXN, CurrencyCode.JPY],
            ),
          ],
        ),
      );

      bloc.add(const FavoritesLoadEvent());
      await waitMs();

      when(() => favorite.addFavorite(CurrencyCode.EUR)).thenThrow(
        const CcError(ErrorCode.source_local_favorite_writeError),
      );

      bloc.add(const FavoritesToggleEvent(CurrencyCode.EUR, true));
      favoriteController.add(const DataSuccess([...testFavorites0, CurrencyCode.EUR]));
      await waitMs();

      verify(
        () => logger.logBloc(name: Analytics.errorEvent, bloc: Analytics.favoritesBloc, params: any(named: "params")),
      ).called(1);

      bloc.close();
      favoriteController.close();
    });
  });
}
