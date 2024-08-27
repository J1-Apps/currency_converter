final class Currency {
  /// Three character currency code, also used as the unique ID. This code can also be used to derive the currency's
  /// localized name in the UI layer.
  final CurrencyCode code;

  /// Unicode symbol.
  final String symbol;

  const Currency(this.code, this.symbol);

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

  static const USD = Currency(CurrencyCode.USD, "\$");
  static const EUR = Currency(CurrencyCode.EUR, "€");
  static const JPY = Currency(CurrencyCode.JPY, "¥");
  static const GBP = Currency(CurrencyCode.GBP, "£");
  static const AUD = Currency(CurrencyCode.AUD, "\$");
  static const CAD = Currency(CurrencyCode.CAD, "\$");
  static const CHF = Currency(CurrencyCode.CHF, "₣");
  static const CNY = Currency(CurrencyCode.CNY, "¥");
  static const SEK = Currency(CurrencyCode.SEK, "kr");
  static const MXN = Currency(CurrencyCode.MXN, "\$");
  static const NZD = Currency(CurrencyCode.NZD, "\$");
  static const SGD = Currency(CurrencyCode.SGD, "\$");
  static const HKD = Currency(CurrencyCode.HKD, "\$");
  static const NOK = Currency(CurrencyCode.NOK, "kr");
  static const KRW = Currency(CurrencyCode.KRW, "₩");
  static const TRY = Currency(CurrencyCode.TRY, "₺");
  static const INR = Currency(CurrencyCode.INR, "₹");
  static const RUB = Currency(CurrencyCode.RUB, "₽");
  static const BRL = Currency(CurrencyCode.BRL, "R\$");
  static const ZAR = Currency(CurrencyCode.ZAR, "R");
  static const DKK = Currency(CurrencyCode.DKK, "kr");
  static const PLN = Currency(CurrencyCode.PLN, "zł");
  static const TWD = Currency(CurrencyCode.TWD, "\$");
  static const THB = Currency(CurrencyCode.THB, "฿");
  static const MYR = Currency(CurrencyCode.MYR, "RM");
  static const ILS = Currency(CurrencyCode.ILS, "₪");
  static const IDR = Currency(CurrencyCode.IDR, "Rp");
  static const CZK = Currency(CurrencyCode.CZK, "Kč");
  static const AED = Currency(CurrencyCode.AED, "د.إ");
  static const HUF = Currency(CurrencyCode.HUF, "Ft");
  static const CLP = Currency(CurrencyCode.CLP, "\$");
  static const SAR = Currency(CurrencyCode.SAR, "ر.س");
  static const PHP = Currency(CurrencyCode.PHP, "₱");
  static const COP = Currency(CurrencyCode.COP, "\$");
  static const RON = Currency(CurrencyCode.RON, "lei");
  static const PEN = Currency(CurrencyCode.PEN, "S/");
  static const BHD = Currency(CurrencyCode.BHD, ".د.ب");
  static const BGN = Currency(CurrencyCode.BGN, "лв");
  static const ARS = Currency(CurrencyCode.ARS, "\$");
}

// ignore_for_file: constant_identifier_names
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
  // coverage:ignore-end
}
