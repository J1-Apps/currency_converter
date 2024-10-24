import "package:currency_converter/model/exchange_rate.dart";
import "package:currency_converter/source/remote_exchange_source.dart/remote_exchange_source.dart";

class ExchangeRepository {
  final RemoteExchangeSource _exchangeSource;

  const ExchangeRepository({required RemoteExchangeSource exchangeSource}) : _exchangeSource = exchangeSource;

  Future<ExchangeRateSnapshot> getExchangeRateSnapshot({RemoteExchangeSource? exchangeSource}) {
    return _exchangeSource.getExchangeRateSnapshot();
  }
}
