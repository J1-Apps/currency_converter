import "package:currency_converter/model/exchange_rate.dart";

abstract class RemoteExchangeSource {
  Future<ExchangeRateSnapshot> getExchangeRate();
}
