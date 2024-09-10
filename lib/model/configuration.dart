import "package:currency_converter/model/currency.dart";
import "package:currency_converter/model/exchange_rate.dart";
import "package:dart_mappable/dart_mappable.dart";

part "configuration.mapper.dart";

@MappableClass()
class Configuration with ConfigurationMappable {
  final String name;
  final double baseValue;
  final CurrencyCode baseCurrency;
  final Set<CurrencyCode> currencies;
  final ExchangeRateSnapshot snapshot;

  const Configuration(
    this.name,
    this.baseValue,
    this.baseCurrency,
    this.currencies,
    this.snapshot,
  );

  static const fromJson = ConfigurationMapper.fromJson;
}
