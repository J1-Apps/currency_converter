import "package:currency_converter/data/model/cc_error.dart";
import "package:currency_converter/data/model/currency.dart";
import "package:currency_converter/data/repository/data_state.dart";
import "package:currency_converter/data/repository/favorite_repository.dart";
import "package:currency_converter/data/source/local_favorite_source/local_favorite_source.dart";
import "package:flutter_test/flutter_test.dart";
import "package:j1_environment/j1_environment.dart";
import "package:mocktail/mocktail.dart";

import "../../testing_utils.dart";

class MockLocalFavoriteSource extends Mock implements LocalFavoriteSource {}

void main() {
  group("Favorite Repository", () {
    final localSource = MockLocalFavoriteSource();
    late FavoriteRepository repository;

    setUpAll(() {
      locator.registerSingleton<LocalFavoriteSource>(localSource);
    });

    setUp(() {
      repository = FavoriteRepository();
    });

    tearDown(() {
      reset(localSource);
      repository.dispose();
    });

    tearDownAll(() async {
      await locator.reset();
    });

    test("gets and updates favorites, handling errors", () async {
      expect(
        repository.favoritesStream.handleErrorForTest(),
        emitsInOrder(
          [
            const DataEmpty<List<CurrencyCode>>(),
            const DataEmpty<List<CurrencyCode>>(),
            HasErrorCode(ErrorCode.source_local_favorite_readError),
            const DataSuccess([CurrencyCode.USD, CurrencyCode.KRW]),
            const DataSuccess([CurrencyCode.USD, CurrencyCode.KRW, CurrencyCode.EUR]),
            HasErrorCode(ErrorCode.source_local_favorite_writeError),
            const DataSuccess([CurrencyCode.USD, CurrencyCode.KRW, CurrencyCode.EUR, CurrencyCode.MXN]),
            const DataSuccess([CurrencyCode.KRW, CurrencyCode.EUR, CurrencyCode.MXN]),
            HasErrorCode(ErrorCode.source_local_favorite_writeError),
            const DataSuccess([CurrencyCode.KRW, CurrencyCode.EUR]),
            const DataSuccess(<CurrencyCode>[]),
            HasErrorCode(ErrorCode.source_local_favorite_writeError),
          ],
        ),
      );

      when(localSource.getFavorites).thenThrow(const CcError(ErrorCode.source_local_favorite_readError));
      await repository.loadFavorites();

      when(localSource.getFavorites).thenAnswer((_) => Future.value([CurrencyCode.USD, CurrencyCode.KRW]));
      await repository.loadFavorites();

      when(() => localSource.updateFavorites(any())).thenThrow(
        const CcError(ErrorCode.source_local_favorite_writeError),
      );
      await repository.addFavorite(CurrencyCode.EUR);

      when(() => localSource.updateFavorites(any())).thenAnswer((_) => Future.value());
      await repository.addFavorite(CurrencyCode.MXN);

      when(() => localSource.updateFavorites(any())).thenThrow(
        const CcError(ErrorCode.source_local_favorite_writeError),
      );
      await repository.removeFavorite(CurrencyCode.USD);

      when(() => localSource.updateFavorites(any())).thenAnswer((_) => Future.value());
      await repository.removeFavorite(CurrencyCode.MXN);

      when(() => localSource.updateFavorites(any())).thenThrow(
        const CcError(ErrorCode.source_local_favorite_writeError),
      );
      await repository.clearFavorites();

      verify(localSource.getFavorites).called(2);
      verify(() => localSource.updateFavorites(any())).called(5);
      repository.dispose();
    });

    test("handles add and remove seeding errors", () async {
      expect(
        repository.favoritesStream.handleErrorForTest(),
        emitsInOrder(
          [
            const DataEmpty<List<CurrencyCode>>(),
            const DataEmpty<List<CurrencyCode>>(),
            HasErrorCode(ErrorCode.source_local_favorite_readError),
            HasErrorCode(ErrorCode.repository_favorite_notSeededError),
            HasErrorCode(ErrorCode.repository_favorite_notSeededError),
          ],
        ),
      );

      when(localSource.getFavorites).thenThrow(const CcError(ErrorCode.source_local_favorite_readError));
      await repository.loadFavorites();

      await repository.addFavorite(CurrencyCode.EUR);
      await repository.removeFavorite(CurrencyCode.USD);

      verify(localSource.getFavorites).called(1);
      verifyNever(() => localSource.updateFavorites(any()));
      repository.dispose();
    });
  });
}
