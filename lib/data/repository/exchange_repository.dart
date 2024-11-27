import "package:currency_converter/data/model/cc_error.dart";
import "package:currency_converter/data/model/exchange_rate.dart";
import "package:currency_converter/data/repository/data_state.dart";
import "package:currency_converter/data/source/local_exchange_source/local_exchange_source.dart";
import "package:currency_converter/data/source/remote_exchange_source/remote_exchange_source.dart";
import "package:j1_environment/j1_environment.dart";

class ExchangeRepository {
  final RemoteExchangeSource _remoteSource;
  final LocalExchangeSource _localSource;
  final DataSubject<ExchangeRateSnapshot> _exchangeSubject;

  Stream<DataState<ExchangeRateSnapshot>> get exchangeRateStream => _exchangeSubject.stream;

  DataState<ExchangeRateSnapshot> get exchangeRate => _exchangeSubject.value;

  ExchangeRepository({
    RemoteExchangeSource? remoteSource,
    LocalExchangeSource? localSource,
    ExchangeRateSnapshot? initialState,
  })  : _remoteSource = remoteSource ?? locator.get<RemoteExchangeSource>(),
        _localSource = localSource ?? locator.get<LocalExchangeSource>(),
        _exchangeSubject = DataSubject.initial(initialState);

  Future<void> loadExchangeRate({bool forceRefresh = false}) async {
    if (_exchangeSubject.value is DataSuccess<ExchangeRateSnapshot> && !forceRefresh) {
      return;
    }

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
