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

final class SettingsUpdateLanuageEvent extends SettingsEvent {
  final String languageCode;

  const SettingsUpdateLanuageEvent(this.languageCode);
}

// Stream update events.

final class SettingsSetFavoritesEvent extends SettingsEvent {
  final List<CurrencyCode> favorites;

  const SettingsSetFavoritesEvent(this.favorites);
}

final class SettingsSetConfigurationsEvent extends SettingsEvent {
  final List<Configuration> configurations;

  const SettingsSetConfigurationsEvent(this.configurations);
}

final class SettingsSetLanguageEvent extends SettingsEvent {
  final String language;

  const SettingsSetLanguageEvent(this.language);
}
