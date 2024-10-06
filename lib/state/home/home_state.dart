import "package:currency_converter/model/configuration.dart";
import "package:currency_converter/model/exchange_rate.dart";
import "package:currency_converter/util/errors/cc_error.dart";
import "package:dart_mappable/dart_mappable.dart";

part "home_state.mapper.dart";

@MappableClass()
class HomeState with HomeStateMappable {
  final HomeStatus status;
  final Configuration? configuration;
  final ExchangeRateSnapshot? snapshot;
  final bool isRefreshing;
  final CcError? error;

  const HomeState({
    required this.status,
    required this.configuration,
    required this.snapshot,
    this.isRefreshing = false,
    this.error,
  });
}

@MappableEnum()
enum HomeStatus {
  initial,
  loading,
  error,
  loaded,
}
