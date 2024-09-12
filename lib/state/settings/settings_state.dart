import "package:currency_converter/model/configuration.dart";
import "package:currency_converter/model/currency.dart";
import "package:currency_converter/util/errors/cc_error.dart";
import "package:dart_mappable/dart_mappable.dart";

part "settings_state.mapper.dart";

@MappableClass()
class SettingsState with SettingsStateMappable {
  final Set<CurrencyCode> favorites;
  final Set<Configuration> configurations;
  final String language;
  final CcError? error;

  const SettingsState(
    this.favorites,
    this.configurations,
    this.language,
    this.error,
  );
}
