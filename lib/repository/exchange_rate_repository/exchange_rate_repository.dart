import "package:currency_converter/model/currency.dart";
import "package:currency_converter/model/exchange_rate.dart";

abstract class ExchangeRateRepository {
  Future<ExchangeRateSnapshot> getExchangeRateSnapshot(CurrencyCode currencyCode);
}
