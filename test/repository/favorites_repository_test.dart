import "package:currency_converter/model/currency.dart";
import "package:currency_converter/repository/favorite_repository.dart";
import "package:currency_converter/source/local_favorite_source/local_favorite_source.dart";
import "package:flutter_test/flutter_test.dart";
import "package:j1_environment/j1_environment.dart";
import "package:mocktail/mocktail.dart";

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
    });

    tearDownAll(() async {
      await locator.reset();
    });

    test("gets and updates favorites", () async {
      when(localSource.getFavorites).thenAnswer((_) => Future.value([CurrencyCode.USD, CurrencyCode.KRW]));
      when(() => localSource.updateFavorites(any())).thenAnswer((_) => Future.value());

      expect(
        repository.getFavoritesStream(),
        emitsInOrder(
          [
            null,
            [CurrencyCode.USD, CurrencyCode.KRW],
            [CurrencyCode.USD, CurrencyCode.KRW, CurrencyCode.EUR],
            [CurrencyCode.KRW, CurrencyCode.EUR],
          ],
        ),
      );

      await repository.loadFavorites();
      await repository.addFavorite(CurrencyCode.EUR);
      await repository.removeFavorite(CurrencyCode.USD);

      verify(localSource.getFavorites).called(1);
      verify(() => localSource.updateFavorites([CurrencyCode.USD, CurrencyCode.KRW, CurrencyCode.EUR])).called(1);
      verify(() => localSource.updateFavorites([CurrencyCode.KRW, CurrencyCode.EUR])).called(1);

      repository.dispose();
    });
  });
}
