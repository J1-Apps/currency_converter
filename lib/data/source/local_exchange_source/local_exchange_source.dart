import "package:currency_converter/data/model/exchange_rate.dart";

abstract class LocalExchangeSource {
  Future<ExchangeRateSnapshot?> getExchangeRate();
  Future<void> updateExchangeRate(ExchangeRateSnapshot snapshot);
}
