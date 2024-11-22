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
      ConfigurationCurrencyMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'Configuration';

  static String _$id(Configuration v) => v.id;
  static const Field<Configuration, String> _f$id = Field('id', _$id);
  static String _$name(Configuration v) => v.name;
  static const Field<Configuration, String> _f$name = Field('name', _$name);
  static double _$baseValue(Configuration v) => v.baseValue;
  static const Field<Configuration, double> _f$baseValue = Field('baseValue', _$baseValue);
  static CurrencyCode _$baseCurrency(Configuration v) => v.baseCurrency;
  static const Field<Configuration, CurrencyCode> _f$baseCurrency = Field('baseCurrency', _$baseCurrency);
  static List<ConfigurationCurrency> _$currencyData(Configuration v) => v.currencyData;
  static const Field<Configuration, List<ConfigurationCurrency>> _f$currencyData =
      Field('currencyData', _$currencyData);

  @override
  final MappableFields<Configuration> fields = const {
    #id: _f$id,
    #name: _f$name,
    #baseValue: _f$baseValue,
    #baseCurrency: _f$baseCurrency,
    #currencyData: _f$currencyData,
  };

  static Configuration _instantiate(DecodingData data) {
    return Configuration(data.dec(_f$id), data.dec(_f$name), data.dec(_f$baseValue), data.dec(_f$baseCurrency),
        data.dec(_f$currencyData));
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
  ListCopyWith<$R, ConfigurationCurrency,
      ConfigurationCurrencyCopyWith<$R, ConfigurationCurrency, ConfigurationCurrency>> get currencyData;
  $R call(
      {String? id,
      String? name,
      double? baseValue,
      CurrencyCode? baseCurrency,
      List<ConfigurationCurrency>? currencyData});
  ConfigurationCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _ConfigurationCopyWithImpl<$R, $Out> extends ClassCopyWithBase<$R, Configuration, $Out>
    implements ConfigurationCopyWith<$R, Configuration, $Out> {
  _ConfigurationCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<Configuration> $mapper = ConfigurationMapper.ensureInitialized();
  @override
  ListCopyWith<$R, ConfigurationCurrency,
          ConfigurationCurrencyCopyWith<$R, ConfigurationCurrency, ConfigurationCurrency>>
      get currencyData =>
          ListCopyWith($value.currencyData, (v, t) => v.copyWith.$chain(t), (v) => call(currencyData: v));
  @override
  $R call(
          {String? id,
          String? name,
          double? baseValue,
          CurrencyCode? baseCurrency,
          List<ConfigurationCurrency>? currencyData}) =>
      $apply(FieldCopyWithData({
        if (id != null) #id: id,
        if (name != null) #name: name,
        if (baseValue != null) #baseValue: baseValue,
        if (baseCurrency != null) #baseCurrency: baseCurrency,
        if (currencyData != null) #currencyData: currencyData
      }));
  @override
  Configuration $make(CopyWithData data) => Configuration(
      data.get(#id, or: $value.id),
      data.get(#name, or: $value.name),
      data.get(#baseValue, or: $value.baseValue),
      data.get(#baseCurrency, or: $value.baseCurrency),
      data.get(#currencyData, or: $value.currencyData));

  @override
  ConfigurationCopyWith<$R2, Configuration, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t) =>
      _ConfigurationCopyWithImpl($value, $cast, t);
}

class ConfigurationCurrencyMapper extends ClassMapperBase<ConfigurationCurrency> {
  ConfigurationCurrencyMapper._();

  static ConfigurationCurrencyMapper? _instance;
  static ConfigurationCurrencyMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = ConfigurationCurrencyMapper._());
      CurrencyCodeMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'ConfigurationCurrency';

  static CurrencyCode _$code(ConfigurationCurrency v) => v.code;
  static const Field<ConfigurationCurrency, CurrencyCode> _f$code = Field('code', _$code);
  static bool _$isExpanded(ConfigurationCurrency v) => v.isExpanded;
  static const Field<ConfigurationCurrency, bool> _f$isExpanded = Field('isExpanded', _$isExpanded);

  @override
  final MappableFields<ConfigurationCurrency> fields = const {
    #code: _f$code,
    #isExpanded: _f$isExpanded,
  };

  static ConfigurationCurrency _instantiate(DecodingData data) {
    return ConfigurationCurrency(data.dec(_f$code), data.dec(_f$isExpanded));
  }

  @override
  final Function instantiate = _instantiate;

  static ConfigurationCurrency fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<ConfigurationCurrency>(map);
  }

  static ConfigurationCurrency fromJson(String json) {
    return ensureInitialized().decodeJson<ConfigurationCurrency>(json);
  }
}

mixin ConfigurationCurrencyMappable {
  String toJson() {
    return ConfigurationCurrencyMapper.ensureInitialized()
        .encodeJson<ConfigurationCurrency>(this as ConfigurationCurrency);
  }

  Map<String, dynamic> toMap() {
    return ConfigurationCurrencyMapper.ensureInitialized()
        .encodeMap<ConfigurationCurrency>(this as ConfigurationCurrency);
  }

  ConfigurationCurrencyCopyWith<ConfigurationCurrency, ConfigurationCurrency, ConfigurationCurrency> get copyWith =>
      _ConfigurationCurrencyCopyWithImpl(this as ConfigurationCurrency, $identity, $identity);
  @override
  String toString() {
    return ConfigurationCurrencyMapper.ensureInitialized().stringifyValue(this as ConfigurationCurrency);
  }

  @override
  bool operator ==(Object other) {
    return ConfigurationCurrencyMapper.ensureInitialized().equalsValue(this as ConfigurationCurrency, other);
  }

  @override
  int get hashCode {
    return ConfigurationCurrencyMapper.ensureInitialized().hashValue(this as ConfigurationCurrency);
  }
}

extension ConfigurationCurrencyValueCopy<$R, $Out> on ObjectCopyWith<$R, ConfigurationCurrency, $Out> {
  ConfigurationCurrencyCopyWith<$R, ConfigurationCurrency, $Out> get $asConfigurationCurrency =>
      $base.as((v, t, t2) => _ConfigurationCurrencyCopyWithImpl(v, t, t2));
}

abstract class ConfigurationCurrencyCopyWith<$R, $In extends ConfigurationCurrency, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  $R call({CurrencyCode? code, bool? isExpanded});
  ConfigurationCurrencyCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _ConfigurationCurrencyCopyWithImpl<$R, $Out> extends ClassCopyWithBase<$R, ConfigurationCurrency, $Out>
    implements ConfigurationCurrencyCopyWith<$R, ConfigurationCurrency, $Out> {
  _ConfigurationCurrencyCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<ConfigurationCurrency> $mapper = ConfigurationCurrencyMapper.ensureInitialized();
  @override
  $R call({CurrencyCode? code, bool? isExpanded}) =>
      $apply(FieldCopyWithData({if (code != null) #code: code, if (isExpanded != null) #isExpanded: isExpanded}));
  @override
  ConfigurationCurrency $make(CopyWithData data) =>
      ConfigurationCurrency(data.get(#code, or: $value.code), data.get(#isExpanded, or: $value.isExpanded));

  @override
  ConfigurationCurrencyCopyWith<$R2, ConfigurationCurrency, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t) =>
      _ConfigurationCurrencyCopyWithImpl($value, $cast, t);
}
