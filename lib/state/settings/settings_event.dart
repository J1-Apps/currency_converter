import "package:currency_converter/data/model/configuration.dart";

sealed class SettingsEvent {
  const SettingsEvent();
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

final class SettingsSetLanguageEvent extends SettingsEvent {
  final String language;

  const SettingsSetLanguageEvent(this.language);
}
