import "package:currency_converter/data/model/cc_error.dart";
import "package:currency_converter/data/model/configuration.dart";
import "package:currency_converter/data/model/currency.dart";
import "package:currency_converter/data/repository/defaults.dart";
import "package:currency_converter/data/repository/data_state.dart";
import "package:currency_converter/data/source/local_configuration_source/local_configuration_source.dart";
import "package:j1_environment/j1_environment.dart";

class ConfigurationRepository {
  final LocalConfigurationSource _localSource;
  final DataSubject<Configuration> _currentConfigurationSubject;
  final DataSubject<List<Configuration>> _configurationsSubject;

  bool _currentSeeded = false;

  Stream<DataState<Configuration>> get currentConfigurationStream => _currentConfigurationSubject.stream;
  Stream<DataState<List<Configuration>>> get configurationsStream => _configurationsSubject.stream;

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
      _currentSeeded = true;
    } catch (e) {
      _currentSeeded = false;
      _currentConfigurationSubject.addSuccess(defaultConfiguration);
      _currentConfigurationSubject.addErrorEvent(CcError.fromObject(e));
    }
  }

  Future<void> _updateCurrentConfiguration(Configuration configuration) async {
    _currentConfigurationSubject.addSuccess(configuration);

    if (!_currentSeeded) {
      _currentConfigurationSubject.addErrorEvent(const CcError(ErrorCode.repository_configuration_notSeededError));
      return;
    }

    try {
      await _localSource.updateCurrentConfiguration(configuration);
    } catch (e) {
      _currentConfigurationSubject.addErrorEvent(CcError.fromObject(e));
    }
  }

  Future<void> updateCurrentBaseValue(double baseValue) async {
    final config = _currentConfigurationSubject.dataValue ?? defaultConfiguration;

    await _updateCurrentConfiguration(config.copyWith(baseValue: baseValue));
  }

  Future<void> updateCurrentBaseCurrency(CurrencyCode baseCurrency, double value) async {
    final config = _currentConfigurationSubject.dataValue ?? defaultConfiguration;

    final newBaseIndex = config.currencies.indexOf(baseCurrency);
    final updatedCurrencies = [...config.currencies];

    if (newBaseIndex > -1) {
      updatedCurrencies[newBaseIndex] = config.baseCurrency;
    }

    final updatedConfig = config.copyWith(
      baseCurrency: baseCurrency,
      baseValue: value,
      currencies: updatedCurrencies,
    );

    await _updateCurrentConfiguration(updatedConfig);
  }

  Future<void> toggleCurrentCurrency(CurrencyCode currency) async {
    final config = _currentConfigurationSubject.dataValue ?? defaultConfiguration;

    final currencies = [...config.currencies];
    if (currencies.contains(currency)) {
      currencies.remove(currency);
    } else {
      currencies.add(currency);
    }

    await _updateCurrentConfiguration(config.copyWith(currencies: currencies));
  }

  Future<void> updateCurrentCurrency(CurrencyCode currency, int index) async {
    final config = _currentConfigurationSubject.dataValue ?? defaultConfiguration;

    if (index < 0 || index >= config.currencies.length) {
      _currentConfigurationSubject.addErrorEvent(const CcError(ErrorCode.repository_configuration_missingIndexError));
      return;
    }

    final currencies = [...config.currencies];
    currencies.replaceRange(index, index + 1, [currency]);

    final updatedConfig = config.copyWith(currencies: currencies);

    await _updateCurrentConfiguration(updatedConfig);
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
    _currentConfigurationSubject.close();
    _configurationsSubject.close();
  }
}
