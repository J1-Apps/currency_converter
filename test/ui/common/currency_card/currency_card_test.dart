import "package:currency_converter/model/currency.dart";
import "package:currency_converter/ui/common/currency_flag_icon.dart";
import "package:currency_converter/ui/common/currency_card/currency_card.dart";
import "package:fl_chart/fl_chart.dart";
import "package:flutter/material.dart";
import "package:flutter_test/flutter_test.dart";
import "package:j1_ui/j1_ui.dart";

import "../../../testing_values.dart";
import "../../../testing_utils.dart";

void main() {
  group("Currency Card", () {
    testWidgets("expands and collapses", (tester) async {
      await tester.pumpWidget(const TestWrapper(child: _CurrencyCardUpdateTester()));

      final logoFinder = find.byType(CurrencyFlagIcon);
      final labelFinder = find.text(CurrencyCode.USD.name.toUpperCase());
      final fieldFinder = find.byType(TextFormField);
      final expandFinder = find.byIcon(JamIcons.info);
      final collapseFinder = find.byIcon(JamIcons.infofilled);

      final chartFinder = find.byType(LineChart);
      final actionFinder = find.byType(JTextButton);

      expect(logoFinder, findsNWidgets(2));
      expect(labelFinder, findsOneWidget);
      expect(fieldFinder, findsOneWidget);
      expect(expandFinder, findsOneWidget);
      expect(collapseFinder, findsNothing);

      expect(chartFinder, findsNothing);
      expect(actionFinder, findsNothing);

      await tester.tap(expandFinder);
      await tester.pumpAndSettle();

      expect(logoFinder, findsNWidgets(2));
      expect(labelFinder, findsOneWidget);
      expect(fieldFinder, findsOneWidget);
      expect(expandFinder, findsNothing);
      expect(collapseFinder, findsOneWidget);

      expect(chartFinder, findsOneWidget);
      expect(actionFinder, findsNWidgets(2));

      await tester.tap(collapseFinder);
      await tester.pumpAndSettle();

      expect(logoFinder, findsNWidgets(2));
      expect(labelFinder, findsOneWidget);
      expect(fieldFinder, findsOneWidget);
      expect(expandFinder, findsOneWidget);
      expect(collapseFinder, findsNothing);

      expect(chartFinder, findsNothing);
      expect(actionFinder, findsNothing);
    });
  });
}

class _CurrencyCardUpdateTester extends StatefulWidget {
  const _CurrencyCardUpdateTester();

  @override
  State<StatefulWidget> createState() => _CurrencyCardUpdateTesterState();
}

class _CurrencyCardUpdateTesterState extends State<_CurrencyCardUpdateTester> {
  var isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CurrencyCard(
          currency: CurrencyCode.USD,
          onTapCurrency: () {},
          isBase: false,
          isExpanded: isExpanded,
          toggleExpanded: () => setState(() => isExpanded = !isExpanded),
          relativeValue: 0.00,
          updateRelativeValue: (_) {},
          isFavorite: false,
          toggleFavorite: () {},
          onRemove: () {},
          snapshot: oneYearSnapshot(CurrencyCode.USD),
          onSnapshotPeriodUpdate: (_) {},
        ),
      ],
    );
  }
}
