import "package:currency_converter/data/model/currency.dart";
import "package:currency_converter/data/source/local_currency_source/memory_local_currency_source.dart";
import "package:flutter_test/flutter_test.dart";

void main() {
  group("Memory Local Currency Source", () {
    test("gets all currencies", () async {
      final source = MemoryLocalCurrencySource();

      final currencies = await source.getAllCurrencies();
      currencies.sort((a, b) => a.toValue().compareTo(b.toValue()));
      expect(currencies, currencies);
    });
  });
}
