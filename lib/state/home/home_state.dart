import "package:currency_converter/model/configuration.dart";
import "package:currency_converter/model/currency.dart";
import "package:currency_converter/model/exchange_rate.dart";
import "package:currency_converter/util/errors/cc_error.dart";
import "package:dart_mappable/dart_mappable.dart";

part "home_state.mapper.dart";

@MappableClass()
class HomeState with HomeStateMappable {
  final HomeLoadingState loadingState;
  final Configuration? configuration;
  final ExchangeRateSnapshot? snapshot;
  final List<CurrencyCode>? favorites;
  final ErrorCode? error;

  const HomeState(
    this.loadingState,
    this.configuration,
    this.snapshot,
    this.favorites,
    this.error,
  );
}

@MappableEnum()
enum HomeLoadingState {
  loadingConfig,
  loadingSnapshot,
  snapshotError,
  loaded,
}
