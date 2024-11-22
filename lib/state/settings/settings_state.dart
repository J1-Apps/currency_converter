import "package:currency_converter/state/loading_state.dart";
import "package:dart_mappable/dart_mappable.dart";

part "settings_state.mapper.dart";

@MappableClass()
class SettingsState with SettingsStateMappable {
  final LoadingState status;
  final String? language;
  final SettingsErrorCode? error;

  const SettingsState(
    this.status,
    this.language,
    this.error,
  );

  const SettingsState.loaded({
    required this.language,
    this.error,
  }) : status = LoadingState.loaded;

  const SettingsState.initial()
      : status = LoadingState.initial,
        language = null,
        error = null;

  const SettingsState.loading()
      : status = LoadingState.loading,
        language = null,
        error = null;

  const SettingsState.error()
      : status = LoadingState.loading,
        language = null,
        error = null;
}

@MappableEnum()
enum SettingsErrorCode {
  loadLanguage,
  saveLanguage,
}
