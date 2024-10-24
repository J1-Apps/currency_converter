import "package:currency_converter/repository/app_storage_repository/app_storage_repository.dart";
import "package:currency_converter/repository/app_storage_repository/device_app_storage_repository.dart";
import "package:currency_converter/repository/configuration_repository.dart";
import "package:currency_converter/repository/exchange_repository.dart";
import "package:currency_converter/source/local_configuration_source/local_configuration_source.dart";
import "package:currency_converter/source/local_configuration_source/preferences_local_configuration_source.dart";
import "package:currency_converter/source/local_exchange_source/local_exchange_source.dart";
import "package:currency_converter/source/local_exchange_source/preferences_local_exchange_source.dart";
import "package:currency_converter/source/remote_exchange_source/remote_exchange_source.dart";
import "package:currency_converter/source/remote_exchange_source/github_remote_exchange_source.dart";
import "package:currency_converter/ui/util/environment/cc_environment.dart";
import "package:currency_converter/ui/util/environment/test_firebase_options.dart";
import "package:firebase_core/firebase_core.dart";
import "package:j1_crash_handler/j1_crash_handler.dart";
import "package:j1_logger/j1_logger.dart";
import "package:j1_router/j1_router.dart";
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
  RemoteExchangeSource get remoteExchangeSource => GithubRemoteExchangeSource();

  @override
  LocalExchangeSource get localExchangeSource => PreferencesLocalExchangeSource(preferences: mockSharedPreferences);

  @override
  AppStorageRepository get appStorageRepository => DeviceAppStorageRepository(preferences: mockSharedPreferences);

  @override
  ConfigurationRepository get configurationRepository => ConfigurationRepository();

  @override
  ExchangeRepository get exchangeRepository => ExchangeRepository();

  TestEnvironment({this.mockFirebaseOptions = false, this.mockSharedPreferences});
}
