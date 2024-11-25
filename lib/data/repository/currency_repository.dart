import "package:currency_converter/data/model/cc_error.dart";
import "package:currency_converter/data/model/currency.dart";
import "package:currency_converter/data/repository/data_state.dart";
import "package:currency_converter/data/source/local_currency_source/local_currency_source.dart";
import "package:j1_environment/j1_environment.dart";

class CurrencyRepository {
  final LocalCurrencySource _localSource;

  final DataSubject<List<CurrencyCode>> _allCurrenciesSubject;

  Stream<DataState<List<CurrencyCode>>> get allCurrenciesStream => _allCurrenciesSubject.stream;

  CurrencyRepository({
    LocalCurrencySource? localSource,
    List<CurrencyCode>? initialAllCurrencies,
  })  : _localSource = localSource ?? locator.get<LocalCurrencySource>(),
        _allCurrenciesSubject = DataSubject.initial(initialAllCurrencies);

  Future<void> loadAllCurrencies({bool forceRefresh = false}) async {
    if (_allCurrenciesSubject.value is DataSuccess<List<CurrencyCode>> && !forceRefresh) {
      return;
    }

    try {
      _allCurrenciesSubject.addSuccess(await _localSource.getAllCurrencies());
    } catch (e) {
      _allCurrenciesSubject.addSuccess(CurrencyCode.sortedValues());
      _allCurrenciesSubject.addErrorEvent(CcError.fromObject(e));
    }
  }

  void dispose() {
    _allCurrenciesSubject.close();
  }
}
