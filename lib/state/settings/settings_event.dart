import "package:currency_converter/state/settings/settings_state.dart";

sealed class SettingsEvent {
  const SettingsEvent();
}

final class SettingsLoadEvent extends SettingsEvent {
  const SettingsLoadEvent();
}

final class SettingsUpdateLanguageEvent extends SettingsEvent {
  final String language;

  const SettingsUpdateLanguageEvent(this.language);
}

// Stream update events.

final class SettingsSuccessDataEvent extends SettingsEvent {
  final SettingsState next;

  const SettingsSuccessDataEvent(this.next);
}

final class SettingsErrorDataEvent extends SettingsEvent {
  final SettingsErrorCode error;

  const SettingsErrorDataEvent(this.error);
}
