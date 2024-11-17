import "package:currency_converter/data/repository/configuration_repository.dart";
import "package:currency_converter/data/repository/currency_repository.dart";
import "package:currency_converter/data/repository/exchange_repository.dart";
import "package:currency_converter/data/repository/favorite_repository.dart";
import "package:currency_converter/data/repository/language_repository.dart";
import "package:currency_converter/data/source/local_configuration_source/local_configuration_source.dart";
import "package:currency_converter/data/source/local_currency_source/local_currency_source.dart";
import "package:currency_converter/data/source/local_exchange_source/local_exchange_source.dart";
import "package:currency_converter/data/source/local_favorite_source/local_favorite_source.dart";
import "package:currency_converter/data/source/local_language_source/local_language_source.dart";
import "package:currency_converter/data/source/local_theme_source/local_theme_source.dart";
import "package:currency_converter/data/source/remote_exchange_source/remote_exchange_source.dart";
import "package:j1_environment/j1_environment.dart";
import "package:j1_theme/j1_theme.dart";

abstract class CcEnvironment extends J1Environment {
  // Source
  LocalConfigurationSource get localConfigurationSource;
  LocalCurrencySource get localCurrencySource;
  RemoteExchangeSource get remoteExchangeSource;
  LocalExchangeSource get localExchangeSource;
  LocalFavoriteSource get localFavoriteSource;
  LocalLanguageSource get localLanguageSource;
  LocalThemeSource get localThemeSource;

  // Repository
  J1ThemeRepository get themeRepository;
  ConfigurationRepository get configurationRepository;
  CurrencyRepository get currencyRepository;
  ExchangeRepository get exchangeRepository;
  FavoriteRepository get favoriteRepository;
  LanguageRepository get languageRepository;

  @override
  Future<void> configure() async {
    await super.configure();

    // Source
    locator.registerSingleton<LocalConfigurationSource>(localConfigurationSource);
    locator.registerSingleton<LocalCurrencySource>(localCurrencySource);
    locator.registerSingleton<RemoteExchangeSource>(remoteExchangeSource);
    locator.registerSingleton<LocalExchangeSource>(localExchangeSource);
    locator.registerSingleton<LocalFavoriteSource>(localFavoriteSource);
    locator.registerSingleton<LocalLanguageSource>(localLanguageSource);
    locator.registerSingleton<LocalThemeSource>(localThemeSource);

    // Repository
    locator.registerSingleton<J1ThemeRepository>(themeRepository);
    locator.registerSingleton<ConfigurationRepository>(configurationRepository);
    locator.registerSingleton<CurrencyRepository>(currencyRepository);
    locator.registerSingleton<ExchangeRepository>(exchangeRepository);
    locator.registerSingleton<FavoriteRepository>(favoriteRepository);
    locator.registerSingleton<LanguageRepository>(languageRepository);
  }
}
