import "package:currency_converter/ui/common/currency_card/currency_card_history.dart";
import "package:fl_chart/fl_chart.dart";
import "package:flutter_test/flutter_test.dart";

import "../../../testing_utils.dart";

void main() {
  // TODO: Test this widget more once mappings from histories are added.
  group("Currency Card History", () {
    testWidgets("renders a line chart", (tester) async {
      await tester.pumpWidget(
        const TestWrapper(
          child: CurrencyCardHistory(),
        ),
      );

      expect(find.byType(LineChart), findsOneWidget);
    });
  });
}
