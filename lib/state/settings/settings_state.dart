import "package:currency_converter/model/configuration.dart";
import "package:currency_converter/model/cc_error.dart";
import "package:dart_mappable/dart_mappable.dart";

part "settings_state.mapper.dart";

@MappableClass()
class SettingsState with SettingsStateMappable {
  final List<Configuration> configurations;
  final String language;
  final CcError? error;

  const SettingsState(
    this.configurations,
    this.language,
    this.error,
  );
}
