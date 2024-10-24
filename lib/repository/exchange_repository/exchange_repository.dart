import "package:currency_converter/model/cc_error.dart";
import "package:currency_converter/model/exchange_rate.dart";
import "package:currency_converter/source/local_exchange_source/local_exchange_source.dart";
import "package:currency_converter/source/remote_exchange_source/remote_exchange_source.dart";

class ExchangeRepository {
  final RemoteExchangeSource _remoteSource;
  final LocalExchangeSource _localSource;

  ExchangeRepository({
    required RemoteExchangeSource remoteSource,
    required LocalExchangeSource localSource,
  })  : _remoteSource = remoteSource,
        _localSource = localSource;

  Future<ExchangeRateSnapshot> getExchangeRate() async {
    final CcError? error;

    try {
      final snapshot = await _remoteSource.getExchangeRate();

      try {
        _localSource.updateExchangeRate(snapshot);
      } catch (_) {}

      return snapshot;
    } catch (e) {
      error = CcError.fromObject(e);
    }

    final snapshot = await _localSource.getExchangeRate();

    if (snapshot != null) {
      return snapshot;
    }

    throw error;
  }
}
