import "package:currency_converter/model/currency.dart";

sealed class HomeEvent {
  const HomeEvent();
}

final class HomeLoadConfigurationEvent extends HomeEvent {
  const HomeLoadConfigurationEvent();
}

final class HomeRefreshSnapshotEvent extends HomeEvent {
  const HomeRefreshSnapshotEvent();
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

final class HomeUpdateCurrencyEvent extends HomeEvent {
  final int index;
  final CurrencyCode code;

  const HomeUpdateCurrencyEvent(this.index, this.code);
}
