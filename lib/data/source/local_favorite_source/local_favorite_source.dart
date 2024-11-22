import "package:currency_converter/data/model/currency.dart";

abstract class LocalFavoriteSource {
  Future<List<CurrencyCode>> getFavorites();
  Future<void> updateFavorites(List<CurrencyCode> favorites);
}
