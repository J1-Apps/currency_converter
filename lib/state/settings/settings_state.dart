import "package:currency_converter/model/configuration.dart";
import "package:currency_converter/model/currency.dart";
import "package:dart_mappable/dart_mappable.dart";

part "settings_state.mapper.dart";

@MappableClass()
class SettingsState with SettingsStateMappable {
  final List<CurrencyCode> favorites;
  final List<Configuration> configurations;
  final String language;

  const SettingsState(
    this.favorites,
    this.configurations,
    this.language,
  );
}
