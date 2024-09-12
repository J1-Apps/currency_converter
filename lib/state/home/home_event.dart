import "package:currency_converter/model/currency.dart";

sealed class HomeEvent {
  const HomeEvent();
}

final class HomeLoadConfigurationEvent extends HomeEvent {
  const HomeLoadConfigurationEvent();
}

final class HomeLoadSnapshotEvent extends HomeEvent {
  const HomeLoadSnapshotEvent();
}

final class HomeUpdateBaseValueEvent extends HomeEvent {
  final double value;

  const HomeUpdateBaseValueEvent(this.value);
}

final class HomeUpdateBaseCurrencyEvent extends HomeEvent {
  final CurrencyCode code;

  const HomeUpdateBaseCurrencyEvent(this.code);
}

final class HomeToggleCurrencyEvent extends HomeEvent {
  final CurrencyCode code;

  const HomeToggleCurrencyEvent(this.code);
}
