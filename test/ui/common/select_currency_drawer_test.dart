import "package:currency_converter/data/model/currency.dart";
import "package:currency_converter/ui/common/currency_card/select_currency_card.dart";
import "package:currency_converter/ui/common/select_currency_drawer.dart";
import "package:flutter/material.dart";
import "package:flutter_test/flutter_test.dart";
import "package:j1_ui/j1_ui.dart";

import "../../testing_utils.dart";

void main() {
  group("Select Currency Drawer", () {
    testWidgets("opens, filters, and selects, and handles empty result", (tester) async {
      tester.view.physicalSize = const Size(600, 1200);
      tester.view.devicePixelRatio = 1.0;

      addTearDown(() => tester.view.resetPhysicalSize());
      addTearDown(() => tester.view.resetDevicePixelRatio());

      await tester.pumpWidget(
        TestWrapper(
          child: Builder(
            builder: (context) => JIconButton(
              icon: JamIcons.plus,
              onPressed: () => context.showJBottomSheet(
                child: const _TestSelectCurrencyDrawer(
                  currencyList: [CurrencyCode.USD, CurrencyCode.KRW, CurrencyCode.EUR],
                  favorites: [CurrencyCode.EUR],
                  initialSelected: [CurrencyCode.KRW],
                ),
              ),
            ),
          ),
        ),
      );

      final searchFinder = find.byType(JTextField);
      final cardFinder = find.byType(SelectCurrencyCard);
      final selectedFinder = find.byIcon(JamIcons.check);
      final favoriteFinder = find.byIcon(JamIcons.starfilled);
      final emptyFinder = find.byType(JErrorMessage);

      await tester.tap(find.byIcon(JamIcons.plus));
      await tester.pumpAndSettle();

      expect(searchFinder, findsOneWidget);
      expect(favoriteFinder, findsOneWidget);
      expect(selectedFinder, findsOneWidget);
      expect(cardFinder, findsNWidgets(3));
      expect(emptyFinder, findsNothing);

      await tester.tap(cardFinder.at(1));
      await tester.pumpAndSettle();

      expect(searchFinder, findsOneWidget);
      expect(favoriteFinder, findsOneWidget);
      expect(selectedFinder, findsNWidgets(2));
      expect(cardFinder, findsNWidgets(3));
      expect(emptyFinder, findsNothing);

      await tester.tap(cardFinder.at(2));
      await tester.pumpAndSettle();

      expect(searchFinder, findsOneWidget);
      expect(favoriteFinder, findsOneWidget);
      expect(selectedFinder, findsNWidgets(3));
      expect(cardFinder, findsNWidgets(3));
      expect(emptyFinder, findsNothing);

      await tester.tap(cardFinder.first);
      await tester.pumpAndSettle();

      expect(searchFinder, findsOneWidget);
      expect(favoriteFinder, findsOneWidget);
      expect(selectedFinder, findsNWidgets(2));
      expect(cardFinder, findsNWidgets(3));
      expect(emptyFinder, findsNothing);

      await tester.tap(cardFinder.at(1));
      await tester.pumpAndSettle();

      expect(searchFinder, findsOneWidget);
      expect(favoriteFinder, findsOneWidget);
      expect(selectedFinder, findsOneWidget);
      expect(cardFinder, findsNWidgets(3));
      expect(emptyFinder, findsNothing);

      await tester.enterText(searchFinder, "us");
      await tester.pumpAndSettle();

      expect(searchFinder, findsOneWidget);
      expect(favoriteFinder, findsNothing);
      expect(selectedFinder, findsOneWidget);
      expect(cardFinder, findsOneWidget);
      expect(emptyFinder, findsNothing);

      await tester.tap(cardFinder);
      await tester.pumpAndSettle();

      expect(searchFinder, findsOneWidget);
      expect(favoriteFinder, findsNothing);
      expect(selectedFinder, findsNothing);
      expect(cardFinder, findsOneWidget);
      expect(emptyFinder, findsNothing);

      await tester.enterText(searchFinder, "test");
      await tester.pumpAndSettle();

      expect(searchFinder, findsOneWidget);
      expect(favoriteFinder, findsNothing);
      expect(selectedFinder, findsNothing);
      expect(cardFinder, findsNothing);
      expect(emptyFinder, findsOneWidget);
    });
  });
}

class _TestSelectCurrencyDrawer extends StatefulWidget {
  final List<CurrencyCode> currencyList;
  final List<CurrencyCode> favorites;
  final List<CurrencyCode> initialSelected;

  const _TestSelectCurrencyDrawer({
    required this.currencyList,
    required this.favorites,
    required this.initialSelected,
  });

  @override
  State<StatefulWidget> createState() => _TestSelectCurrencyDrawerState();
}

class _TestSelectCurrencyDrawerState extends State<_TestSelectCurrencyDrawer> {
  late List<CurrencyCode> selected;

  @override
  void initState() {
    selected = [...widget.initialSelected];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SelectCurrencyDrawer(
      options: widget.currencyList,
      favorites: widget.favorites,
      selected: selected,
      toggleSelected: (code) => setState(() {
        if (selected.contains(code)) {
          selected.remove(code);
        } else {
          selected.add(code);
        }
      }),
    );
  }
}
