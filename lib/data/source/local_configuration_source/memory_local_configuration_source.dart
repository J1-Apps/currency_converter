import "package:currency_converter/data/model/cc_error.dart";
import "package:currency_converter/data/model/configuration.dart";
import "package:currency_converter/data/source/local_configuration_source/local_configuration_source.dart";
import "package:currency_converter/data/source/util/memory_source.dart";

class MemoryLocalConfigurationSource extends MemorySource implements LocalConfigurationSource {
  Configuration? _configuration;
  List<Configuration> _configurations = [];

  MemoryLocalConfigurationSource({super.initialShouldThrow, super.initialMsDelay});

  @override
  Future<Configuration?> getCurrentConfiguration() async {
    return wrapRequest(
      Future.value(_configuration),
      ErrorCode.source_local_configuration_currentReadError,
    );
  }

  @override
  Future<void> updateCurrentConfiguration(Configuration configuration) async {
    await wrapRequest(
      Future(() => _configuration = configuration),
      ErrorCode.source_local_configuration_currentWriteError,
    );
  }

  @override
  Future<List<Configuration>> getConfigurations() {
    return wrapRequest(
      Future.value(_configurations),
      ErrorCode.source_local_configuration_readError,
    );
  }

  @override
  Future<void> updateConfigurations(List<Configuration> configurations) async {
    await wrapRequest(
      Future(() => _configurations = configurations),
      ErrorCode.source_local_configuration_writeError,
    );
  }
}
