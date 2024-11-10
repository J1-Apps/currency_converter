// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'home_state.dart';

class HomeStateMapper extends ClassMapperBase<HomeState> {
  HomeStateMapper._();

  static HomeStateMapper? _instance;
  static HomeStateMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = HomeStateMapper._());
      HomeRefreshMapper.ensureInitialized();
      HomeBaseCurrencyMapper.ensureInitialized();
      HomeConvertedCurrencyMapper.ensureInitialized();
      CcErrorMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'HomeState';

  static HomeRefresh? _$refresh(HomeState v) => v.refresh;
  static const Field<HomeState, HomeRefresh> _f$refresh =
      Field('refresh', _$refresh);
  static HomeBaseCurrency? _$baseCurrency(HomeState v) => v.baseCurrency;
  static const Field<HomeState, HomeBaseCurrency> _f$baseCurrency =
      Field('baseCurrency', _$baseCurrency);
  static List<HomeConvertedCurrency>? _$currencies(HomeState v) => v.currencies;
  static const Field<HomeState, List<HomeConvertedCurrency>> _f$currencies =
      Field('currencies', _$currencies);
  static CcError? _$error(HomeState v) => v.error;
  static const Field<HomeState, CcError> _f$error =
      Field('error', _$error, opt: true);
  static LoadingState _$status(HomeState v) => v.status;
  static const Field<HomeState, LoadingState> _f$status =
      Field('status', _$status, mode: FieldMode.member);

  @override
  final MappableFields<HomeState> fields = const {
    #refresh: _f$refresh,
    #baseCurrency: _f$baseCurrency,
    #currencies: _f$currencies,
    #error: _f$error,
    #status: _f$status,
  };

  static HomeState _instantiate(DecodingData data) {
    return HomeState.loaded(
        refresh: data.dec(_f$refresh),
        baseCurrency: data.dec(_f$baseCurrency),
        currencies: data.dec(_f$currencies),
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
    return HomeStateMapper.ensureInitialized()
        .encodeJson<HomeState>(this as HomeState);
  }

  Map<String, dynamic> toMap() {
    return HomeStateMapper.ensureInitialized()
        .encodeMap<HomeState>(this as HomeState);
  }

  HomeStateCopyWith<HomeState, HomeState, HomeState> get copyWith =>
      _HomeStateCopyWithImpl(this as HomeState, $identity, $identity);
  @override
  String toString() {
    return HomeStateMapper.ensureInitialized()
        .stringifyValue(this as HomeState);
  }

  @override
  bool operator ==(Object other) {
    return HomeStateMapper.ensureInitialized()
        .equalsValue(this as HomeState, other);
  }

  @override
  int get hashCode {
    return HomeStateMapper.ensureInitialized().hashValue(this as HomeState);
  }
}

extension HomeStateValueCopy<$R, $Out> on ObjectCopyWith<$R, HomeState, $Out> {
  HomeStateCopyWith<$R, HomeState, $Out> get $asHomeState =>
      $base.as((v, t, t2) => _HomeStateCopyWithImpl(v, t, t2));
}

abstract class HomeStateCopyWith<$R, $In extends HomeState, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  HomeRefreshCopyWith<$R, HomeRefresh, HomeRefresh>? get refresh;
  HomeBaseCurrencyCopyWith<$R, HomeBaseCurrency, HomeBaseCurrency>?
      get baseCurrency;
  ListCopyWith<
      $R,
      HomeConvertedCurrency,
      HomeConvertedCurrencyCopyWith<$R, HomeConvertedCurrency,
          HomeConvertedCurrency>>? get currencies;
  CcErrorCopyWith<$R, CcError, CcError>? get error;
  $R call(
      {HomeRefresh? refresh,
      HomeBaseCurrency? baseCurrency,
      List<HomeConvertedCurrency>? currencies,
      CcError? error});
  HomeStateCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _HomeStateCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, HomeState, $Out>
    implements HomeStateCopyWith<$R, HomeState, $Out> {
  _HomeStateCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<HomeState> $mapper =
      HomeStateMapper.ensureInitialized();
  @override
  HomeRefreshCopyWith<$R, HomeRefresh, HomeRefresh>? get refresh =>
      $value.refresh?.copyWith.$chain((v) => call(refresh: v));
  @override
  HomeBaseCurrencyCopyWith<$R, HomeBaseCurrency, HomeBaseCurrency>?
      get baseCurrency =>
          $value.baseCurrency?.copyWith.$chain((v) => call(baseCurrency: v));
  @override
  ListCopyWith<
      $R,
      HomeConvertedCurrency,
      HomeConvertedCurrencyCopyWith<$R, HomeConvertedCurrency,
          HomeConvertedCurrency>>? get currencies => $value.currencies != null
      ? ListCopyWith($value.currencies!, (v, t) => v.copyWith.$chain(t),
          (v) => call(currencies: v))
      : null;
  @override
  CcErrorCopyWith<$R, CcError, CcError>? get error =>
      $value.error?.copyWith.$chain((v) => call(error: v));
  @override
  $R call(
          {Object? refresh = $none,
          Object? baseCurrency = $none,
          Object? currencies = $none,
          Object? error = $none}) =>
      $apply(FieldCopyWithData({
        if (refresh != $none) #refresh: refresh,
        if (baseCurrency != $none) #baseCurrency: baseCurrency,
        if (currencies != $none) #currencies: currencies,
        if (error != $none) #error: error
      }));
  @override
  HomeState $make(CopyWithData data) => HomeState.loaded(
      refresh: data.get(#refresh, or: $value.refresh),
      baseCurrency: data.get(#baseCurrency, or: $value.baseCurrency),
      currencies: data.get(#currencies, or: $value.currencies),
      error: data.get(#error, or: $value.error));

  @override
  HomeStateCopyWith<$R2, HomeState, $Out2> $chain<$R2, $Out2>(
          Then<$Out2, $R2> t) =>
      _HomeStateCopyWithImpl($value, $cast, t);
}

class HomeRefreshMapper extends ClassMapperBase<HomeRefresh> {
  HomeRefreshMapper._();

  static HomeRefreshMapper? _instance;
  static HomeRefreshMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = HomeRefreshMapper._());
    }
    return _instance!;
  }

  @override
  final String id = 'HomeRefresh';

  static bool _$isRefreshing(HomeRefresh v) => v.isRefreshing;
  static const Field<HomeRefresh, bool> _f$isRefreshing =
      Field('isRefreshing', _$isRefreshing);
  static DateTime? _$refreshed(HomeRefresh v) => v.refreshed;
  static const Field<HomeRefresh, DateTime> _f$refreshed =
      Field('refreshed', _$refreshed);

  @override
  final MappableFields<HomeRefresh> fields = const {
    #isRefreshing: _f$isRefreshing,
    #refreshed: _f$refreshed,
  };

  static HomeRefresh _instantiate(DecodingData data) {
    return HomeRefresh(
        isRefreshing: data.dec(_f$isRefreshing),
        refreshed: data.dec(_f$refreshed));
  }

  @override
  final Function instantiate = _instantiate;

  static HomeRefresh fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<HomeRefresh>(map);
  }

  static HomeRefresh fromJson(String json) {
    return ensureInitialized().decodeJson<HomeRefresh>(json);
  }
}

mixin HomeRefreshMappable {
  String toJson() {
    return HomeRefreshMapper.ensureInitialized()
        .encodeJson<HomeRefresh>(this as HomeRefresh);
  }

  Map<String, dynamic> toMap() {
    return HomeRefreshMapper.ensureInitialized()
        .encodeMap<HomeRefresh>(this as HomeRefresh);
  }

  HomeRefreshCopyWith<HomeRefresh, HomeRefresh, HomeRefresh> get copyWith =>
      _HomeRefreshCopyWithImpl(this as HomeRefresh, $identity, $identity);
  @override
  String toString() {
    return HomeRefreshMapper.ensureInitialized()
        .stringifyValue(this as HomeRefresh);
  }

  @override
  bool operator ==(Object other) {
    return HomeRefreshMapper.ensureInitialized()
        .equalsValue(this as HomeRefresh, other);
  }

  @override
  int get hashCode {
    return HomeRefreshMapper.ensureInitialized().hashValue(this as HomeRefresh);
  }
}

extension HomeRefreshValueCopy<$R, $Out>
    on ObjectCopyWith<$R, HomeRefresh, $Out> {
  HomeRefreshCopyWith<$R, HomeRefresh, $Out> get $asHomeRefresh =>
      $base.as((v, t, t2) => _HomeRefreshCopyWithImpl(v, t, t2));
}

abstract class HomeRefreshCopyWith<$R, $In extends HomeRefresh, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  $R call({bool? isRefreshing, DateTime? refreshed});
  HomeRefreshCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _HomeRefreshCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, HomeRefresh, $Out>
    implements HomeRefreshCopyWith<$R, HomeRefresh, $Out> {
  _HomeRefreshCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<HomeRefresh> $mapper =
      HomeRefreshMapper.ensureInitialized();
  @override
  $R call({bool? isRefreshing, Object? refreshed = $none}) =>
      $apply(FieldCopyWithData({
        if (isRefreshing != null) #isRefreshing: isRefreshing,
        if (refreshed != $none) #refreshed: refreshed
      }));
  @override
  HomeRefresh $make(CopyWithData data) => HomeRefresh(
      isRefreshing: data.get(#isRefreshing, or: $value.isRefreshing),
      refreshed: data.get(#refreshed, or: $value.refreshed));

  @override
  HomeRefreshCopyWith<$R2, HomeRefresh, $Out2> $chain<$R2, $Out2>(
          Then<$Out2, $R2> t) =>
      _HomeRefreshCopyWithImpl($value, $cast, t);
}

class HomeBaseCurrencyMapper extends ClassMapperBase<HomeBaseCurrency> {
  HomeBaseCurrencyMapper._();

  static HomeBaseCurrencyMapper? _instance;
  static HomeBaseCurrencyMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = HomeBaseCurrencyMapper._());
      CurrencyCodeMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'HomeBaseCurrency';

  static CurrencyCode _$code(HomeBaseCurrency v) => v.code;
  static const Field<HomeBaseCurrency, CurrencyCode> _f$code =
      Field('code', _$code);
  static double _$value(HomeBaseCurrency v) => v.value;
  static const Field<HomeBaseCurrency, double> _f$value =
      Field('value', _$value);

  @override
  final MappableFields<HomeBaseCurrency> fields = const {
    #code: _f$code,
    #value: _f$value,
  };

  static HomeBaseCurrency _instantiate(DecodingData data) {
    return HomeBaseCurrency(code: data.dec(_f$code), value: data.dec(_f$value));
  }

  @override
  final Function instantiate = _instantiate;

  static HomeBaseCurrency fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<HomeBaseCurrency>(map);
  }

  static HomeBaseCurrency fromJson(String json) {
    return ensureInitialized().decodeJson<HomeBaseCurrency>(json);
  }
}

mixin HomeBaseCurrencyMappable {
  String toJson() {
    return HomeBaseCurrencyMapper.ensureInitialized()
        .encodeJson<HomeBaseCurrency>(this as HomeBaseCurrency);
  }

  Map<String, dynamic> toMap() {
    return HomeBaseCurrencyMapper.ensureInitialized()
        .encodeMap<HomeBaseCurrency>(this as HomeBaseCurrency);
  }

  HomeBaseCurrencyCopyWith<HomeBaseCurrency, HomeBaseCurrency, HomeBaseCurrency>
      get copyWith => _HomeBaseCurrencyCopyWithImpl(
          this as HomeBaseCurrency, $identity, $identity);
  @override
  String toString() {
    return HomeBaseCurrencyMapper.ensureInitialized()
        .stringifyValue(this as HomeBaseCurrency);
  }

  @override
  bool operator ==(Object other) {
    return HomeBaseCurrencyMapper.ensureInitialized()
        .equalsValue(this as HomeBaseCurrency, other);
  }

  @override
  int get hashCode {
    return HomeBaseCurrencyMapper.ensureInitialized()
        .hashValue(this as HomeBaseCurrency);
  }
}

extension HomeBaseCurrencyValueCopy<$R, $Out>
    on ObjectCopyWith<$R, HomeBaseCurrency, $Out> {
  HomeBaseCurrencyCopyWith<$R, HomeBaseCurrency, $Out>
      get $asHomeBaseCurrency =>
          $base.as((v, t, t2) => _HomeBaseCurrencyCopyWithImpl(v, t, t2));
}

abstract class HomeBaseCurrencyCopyWith<$R, $In extends HomeBaseCurrency, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  $R call({CurrencyCode? code, double? value});
  HomeBaseCurrencyCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
      Then<$Out2, $R2> t);
}

class _HomeBaseCurrencyCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, HomeBaseCurrency, $Out>
    implements HomeBaseCurrencyCopyWith<$R, HomeBaseCurrency, $Out> {
  _HomeBaseCurrencyCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<HomeBaseCurrency> $mapper =
      HomeBaseCurrencyMapper.ensureInitialized();
  @override
  $R call({CurrencyCode? code, double? value}) => $apply(FieldCopyWithData(
      {if (code != null) #code: code, if (value != null) #value: value}));
  @override
  HomeBaseCurrency $make(CopyWithData data) => HomeBaseCurrency(
      code: data.get(#code, or: $value.code),
      value: data.get(#value, or: $value.value));

  @override
  HomeBaseCurrencyCopyWith<$R2, HomeBaseCurrency, $Out2> $chain<$R2, $Out2>(
          Then<$Out2, $R2> t) =>
      _HomeBaseCurrencyCopyWithImpl($value, $cast, t);
}

class HomeConvertedCurrencyMapper
    extends ClassMapperBase<HomeConvertedCurrency> {
  HomeConvertedCurrencyMapper._();

  static HomeConvertedCurrencyMapper? _instance;
  static HomeConvertedCurrencyMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = HomeConvertedCurrencyMapper._());
      CurrencyCodeMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'HomeConvertedCurrency';

  static CurrencyCode _$code(HomeConvertedCurrency v) => v.code;
  static const Field<HomeConvertedCurrency, CurrencyCode> _f$code =
      Field('code', _$code);
  static double _$value(HomeConvertedCurrency v) => v.value;
  static const Field<HomeConvertedCurrency, double> _f$value =
      Field('value', _$value);
  static bool _$isFavorite(HomeConvertedCurrency v) => v.isFavorite;
  static const Field<HomeConvertedCurrency, bool> _f$isFavorite =
      Field('isFavorite', _$isFavorite);

  @override
  final MappableFields<HomeConvertedCurrency> fields = const {
    #code: _f$code,
    #value: _f$value,
    #isFavorite: _f$isFavorite,
  };

  static HomeConvertedCurrency _instantiate(DecodingData data) {
    return HomeConvertedCurrency(
        code: data.dec(_f$code),
        value: data.dec(_f$value),
        isFavorite: data.dec(_f$isFavorite));
  }

  @override
  final Function instantiate = _instantiate;

  static HomeConvertedCurrency fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<HomeConvertedCurrency>(map);
  }

  static HomeConvertedCurrency fromJson(String json) {
    return ensureInitialized().decodeJson<HomeConvertedCurrency>(json);
  }
}

mixin HomeConvertedCurrencyMappable {
  String toJson() {
    return HomeConvertedCurrencyMapper.ensureInitialized()
        .encodeJson<HomeConvertedCurrency>(this as HomeConvertedCurrency);
  }

  Map<String, dynamic> toMap() {
    return HomeConvertedCurrencyMapper.ensureInitialized()
        .encodeMap<HomeConvertedCurrency>(this as HomeConvertedCurrency);
  }

  HomeConvertedCurrencyCopyWith<HomeConvertedCurrency, HomeConvertedCurrency,
          HomeConvertedCurrency>
      get copyWith => _HomeConvertedCurrencyCopyWithImpl(
          this as HomeConvertedCurrency, $identity, $identity);
  @override
  String toString() {
    return HomeConvertedCurrencyMapper.ensureInitialized()
        .stringifyValue(this as HomeConvertedCurrency);
  }

  @override
  bool operator ==(Object other) {
    return HomeConvertedCurrencyMapper.ensureInitialized()
        .equalsValue(this as HomeConvertedCurrency, other);
  }

  @override
  int get hashCode {
    return HomeConvertedCurrencyMapper.ensureInitialized()
        .hashValue(this as HomeConvertedCurrency);
  }
}

extension HomeConvertedCurrencyValueCopy<$R, $Out>
    on ObjectCopyWith<$R, HomeConvertedCurrency, $Out> {
  HomeConvertedCurrencyCopyWith<$R, HomeConvertedCurrency, $Out>
      get $asHomeConvertedCurrency =>
          $base.as((v, t, t2) => _HomeConvertedCurrencyCopyWithImpl(v, t, t2));
}

abstract class HomeConvertedCurrencyCopyWith<
    $R,
    $In extends HomeConvertedCurrency,
    $Out> implements ClassCopyWith<$R, $In, $Out> {
  $R call({CurrencyCode? code, double? value, bool? isFavorite});
  HomeConvertedCurrencyCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
      Then<$Out2, $R2> t);
}

class _HomeConvertedCurrencyCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, HomeConvertedCurrency, $Out>
    implements HomeConvertedCurrencyCopyWith<$R, HomeConvertedCurrency, $Out> {
  _HomeConvertedCurrencyCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<HomeConvertedCurrency> $mapper =
      HomeConvertedCurrencyMapper.ensureInitialized();
  @override
  $R call({CurrencyCode? code, double? value, bool? isFavorite}) =>
      $apply(FieldCopyWithData({
        if (code != null) #code: code,
        if (value != null) #value: value,
        if (isFavorite != null) #isFavorite: isFavorite
      }));
  @override
  HomeConvertedCurrency $make(CopyWithData data) => HomeConvertedCurrency(
      code: data.get(#code, or: $value.code),
      value: data.get(#value, or: $value.value),
      isFavorite: data.get(#isFavorite, or: $value.isFavorite));

  @override
  HomeConvertedCurrencyCopyWith<$R2, HomeConvertedCurrency, $Out2>
      $chain<$R2, $Out2>(Then<$Out2, $R2> t) =>
          _HomeConvertedCurrencyCopyWithImpl($value, $cast, t);
}
