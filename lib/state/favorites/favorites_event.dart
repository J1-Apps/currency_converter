import "package:currency_converter/data/model/currency.dart";
import "package:currency_converter/state/favorites/favorites_state.dart";

sealed class FavoritesEvent {
  const FavoritesEvent();
}

final class FavoritesLoadEvent extends FavoritesEvent {
  const FavoritesLoadEvent();
}

final class FavoritesToggleEvent extends FavoritesEvent {
  final CurrencyCode code;
  final bool isFavorite;

  const FavoritesToggleEvent(this.code, this.isFavorite);
}

// Stream update events.

final class FavoritesSuccessDataEvent extends FavoritesEvent {
  final FavoritesState next;

  const FavoritesSuccessDataEvent(this.next);
}

final class FavoritesErrorDataEvent extends FavoritesEvent {
  final FavoritesErrorCode error;

  const FavoritesErrorDataEvent(this.error);
}
