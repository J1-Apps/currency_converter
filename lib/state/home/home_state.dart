import "package:currency_converter/data/model/currency.dart";
import "package:currency_converter/data/model/cc_error.dart";
import "package:currency_converter/state/loading_state.dart";
import "package:dart_mappable/dart_mappable.dart";

part "home_state.mapper.dart";

@MappableClass()
class HomeState with HomeStateMappable {
  final LoadingState status;
  final HomeRefresh? refresh;
  final HomeBaseCurrency? baseCurrency;
  final List<HomeConvertedCurrency>? currencies;
  final CcError? error;

  const HomeState.loaded({
    required this.refresh,
    required this.baseCurrency,
    required this.currencies,
    this.error,
  }) : status = LoadingState.loaded;

  const HomeState.initial()
      : status = LoadingState.initial,
        refresh = null,
        baseCurrency = null,
        currencies = null,
        error = null;

  const HomeState.loading()
      : status = LoadingState.loading,
        refresh = null,
        baseCurrency = null,
        currencies = null,
        error = null;

  const HomeState.error()
      : status = LoadingState.error,
        refresh = null,
        baseCurrency = null,
        currencies = null,
        error = null;
}

@MappableClass()
class HomeRefresh with HomeRefreshMappable {
  final bool isRefreshing;
  final DateTime refreshed;

  const HomeRefresh({
    required this.isRefreshing,
    required this.refreshed,
  });
}

@MappableClass()
class HomeBaseCurrency with HomeBaseCurrencyMappable {
  final CurrencyCode code;
  final double value;

  const HomeBaseCurrency({
    required this.code,
    required this.value,
  });
}

@MappableClass()
class HomeConvertedCurrency with HomeConvertedCurrencyMappable {
  final CurrencyCode code;
  final double value;
  final bool isFavorite;

  const HomeConvertedCurrency({
    required this.code,
    required this.value,
    required this.isFavorite,
  });
}
