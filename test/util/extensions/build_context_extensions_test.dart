import "package:currency_converter/util/extensions/build_context_extensions.dart";
import "package:flutter/material.dart";
import "package:flutter_test/flutter_test.dart";
import "package:flutter_gen/gen_l10n/app_localizations.dart";

void main() {
  group("Build Context Extensions", () {
    testWidgets("gets the localization class", (tester) async {
      late BuildContext context;

      await tester.pumpWidget(
        MaterialApp(
          localizationsDelegates: Strings.localizationsDelegates,
          supportedLocales: Strings.supportedLocales,
          home: Builder(
            builder: (widgetContext) {
              context = widgetContext;
              return const Center(child: CircularProgressIndicator());
            },
          ),
        ),
      );

      final strings = context.strings();
      expect(strings, isNotNull);
    });
  });
}
