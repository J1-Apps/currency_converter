// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'settings_state.dart';

class SettingsStateMapper extends ClassMapperBase<SettingsState> {
  SettingsStateMapper._();

  static SettingsStateMapper? _instance;
  static SettingsStateMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = SettingsStateMapper._());
      CurrencyCodeMapper.ensureInitialized();
      ConfigurationMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'SettingsState';

  static List<CurrencyCode> _$favorites(SettingsState v) => v.favorites;
  static const Field<SettingsState, List<CurrencyCode>> _f$favorites = Field('favorites', _$favorites);
  static List<Configuration> _$configurations(SettingsState v) => v.configurations;
  static const Field<SettingsState, List<Configuration>> _f$configurations = Field('configurations', _$configurations);
  static String _$language(SettingsState v) => v.language;
  static const Field<SettingsState, String> _f$language = Field('language', _$language);

  @override
  final MappableFields<SettingsState> fields = const {
    #favorites: _f$favorites,
    #configurations: _f$configurations,
    #language: _f$language,
  };

  static SettingsState _instantiate(DecodingData data) {
    return SettingsState(data.dec(_f$favorites), data.dec(_f$configurations), data.dec(_f$language));
  }

  @override
  final Function instantiate = _instantiate;

  static SettingsState fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<SettingsState>(map);
  }

  static SettingsState fromJson(String json) {
    return ensureInitialized().decodeJson<SettingsState>(json);
  }
}

mixin SettingsStateMappable {
  String toJson() {
    return SettingsStateMapper.ensureInitialized().encodeJson<SettingsState>(this as SettingsState);
  }

  Map<String, dynamic> toMap() {
    return SettingsStateMapper.ensureInitialized().encodeMap<SettingsState>(this as SettingsState);
  }

  SettingsStateCopyWith<SettingsState, SettingsState, SettingsState> get copyWith =>
      _SettingsStateCopyWithImpl(this as SettingsState, $identity, $identity);
  @override
  String toString() {
    return SettingsStateMapper.ensureInitialized().stringifyValue(this as SettingsState);
  }

  @override
  bool operator ==(Object other) {
    return SettingsStateMapper.ensureInitialized().equalsValue(this as SettingsState, other);
  }

  @override
  int get hashCode {
    return SettingsStateMapper.ensureInitialized().hashValue(this as SettingsState);
  }
}

extension SettingsStateValueCopy<$R, $Out> on ObjectCopyWith<$R, SettingsState, $Out> {
  SettingsStateCopyWith<$R, SettingsState, $Out> get $asSettingsState =>
      $base.as((v, t, t2) => _SettingsStateCopyWithImpl(v, t, t2));
}

abstract class SettingsStateCopyWith<$R, $In extends SettingsState, $Out> implements ClassCopyWith<$R, $In, $Out> {
  ListCopyWith<$R, CurrencyCode, ObjectCopyWith<$R, CurrencyCode, CurrencyCode>> get favorites;
  ListCopyWith<$R, Configuration, ConfigurationCopyWith<$R, Configuration, Configuration>> get configurations;
  $R call({List<CurrencyCode>? favorites, List<Configuration>? configurations, String? language});
  SettingsStateCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _SettingsStateCopyWithImpl<$R, $Out> extends ClassCopyWithBase<$R, SettingsState, $Out>
    implements SettingsStateCopyWith<$R, SettingsState, $Out> {
  _SettingsStateCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<SettingsState> $mapper = SettingsStateMapper.ensureInitialized();
  @override
  ListCopyWith<$R, CurrencyCode, ObjectCopyWith<$R, CurrencyCode, CurrencyCode>> get favorites =>
      ListCopyWith($value.favorites, (v, t) => ObjectCopyWith(v, $identity, t), (v) => call(favorites: v));
  @override
  ListCopyWith<$R, Configuration, ConfigurationCopyWith<$R, Configuration, Configuration>> get configurations =>
      ListCopyWith($value.configurations, (v, t) => v.copyWith.$chain(t), (v) => call(configurations: v));
  @override
  $R call({List<CurrencyCode>? favorites, List<Configuration>? configurations, String? language}) =>
      $apply(FieldCopyWithData({
        if (favorites != null) #favorites: favorites,
        if (configurations != null) #configurations: configurations,
        if (language != null) #language: language
      }));
  @override
  SettingsState $make(CopyWithData data) => SettingsState(data.get(#favorites, or: $value.favorites),
      data.get(#configurations, or: $value.configurations), data.get(#language, or: $value.language));

  @override
  SettingsStateCopyWith<$R2, SettingsState, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t) =>
      _SettingsStateCopyWithImpl($value, $cast, t);
}