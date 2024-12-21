import "package:currency_converter/data/repository/configuration_repository.dart";
import "package:currency_converter/data/repository/currency_repository.dart";
import "package:currency_converter/data/repository/exchange_repository.dart";
import "package:currency_converter/data/repository/favorite_repository.dart";
import "package:currency_converter/data/repository/language_repository.dart";
import "package:currency_converter/data/repository/theme_repository.dart";
import "package:currency_converter/data/source/local_configuration_source/local_configuration_source.dart";
import "package:currency_converter/data/source/local_configuration_source/preferences_local_configuration_source.dart";
import "package:currency_converter/data/source/local_currency_source/local_currency_source.dart";
import "package:currency_converter/data/source/local_currency_source/memory_local_currency_source.dart";
import "package:currency_converter/data/source/local_exchange_source/local_exchange_source.dart";
import "package:currency_converter/data/source/local_exchange_source/preferences_local_exchange_source.dart";
import "package:currency_converter/data/source/local_favorite_source/local_favorite_source.dart";
import "package:currency_converter/data/source/local_favorite_source/preferences_local_favorite_source.dart";
import "package:currency_converter/data/source/local_language_source/local_language_source.dart";
import "package:currency_converter/data/source/local_language_source/preferences_local_language_source.dart";
import "package:currency_converter/data/source/local_theme_source/local_theme_source.dart";
import "package:currency_converter/data/source/local_theme_source/preferences_local_theme_source.dart";
import "package:currency_converter/data/source/remote_exchange_source/firebase_remote_exchange_source.dart";
import "package:currency_converter/data/source/remote_exchange_source/remote_exchange_source.dart";
import "package:currency_converter/ui/util/environment/cc_environment.dart";
import "package:currency_converter/ui/util/environment/test_firebase_options.dart";
import "package:firebase_core/firebase_core.dart";
import "package:j1_crash_handler/j1_crash_handler.dart";
import "package:j1_logger/j1_logger.dart";
import "package:j1_router/j1_router.dart";
import "package:j1_theme/j1_theme.dart";
import "package:shared_preferences/shared_preferences.dart";

class TestEnvironment extends CcEnvironment {
  final bool mockFirebaseOptions;
  final SharedPreferencesAsync? mockSharedPreferences;

  @override
  FirebaseOptions? get firebaseOptions => mockFirebaseOptions ? null : TestFirebaseOptions.currentPlatform;

  @override
  J1CrashHandler get crashHandler => FirebaseCrashHandler();

  @override
  J1Logger get logger => FirebaseLogger();

  @override
  J1Router get router => GoRouter();

  @override
  LocalConfigurationSource get localConfigurationSource => PreferencesLocalConfigurationSource(
        preferences: mockSharedPreferences,
      );

  @override
  LocalCurrencySource get localCurrencySource => MemoryLocalCurrencySource();

  @override
  RemoteExchangeSource get remoteExchangeSource => FirebaseRemoteExchangeSource();

  @override
  LocalExchangeSource get localExchangeSource => PreferencesLocalExchangeSource(preferences: mockSharedPreferences);

  @override
  LocalFavoriteSource get localFavoriteSource => PreferencesLocalFavoriteSource(preferences: mockSharedPreferences);

  @override
  LocalLanguageSource get localLanguageSource => PreferencesLocalLanguageSource(preferences: mockSharedPreferences);

  @override
  LocalThemeSource get localThemeSource => PreferencesLocalThemeSource(preferences: mockSharedPreferences);

  @override
  J1ThemeRepository get themeRepository => ThemeRepository();

  @override
  ConfigurationRepository get configurationRepository => ConfigurationRepository();

  @override
  CurrencyRepository get currencyRepository => CurrencyRepository();

  @override
  ExchangeRepository get exchangeRepository => ExchangeRepository();

  @override
  FavoriteRepository get favoriteRepository => FavoriteRepository();

  @override
  LanguageRepository get languageRepository => LanguageRepository();

  TestEnvironment({this.mockFirebaseOptions = false, this.mockSharedPreferences});
}
