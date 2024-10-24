import "package:currency_converter/repository/app_storage_repository/app_storage_repository.dart";
import "package:currency_converter/repository/app_storage_repository/local_app_storage_repository.dart";
import "package:currency_converter/repository/exchange_repository/exchange_repository.dart";
import "package:currency_converter/source/remote_exchange_source.dart/remote_exchange_source.dart";
import "package:currency_converter/source/remote_exchange_source.dart/memory_remote_exchange_source.dart";
import "package:currency_converter/ui/util/environment/cc_environment.dart";
import "package:firebase_core/firebase_core.dart";
import "package:j1_crash_handler/j1_crash_handler.dart";
import "package:j1_logger/j1_logger.dart";
import "package:j1_router/j1_router.dart";

class LocalEnvironment extends CcEnvironment {
  final _remoteExchangeSource = MemoryRemoteExchangeSource();

  @override
  FirebaseOptions? get firebaseOptions => null;

  @override
  J1CrashHandler get crashHandler => const LocalCrashHandler();

  @override
  J1Logger get logger => LocalLogger();

  @override
  J1Router get router => GoRouter();

  @override
  RemoteExchangeSource get remoteExchangeSource => _remoteExchangeSource;

  @override
  AppStorageRepository get appStorageRepository => LocalAppStorageRepository();

  @override
  ExchangeRepository get exchangeRepository => ExchangeRepository(exchangeSource: _remoteExchangeSource);
}
