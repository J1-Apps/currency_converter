import "package:currency_converter/models/currency.dart";
import "package:currency_converter/models/exchange_rate.dart";

abstract class ExchangeRateRepository {
  Future<ExchangeRateSnapshot> getExchangeRateSnapshot(CurrencyCode currencyCode);
}
