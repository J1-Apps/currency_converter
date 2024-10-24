import "package:currency_converter/repository/app_storage_repository/app_storage_repository.dart";
import "package:currency_converter/repository/exchange_rate_repository/exchange_rate_repository.dart";
import "package:j1_environment/j1_environment.dart";
import "package:j1_theme/j1_theme.dart";

abstract class CcEnvironment extends J1Environment {
  AppStorageRepository get appStorage;
  ExchangeRateRepository get exchangeRate;

  @override
  Future<void> configure() async {
    await super.configure();

    locator.registerSingleton<J1ThemeRepository>(appStorage);
    locator.registerSingleton<AppStorageRepository>(appStorage);
    locator.registerSingleton<ExchangeRateRepository>(exchangeRate);
  }
}
