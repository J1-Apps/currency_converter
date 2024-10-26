import "package:currency_converter/model/cc_error.dart";
import "package:currency_converter/model/exchange_rate.dart";
import "package:currency_converter/repository/data_state.dart";
import "package:currency_converter/source/local_exchange_source/local_exchange_source.dart";
import "package:currency_converter/source/remote_exchange_source/remote_exchange_source.dart";
import "package:j1_environment/j1_environment.dart";
import "package:rxdart/subjects.dart";

class ExchangeRepository {
  final RemoteExchangeSource _remoteSource;
  final LocalExchangeSource _localSource;
  final BehaviorSubject<DataState<ExchangeRateSnapshot>> _exchangeSubject;

  ExchangeRepository({
    RemoteExchangeSource? remoteSource,
    LocalExchangeSource? localSource,
    ExchangeRateSnapshot? initialState,
  })  : _remoteSource = remoteSource ?? locator.get<RemoteExchangeSource>(),
        _localSource = localSource ?? locator.get<LocalExchangeSource>(),
        _exchangeSubject = BehaviorSubject.seeded(
          initialState == null ? const DataLoading() : DataSuccess(data: initialState),
        );

  Stream<DataState<ExchangeRateSnapshot>> getExchangeRateStream() {
    return _exchangeSubject.stream;
  }

  Future<void> updateExchangeRate() async {
    _exchangeSubject.addLoadingState();

    try {
      final snapshot = await _remoteSource.getExchangeRate();

      _exchangeSubject.addSuccessState(snapshot);

      try {
        await _localSource.updateExchangeRate(snapshot);
      } catch (e) {
        _exchangeSubject.addError(CcError.fromObject(e));
      }

      return;
    } catch (e) {
      _exchangeSubject.addError(CcError.fromObject(e));
    }

    try {
      final snapshot = await _localSource.getExchangeRate();

      if (snapshot != null) {
        _exchangeSubject.addSuccessState(snapshot);
      } else {
        _exchangeSubject.addErrorState();
        _exchangeSubject.addError(const CcError(ErrorCode.repository_exchange_noExchangeError));
      }
    } catch (e) {
      _exchangeSubject.addErrorState();
      _exchangeSubject.addError(CcError.fromObject(e));
    }
  }

  void dispose() {
    _exchangeSubject.close();
  }
}
