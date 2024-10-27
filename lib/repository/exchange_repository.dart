import "package:currency_converter/model/cc_error.dart";
import "package:currency_converter/model/exchange_rate.dart";
import "package:currency_converter/repository/data_state.dart";
import "package:currency_converter/source/local_exchange_source/local_exchange_source.dart";
import "package:currency_converter/source/remote_exchange_source/remote_exchange_source.dart";
import "package:j1_environment/j1_environment.dart";

class ExchangeRepository {
  final RemoteExchangeSource _remoteSource;
  final LocalExchangeSource _localSource;
  final DataSubject<ExchangeRateSnapshot> _exchangeSubject;

  Stream<DataState<ExchangeRateSnapshot>> get exchangeRate => _exchangeSubject.stream;

  ExchangeRepository({
    RemoteExchangeSource? remoteSource,
    LocalExchangeSource? localSource,
    ExchangeRateSnapshot? initialState,
  })  : _remoteSource = remoteSource ?? locator.get<RemoteExchangeSource>(),
        _localSource = localSource ?? locator.get<LocalExchangeSource>(),
        _exchangeSubject = DataSubject.initial(initialState);

  Future<void> loadExchangeRate() async {
    try {
      final snapshot = await _remoteSource.getExchangeRate();

      _exchangeSubject.addSuccess(snapshot);

      try {
        await _localSource.updateExchangeRate(snapshot);
      } catch (e) {
        _exchangeSubject.addErrorEvent(CcError.fromObject(e));
      }

      return;
    } catch (e) {
      _exchangeSubject.addErrorEvent(CcError.fromObject(e));
    }

    try {
      final snapshot = await _localSource.getExchangeRate();

      if (snapshot != null) {
        _exchangeSubject.addSuccess(snapshot);
      } else {
        throw const CcError(ErrorCode.repository_exchange_noExchangeError);
      }
    } catch (e) {
      _exchangeSubject.addEmpty();
      _exchangeSubject.addErrorEvent(CcError.fromObject(e));
    }
  }

  void dispose() {
    _exchangeSubject.close();
  }
}
