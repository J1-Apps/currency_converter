import "package:currency_converter/model/configuration.dart";
import "package:currency_converter/model/currency.dart";

sealed class SettingsEvent {
  const SettingsEvent();
}

final class SettingsToggleFavoriteEvent extends SettingsEvent {
  final CurrencyCode code;

  const SettingsToggleFavoriteEvent(this.code);
}

final class SettingsSaveConfigurationEvent extends SettingsEvent {
  final Configuration configuration;

  const SettingsSaveConfigurationEvent(this.configuration);
}

final class SettingsRemoveConfigurationEvent extends SettingsEvent {
  final Configuration configuration;

  const SettingsRemoveConfigurationEvent(this.configuration);
}

final class SettingsUpdateLanguageEvent extends SettingsEvent {
  final String language;

  const SettingsUpdateLanguageEvent(this.language);
}

// Stream update events.

final class SettingsSetFavoritesEvent extends SettingsEvent {
  final List<CurrencyCode> favorites;

  const SettingsSetFavoritesEvent(this.favorites);
}

final class SettingsSetLanguageEvent extends SettingsEvent {
  final String language;

  const SettingsSetLanguageEvent(this.language);
}
