import "package:currency_converter/model/currency.dart";
import "package:currency_converter/ui/common/currency_card/favorite_currency_card.dart";
import "package:currency_converter/ui/common/currency_flag_icon.dart";
import "package:flutter/material.dart";
import "package:flutter_test/flutter_test.dart";
import "package:j1_ui/j1_ui.dart";

import "../../../testing_utils.dart";

void main() {
  group("Favorite Currency Card", () {
    testWidgets("renders and handles taps", (tester) async {
      await tester.pumpWidget(const TestWrapper(child: _CurrencyCardUpdateTester()));

      final cardFinder = find.byType(JCard);
      final flagFinder = find.byType(CurrencyFlagIcon);
      final filledFinder = find.byIcon(JamIcons.starfilled);
      final emptyFinder = find.byIcon(JamIcons.star);

      expect(cardFinder, findsOneWidget);
      expect(flagFinder, findsNWidgets(2));
      expect(filledFinder, findsOneWidget);
      expect(emptyFinder, findsNothing);

      await tester.tap(cardFinder);
      await tester.pumpAndSettle();

      expect(cardFinder, findsOneWidget);
      expect(flagFinder, findsNWidgets(2));
      expect(filledFinder, findsNothing);
      expect(emptyFinder, findsOneWidget);

      await tester.tap(cardFinder);
      await tester.pumpAndSettle();

      expect(cardFinder, findsOneWidget);
      expect(flagFinder, findsNWidgets(2));
      expect(filledFinder, findsOneWidget);
      expect(emptyFinder, findsNothing);
    });
  });
}

class _CurrencyCardUpdateTester extends StatefulWidget {
  const _CurrencyCardUpdateTester();

  @override
  State<StatefulWidget> createState() => _CurrencyCardUpdateTesterState();
}

class _CurrencyCardUpdateTesterState extends State<_CurrencyCardUpdateTester> {
  var isFavorite = true;

  @override
  Widget build(BuildContext context) {
    return FavoriteCurrencyCard(
      currency: CurrencyCode.USD,
      isFavorite: isFavorite,
      onTap: () => setState(() => isFavorite = !isFavorite),
    );
  }
}
