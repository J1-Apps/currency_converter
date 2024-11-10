// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'currency.dart';

class CurrencyCodeMapper extends EnumMapper<CurrencyCode> {
  CurrencyCodeMapper._();

  static CurrencyCodeMapper? _instance;
  static CurrencyCodeMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = CurrencyCodeMapper._());
    }
    return _instance!;
  }

  static CurrencyCode fromValue(dynamic value) {
    ensureInitialized();
    return MapperContainer.globals.fromValue(value);
  }

  @override
  CurrencyCode decode(dynamic value) {
    switch (value) {
      case 'USD':
        return CurrencyCode.USD;
      case 'EUR':
        return CurrencyCode.EUR;
      case 'JPY':
        return CurrencyCode.JPY;
      case 'GBP':
        return CurrencyCode.GBP;
      case 'AUD':
        return CurrencyCode.AUD;
      case 'CAD':
        return CurrencyCode.CAD;
      case 'CHF':
        return CurrencyCode.CHF;
      case 'CNY':
        return CurrencyCode.CNY;
      case 'SEK':
        return CurrencyCode.SEK;
      case 'MXN':
        return CurrencyCode.MXN;
      case 'NZD':
        return CurrencyCode.NZD;
      case 'SGD':
        return CurrencyCode.SGD;
      case 'HKD':
        return CurrencyCode.HKD;
      case 'NOK':
        return CurrencyCode.NOK;
      case 'KRW':
        return CurrencyCode.KRW;
      case 'TRY':
        return CurrencyCode.TRY;
      case 'INR':
        return CurrencyCode.INR;
      case 'RUB':
        return CurrencyCode.RUB;
      case 'BRL':
        return CurrencyCode.BRL;
      case 'ZAR':
        return CurrencyCode.ZAR;
      case 'DKK':
        return CurrencyCode.DKK;
      case 'PLN':
        return CurrencyCode.PLN;
      case 'TWD':
        return CurrencyCode.TWD;
      case 'THB':
        return CurrencyCode.THB;
      case 'MYR':
        return CurrencyCode.MYR;
      case 'ILS':
        return CurrencyCode.ILS;
      case 'IDR':
        return CurrencyCode.IDR;
      case 'CZK':
        return CurrencyCode.CZK;
      case 'AED':
        return CurrencyCode.AED;
      case 'HUF':
        return CurrencyCode.HUF;
      case 'CLP':
        return CurrencyCode.CLP;
      case 'SAR':
        return CurrencyCode.SAR;
      case 'PHP':
        return CurrencyCode.PHP;
      case 'COP':
        return CurrencyCode.COP;
      case 'RON':
        return CurrencyCode.RON;
      case 'PEN':
        return CurrencyCode.PEN;
      case 'BHD':
        return CurrencyCode.BHD;
      case 'BGN':
        return CurrencyCode.BGN;
      case 'ARS':
        return CurrencyCode.ARS;
      default:
        throw MapperException.unknownEnumValue(value);
    }
  }

  @override
  dynamic encode(CurrencyCode self) {
    switch (self) {
      case CurrencyCode.USD:
        return 'USD';
      case CurrencyCode.EUR:
        return 'EUR';
      case CurrencyCode.JPY:
        return 'JPY';
      case CurrencyCode.GBP:
        return 'GBP';
      case CurrencyCode.AUD:
        return 'AUD';
      case CurrencyCode.CAD:
        return 'CAD';
      case CurrencyCode.CHF:
        return 'CHF';
      case CurrencyCode.CNY:
        return 'CNY';
      case CurrencyCode.SEK:
        return 'SEK';
      case CurrencyCode.MXN:
        return 'MXN';
      case CurrencyCode.NZD:
        return 'NZD';
      case CurrencyCode.SGD:
        return 'SGD';
      case CurrencyCode.HKD:
        return 'HKD';
      case CurrencyCode.NOK:
        return 'NOK';
      case CurrencyCode.KRW:
        return 'KRW';
      case CurrencyCode.TRY:
        return 'TRY';
      case CurrencyCode.INR:
        return 'INR';
      case CurrencyCode.RUB:
        return 'RUB';
      case CurrencyCode.BRL:
        return 'BRL';
      case CurrencyCode.ZAR:
        return 'ZAR';
      case CurrencyCode.DKK:
        return 'DKK';
      case CurrencyCode.PLN:
        return 'PLN';
      case CurrencyCode.TWD:
        return 'TWD';
      case CurrencyCode.THB:
        return 'THB';
      case CurrencyCode.MYR:
        return 'MYR';
      case CurrencyCode.ILS:
        return 'ILS';
      case CurrencyCode.IDR:
        return 'IDR';
      case CurrencyCode.CZK:
        return 'CZK';
      case CurrencyCode.AED:
        return 'AED';
      case CurrencyCode.HUF:
        return 'HUF';
      case CurrencyCode.CLP:
        return 'CLP';
      case CurrencyCode.SAR:
        return 'SAR';
      case CurrencyCode.PHP:
        return 'PHP';
      case CurrencyCode.COP:
        return 'COP';
      case CurrencyCode.RON:
        return 'RON';
      case CurrencyCode.PEN:
        return 'PEN';
      case CurrencyCode.BHD:
        return 'BHD';
      case CurrencyCode.BGN:
        return 'BGN';
      case CurrencyCode.ARS:
        return 'ARS';
    }
  }
}

extension CurrencyCodeMapperExtension on CurrencyCode {
  String toValue() {
    CurrencyCodeMapper.ensureInitialized();
    return MapperContainer.globals.toValue<CurrencyCode>(this) as String;
  }
}

class CurrencyMapper extends ClassMapperBase<Currency> {
  CurrencyMapper._();

  static CurrencyMapper? _instance;
  static CurrencyMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = CurrencyMapper._());
      CurrencyCodeMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'Currency';

  static CurrencyCode _$code(Currency v) => v.code;
  static const Field<Currency, CurrencyCode> _f$code = Field('code', _$code);
  static String _$symbol(Currency v) => v.symbol;
  static const Field<Currency, String> _f$symbol = Field('symbol', _$symbol);
  static int _$decimalDigits(Currency v) => v.decimalDigits;
  static const Field<Currency, int> _f$decimalDigits =
      Field('decimalDigits', _$decimalDigits);
  static double _$roundingValue(Currency v) => v.roundingValue;
  static const Field<Currency, double> _f$roundingValue =
      Field('roundingValue', _$roundingValue);

  @override
  final MappableFields<Currency> fields = const {
    #code: _f$code,
    #symbol: _f$symbol,
    #decimalDigits: _f$decimalDigits,
    #roundingValue: _f$roundingValue,
  };

  static Currency _instantiate(DecodingData data) {
    return Currency(data.dec(_f$code), data.dec(_f$symbol),
        data.dec(_f$decimalDigits), data.dec(_f$roundingValue));
  }

  @override
  final Function instantiate = _instantiate;

  static Currency fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<Currency>(map);
  }

  static Currency fromJson(String json) {
    return ensureInitialized().decodeJson<Currency>(json);
  }
}

mixin CurrencyMappable {
  String toJson() {
    return CurrencyMapper.ensureInitialized()
        .encodeJson<Currency>(this as Currency);
  }

  Map<String, dynamic> toMap() {
    return CurrencyMapper.ensureInitialized()
        .encodeMap<Currency>(this as Currency);
  }

  CurrencyCopyWith<Currency, Currency, Currency> get copyWith =>
      _CurrencyCopyWithImpl(this as Currency, $identity, $identity);
  @override
  String toString() {
    return CurrencyMapper.ensureInitialized().stringifyValue(this as Currency);
  }

  @override
  bool operator ==(Object other) {
    return CurrencyMapper.ensureInitialized()
        .equalsValue(this as Currency, other);
  }

  @override
  int get hashCode {
    return CurrencyMapper.ensureInitialized().hashValue(this as Currency);
  }
}

extension CurrencyValueCopy<$R, $Out> on ObjectCopyWith<$R, Currency, $Out> {
  CurrencyCopyWith<$R, Currency, $Out> get $asCurrency =>
      $base.as((v, t, t2) => _CurrencyCopyWithImpl(v, t, t2));
}

abstract class CurrencyCopyWith<$R, $In extends Currency, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  $R call(
      {CurrencyCode? code,
      String? symbol,
      int? decimalDigits,
      double? roundingValue});
  CurrencyCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _CurrencyCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, Currency, $Out>
    implements CurrencyCopyWith<$R, Currency, $Out> {
  _CurrencyCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<Currency> $mapper =
      CurrencyMapper.ensureInitialized();
  @override
  $R call(
          {CurrencyCode? code,
          String? symbol,
          int? decimalDigits,
          double? roundingValue}) =>
      $apply(FieldCopyWithData({
        if (code != null) #code: code,
        if (symbol != null) #symbol: symbol,
        if (decimalDigits != null) #decimalDigits: decimalDigits,
        if (roundingValue != null) #roundingValue: roundingValue
      }));
  @override
  Currency $make(CopyWithData data) => Currency(
      data.get(#code, or: $value.code),
      data.get(#symbol, or: $value.symbol),
      data.get(#decimalDigits, or: $value.decimalDigits),
      data.get(#roundingValue, or: $value.roundingValue));

  @override
  CurrencyCopyWith<$R2, Currency, $Out2> $chain<$R2, $Out2>(
          Then<$Out2, $R2> t) =>
      _CurrencyCopyWithImpl($value, $cast, t);
}
