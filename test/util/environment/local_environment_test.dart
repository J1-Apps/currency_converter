import "package:currency_converter/repository/app_storage_repository/local_app_storage_repository.dart";
import "package:currency_converter/util/environment/local_environment.dart";
import "package:flutter_test/flutter_test.dart";
import "package:j1_environment/j1_environment.dart";
import "package:j1_logger/j1_logger.dart";
import "package:j1_router/j1_router.dart";
import "package:j1_theme/j1_theme.dart";

/// This test is used to enforce the default [LocalEnvironment] implementation. Please do not modify this test unless
/// you are intentionally updating the default [LocalEnvironment] implementation.
void main() {
  group("Local Environment", () {
    test("configures local dependencies", () async {
      await LocalEnvironment().configure();

      expect(locator.get<J1Logger>() is LocalLogger, true);
      expect(locator.get<J1Router>() is GoRouter, true);
      expect(locator.get<J1ThemeRepository>() is LocalAppStorageRepository, true);
    });
  });
}
