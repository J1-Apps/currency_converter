import "package:currency_converter/data/model/exchange_rate.dart";

abstract class RemoteExchangeSource {
  Future<ExchangeRateSnapshot> getExchangeRate();
}
