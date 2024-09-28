import "package:currency_converter/model/currency.dart";
import "package:dart_mappable/dart_mappable.dart";

part "configuration.mapper.dart";

@MappableClass()
class Configuration with ConfigurationMappable {
  final String name;
  final double baseValue;
  final CurrencyCode baseCurrency;
  final List<CurrencyCode> currencies;

  const Configuration(
    this.name,
    this.baseValue,
    this.baseCurrency,
    this.currencies,
  );

  static const fromJson = ConfigurationMapper.fromJson;
}
