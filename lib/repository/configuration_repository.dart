import "package:currency_converter/model/configuration.dart";
import "package:currency_converter/source/local_configuration_source/local_configuration_source.dart";
import "package:j1_environment/j1_environment.dart";

class ConfigurationRepository {
  final LocalConfigurationSource _localSource;

  ConfigurationRepository({LocalConfigurationSource? localSource})
      : _localSource = localSource ?? locator.get<LocalConfigurationSource>();

  Future<Configuration?> getCurrentConfiguration() {
    return _localSource.getCurrentConfiguration();
  }

  Future<void> updateCurrentConfiguration(Configuration configuration) async {
    await _localSource.updateCurrentConfiguration(configuration);
  }

  Future<List<Configuration>> getConfigurations() {
    return _localSource.getConfigurations();
  }

  Future<void> updateConfigurations(List<Configuration> configurations) async {
    await _localSource.updateConfigurations(configurations);
  }
}
