import "package:currency_converter/data/repository/theme_repository.dart";
import "package:currency_converter/ui/util/environment/prod_environment.dart";
import "package:firebase_core/firebase_core.dart";
import "package:flutter_test/flutter_test.dart";
import "package:j1_environment/j1_environment.dart";
import "package:j1_logger/j1_logger.dart";
import "package:j1_router/j1_router.dart";
import "package:j1_theme/j1_theme.dart";
import "package:mocktail/mocktail.dart";

import "../../../testing_utils.dart";
import "mocks.dart";

/// This test is used to enforce the default [ProdEnvironment] implementation. Please do not modify this test unless
/// you are intentionally updating the default [ProdEnvironment] implementation.
void main() {
  group("Prod Environment", () {
    setupFirebaseAuthMocks();

    setUpAll(() async {
      await Firebase.initializeApp();
    });

    test("configures prod dependencies", () async {
      final preferences = MockSharedPreferences();

      when(() => preferences.getString(any())).thenAnswer((_) => Future.value());
      when(() => preferences.getStringList(any())).thenAnswer((_) => Future.value());

      await ProdEnvironment(mockFirebaseOptions: true, mockSharedPreferences: preferences).configure();

      expect(locator.get<J1Logger>() is FirebaseLogger, true);
      expect(locator.get<J1Router>() is GoRouter, true);
      expect(locator.get<J1ThemeRepository>() is ThemeRepository, true);
    });
  });
}
