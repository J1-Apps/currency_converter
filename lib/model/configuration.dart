import "package:currency_converter/model/currency.dart";
import "package:currency_converter/model/exchange_rate.dart";
import "package:equatable/equatable.dart";

class Configuration extends Equatable {
  final double baseValue;
  final CurrencyCode baseCurrency;
  final Set<CurrencyCode> currencies;
  final ExchangeRateSnapshot snapshot;

  const Configuration({
    required this.baseValue,
    required this.baseCurrency,
    required this.currencies,
    required this.snapshot,
  });

  @override
  List<Object?> get props => [
        baseValue,
        baseCurrency,
        currencies,
      ];

  @override
  String toString() {
    return "Configuration(baseValue: $baseValue, baseCurrency: $baseCurrency, currencies: $currencies)";
  }
}
