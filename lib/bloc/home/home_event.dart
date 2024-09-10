import "package:currency_converter/model/currency.dart";

sealed class HomeEvent {
  const HomeEvent();
}

final class HomeLoadEvent extends HomeEvent {
  const HomeLoadEvent();
}

final class HomeRefreshEvent extends HomeEvent {
  const HomeRefreshEvent();
}

final class UpdateBaseValue extends HomeEvent {
  final double value;

  const UpdateBaseValue(this.value);
}

final class HomeToggleCurrencyEvent extends HomeEvent {
  final CurrencyCode code;

  const HomeToggleCurrencyEvent(this.code);
}
