import "package:currency_converter/data/repository/configuration_repository.dart";
import "package:currency_converter/data/repository/exchange_repository.dart";
import "package:currency_converter/data/repository/favorite_repository.dart";
import "package:currency_converter/data/repository/language_repository.dart";
import "package:currency_converter/data/repository/theme_repository.dart";
import "package:currency_converter/data/source/local_configuration_source/local_configuration_source.dart";
import "package:currency_converter/data/source/local_configuration_source/memory_local_configuration_source.dart";
import "package:currency_converter/data/source/local_exchange_source/local_exchange_source.dart";
import "package:currency_converter/data/source/local_exchange_source/memory_local_exchange_source.dart";
import "package:currency_converter/data/source/local_favorite_source/local_favorite_source.dart";
import "package:currency_converter/data/source/local_favorite_source/memory_local_favorite_source.dart";
import "package:currency_converter/data/source/local_language_source/local_language_source.dart";
import "package:currency_converter/data/source/local_language_source/memory_local_language_source.dart";
import "package:currency_converter/data/source/local_theme_source/local_theme_source.dart";
import "package:currency_converter/data/source/local_theme_source/memory_local_theme_source.dart";
import "package:currency_converter/data/source/remote_exchange_source/remote_exchange_source.dart";
import "package:currency_converter/data/source/remote_exchange_source/memory_remote_exchange_source.dart";
import "package:currency_converter/ui/util/environment/cc_environment.dart";
import "package:firebase_core/firebase_core.dart";
import "package:j1_crash_handler/j1_crash_handler.dart";
import "package:j1_logger/j1_logger.dart";
import "package:j1_router/j1_router.dart";
import "package:j1_theme/j1_theme.dart";

class LocalEnvironment extends CcEnvironment {
  @override
  FirebaseOptions? get firebaseOptions => null;

  @override
  J1CrashHandler get crashHandler => const LocalCrashHandler();

  @override
  J1Logger get logger => LocalLogger();

  @override
  J1Router get router => GoRouter();

  @override
  LocalConfigurationSource get localConfigurationSource => MemoryLocalConfigurationSource();

  @override
  RemoteExchangeSource get remoteExchangeSource => MemoryRemoteExchangeSource();

  @override
  LocalExchangeSource get localExchangeSource => MemoryLocalExchangeSource();

  @override
  LocalFavoriteSource get localFavoriteSource => MemoryLocalFavoriteSource();

  @override
  LocalLanguageSource get localLanguageSource => MemoryLocalLanguageSource();

  @override
  LocalThemeSource get localThemeSource => MemoryLocalThemeSource();

  @override
  J1ThemeRepository get themeRepository => ThemeRepository();

  @override
  ConfigurationRepository get configurationRepository => ConfigurationRepository();

  @override
  ExchangeRepository get exchangeRepository => ExchangeRepository();

  @override
  FavoriteRepository get favoriteRepository => FavoriteRepository();

  @override
  LanguageRepository get languageRepository => LanguageRepository();
}
