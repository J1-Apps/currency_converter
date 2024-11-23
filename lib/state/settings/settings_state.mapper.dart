// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'settings_state.dart';

class SettingsErrorCodeMapper extends EnumMapper<SettingsErrorCode> {
  SettingsErrorCodeMapper._();

  static SettingsErrorCodeMapper? _instance;
  static SettingsErrorCodeMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = SettingsErrorCodeMapper._());
    }
    return _instance!;
  }

  static SettingsErrorCode fromValue(dynamic value) {
    ensureInitialized();
    return MapperContainer.globals.fromValue(value);
  }

  @override
  SettingsErrorCode decode(dynamic value) {
    switch (value) {
      case 'loadLanguage':
        return SettingsErrorCode.loadLanguage;
      case 'saveLanguage':
        return SettingsErrorCode.saveLanguage;
      default:
        throw MapperException.unknownEnumValue(value);
    }
  }

  @override
  dynamic encode(SettingsErrorCode self) {
    switch (self) {
      case SettingsErrorCode.loadLanguage:
        return 'loadLanguage';
      case SettingsErrorCode.saveLanguage:
        return 'saveLanguage';
    }
  }
}

extension SettingsErrorCodeMapperExtension on SettingsErrorCode {
  String toValue() {
    SettingsErrorCodeMapper.ensureInitialized();
    return MapperContainer.globals.toValue<SettingsErrorCode>(this) as String;
  }
}

class SettingsStateMapper extends ClassMapperBase<SettingsState> {
  SettingsStateMapper._();

  static SettingsStateMapper? _instance;
  static SettingsStateMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = SettingsStateMapper._());
      LoadingStateMapper.ensureInitialized();
      SettingsErrorCodeMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'SettingsState';

  static LoadingState _$status(SettingsState v) => v.status;
  static const Field<SettingsState, LoadingState> _f$status = Field('status', _$status);
  static String? _$language(SettingsState v) => v.language;
  static const Field<SettingsState, String> _f$language = Field('language', _$language);
  static SettingsErrorCode? _$error(SettingsState v) => v.error;
  static const Field<SettingsState, SettingsErrorCode> _f$error = Field('error', _$error);

  @override
  final MappableFields<SettingsState> fields = const {
    #status: _f$status,
    #language: _f$language,
    #error: _f$error,
  };

  static SettingsState _instantiate(DecodingData data) {
    return SettingsState(data.dec(_f$status), data.dec(_f$language), data.dec(_f$error));
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
  $R call({LoadingState? status, String? language, SettingsErrorCode? error});
  SettingsStateCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _SettingsStateCopyWithImpl<$R, $Out> extends ClassCopyWithBase<$R, SettingsState, $Out>
    implements SettingsStateCopyWith<$R, SettingsState, $Out> {
  _SettingsStateCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<SettingsState> $mapper = SettingsStateMapper.ensureInitialized();
  @override
  $R call({LoadingState? status, Object? language = $none, Object? error = $none}) => $apply(FieldCopyWithData({
        if (status != null) #status: status,
        if (language != $none) #language: language,
        if (error != $none) #error: error
      }));
  @override
  SettingsState $make(CopyWithData data) => SettingsState(data.get(#status, or: $value.status),
      data.get(#language, or: $value.language), data.get(#error, or: $value.error));

  @override
  SettingsStateCopyWith<$R2, SettingsState, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t) =>
      _SettingsStateCopyWithImpl($value, $cast, t);
}
