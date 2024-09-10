// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'configuration.dart';

class ConfigurationMapper extends ClassMapperBase<Configuration> {
  ConfigurationMapper._();

  static ConfigurationMapper? _instance;
  static ConfigurationMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = ConfigurationMapper._());
      CurrencyCodeMapper.ensureInitialized();
      ExchangeRateSnapshotMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'Configuration';

  static String _$name(Configuration v) => v.name;
  static const Field<Configuration, String> _f$name = Field('name', _$name);
  static double _$baseValue(Configuration v) => v.baseValue;
  static const Field<Configuration, double> _f$baseValue = Field('baseValue', _$baseValue);
  static CurrencyCode _$baseCurrency(Configuration v) => v.baseCurrency;
  static const Field<Configuration, CurrencyCode> _f$baseCurrency = Field('baseCurrency', _$baseCurrency);
  static Set<CurrencyCode> _$currencies(Configuration v) => v.currencies;
  static const Field<Configuration, Set<CurrencyCode>> _f$currencies = Field('currencies', _$currencies);
  static ExchangeRateSnapshot _$snapshot(Configuration v) => v.snapshot;
  static const Field<Configuration, ExchangeRateSnapshot> _f$snapshot = Field('snapshot', _$snapshot);

  @override
  final MappableFields<Configuration> fields = const {
    #name: _f$name,
    #baseValue: _f$baseValue,
    #baseCurrency: _f$baseCurrency,
    #currencies: _f$currencies,
    #snapshot: _f$snapshot,
  };

  static Configuration _instantiate(DecodingData data) {
    return Configuration(data.dec(_f$name), data.dec(_f$baseValue), data.dec(_f$baseCurrency), data.dec(_f$currencies),
        data.dec(_f$snapshot));
  }

  @override
  final Function instantiate = _instantiate;

  static Configuration fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<Configuration>(map);
  }

  static Configuration fromJson(String json) {
    return ensureInitialized().decodeJson<Configuration>(json);
  }
}

mixin ConfigurationMappable {
  String toJson() {
    return ConfigurationMapper.ensureInitialized().encodeJson<Configuration>(this as Configuration);
  }

  Map<String, dynamic> toMap() {
    return ConfigurationMapper.ensureInitialized().encodeMap<Configuration>(this as Configuration);
  }

  ConfigurationCopyWith<Configuration, Configuration, Configuration> get copyWith =>
      _ConfigurationCopyWithImpl(this as Configuration, $identity, $identity);
  @override
  String toString() {
    return ConfigurationMapper.ensureInitialized().stringifyValue(this as Configuration);
  }

  @override
  bool operator ==(Object other) {
    return ConfigurationMapper.ensureInitialized().equalsValue(this as Configuration, other);
  }

  @override
  int get hashCode {
    return ConfigurationMapper.ensureInitialized().hashValue(this as Configuration);
  }
}

extension ConfigurationValueCopy<$R, $Out> on ObjectCopyWith<$R, Configuration, $Out> {
  ConfigurationCopyWith<$R, Configuration, $Out> get $asConfiguration =>
      $base.as((v, t, t2) => _ConfigurationCopyWithImpl(v, t, t2));
}

abstract class ConfigurationCopyWith<$R, $In extends Configuration, $Out> implements ClassCopyWith<$R, $In, $Out> {
  ExchangeRateSnapshotCopyWith<$R, ExchangeRateSnapshot, ExchangeRateSnapshot> get snapshot;
  $R call(
      {String? name,
      double? baseValue,
      CurrencyCode? baseCurrency,
      Set<CurrencyCode>? currencies,
      ExchangeRateSnapshot? snapshot});
  ConfigurationCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _ConfigurationCopyWithImpl<$R, $Out> extends ClassCopyWithBase<$R, Configuration, $Out>
    implements ConfigurationCopyWith<$R, Configuration, $Out> {
  _ConfigurationCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<Configuration> $mapper = ConfigurationMapper.ensureInitialized();
  @override
  ExchangeRateSnapshotCopyWith<$R, ExchangeRateSnapshot, ExchangeRateSnapshot> get snapshot =>
      $value.snapshot.copyWith.$chain((v) => call(snapshot: v));
  @override
  $R call(
          {String? name,
          double? baseValue,
          CurrencyCode? baseCurrency,
          Set<CurrencyCode>? currencies,
          ExchangeRateSnapshot? snapshot}) =>
      $apply(FieldCopyWithData({
        if (name != null) #name: name,
        if (baseValue != null) #baseValue: baseValue,
        if (baseCurrency != null) #baseCurrency: baseCurrency,
        if (currencies != null) #currencies: currencies,
        if (snapshot != null) #snapshot: snapshot
      }));
  @override
  Configuration $make(CopyWithData data) => Configuration(
      data.get(#name, or: $value.name),
      data.get(#baseValue, or: $value.baseValue),
      data.get(#baseCurrency, or: $value.baseCurrency),
      data.get(#currencies, or: $value.currencies),
      data.get(#snapshot, or: $value.snapshot));

  @override
  ConfigurationCopyWith<$R2, Configuration, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t) =>
      _ConfigurationCopyWithImpl($value, $cast, t);
}
