// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'favorites_state.dart';

class FavoritesErrorCodeMapper extends EnumMapper<FavoritesErrorCode> {
  FavoritesErrorCodeMapper._();

  static FavoritesErrorCodeMapper? _instance;
  static FavoritesErrorCodeMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = FavoritesErrorCodeMapper._());
    }
    return _instance!;
  }

  static FavoritesErrorCode fromValue(dynamic value) {
    ensureInitialized();
    return MapperContainer.globals.fromValue(value);
  }

  @override
  FavoritesErrorCode decode(dynamic value) {
    switch (value) {
      case 'loadFavorites':
        return FavoritesErrorCode.loadFavorites;
      case 'saveFavorite':
        return FavoritesErrorCode.saveFavorite;
      case 'loadCurrencies':
        return FavoritesErrorCode.loadCurrencies;
      default:
        throw MapperException.unknownEnumValue(value);
    }
  }

  @override
  dynamic encode(FavoritesErrorCode self) {
    switch (self) {
      case FavoritesErrorCode.loadFavorites:
        return 'loadFavorites';
      case FavoritesErrorCode.saveFavorite:
        return 'saveFavorite';
      case FavoritesErrorCode.loadCurrencies:
        return 'loadCurrencies';
    }
  }
}

extension FavoritesErrorCodeMapperExtension on FavoritesErrorCode {
  String toValue() {
    FavoritesErrorCodeMapper.ensureInitialized();
    return MapperContainer.globals.toValue<FavoritesErrorCode>(this) as String;
  }
}

class FavoritesStateMapper extends ClassMapperBase<FavoritesState> {
  FavoritesStateMapper._();

  static FavoritesStateMapper? _instance;
  static FavoritesStateMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = FavoritesStateMapper._());
      CurrencyCodeMapper.ensureInitialized();
      FavoritesErrorCodeMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'FavoritesState';

  static List<CurrencyCode>? _$favorites(FavoritesState v) => v.favorites;
  static const Field<FavoritesState, List<CurrencyCode>> _f$favorites = Field('favorites', _$favorites);
  static List<CurrencyCode>? _$nonFavorites(FavoritesState v) => v.nonFavorites;
  static const Field<FavoritesState, List<CurrencyCode>> _f$nonFavorites = Field('nonFavorites', _$nonFavorites);
  static FavoritesErrorCode? _$error(FavoritesState v) => v.error;
  static const Field<FavoritesState, FavoritesErrorCode> _f$error = Field('error', _$error, opt: true);
  static LoadingState _$status(FavoritesState v) => v.status;
  static const Field<FavoritesState, LoadingState> _f$status = Field('status', _$status, mode: FieldMode.member);

  @override
  final MappableFields<FavoritesState> fields = const {
    #favorites: _f$favorites,
    #nonFavorites: _f$nonFavorites,
    #error: _f$error,
    #status: _f$status,
  };

  static FavoritesState _instantiate(DecodingData data) {
    return FavoritesState.loaded(
        favorites: data.dec(_f$favorites), nonFavorites: data.dec(_f$nonFavorites), error: data.dec(_f$error));
  }

  @override
  final Function instantiate = _instantiate;

  static FavoritesState fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<FavoritesState>(map);
  }

  static FavoritesState fromJson(String json) {
    return ensureInitialized().decodeJson<FavoritesState>(json);
  }
}

mixin FavoritesStateMappable {
  String toJson() {
    return FavoritesStateMapper.ensureInitialized().encodeJson<FavoritesState>(this as FavoritesState);
  }

  Map<String, dynamic> toMap() {
    return FavoritesStateMapper.ensureInitialized().encodeMap<FavoritesState>(this as FavoritesState);
  }

  FavoritesStateCopyWith<FavoritesState, FavoritesState, FavoritesState> get copyWith =>
      _FavoritesStateCopyWithImpl(this as FavoritesState, $identity, $identity);
  @override
  String toString() {
    return FavoritesStateMapper.ensureInitialized().stringifyValue(this as FavoritesState);
  }

  @override
  bool operator ==(Object other) {
    return FavoritesStateMapper.ensureInitialized().equalsValue(this as FavoritesState, other);
  }

  @override
  int get hashCode {
    return FavoritesStateMapper.ensureInitialized().hashValue(this as FavoritesState);
  }
}

extension FavoritesStateValueCopy<$R, $Out> on ObjectCopyWith<$R, FavoritesState, $Out> {
  FavoritesStateCopyWith<$R, FavoritesState, $Out> get $asFavoritesState =>
      $base.as((v, t, t2) => _FavoritesStateCopyWithImpl(v, t, t2));
}

abstract class FavoritesStateCopyWith<$R, $In extends FavoritesState, $Out> implements ClassCopyWith<$R, $In, $Out> {
  ListCopyWith<$R, CurrencyCode, ObjectCopyWith<$R, CurrencyCode, CurrencyCode>>? get favorites;
  ListCopyWith<$R, CurrencyCode, ObjectCopyWith<$R, CurrencyCode, CurrencyCode>>? get nonFavorites;
  $R call({List<CurrencyCode>? favorites, List<CurrencyCode>? nonFavorites, FavoritesErrorCode? error});
  FavoritesStateCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _FavoritesStateCopyWithImpl<$R, $Out> extends ClassCopyWithBase<$R, FavoritesState, $Out>
    implements FavoritesStateCopyWith<$R, FavoritesState, $Out> {
  _FavoritesStateCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<FavoritesState> $mapper = FavoritesStateMapper.ensureInitialized();
  @override
  ListCopyWith<$R, CurrencyCode, ObjectCopyWith<$R, CurrencyCode, CurrencyCode>>? get favorites =>
      $value.favorites != null
          ? ListCopyWith($value.favorites!, (v, t) => ObjectCopyWith(v, $identity, t), (v) => call(favorites: v))
          : null;
  @override
  ListCopyWith<$R, CurrencyCode, ObjectCopyWith<$R, CurrencyCode, CurrencyCode>>? get nonFavorites =>
      $value.nonFavorites != null
          ? ListCopyWith($value.nonFavorites!, (v, t) => ObjectCopyWith(v, $identity, t), (v) => call(nonFavorites: v))
          : null;
  @override
  $R call({Object? favorites = $none, Object? nonFavorites = $none, Object? error = $none}) =>
      $apply(FieldCopyWithData({
        if (favorites != $none) #favorites: favorites,
        if (nonFavorites != $none) #nonFavorites: nonFavorites,
        if (error != $none) #error: error
      }));
  @override
  FavoritesState $make(CopyWithData data) => FavoritesState.loaded(
      favorites: data.get(#favorites, or: $value.favorites),
      nonFavorites: data.get(#nonFavorites, or: $value.nonFavorites),
      error: data.get(#error, or: $value.error));

  @override
  FavoritesStateCopyWith<$R2, FavoritesState, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t) =>
      _FavoritesStateCopyWithImpl($value, $cast, t);
}
