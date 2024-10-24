import "package:currency_converter/model/currency.dart";
import "package:currency_converter/source/remote_exchange_source.dart/memory_remote_exchange_source.dart";
import "package:currency_converter/model/cc_error.dart";
import "package:flutter_test/flutter_test.dart";

import "../../testing_utils.dart";

void main() {
  group("Memory Remote Exchange Source", () {
    final source = MemoryRemoteExchangeSource();

    tearDown(source.reset);

    test("gets exchange rate", () async {
      source.msDelay = 0;

      final snapshot = await source.getExchangeRateSnapshot();

      expect(snapshot.exchangeRates[CurrencyCode.USD], greaterThan(0.99));
      expect(snapshot.exchangeRates[CurrencyCode.KRW], greaterThan(0.99));
      expect(snapshot.exchangeRates[CurrencyCode.MXN], greaterThan(0.99));
    });

    test("throws on get exchange rate when requested", () async {
      source.shouldThrow = true;
      source.msDelay = 0;

      expect(
        () async => source.getExchangeRateSnapshot(),
        throwsA(HasErrorCode(ErrorCode.source_exchangeRate_httpError)),
      );
    });
  });
}
