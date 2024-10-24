import "package:currency_converter/model/currency.dart";
import "package:currency_converter/source/local_favorite_source/memory_local_favorite_source.dart";
import "package:flutter_test/flutter_test.dart";

void main() {
  group("Memory Local Favorite Source", () {
    test("gets and sets favorites", () async {
      final source = MemoryLocalFavoriteSource();

      expect(await source.getFavorites(), []);

      await source.updateFavorites([CurrencyCode.USD]);
      expect(await source.getFavorites(), [CurrencyCode.USD]);

      await source.updateFavorites([CurrencyCode.USD, CurrencyCode.KRW]);
      expect(await source.getFavorites(), [CurrencyCode.USD, CurrencyCode.KRW]);
    });
  });
}
