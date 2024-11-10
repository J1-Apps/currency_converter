import "package:currency_converter/data/source/local_exchange_source/memory_local_exchange_source.dart";
import "package:flutter_test/flutter_test.dart";

import "../../../testing_values.dart";

void main() {
  group("Memory Local Exchange Source", () {
    test("gets and updates exchange rate", () async {
      final source = MemoryLocalExchangeSource(initialMsDelay: 1);

      final initialRate = await source.getExchangeRate();
      expect(initialRate, null);

      await source.updateExchangeRate(testSnapshot0);
      final snapshot0 = await source.getExchangeRate();
      expect(snapshot0, testSnapshot0);

      await source.updateExchangeRate(testSnapshot1);
      final snapshot1 = await source.getExchangeRate();
      expect(snapshot1, testSnapshot1);
    });
  });
}
