// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'home_state.dart';

class HomeStatusMapper extends EnumMapper<HomeStatus> {
  HomeStatusMapper._();

  static HomeStatusMapper? _instance;
  static HomeStatusMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = HomeStatusMapper._());
    }
    return _instance!;
  }

  static HomeStatus fromValue(dynamic value) {
    ensureInitialized();
    return MapperContainer.globals.fromValue(value);
  }

  @override
  HomeStatus decode(dynamic value) {
    switch (value) {
      case 'initial':
        return HomeStatus.initial;
      case 'loading':
        return HomeStatus.loading;
      case 'error':
        return HomeStatus.error;
      case 'loaded':
        return HomeStatus.loaded;
      default:
        throw MapperException.unknownEnumValue(value);
    }
  }

  @override
  dynamic encode(HomeStatus self) {
    switch (self) {
      case HomeStatus.initial:
        return 'initial';
      case HomeStatus.loading:
        return 'loading';
      case HomeStatus.error:
        return 'error';
      case HomeStatus.loaded:
        return 'loaded';
    }
  }
}

extension HomeStatusMapperExtension on HomeStatus {
  String toValue() {
    HomeStatusMapper.ensureInitialized();
    return MapperContainer.globals.toValue<HomeStatus>(this) as String;
  }
}

class HomeStateMapper extends ClassMapperBase<HomeState> {
  HomeStateMapper._();

  static HomeStateMapper? _instance;
  static HomeStateMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = HomeStateMapper._());
      HomeStatusMapper.ensureInitialized();
      ConfigurationMapper.ensureInitialized();
      ExchangeRateSnapshotMapper.ensureInitialized();
      CcErrorMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'HomeState';

  static HomeStatus _$status(HomeState v) => v.status;
  static const Field<HomeState, HomeStatus> _f$status = Field('status', _$status);
  static Configuration? _$configuration(HomeState v) => v.configuration;
  static const Field<HomeState, Configuration> _f$configuration = Field('configuration', _$configuration);
  static ExchangeRateSnapshot? _$snapshot(HomeState v) => v.snapshot;
  static const Field<HomeState, ExchangeRateSnapshot> _f$snapshot = Field('snapshot', _$snapshot);
  static bool _$isRefreshing(HomeState v) => v.isRefreshing;
  static const Field<HomeState, bool> _f$isRefreshing = Field('isRefreshing', _$isRefreshing, opt: true, def: false);
  static CcError? _$error(HomeState v) => v.error;
  static const Field<HomeState, CcError> _f$error = Field('error', _$error, opt: true);

  @override
  final MappableFields<HomeState> fields = const {
    #status: _f$status,
    #configuration: _f$configuration,
    #snapshot: _f$snapshot,
    #isRefreshing: _f$isRefreshing,
    #error: _f$error,
  };

  static HomeState _instantiate(DecodingData data) {
    return HomeState(
        status: data.dec(_f$status),
        configuration: data.dec(_f$configuration),
        snapshot: data.dec(_f$snapshot),
        isRefreshing: data.dec(_f$isRefreshing),
        error: data.dec(_f$error));
  }

  @override
  final Function instantiate = _instantiate;

  static HomeState fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<HomeState>(map);
  }

  static HomeState fromJson(String json) {
    return ensureInitialized().decodeJson<HomeState>(json);
  }
}

mixin HomeStateMappable {
  String toJson() {
    return HomeStateMapper.ensureInitialized().encodeJson<HomeState>(this as HomeState);
  }

  Map<String, dynamic> toMap() {
    return HomeStateMapper.ensureInitialized().encodeMap<HomeState>(this as HomeState);
  }

  HomeStateCopyWith<HomeState, HomeState, HomeState> get copyWith =>
      _HomeStateCopyWithImpl(this as HomeState, $identity, $identity);
  @override
  String toString() {
    return HomeStateMapper.ensureInitialized().stringifyValue(this as HomeState);
  }

  @override
  bool operator ==(Object other) {
    return HomeStateMapper.ensureInitialized().equalsValue(this as HomeState, other);
  }

  @override
  int get hashCode {
    return HomeStateMapper.ensureInitialized().hashValue(this as HomeState);
  }
}

extension HomeStateValueCopy<$R, $Out> on ObjectCopyWith<$R, HomeState, $Out> {
  HomeStateCopyWith<$R, HomeState, $Out> get $asHomeState => $base.as((v, t, t2) => _HomeStateCopyWithImpl(v, t, t2));
}

abstract class HomeStateCopyWith<$R, $In extends HomeState, $Out> implements ClassCopyWith<$R, $In, $Out> {
  ConfigurationCopyWith<$R, Configuration, Configuration>? get configuration;
  ExchangeRateSnapshotCopyWith<$R, ExchangeRateSnapshot, ExchangeRateSnapshot>? get snapshot;
  CcErrorCopyWith<$R, CcError, CcError>? get error;
  $R call(
      {HomeStatus? status,
      Configuration? configuration,
      ExchangeRateSnapshot? snapshot,
      bool? isRefreshing,
      CcError? error});
  HomeStateCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _HomeStateCopyWithImpl<$R, $Out> extends ClassCopyWithBase<$R, HomeState, $Out>
    implements HomeStateCopyWith<$R, HomeState, $Out> {
  _HomeStateCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<HomeState> $mapper = HomeStateMapper.ensureInitialized();
  @override
  ConfigurationCopyWith<$R, Configuration, Configuration>? get configuration =>
      $value.configuration?.copyWith.$chain((v) => call(configuration: v));
  @override
  ExchangeRateSnapshotCopyWith<$R, ExchangeRateSnapshot, ExchangeRateSnapshot>? get snapshot =>
      $value.snapshot?.copyWith.$chain((v) => call(snapshot: v));
  @override
  CcErrorCopyWith<$R, CcError, CcError>? get error => $value.error?.copyWith.$chain((v) => call(error: v));
  @override
  $R call(
          {HomeStatus? status,
          Object? configuration = $none,
          Object? snapshot = $none,
          bool? isRefreshing,
          Object? error = $none}) =>
      $apply(FieldCopyWithData({
        if (status != null) #status: status,
        if (configuration != $none) #configuration: configuration,
        if (snapshot != $none) #snapshot: snapshot,
        if (isRefreshing != null) #isRefreshing: isRefreshing,
        if (error != $none) #error: error
      }));
  @override
  HomeState $make(CopyWithData data) => HomeState(
      status: data.get(#status, or: $value.status),
      configuration: data.get(#configuration, or: $value.configuration),
      snapshot: data.get(#snapshot, or: $value.snapshot),
      isRefreshing: data.get(#isRefreshing, or: $value.isRefreshing),
      error: data.get(#error, or: $value.error));

  @override
  HomeStateCopyWith<$R2, HomeState, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t) =>
      _HomeStateCopyWithImpl($value, $cast, t);
}
