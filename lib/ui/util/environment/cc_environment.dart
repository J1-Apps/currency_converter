import "package:currency_converter/repository/app_storage_repository/app_storage_repository.dart";
import "package:currency_converter/repository/configuration_repository.dart";
import "package:currency_converter/repository/exchange_repository.dart";
import "package:currency_converter/source/local_configuration_source/local_configuration_source.dart";
import "package:currency_converter/source/local_exchange_source/local_exchange_source.dart";
import "package:currency_converter/source/remote_exchange_source/remote_exchange_source.dart";
import "package:j1_environment/j1_environment.dart";
import "package:j1_theme/j1_theme.dart";

abstract class CcEnvironment extends J1Environment {
  // Source
  LocalConfigurationSource get localConfigurationSource;
  RemoteExchangeSource get remoteExchangeSource;
  LocalExchangeSource get localExchangeSource;

  // Repository
  AppStorageRepository get appStorageRepository;
  ConfigurationRepository get configurationRepository;
  ExchangeRepository get exchangeRepository;

  @override
  Future<void> configure() async {
    await super.configure();

    // Source
    locator.registerSingleton<LocalConfigurationSource>(localConfigurationSource);
    locator.registerSingleton<RemoteExchangeSource>(remoteExchangeSource);
    locator.registerSingleton<LocalExchangeSource>(localExchangeSource);

    // Repository
    locator.registerSingleton<J1ThemeRepository>(appStorageRepository);
    locator.registerSingleton<AppStorageRepository>(appStorageRepository);
    locator.registerSingleton<ConfigurationRepository>(configurationRepository);
    locator.registerSingleton<ExchangeRepository>(exchangeRepository);
  }
}
