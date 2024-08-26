import "package:currency_converter/repository/theme_repository.dart";
import "package:currency_converter/util/environment/cc_environment.dart";
import "package:currency_converter/util/environment/test_firebase_options.dart";
import "package:firebase_core/firebase_core.dart";
import "package:j1_crash_handler/j1_crash_handler.dart";
import "package:j1_logger/j1_logger.dart";
import "package:j1_router/j1_router.dart";
import "package:j1_theme/j1_theme.dart";

class TestEnvironment extends CcEnvironment {
  @override
  FirebaseOptions? get firebaseOptions => TestFirebaseOptions.currentPlatform;

  @override
  J1CrashHandler get crashHandler => FirebaseCrashHandler();

  @override
  J1Logger get logger => FirebaseLogger();

  @override
  J1Router get router => GoRouter();

  @override
  J1ThemeRepository get themeRepository => ThemeRepository();
}
