import "package:currency_converter/model/currency.dart";
import "package:currency_converter/model/exchange_rate.dart";
import "package:currency_converter/ui/common/currency_card/currency_card_history.dart";
import "package:flutter_test/flutter_test.dart";
import "package:j1_ui/j1_ui.dart";

import "../../../testing_utils.dart";

void main() {
  // TODO: Test this more in #36.
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

  testWidgets("renders an error state", (tester) async {
    await tester.pumpWidget(
      TestWrapper(
        child: CurrencyCardHistory(
          snapshot: ExchangeRateHistorySnapshot(
            HistorySnapshotPeriod.oneWeek,
            DateTime.now().toUtc(),
            CurrencyCode.USD,
            CurrencyCode.KRW,
            const {},
          ),
          onSnapshotPeriodUpdate: (_) {},
        ),
      ),
    );

    expect(find.byType(JErrorMessage), findsOneWidget);
  });
}
