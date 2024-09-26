import "package:currency_converter/ui/common/currency_card/currency_card_history.dart";
import "package:flutter_test/flutter_test.dart";
import "package:j1_ui/j1_ui.dart";

import "../../../testing_utils.dart";

void main() {
  // TODO: Test this widget more once mappings from histories are added.
  group("Currency Card History", () {
    testWidgets("renders a loading indicator", (tester) async {
      await tester.pumpWidget(
        TestWrapper(
          child: CurrencyCardHistory(
            snapshot: null,
            onSnapshotPeriodUpdate: (_) {},
          ),
        ),
      );

      expect(find.byType(JLoadingBox), findsOneWidget);
    });
  });

  testWidgets("renders an error state", (tester) async {});
}
