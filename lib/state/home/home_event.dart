import "package:currency_converter/data/model/cc_error.dart";
import "package:currency_converter/data/model/currency.dart";
import "package:currency_converter/state/home/home_state.dart";

sealed class HomeEvent {
  const HomeEvent();
}

final class HomeLoadEvent extends HomeEvent {
  const HomeLoadEvent();
}

final class HomeRefreshEvent extends HomeEvent {
  const HomeRefreshEvent();
}

final class HomeUpdateBaseValueEvent extends HomeEvent {
  final CurrencyCode code;
  final double value;

  const HomeUpdateBaseValueEvent(this.code, this.value);
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

final class HomeToggleFavoriteEvent extends HomeEvent {
  final CurrencyCode code;
  final bool isFavorite;

  const HomeToggleFavoriteEvent(this.code, this.isFavorite);
}

final class HomeToggleExpandedEvent extends HomeEvent {
  final int index;

  const HomeToggleExpandedEvent(this.index);
}

// Repository Update Events

final class HomeSuccessDataEvent extends HomeEvent {
  final HomeState next;

  const HomeSuccessDataEvent(this.next);
}

final class HomeErrorDataEvent extends HomeEvent {
  final CcError error;

  const HomeErrorDataEvent(this.error);
}
