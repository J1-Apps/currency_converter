import "package:currency_converter/repository/app_storage_repository/app_storage_repository.dart";
import "package:currency_converter/repository/app_storage_repository/device_app_storage_repository.dart";
import "package:currency_converter/repository/exchange_rate_repository/exchange_rate_repository.dart";
import "package:currency_converter/repository/exchange_rate_repository/github_exchange_rate_repository.dart";
import "package:currency_converter/util/environment/cc_environment.dart";
import "package:currency_converter/util/environment/test_firebase_options.dart";
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
  AppStorageRepository get appStorage => DeviceAppStorageRepository(preferences: mockSharedPreferences);

  @override
  ExchangeRateRepository get exchangeRate => GithubExchangeRateRepository();

  TestEnvironment({this.mockFirebaseOptions = false, this.mockSharedPreferences});
}
