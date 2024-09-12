// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'home_state.dart';

class HomeLoadingStateMapper extends EnumMapper<HomeLoadingState> {
  HomeLoadingStateMapper._();

  static HomeLoadingStateMapper? _instance;
  static HomeLoadingStateMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = HomeLoadingStateMapper._());
    }
    return _instance!;
  }

  static HomeLoadingState fromValue(dynamic value) {
    ensureInitialized();
    return MapperContainer.globals.fromValue(value);
  }

  @override
  HomeLoadingState decode(dynamic value) {
    switch (value) {
      case 'loadingConfig':
        return HomeLoadingState.loadingConfig;
      case 'loadingSnapshot':
        return HomeLoadingState.loadingSnapshot;
      case 'snapshotError':
        return HomeLoadingState.snapshotError;
      case 'loaded':
        return HomeLoadingState.loaded;
      default:
        throw MapperException.unknownEnumValue(value);
    }
  }

  @override
  dynamic encode(HomeLoadingState self) {
    switch (self) {
      case HomeLoadingState.loadingConfig:
        return 'loadingConfig';
      case HomeLoadingState.loadingSnapshot:
        return 'loadingSnapshot';
      case HomeLoadingState.snapshotError:
        return 'snapshotError';
      case HomeLoadingState.loaded:
        return 'loaded';
    }
  }
}

extension HomeLoadingStateMapperExtension on HomeLoadingState {
  String toValue() {
    HomeLoadingStateMapper.ensureInitialized();
    return MapperContainer.globals.toValue<HomeLoadingState>(this) as String;
  }
}

class HomeStateMapper extends ClassMapperBase<HomeState> {
  HomeStateMapper._();

  static HomeStateMapper? _instance;
  static HomeStateMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = HomeStateMapper._());
      HomeLoadingStateMapper.ensureInitialized();
      ConfigurationMapper.ensureInitialized();
      ExchangeRateSnapshotMapper.ensureInitialized();
      CurrencyCodeMapper.ensureInitialized();
      CcErrorMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'HomeState';

  static HomeLoadingState _$loadingState(HomeState v) => v.loadingState;
  static const Field<HomeState, HomeLoadingState> _f$loadingState = Field('loadingState', _$loadingState);
  static Configuration? _$configuration(HomeState v) => v.configuration;
  static const Field<HomeState, Configuration> _f$configuration = Field('configuration', _$configuration);
  static ExchangeRateSnapshot? _$snapshot(HomeState v) => v.snapshot;
  static const Field<HomeState, ExchangeRateSnapshot> _f$snapshot = Field('snapshot', _$snapshot);
  static List<CurrencyCode>? _$favorites(HomeState v) => v.favorites;
  static const Field<HomeState, List<CurrencyCode>> _f$favorites = Field('favorites', _$favorites);
  static CcError? _$error(HomeState v) => v.error;
  static const Field<HomeState, CcError> _f$error = Field('error', _$error);

  @override
  final MappableFields<HomeState> fields = const {
    #loadingState: _f$loadingState,
    #configuration: _f$configuration,
    #snapshot: _f$snapshot,
    #favorites: _f$favorites,
    #error: _f$error,
  };

  static HomeState _instantiate(DecodingData data) {
    return HomeState(data.dec(_f$loadingState), data.dec(_f$configuration), data.dec(_f$snapshot),
        data.dec(_f$favorites), data.dec(_f$error));
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
  ListCopyWith<$R, CurrencyCode, ObjectCopyWith<$R, CurrencyCode, CurrencyCode>>? get favorites;
  CcErrorCopyWith<$R, CcError, CcError>? get error;
  $R call(
      {HomeLoadingState? loadingState,
      Configuration? configuration,
      ExchangeRateSnapshot? snapshot,
      List<CurrencyCode>? favorites,
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
  ListCopyWith<$R, CurrencyCode, ObjectCopyWith<$R, CurrencyCode, CurrencyCode>>? get favorites =>
      $value.favorites != null
          ? ListCopyWith($value.favorites!, (v, t) => ObjectCopyWith(v, $identity, t), (v) => call(favorites: v))
          : null;
  @override
  CcErrorCopyWith<$R, CcError, CcError>? get error => $value.error?.copyWith.$chain((v) => call(error: v));
  @override
  $R call(
          {HomeLoadingState? loadingState,
          Object? configuration = $none,
          Object? snapshot = $none,
          Object? favorites = $none,
          Object? error = $none}) =>
      $apply(FieldCopyWithData({
        if (loadingState != null) #loadingState: loadingState,
        if (configuration != $none) #configuration: configuration,
        if (snapshot != $none) #snapshot: snapshot,
        if (favorites != $none) #favorites: favorites,
        if (error != $none) #error: error
      }));
  @override
  HomeState $make(CopyWithData data) => HomeState(
      data.get(#loadingState, or: $value.loadingState),
      data.get(#configuration, or: $value.configuration),
      data.get(#snapshot, or: $value.snapshot),
      data.get(#favorites, or: $value.favorites),
      data.get(#error, or: $value.error));

  @override
  HomeStateCopyWith<$R2, HomeState, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t) =>
      _HomeStateCopyWithImpl($value, $cast, t);
}
