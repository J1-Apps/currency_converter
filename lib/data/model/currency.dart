import "package:dart_mappable/dart_mappable.dart";
import "package:intl/intl.dart";

part "currency.mapper.dart";

// ignore_for_file: constant_identifier_names
@MappableClass()
final class Currency with CurrencyMappable {
  /// Three character currency code, also used as the unique ID. This code can also be used to derive the currency's
  /// localized name in the UI layer.
  final CurrencyCode code;

  /// Unicode symbol.
  final String symbol;

  /// The number of decimal digits that this currency should have.
  final int decimalDigits;

  /// The value increments that this currency should be rounded to.
  final double roundingValue;

  const Currency(this.code, this.symbol, this.decimalDigits, this.roundingValue);

  String formatValue(double value) {
    final formatter = NumberFormat.currency(name: code.name, symbol: "");
    return formatter.format(value);
  }

  // coverage:ignore-start
  factory Currency.fromCode(CurrencyCode code) {
    return switch (code) {
      CurrencyCode.USD => USD,
      CurrencyCode.EUR => EUR,
      CurrencyCode.JPY => JPY,
      CurrencyCode.GBP => GBP,
      CurrencyCode.AUD => AUD,
      CurrencyCode.CAD => CAD,
      CurrencyCode.CHF => CHF,
      CurrencyCode.CNY => CNY,
      CurrencyCode.SEK => SEK,
      CurrencyCode.MXN => MXN,
      CurrencyCode.NZD => NZD,
      CurrencyCode.SGD => SGD,
      CurrencyCode.HKD => HKD,
      CurrencyCode.NOK => NOK,
      CurrencyCode.KRW => KRW,
      CurrencyCode.TRY => TRY,
      CurrencyCode.INR => INR,
      CurrencyCode.RUB => RUB,
      CurrencyCode.BRL => BRL,
      CurrencyCode.ZAR => ZAR,
      CurrencyCode.DKK => DKK,
      CurrencyCode.PLN => PLN,
      CurrencyCode.TWD => TWD,
      CurrencyCode.THB => THB,
      CurrencyCode.MYR => MYR,
      CurrencyCode.ILS => ILS,
      CurrencyCode.IDR => IDR,
      CurrencyCode.CZK => CZK,
      CurrencyCode.AED => AED,
      CurrencyCode.HUF => HUF,
      CurrencyCode.CLP => CLP,
      CurrencyCode.SAR => SAR,
      CurrencyCode.PHP => PHP,
      CurrencyCode.COP => COP,
      CurrencyCode.RON => RON,
      CurrencyCode.PEN => PEN,
      CurrencyCode.BHD => BHD,
      CurrencyCode.BGN => BGN,
      CurrencyCode.ARS => ARS,
    };
  }
  // coverage:ignore-end

  static const USD = Currency(CurrencyCode.USD, "\$", 2, 0);
  static const EUR = Currency(CurrencyCode.EUR, "€", 2, 0);
  static const JPY = Currency(CurrencyCode.JPY, "¥", 0, 0);
  static const GBP = Currency(CurrencyCode.GBP, "£", 2, 0);
  static const AUD = Currency(CurrencyCode.AUD, "\$", 2, 0);
  static const CAD = Currency(CurrencyCode.CAD, "\$", 2, 0);
  static const CHF = Currency(CurrencyCode.CHF, "fr.", 2, 0.05);
  static const CNY = Currency(CurrencyCode.CNY, "¥", 2, 0);
  static const SEK = Currency(CurrencyCode.SEK, "kr", 2, 0);
  static const MXN = Currency(CurrencyCode.MXN, "\$", 2, 0);
  static const NZD = Currency(CurrencyCode.NZD, "\$", 2, 0);
  static const SGD = Currency(CurrencyCode.SGD, "\$", 2, 0);
  static const HKD = Currency(CurrencyCode.HKD, "\$", 2, 0);
  static const NOK = Currency(CurrencyCode.NOK, "kr", 2, 0);
  static const KRW = Currency(CurrencyCode.KRW, "₩", 0, 0);
  static const TRY = Currency(CurrencyCode.TRY, "₺", 2, 0);
  static const INR = Currency(CurrencyCode.INR, "টকা", 2, 0);
  static const RUB = Currency(CurrencyCode.RUB, "₽.", 2, 0);
  static const BRL = Currency(CurrencyCode.BRL, "R\$", 2, 0);
  static const ZAR = Currency(CurrencyCode.ZAR, "R", 2, 0);
  static const DKK = Currency(CurrencyCode.DKK, "kr", 2, 0);
  static const PLN = Currency(CurrencyCode.PLN, "zł", 2, 0);
  static const TWD = Currency(CurrencyCode.TWD, "\$", 2, 0);
  static const THB = Currency(CurrencyCode.THB, "฿", 2, 0);
  static const MYR = Currency(CurrencyCode.MYR, "RM", 2, 0);
  static const ILS = Currency(CurrencyCode.ILS, "₪", 2, 0);
  static const IDR = Currency(CurrencyCode.IDR, "Rp", 0, 0);
  static const CZK = Currency(CurrencyCode.CZK, "Kč", 2, 0);
  static const AED = Currency(CurrencyCode.AED, "د.إ", 2, 0);
  static const HUF = Currency(CurrencyCode.HUF, "Ft", 0, 0);
  static const CLP = Currency(CurrencyCode.CLP, "\$", 0, 0);
  static const SAR = Currency(CurrencyCode.SAR, "ر.س", 2, 0);
  static const PHP = Currency(CurrencyCode.PHP, "₱", 2, 0);
  static const COP = Currency(CurrencyCode.COP, "\$", 0, 0);
  static const RON = Currency(CurrencyCode.RON, "lei", 2, 0);
  static const PEN = Currency(CurrencyCode.PEN, "S/", 2, 0);
  static const BHD = Currency(CurrencyCode.BHD, ".د.ب", 3, 0);
  static const BGN = Currency(CurrencyCode.BGN, "лв", 2, 0);
  static const ARS = Currency(CurrencyCode.ARS, "\$", 2, 0);
}

@MappableEnum()
enum CurrencyCode {
  USD,
  EUR,
  JPY,
  GBP,
  AUD,
  CAD,
  CHF,
  CNY,
  SEK,
  MXN,
  NZD,
  SGD,
  HKD,
  NOK,
  KRW,
  TRY,
  INR,
  RUB,
  BRL,
  ZAR,
  DKK,
  PLN,
  TWD,
  THB,
  MYR,
  ILS,
  IDR,
  CZK,
  AED,
  HUF,
  CLP,
  SAR,
  PHP,
  COP,
  RON,
  PEN,
  BHD,
  BGN,
  ARS;

  static const fromValue = CurrencyCodeMapper.fromValue;

  // coverage:ignore-start
  factory CurrencyCode.fromCode(String code) {
    return switch (code.toLowerCase()) {
      "eur" => EUR,
      "jpy" => JPY,
      "gbp" => GBP,
      "aud" => AUD,
      "cad" => CAD,
      "chf" => CHF,
      "cny" => CNY,
      "sek" => SEK,
      "mxn" => MXN,
      "nzd" => NZD,
      "sgd" => SGD,
      "hkd" => HKD,
      "nok" => NOK,
      "krw" => KRW,
      "try" => TRY,
      "inr" => INR,
      "rub" => RUB,
      "brl" => BRL,
      "zar" => ZAR,
      "dkk" => DKK,
      "pln" => PLN,
      "twd" => TWD,
      "thb" => THB,
      "myr" => MYR,
      "ils" => ILS,
      "idr" => IDR,
      "czk" => CZK,
      "aed" => AED,
      "huf" => HUF,
      "clp" => CLP,
      "sar" => SAR,
      "php" => PHP,
      "cop" => COP,
      "ron" => RON,
      "pen" => PEN,
      "bhd" => BHD,
      "bgn" => BGN,
      "ars" => ARS,
      _ => USD,
    };
  }

  static List<CurrencyCode> sortedValues() {
    final sorted = [...values];
    sorted.sort((a, b) => a.toValue().compareTo(b.toValue()));
    return sorted;
  }
  // coverage:ignore-end
}
