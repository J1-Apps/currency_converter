// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'data_state.dart';

class DataStateMapper extends ClassMapperBase<DataState> {
  DataStateMapper._();

  static DataStateMapper? _instance;
  static DataStateMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = DataStateMapper._());
      DataSuccessMapper.ensureInitialized();
      DataEmptyMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'DataState';
  @override
  Function get typeFactory => <T>(f) => f<DataState<T>>();

  @override
  final MappableFields<DataState> fields = const {};

  static DataState<T> _instantiate<T>(DecodingData data) {
    throw MapperException.missingSubclass(
        'DataState', 'state', '${data.value['state']}');
  }

  @override
  final Function instantiate = _instantiate;

  static DataState<T> fromMap<T>(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<DataState<T>>(map);
  }

  static DataState<T> fromJson<T>(String json) {
    return ensureInitialized().decodeJson<DataState<T>>(json);
  }
}

mixin DataStateMappable<T> {
  String toJson();
  Map<String, dynamic> toMap();
  DataStateCopyWith<DataState<T>, DataState<T>, DataState<T>, T> get copyWith;
}

abstract class DataStateCopyWith<$R, $In extends DataState<T>, $Out, T>
    implements ClassCopyWith<$R, $In, $Out> {
  $R call();
  DataStateCopyWith<$R2, $In, $Out2, T> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class DataSuccessMapper extends SubClassMapperBase<DataSuccess> {
  DataSuccessMapper._();

  static DataSuccessMapper? _instance;
  static DataSuccessMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = DataSuccessMapper._());
      DataStateMapper.ensureInitialized().addSubMapper(_instance!);
    }
    return _instance!;
  }

  @override
  final String id = 'DataSuccess';
  @override
  Function get typeFactory => <T>(f) => f<DataSuccess<T>>();

  static dynamic _$data(DataSuccess v) => v.data;
  static dynamic _arg$data<T>(f) => f<T>();
  static const Field<DataSuccess, dynamic> _f$data =
      Field('data', _$data, arg: _arg$data);

  @override
  final MappableFields<DataSuccess> fields = const {
    #data: _f$data,
  };

  @override
  final String discriminatorKey = 'state';
  @override
  final dynamic discriminatorValue = "success";
  @override
  late final ClassMapperBase superMapper = DataStateMapper.ensureInitialized();

  static DataSuccess<T> _instantiate<T>(DecodingData data) {
    return DataSuccess(data.dec(_f$data));
  }

  @override
  final Function instantiate = _instantiate;

  static DataSuccess<T> fromMap<T>(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<DataSuccess<T>>(map);
  }

  static DataSuccess<T> fromJson<T>(String json) {
    return ensureInitialized().decodeJson<DataSuccess<T>>(json);
  }
}

mixin DataSuccessMappable<T> {
  String toJson() {
    return DataSuccessMapper.ensureInitialized()
        .encodeJson<DataSuccess<T>>(this as DataSuccess<T>);
  }

  Map<String, dynamic> toMap() {
    return DataSuccessMapper.ensureInitialized()
        .encodeMap<DataSuccess<T>>(this as DataSuccess<T>);
  }

  DataSuccessCopyWith<DataSuccess<T>, DataSuccess<T>, DataSuccess<T>, T>
      get copyWith => _DataSuccessCopyWithImpl(
          this as DataSuccess<T>, $identity, $identity);
  @override
  String toString() {
    return DataSuccessMapper.ensureInitialized()
        .stringifyValue(this as DataSuccess<T>);
  }

  @override
  bool operator ==(Object other) {
    return DataSuccessMapper.ensureInitialized()
        .equalsValue(this as DataSuccess<T>, other);
  }

  @override
  int get hashCode {
    return DataSuccessMapper.ensureInitialized()
        .hashValue(this as DataSuccess<T>);
  }
}

extension DataSuccessValueCopy<$R, $Out, T>
    on ObjectCopyWith<$R, DataSuccess<T>, $Out> {
  DataSuccessCopyWith<$R, DataSuccess<T>, $Out, T> get $asDataSuccess =>
      $base.as((v, t, t2) => _DataSuccessCopyWithImpl(v, t, t2));
}

abstract class DataSuccessCopyWith<$R, $In extends DataSuccess<T>, $Out, T>
    implements DataStateCopyWith<$R, $In, $Out, T> {
  @override
  $R call({T? data});
  DataSuccessCopyWith<$R2, $In, $Out2, T> $chain<$R2, $Out2>(
      Then<$Out2, $R2> t);
}

class _DataSuccessCopyWithImpl<$R, $Out, T>
    extends ClassCopyWithBase<$R, DataSuccess<T>, $Out>
    implements DataSuccessCopyWith<$R, DataSuccess<T>, $Out, T> {
  _DataSuccessCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<DataSuccess> $mapper =
      DataSuccessMapper.ensureInitialized();
  @override
  $R call({T? data}) =>
      $apply(FieldCopyWithData({if (data != null) #data: data}));
  @override
  DataSuccess<T> $make(CopyWithData data) =>
      DataSuccess(data.get(#data, or: $value.data));

  @override
  DataSuccessCopyWith<$R2, DataSuccess<T>, $Out2, T> $chain<$R2, $Out2>(
          Then<$Out2, $R2> t) =>
      _DataSuccessCopyWithImpl($value, $cast, t);
}

class DataEmptyMapper extends SubClassMapperBase<DataEmpty> {
  DataEmptyMapper._();

  static DataEmptyMapper? _instance;
  static DataEmptyMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = DataEmptyMapper._());
      DataStateMapper.ensureInitialized().addSubMapper(_instance!);
    }
    return _instance!;
  }

  @override
  final String id = 'DataEmpty';
  @override
  Function get typeFactory => <T>(f) => f<DataEmpty<T>>();

  @override
  final MappableFields<DataEmpty> fields = const {};

  @override
  final String discriminatorKey = 'state';
  @override
  final dynamic discriminatorValue = "empty";
  @override
  late final ClassMapperBase superMapper = DataStateMapper.ensureInitialized();

  static DataEmpty<T> _instantiate<T>(DecodingData data) {
    return DataEmpty();
  }

  @override
  final Function instantiate = _instantiate;

  static DataEmpty<T> fromMap<T>(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<DataEmpty<T>>(map);
  }

  static DataEmpty<T> fromJson<T>(String json) {
    return ensureInitialized().decodeJson<DataEmpty<T>>(json);
  }
}

mixin DataEmptyMappable<T> {
  String toJson() {
    return DataEmptyMapper.ensureInitialized()
        .encodeJson<DataEmpty<T>>(this as DataEmpty<T>);
  }

  Map<String, dynamic> toMap() {
    return DataEmptyMapper.ensureInitialized()
        .encodeMap<DataEmpty<T>>(this as DataEmpty<T>);
  }

  DataEmptyCopyWith<DataEmpty<T>, DataEmpty<T>, DataEmpty<T>, T> get copyWith =>
      _DataEmptyCopyWithImpl(this as DataEmpty<T>, $identity, $identity);
  @override
  String toString() {
    return DataEmptyMapper.ensureInitialized()
        .stringifyValue(this as DataEmpty<T>);
  }

  @override
  bool operator ==(Object other) {
    return DataEmptyMapper.ensureInitialized()
        .equalsValue(this as DataEmpty<T>, other);
  }

  @override
  int get hashCode {
    return DataEmptyMapper.ensureInitialized().hashValue(this as DataEmpty<T>);
  }
}

extension DataEmptyValueCopy<$R, $Out, T>
    on ObjectCopyWith<$R, DataEmpty<T>, $Out> {
  DataEmptyCopyWith<$R, DataEmpty<T>, $Out, T> get $asDataEmpty =>
      $base.as((v, t, t2) => _DataEmptyCopyWithImpl(v, t, t2));
}

abstract class DataEmptyCopyWith<$R, $In extends DataEmpty<T>, $Out, T>
    implements DataStateCopyWith<$R, $In, $Out, T> {
  @override
  $R call();
  DataEmptyCopyWith<$R2, $In, $Out2, T> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _DataEmptyCopyWithImpl<$R, $Out, T>
    extends ClassCopyWithBase<$R, DataEmpty<T>, $Out>
    implements DataEmptyCopyWith<$R, DataEmpty<T>, $Out, T> {
  _DataEmptyCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<DataEmpty> $mapper =
      DataEmptyMapper.ensureInitialized();
  @override
  $R call() => $apply(FieldCopyWithData({}));
  @override
  DataEmpty<T> $make(CopyWithData data) => DataEmpty();

  @override
  DataEmptyCopyWith<$R2, DataEmpty<T>, $Out2, T> $chain<$R2, $Out2>(
          Then<$Out2, $R2> t) =>
      _DataEmptyCopyWithImpl($value, $cast, t);
}
