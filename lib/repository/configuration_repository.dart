import "package:currency_converter/model/cc_error.dart";
import "package:currency_converter/model/configuration.dart";
import "package:currency_converter/repository/app_storage_repository/defaults.dart";
import "package:currency_converter/repository/data_state.dart";
import "package:currency_converter/source/local_configuration_source/local_configuration_source.dart";
import "package:j1_environment/j1_environment.dart";

class ConfigurationRepository {
  final LocalConfigurationSource _localSource;
  final DataSubject<Configuration> _currentConfigurationSubject;
  final DataSubject<List<Configuration>> _configurationsSubject;

  Stream<DataState<Configuration>> get currentConfiguration => _currentConfigurationSubject.stream;
  Stream<DataState<List<Configuration>>> get configurations => _configurationsSubject.stream;

  ConfigurationRepository({
    LocalConfigurationSource? localSource,
    Configuration? initialCurrentConfiguration,
    List<Configuration>? initialConfigurations,
  })  : _localSource = localSource ?? locator.get<LocalConfigurationSource>(),
        _currentConfigurationSubject = DataSubject.initial(initialCurrentConfiguration),
        _configurationsSubject = DataSubject.initial(initialConfigurations);

  Future<void> loadCurrentConfiguration() async {
    try {
      _currentConfigurationSubject.addSuccess(await _localSource.getCurrentConfiguration() ?? defaultConfiguration);
    } catch (e) {
      _currentConfigurationSubject.addEmpty();
      _currentConfigurationSubject.addErrorEvent(CcError.fromObject(e));
    }
  }

  Future<void> updateCurrentConfiguration(Configuration configuration) async {
    _currentConfigurationSubject.addSuccess(configuration);

    try {
      await _localSource.updateCurrentConfiguration(configuration);
    } catch (e) {
      _currentConfigurationSubject.addErrorEvent(CcError.fromObject(e));
    }
  }

  Future<void> loadConfigurations() async {
    try {
      _configurationsSubject.addSuccess(await _localSource.getConfigurations());
    } catch (e) {
      _configurationsSubject.addEmpty();
      _configurationsSubject.addErrorEvent(CcError.fromObject(e));
    }
  }

  Future<void> updateConfigurations(List<Configuration> configurations) async {
    _configurationsSubject.addSuccess(configurations);

    try {
      await _localSource.updateConfigurations(configurations);
    } catch (e) {
      _configurationsSubject.addErrorEvent(CcError.fromObject(e));
    }
  }

  void dispose() {
    _currentConfigurationSubject.dispose();
    _configurationsSubject.dispose();
  }
}
