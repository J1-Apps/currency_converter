import "package:currency_converter/models/currency.dart";

final class ExchangeRateSnapshot {
  /// The timestamp of this exchange rate request.
  final DateTime timestamp;

  /// The currency code of the base currency.
  final CurrencyCode baseCode;

  /// A map of currency codes to their exchange rates relative to the base currency.
  final Map<CurrencyCode, double> exchangeRates;

  const ExchangeRateSnapshot(this.timestamp, this.baseCode, this.exchangeRates);
}

final class ExchangeRateHistorySnapshot {
  /// The timestamp of this exchange rate request.
  final DateTime timestamp;

  /// The currency code of the base currency.
  final CurrencyCode baseCode;

  /// The currency code of the converted currency.
  final CurrencyCode convertedCode;

  /// A map of time instances to the relative exchange rate at that time.
  final Map<DateTime, double> exchangeRates;

  const ExchangeRateHistorySnapshot(this.timestamp, this.baseCode, this.convertedCode, this.exchangeRates);
}
