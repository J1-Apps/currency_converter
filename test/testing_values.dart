import "dart:math";

import "package:currency_converter/data/model/configuration.dart";
import "package:currency_converter/data/model/currency.dart";
import "package:currency_converter/data/model/exchange_rate.dart";
import "package:currency_converter/data/repository/defaults.dart";
import "package:j1_theme/j1_theme.dart";

final _random = Random();
final _currentDate = DateTime.utc(2000);

const testConfig0 = Configuration(
  "test0",
  "test 0",
  1.0,
  CurrencyCode.USD,
  [CurrencyCode.EUR, CurrencyCode.KRW],
);

const testConfig1 = Configuration(
  "test1",
  "test 1",
  2.0,
  CurrencyCode.KRW,
  [CurrencyCode.EUR, CurrencyCode.USD],
);

final testSnapshot0 = ExchangeRateSnapshot(
  DateTime.now().toUtc(),
  {CurrencyCode.USD: 1, CurrencyCode.KRW: 1, CurrencyCode.EUR: 1},
);

final testSnapshot1 = ExchangeRateSnapshot(
  DateTime.now().toUtc(),
  {CurrencyCode.USD: 2, CurrencyCode.KRW: 2, CurrencyCode.EUR: 2},
);

const testFavorites0 = [
  CurrencyCode.USD,
  CurrencyCode.KRW,
];

ExchangeRateHistorySnapshot oneYearSnapshot(CurrencyCode code) => ExchangeRateHistorySnapshot(
      HistorySnapshotPeriod.oneYear,
      DateTime.now().toUtc(),
      CurrencyCode.USD,
      code,
      {for (var i = 0; i < 366; i++) _currentDate.subtract(Duration(days: i)): _random.nextDouble() + 1},
    );

final colorScheme0 = defaultColorScheme.copyWith(background: 0xFF000000);
final colorScheme1 = defaultColorScheme.copyWith(background: 0xFFFFFFFF);
final textTheme0 = defaultTextTheme.copyWith(bodyLarge: defaultTextTheme.bodyLarge.copyWith(fontFamily: "test0"));
final textTheme1 = defaultTextTheme.copyWith(bodyLarge: defaultTextTheme.bodyLarge.copyWith(fontFamily: "test1"));
const pageTransition0 = J1PageTransition.zoom;
