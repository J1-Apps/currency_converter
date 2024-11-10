import "package:currency_converter/data/model/configuration.dart";

abstract class LocalConfigurationSource {
  Future<Configuration?> getCurrentConfiguration();
  Future<void> updateCurrentConfiguration(Configuration configuration);

  Future<List<Configuration>> getConfigurations();
  Future<void> updateConfigurations(List<Configuration> configurations);
}
