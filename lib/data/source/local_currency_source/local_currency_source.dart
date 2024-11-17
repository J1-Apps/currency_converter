import "package:currency_converter/data/model/currency.dart";

abstract class LocalCurrencySource {
  Future<List<CurrencyCode>> getAllCurrencies();
}
