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

    test("gets favorites", () async {
      when(localSource.getFavorites).thenAnswer((_) => Future.value([CurrencyCode.USD, CurrencyCode.KRW]));

      final favorites = await repository.getFavorites();

      expect(favorites, [CurrencyCode.USD, CurrencyCode.KRW]);
      verify(localSource.getFavorites).called(1);
    });

    test("updates favorites", () async {
      when(() => localSource.updateFavorites(any())).thenAnswer((_) => Future.value());

      await repository.updateFavorites([CurrencyCode.USD, CurrencyCode.KRW]);

      verify(() => localSource.updateFavorites([CurrencyCode.USD, CurrencyCode.KRW])).called(1);
    });
  });
}
