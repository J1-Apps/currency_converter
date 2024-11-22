import "package:currency_converter/data/model/currency.dart";
import "package:currency_converter/ui/common/currency_card/currency_card_label.dart";
import "package:currency_converter/ui/common/currency_flag_icon.dart";
import "package:flutter_test/flutter_test.dart";
import "package:mocktail/mocktail.dart";

import "../../../testing_utils.dart";

void main() {
  group("Currency Card Label", () {
    testWidgets("renders with arrow", (tester) async {
      final mockCallback = MockVoidCallback();

      await tester.pumpWidget(
        TestWrapper(
          child: CurrencyCardLabel(
            currency: CurrencyCode.USD,
            onTap: mockCallback.call,
            hasArrow: true,
          ),
        ),
      );

      final flagFinder = find.byType(CurrencyFlagIcon);
      final labelFinder = find.text(CurrencyCode.USD.name.toUpperCase());
      final arrowFinder = find.text("▼");

      expect(flagFinder, findsOneWidget);
      expect(labelFinder, findsOneWidget);
      expect(arrowFinder, findsOneWidget);

      await tester.tap(flagFinder);
      await tester.tap(labelFinder);
      await tester.tap(arrowFinder);

      verify(mockCallback.call).called(3);
    });

    testWidgets("renders without arrow", (tester) async {
      final mockCallback = MockVoidCallback();

      await tester.pumpWidget(
        TestWrapper(
          child: CurrencyCardLabel(
            currency: CurrencyCode.USD,
            onTap: mockCallback.call,
          ),
        ),
      );

      final flagFinder = find.byType(CurrencyFlagIcon);
      final labelFinder = find.text(CurrencyCode.USD.name.toUpperCase());
      final arrowFinder = find.text("▼");

      expect(flagFinder, findsOneWidget);
      expect(labelFinder, findsOneWidget);
      expect(arrowFinder, findsNothing);

      await tester.tap(flagFinder);
      await tester.tap(labelFinder);

      verify(mockCallback.call).called(2);
    });
  });
}
