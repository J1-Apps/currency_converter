import "package:currency_converter/model/currency.dart";
import "package:dart_mappable/dart_mappable.dart";

part "exchange_rate.mapper.dart";

@MappableClass()
final class ExchangeRateSnapshot with ExchangeRateSnapshotMappable {
  /// The timestamp of this exchange rate request.
  final DateTime timestamp;

  /// The currency code of the base currency.
  final CurrencyCode baseCode;

  /// A map of currency codes to their exchange rates relative to the base currency.
  final Map<CurrencyCode, double> exchangeRates;

  const ExchangeRateSnapshot(this.timestamp, this.baseCode, this.exchangeRates);
}

@MappableClass()
final class ExchangeRateHistorySnapshot with ExchangeRateHistorySnapshotMappable {
  /// The timestamp of this exchange rate request.
  final DateTime timestamp;

  /// The currency code of the base currency.
  final CurrencyCode baseCode;

  /// The currency code of the converted currency.
  final CurrencyCode convertedCode;

  /// A map of time instances to the relative exchange rate at that time.
  final Map<DateTime, double> exchangeRates;

  // TODO: Remove ignore when historical support is added.
  // coverage:ignore-start
  const ExchangeRateHistorySnapshot(this.timestamp, this.baseCode, this.convertedCode, this.exchangeRates);
  // coverage:ignore-end
}