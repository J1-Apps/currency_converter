import "package:currency_converter/data/model/currency.dart";
import "package:dart_mappable/dart_mappable.dart";

part "configuration.mapper.dart";

@MappableClass()
class Configuration with ConfigurationMappable {
  final String id;
  final String name;
  final double baseValue;
  final CurrencyCode baseCurrency;
  final List<ConfigurationCurrency> currencyData;

  const Configuration(
    this.id,
    this.name,
    this.baseValue,
    this.baseCurrency,
    this.currencyData,
  );

  static const fromJson = ConfigurationMapper.fromJson;
}

@MappableClass()
class ConfigurationCurrency with ConfigurationCurrencyMappable {
  final CurrencyCode code;
  final bool isExpanded;

  const ConfigurationCurrency(this.code, this.isExpanded);
}
