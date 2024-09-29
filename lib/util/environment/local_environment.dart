import "package:currency_converter/repository/app_storage_repository/app_storage_repository.dart";
import "package:currency_converter/repository/app_storage_repository/local_app_storage_repository.dart";
import "package:currency_converter/repository/exchange_rate_repository/exchange_rate_repository.dart";
import "package:currency_converter/repository/exchange_rate_repository/local_exchange_rate_repository.dart";
import "package:currency_converter/util/environment/cc_environment.dart";
import "package:firebase_core/firebase_core.dart";
import "package:j1_crash_handler/j1_crash_handler.dart";
import "package:j1_logger/j1_logger.dart";
import "package:j1_router/j1_router.dart";

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
  AppStorageRepository get appStorage => LocalAppStorageRepository();

  @override
  ExchangeRateRepository get exchangeRate => LocalExchangeRateRepository();
}
