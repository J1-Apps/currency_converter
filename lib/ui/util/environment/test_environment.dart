import "package:currency_converter/repository/app_storage_repository/app_storage_repository.dart";
import "package:currency_converter/repository/app_storage_repository/device_app_storage_repository.dart";
import "package:currency_converter/repository/exchange_repository/exchange_repository.dart";
import "package:currency_converter/source/remote_exchange_source.dart/remote_exchange_source.dart";
import "package:currency_converter/source/remote_exchange_source.dart/github_remote_exchange_source.dart";
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
  final _remoteExchangeSource = GithubRemoteExchangeSource();

  @override
  FirebaseOptions? get firebaseOptions => mockFirebaseOptions ? null : TestFirebaseOptions.currentPlatform;

  @override
  J1CrashHandler get crashHandler => FirebaseCrashHandler();

  @override
  J1Logger get logger => FirebaseLogger();

  @override
  J1Router get router => GoRouter();

  @override
  RemoteExchangeSource get remoteExchangeSource => _remoteExchangeSource;

  @override
  AppStorageRepository get appStorageRepository => DeviceAppStorageRepository(preferences: mockSharedPreferences);

  @override
  ExchangeRepository get exchangeRepository => ExchangeRepository(exchangeSource: _remoteExchangeSource);

  TestEnvironment({this.mockFirebaseOptions = false, this.mockSharedPreferences});
}
