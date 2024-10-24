import "package:currency_converter/repository/app_storage_repository/app_storage_repository.dart";
import "package:currency_converter/repository/exchange_repository/exchange_repository.dart";
import "package:currency_converter/source/remote_exchange_source/remote_exchange_source.dart";
import "package:j1_environment/j1_environment.dart";
import "package:j1_theme/j1_theme.dart";

abstract class CcEnvironment extends J1Environment {
  // Source
  RemoteExchangeSource get remoteExchangeSource;

  // Repository
  AppStorageRepository get appStorageRepository;
  ExchangeRepository get exchangeRepository;

  @override
  Future<void> configure() async {
    await super.configure();

    locator.registerSingleton<J1ThemeRepository>(appStorageRepository);
    locator.registerSingleton<AppStorageRepository>(appStorageRepository);
    locator.registerSingleton<ExchangeRepository>(exchangeRepository);
  }
}
