import "package:currency_converter/model/currency.dart";
import "package:currency_converter/repository/exchange_rate_repository/local_exchange_rate_repository.dart";
import "package:currency_converter/model/cc_error.dart";
import "package:flutter_test/flutter_test.dart";

import "../../testing_utils.dart";

void main() {
  group("Local Exchange Rate Repository", () {
    final repository = LocalExchangeRateRepository();

    tearDown(repository.reset);

    test("gets exchange rate", () async {
      repository.msDelay = 0;

      final snapshot = await repository.getExchangeRateSnapshot();

      expect(snapshot.exchangeRates[CurrencyCode.USD], greaterThan(0.99));
      expect(snapshot.exchangeRates[CurrencyCode.KRW], greaterThan(0.99));
      expect(snapshot.exchangeRates[CurrencyCode.MXN], greaterThan(0.99));
    });

    test("throws on get exchange rate when requested", () async {
      final repository = LocalExchangeRateRepository();
      repository.shouldThrow = true;
      repository.msDelay = 0;

      expect(
        () async => repository.getExchangeRateSnapshot(),
        throwsA(HasErrorCode(ErrorCode.repository_exchangeRate_httpError)),
      );
    });
  });
}
