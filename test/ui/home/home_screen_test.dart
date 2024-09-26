import "package:currency_converter/router.dart";
import "package:currency_converter/ui/home/home_screen.dart";
import "package:currency_converter/ui/settings/settings_screen.dart";
import "package:flutter/material.dart";
import "package:flutter_gen/gen_l10n/app_localizations.dart";
import "package:flutter_test/flutter_test.dart";
import "package:j1_environment/j1_environment.dart";
import "package:j1_router/j1_router.dart";
import "package:j1_ui/j1_ui.dart";

void main() {
  group("Home Screen", () {
    testWidgets("shows refresh and settings buttons", (tester) async {
      await tester.pumpWidget(const MaterialApp(home: HomeScreen()));

      expect(find.byIcon(JamIcons.refresh), findsOneWidget);
      expect(find.byIcon(JamIcons.settings), findsOneWidget);
    });

    testWidgets("navigates to settings", (tester) async {
      locator.registerSingleton<J1Router>(GoRouter());

      await tester.pumpWidget(
        MaterialApp.router(
          localizationsDelegates: Strings.localizationsDelegates,
          supportedLocales: Strings.supportedLocales,
          routerConfig: routeGraph.buildConfig(),
        ),
      );
      await tester.tap(find.byIcon(JamIcons.settings));
      await tester.pumpAndSettle();

      expect(find.byType(SettingsScreen), findsOneWidget);

      await locator.reset();
    });
  });
}