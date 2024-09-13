import "package:currency_converter/ui/home/home_screen.dart";
import "package:flutter/material.dart";
import "package:flutter_test/flutter_test.dart";
import "package:j1_ui/j1_ui.dart";

void main() {
  group("Home Screen", () {
    testWidgets("shows refresh and settings buttons", (tester) async {
      await tester.pumpWidget(const MaterialApp(home: HomeScreen()));

      expect(find.byIcon(JamIcons.refresh), findsOneWidget);
      expect(find.byIcon(JamIcons.settings), findsOneWidget);
    });
  });
}
