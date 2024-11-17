import "package:currency_converter/data/model/currency.dart";
import "package:currency_converter/data/source/local_currency_source/local_currency_source.dart";

class MemoryLocalCurrencySource extends LocalCurrencySource {
  @override
  Future<List<CurrencyCode>> getAllCurrencies() async {
    return CurrencyCode.sortedValues();
  }
}
