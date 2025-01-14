import "package:currency_converter/data/model/currency.dart";
import "package:currency_converter/ui/common/currency_card/select_currency_card.dart";
import "package:currency_converter/ui/common/currency_flag_icon.dart";
import "package:flutter/material.dart";
import "package:flutter_test/flutter_test.dart";
import "package:j1_ui/j1_ui.dart";

import "../../../testing_utils.dart";

void main() {
  group("Select Currency Card", () {
    testWidgets("renders and handles taps", (tester) async {
      await tester.pumpWidget(const TestWrapper(child: _CurrencyCardUpdateTester()));

      final cardFinder = find.byType(JCard);
      final flagFinder = find.byType(CurrencyFlagIcon);
      final selectedFinder = find.byIcon(JamIcons.check);
      final favoriteFinder = find.byIcon(JamIcons.starfilled);

      expect(cardFinder, findsOneWidget);
      expect(flagFinder, findsNWidgets(2));
      expect(selectedFinder, findsOneWidget);
      expect(favoriteFinder, findsOneWidget);

      await tester.tap(cardFinder);
      await tester.pumpAndSettle();

      expect(cardFinder, findsOneWidget);
      expect(flagFinder, findsNWidgets(2));
      expect(selectedFinder, findsNothing);
      expect(favoriteFinder, findsNothing);

      await tester.tap(cardFinder);
      await tester.pumpAndSettle();

      expect(cardFinder, findsOneWidget);
      expect(flagFinder, findsNWidgets(2));
      expect(selectedFinder, findsOneWidget);
      expect(favoriteFinder, findsOneWidget);
    });
  });
}

class _CurrencyCardUpdateTester extends StatefulWidget {
  const _CurrencyCardUpdateTester();

  @override
  State<StatefulWidget> createState() => _CurrencyCardUpdateTesterState();
}

class _CurrencyCardUpdateTesterState extends State<_CurrencyCardUpdateTester> {
  var isSelected = true;
  var isFavorite = true;

  @override
  Widget build(BuildContext context) {
    return SelectCurrencyCard(
      currency: CurrencyCode.USD,
      isSelected: isSelected,
      isFavorite: isFavorite,
      onTap: () => setState(() {
        isSelected = !isSelected;
        isFavorite = !isFavorite;
      }),
    );
  }
}
