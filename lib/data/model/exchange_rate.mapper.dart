// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'exchange_rate.dart';

class HistorySnapshotPeriodMapper extends EnumMapper<HistorySnapshotPeriod> {
  HistorySnapshotPeriodMapper._();

  static HistorySnapshotPeriodMapper? _instance;
  static HistorySnapshotPeriodMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = HistorySnapshotPeriodMapper._());
    }
    return _instance!;
  }

  static HistorySnapshotPeriod fromValue(dynamic value) {
    ensureInitialized();
    return MapperContainer.globals.fromValue(value);
  }

  @override
  HistorySnapshotPeriod decode(dynamic value) {
    switch (value) {
      case 'oneWeek':
        return HistorySnapshotPeriod.oneWeek;
      case 'oneMonth':
        return HistorySnapshotPeriod.oneMonth;
      case 'threeMonths':
        return HistorySnapshotPeriod.threeMonths;
      case 'sixMonths':
        return HistorySnapshotPeriod.sixMonths;
      case 'oneYear':
        return HistorySnapshotPeriod.oneYear;
      default:
        throw MapperException.unknownEnumValue(value);
    }
  }

  @override
  dynamic encode(HistorySnapshotPeriod self) {
    switch (self) {
      case HistorySnapshotPeriod.oneWeek:
        return 'oneWeek';
      case HistorySnapshotPeriod.oneMonth:
        return 'oneMonth';
      case HistorySnapshotPeriod.threeMonths:
        return 'threeMonths';
      case HistorySnapshotPeriod.sixMonths:
        return 'sixMonths';
      case HistorySnapshotPeriod.oneYear:
        return 'oneYear';
    }
  }
}

extension HistorySnapshotPeriodMapperExtension on HistorySnapshotPeriod {
  String toValue() {
    HistorySnapshotPeriodMapper.ensureInitialized();
    return MapperContainer.globals.toValue<HistorySnapshotPeriod>(this) as String;
  }
}

class ExchangeRateSnapshotMapper extends ClassMapperBase<ExchangeRateSnapshot> {
  ExchangeRateSnapshotMapper._();

  static ExchangeRateSnapshotMapper? _instance;
  static ExchangeRateSnapshotMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = ExchangeRateSnapshotMapper._());
      CurrencyCodeMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'ExchangeRateSnapshot';

  static DateTime _$timestamp(ExchangeRateSnapshot v) => v.timestamp;
  static const Field<ExchangeRateSnapshot, DateTime> _f$timestamp = Field('timestamp', _$timestamp);
  static Map<CurrencyCode, double> _$exchangeRates(ExchangeRateSnapshot v) => v.exchangeRates;
  static const Field<ExchangeRateSnapshot, Map<CurrencyCode, double>> _f$exchangeRates =
      Field('exchangeRates', _$exchangeRates);

  @override
  final MappableFields<ExchangeRateSnapshot> fields = const {
    #timestamp: _f$timestamp,
    #exchangeRates: _f$exchangeRates,
  };

  static ExchangeRateSnapshot _instantiate(DecodingData data) {
    return ExchangeRateSnapshot(data.dec(_f$timestamp), data.dec(_f$exchangeRates));
  }

  @override
  final Function instantiate = _instantiate;

  static ExchangeRateSnapshot fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<ExchangeRateSnapshot>(map);
  }

  static ExchangeRateSnapshot fromJson(String json) {
    return ensureInitialized().decodeJson<ExchangeRateSnapshot>(json);
  }
}

mixin ExchangeRateSnapshotMappable {
  String toJson() {
    return ExchangeRateSnapshotMapper.ensureInitialized()
        .encodeJson<ExchangeRateSnapshot>(this as ExchangeRateSnapshot);
  }

  Map<String, dynamic> toMap() {
    return ExchangeRateSnapshotMapper.ensureInitialized().encodeMap<ExchangeRateSnapshot>(this as ExchangeRateSnapshot);
  }

  ExchangeRateSnapshotCopyWith<ExchangeRateSnapshot, ExchangeRateSnapshot, ExchangeRateSnapshot> get copyWith =>
      _ExchangeRateSnapshotCopyWithImpl(this as ExchangeRateSnapshot, $identity, $identity);
  @override
  String toString() {
    return ExchangeRateSnapshotMapper.ensureInitialized().stringifyValue(this as ExchangeRateSnapshot);
  }

  @override
  bool operator ==(Object other) {
    return ExchangeRateSnapshotMapper.ensureInitialized().equalsValue(this as ExchangeRateSnapshot, other);
  }

  @override
  int get hashCode {
    return ExchangeRateSnapshotMapper.ensureInitialized().hashValue(this as ExchangeRateSnapshot);
  }
}

extension ExchangeRateSnapshotValueCopy<$R, $Out> on ObjectCopyWith<$R, ExchangeRateSnapshot, $Out> {
  ExchangeRateSnapshotCopyWith<$R, ExchangeRateSnapshot, $Out> get $asExchangeRateSnapshot =>
      $base.as((v, t, t2) => _ExchangeRateSnapshotCopyWithImpl(v, t, t2));
}

abstract class ExchangeRateSnapshotCopyWith<$R, $In extends ExchangeRateSnapshot, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  MapCopyWith<$R, CurrencyCode, double, ObjectCopyWith<$R, double, double>> get exchangeRates;
  $R call({DateTime? timestamp, Map<CurrencyCode, double>? exchangeRates});
  ExchangeRateSnapshotCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _ExchangeRateSnapshotCopyWithImpl<$R, $Out> extends ClassCopyWithBase<$R, ExchangeRateSnapshot, $Out>
    implements ExchangeRateSnapshotCopyWith<$R, ExchangeRateSnapshot, $Out> {
  _ExchangeRateSnapshotCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<ExchangeRateSnapshot> $mapper = ExchangeRateSnapshotMapper.ensureInitialized();
  @override
  MapCopyWith<$R, CurrencyCode, double, ObjectCopyWith<$R, double, double>> get exchangeRates =>
      MapCopyWith($value.exchangeRates, (v, t) => ObjectCopyWith(v, $identity, t), (v) => call(exchangeRates: v));
  @override
  $R call({DateTime? timestamp, Map<CurrencyCode, double>? exchangeRates}) => $apply(FieldCopyWithData(
      {if (timestamp != null) #timestamp: timestamp, if (exchangeRates != null) #exchangeRates: exchangeRates}));
  @override
  ExchangeRateSnapshot $make(CopyWithData data) => ExchangeRateSnapshot(
      data.get(#timestamp, or: $value.timestamp), data.get(#exchangeRates, or: $value.exchangeRates));

  @override
  ExchangeRateSnapshotCopyWith<$R2, ExchangeRateSnapshot, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t) =>
      _ExchangeRateSnapshotCopyWithImpl($value, $cast, t);
}

class ExchangeRateHistorySnapshotMapper extends ClassMapperBase<ExchangeRateHistorySnapshot> {
  ExchangeRateHistorySnapshotMapper._();

  static ExchangeRateHistorySnapshotMapper? _instance;
  static ExchangeRateHistorySnapshotMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = ExchangeRateHistorySnapshotMapper._());
      HistorySnapshotPeriodMapper.ensureInitialized();
      CurrencyCodeMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'ExchangeRateHistorySnapshot';

  static HistorySnapshotPeriod _$period(ExchangeRateHistorySnapshot v) => v.period;
  static const Field<ExchangeRateHistorySnapshot, HistorySnapshotPeriod> _f$period = Field('period', _$period);
  static DateTime _$timestamp(ExchangeRateHistorySnapshot v) => v.timestamp;
  static const Field<ExchangeRateHistorySnapshot, DateTime> _f$timestamp = Field('timestamp', _$timestamp);
  static CurrencyCode _$baseCode(ExchangeRateHistorySnapshot v) => v.baseCode;
  static const Field<ExchangeRateHistorySnapshot, CurrencyCode> _f$baseCode = Field('baseCode', _$baseCode);
  static CurrencyCode _$convertedCode(ExchangeRateHistorySnapshot v) => v.convertedCode;
  static const Field<ExchangeRateHistorySnapshot, CurrencyCode> _f$convertedCode =
      Field('convertedCode', _$convertedCode);
  static Map<DateTime, double> _$exchangeRates(ExchangeRateHistorySnapshot v) => v.exchangeRates;
  static const Field<ExchangeRateHistorySnapshot, Map<DateTime, double>> _f$exchangeRates =
      Field('exchangeRates', _$exchangeRates);

  @override
  final MappableFields<ExchangeRateHistorySnapshot> fields = const {
    #period: _f$period,
    #timestamp: _f$timestamp,
    #baseCode: _f$baseCode,
    #convertedCode: _f$convertedCode,
    #exchangeRates: _f$exchangeRates,
  };

  static ExchangeRateHistorySnapshot _instantiate(DecodingData data) {
    return ExchangeRateHistorySnapshot(data.dec(_f$period), data.dec(_f$timestamp), data.dec(_f$baseCode),
        data.dec(_f$convertedCode), data.dec(_f$exchangeRates));
  }

  @override
  final Function instantiate = _instantiate;

  static ExchangeRateHistorySnapshot fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<ExchangeRateHistorySnapshot>(map);
  }

  static ExchangeRateHistorySnapshot fromJson(String json) {
    return ensureInitialized().decodeJson<ExchangeRateHistorySnapshot>(json);
  }
}

mixin ExchangeRateHistorySnapshotMappable {
  String toJson() {
    return ExchangeRateHistorySnapshotMapper.ensureInitialized()
        .encodeJson<ExchangeRateHistorySnapshot>(this as ExchangeRateHistorySnapshot);
  }

  Map<String, dynamic> toMap() {
    return ExchangeRateHistorySnapshotMapper.ensureInitialized()
        .encodeMap<ExchangeRateHistorySnapshot>(this as ExchangeRateHistorySnapshot);
  }

  ExchangeRateHistorySnapshotCopyWith<ExchangeRateHistorySnapshot, ExchangeRateHistorySnapshot,
          ExchangeRateHistorySnapshot>
      get copyWith =>
          _ExchangeRateHistorySnapshotCopyWithImpl(this as ExchangeRateHistorySnapshot, $identity, $identity);
  @override
  String toString() {
    return ExchangeRateHistorySnapshotMapper.ensureInitialized().stringifyValue(this as ExchangeRateHistorySnapshot);
  }

  @override
  bool operator ==(Object other) {
    return ExchangeRateHistorySnapshotMapper.ensureInitialized()
        .equalsValue(this as ExchangeRateHistorySnapshot, other);
  }

  @override
  int get hashCode {
    return ExchangeRateHistorySnapshotMapper.ensureInitialized().hashValue(this as ExchangeRateHistorySnapshot);
  }
}

extension ExchangeRateHistorySnapshotValueCopy<$R, $Out> on ObjectCopyWith<$R, ExchangeRateHistorySnapshot, $Out> {
  ExchangeRateHistorySnapshotCopyWith<$R, ExchangeRateHistorySnapshot, $Out> get $asExchangeRateHistorySnapshot =>
      $base.as((v, t, t2) => _ExchangeRateHistorySnapshotCopyWithImpl(v, t, t2));
}

abstract class ExchangeRateHistorySnapshotCopyWith<$R, $In extends ExchangeRateHistorySnapshot, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  MapCopyWith<$R, DateTime, double, ObjectCopyWith<$R, double, double>> get exchangeRates;
  $R call(
      {HistorySnapshotPeriod? period,
      DateTime? timestamp,
      CurrencyCode? baseCode,
      CurrencyCode? convertedCode,
      Map<DateTime, double>? exchangeRates});
  ExchangeRateHistorySnapshotCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _ExchangeRateHistorySnapshotCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, ExchangeRateHistorySnapshot, $Out>
    implements ExchangeRateHistorySnapshotCopyWith<$R, ExchangeRateHistorySnapshot, $Out> {
  _ExchangeRateHistorySnapshotCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<ExchangeRateHistorySnapshot> $mapper =
      ExchangeRateHistorySnapshotMapper.ensureInitialized();
  @override
  MapCopyWith<$R, DateTime, double, ObjectCopyWith<$R, double, double>> get exchangeRates =>
      MapCopyWith($value.exchangeRates, (v, t) => ObjectCopyWith(v, $identity, t), (v) => call(exchangeRates: v));
  @override
  $R call(
          {HistorySnapshotPeriod? period,
          DateTime? timestamp,
          CurrencyCode? baseCode,
          CurrencyCode? convertedCode,
          Map<DateTime, double>? exchangeRates}) =>
      $apply(FieldCopyWithData({
        if (period != null) #period: period,
        if (timestamp != null) #timestamp: timestamp,
        if (baseCode != null) #baseCode: baseCode,
        if (convertedCode != null) #convertedCode: convertedCode,
        if (exchangeRates != null) #exchangeRates: exchangeRates
      }));
  @override
  ExchangeRateHistorySnapshot $make(CopyWithData data) => ExchangeRateHistorySnapshot(
      data.get(#period, or: $value.period),
      data.get(#timestamp, or: $value.timestamp),
      data.get(#baseCode, or: $value.baseCode),
      data.get(#convertedCode, or: $value.convertedCode),
      data.get(#exchangeRates, or: $value.exchangeRates));

  @override
  ExchangeRateHistorySnapshotCopyWith<$R2, ExchangeRateHistorySnapshot, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t) =>
      _ExchangeRateHistorySnapshotCopyWithImpl($value, $cast, t);
}
