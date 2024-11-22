import "package:currency_converter/data/model/currency.dart";
import "package:dart_mappable/dart_mappable.dart";

part "exchange_rate.mapper.dart";

@MappableClass()
final class ExchangeRateSnapshot with ExchangeRateSnapshotMappable {
  /// The timestamp of this exchange rate request.
  final DateTime timestamp;

  /// A map of currency codes to their exchange rates relative to the base currency.
  final Map<CurrencyCode, double> exchangeRates;

  const ExchangeRateSnapshot(this.timestamp, this.exchangeRates);

  static const fromJson = ExchangeRateSnapshotMapper.fromJson;

  double getTargetRate(CurrencyCode base, CurrencyCode target) {
    final baseRate = exchangeRates[base] ?? 1;
    final targetRate = exchangeRates[target] ?? 1;

    if (baseRate == 0 || targetRate == 0) {
      return 1;
    } else {
      return targetRate / baseRate;
    }
  }

  double getTargetValue(CurrencyCode base, CurrencyCode target, double baseValue) {
    return getTargetRate(base, target) * baseValue;
  }
}

@MappableEnum()
enum HistorySnapshotPeriod {
  oneWeek,
  oneMonth,
  threeMonths,
  sixMonths,
  oneYear,
}

@MappableClass()
final class ExchangeRateHistorySnapshot with ExchangeRateHistorySnapshotMappable {
  /// The length of time that this snapshot spans.
  final HistorySnapshotPeriod period;

  /// The timestamp of this exchange rate request.
  final DateTime timestamp;

  /// The currency code of the base currency.
  final CurrencyCode baseCode;

  /// The currency code of the converted currency.
  final CurrencyCode convertedCode;

  /// A map of time instances to the relative exchange rate at that time.
  final Map<DateTime, double> exchangeRates;

  // TODO: Test this in #36.
  // coverage:ignore-start
  const ExchangeRateHistorySnapshot(
    this.period,
    this.timestamp,
    this.baseCode,
    this.convertedCode,
    this.exchangeRates,
  );
  // coverage:ignore-end
}
