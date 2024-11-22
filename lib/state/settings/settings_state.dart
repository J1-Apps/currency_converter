import "package:currency_converter/data/model/configuration.dart";
import "package:currency_converter/data/model/cc_error.dart";
import "package:dart_mappable/dart_mappable.dart";

part "settings_state.mapper.dart";

// TODO: Test this in #25.
// coverage:ignore-file
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
