import "package:currency_converter/model/cc_error.dart";
import "package:currency_converter/model/configuration.dart";
import "package:currency_converter/source/local_configuration_source/local_configuration_source.dart";
import "package:currency_converter/source/util/memory_source.dart";

class MemoryLocalConfigurationSource extends MemorySource implements LocalConfigurationSource {
  Configuration? _configuration;
  List<Configuration> _configurations = [];

  MemoryLocalConfigurationSource({super.initialShouldThrow, super.initialMsDelay});

  @override
  Future<Configuration?> getCurrentConfiguration() async {
    return wrapRequest(
      Future.value(_configuration),
      ErrorCode.source_appStorage_readCurrentConfigurationError,
    );
  }

  @override
  Future<void> updateCurrentConfiguration(Configuration configuration) async {
    await wrapRequest(
      Future(() => _configuration = configuration),
      ErrorCode.source_appStorage_writeCurrentConfigurationError,
    );
  }

  @override
  Future<List<Configuration>> getConfigurations() {
    return wrapRequest(
      Future.value(_configurations),
      ErrorCode.source_appStorage_readConfigurationError,
    );
  }

  @override
  Future<void> updateConfigurations(List<Configuration> configurations) async {
    await wrapRequest(
      Future(() => _configurations = configurations),
      ErrorCode.source_appStorage_writeConfigurationError,
    );
  }
}
