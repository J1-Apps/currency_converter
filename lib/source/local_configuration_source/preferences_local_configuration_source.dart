import "package:currency_converter/model/cc_error.dart";
import "package:currency_converter/model/configuration.dart";
import "package:currency_converter/source/local_configuration_source/local_configuration_source.dart";
import "package:currency_converter/source/util/preferences_source.dart";

const _currentConfigurationKey = "ccCurrentConfiguration";
const _configurationsKey = "ccConfigurations";

class PreferencesLocalConfigurationSource extends PreferencesSource implements LocalConfigurationSource {
  PreferencesLocalConfigurationSource({super.preferences});

  @override
  Future<Configuration?> getCurrentConfiguration() async {
    return getItem(
      _currentConfigurationKey,
      ErrorCode.source_appStorage_readCurrentConfigurationError,
      (preferences) async {
        final configurationJson = await preferences.getString(_currentConfigurationKey);

        if (configurationJson == null || configurationJson.isEmpty) {
          return null;
        }

        return Configuration.fromJson(configurationJson);
      },
    );
  }

  @override
  Future<void> updateCurrentConfiguration(Configuration configuration) async {
    await saveItem(_configurationsKey, ErrorCode.source_appStorage_writeCurrentConfigurationError, (preferences) async {
      await preferences.setString(_currentConfigurationKey, configuration.toJson());
    });
  }

  @override
  Future<List<Configuration>> getConfigurations() {
    return getItem(_configurationsKey, ErrorCode.source_appStorage_readConfigurationError, (preferences) async {
      final configurationsJson = await preferences.getStringList(_currentConfigurationKey);

      if (configurationsJson == null || configurationsJson.isEmpty) {
        return [];
      }

      return configurationsJson.map((json) => Configuration.fromJson(json)).toList();
    });
  }

  @override
  Future<void> updateConfigurations(List<Configuration> configurations) async {
    await saveItem(_configurationsKey, ErrorCode.source_appStorage_writeConfigurationError, (preferences) async {
      await preferences.setStringList(
        _configurationsKey,
        configurations.map((config) => config.toJson()).toList(),
      );
    });
  }
}
