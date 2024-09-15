import "package:currency_converter/model/currency.dart";
import "package:currency_converter/ui/common/currency_flag_icon.dart";
import "package:currency_converter/ui/common/currency_card/currency_card.dart";
import "package:flutter/material.dart" hide IconButton;
import "package:flutter_test/flutter_test.dart";
import "package:j1_ui/j1_ui.dart";
import "package:mocktail/mocktail.dart";

import "../../testing_utils.dart";

void main() {
  group("Currency Flag Icon", () {
    testWidgets("renders and handles text update", (tester) async {
      final mockCallback = MockCallback<double>();

      await tester.pumpWidget(
        TestWrapper(
          child: CurrencyCard(
            currency: CurrencyCode.USD,
            onTapCurrency: () {},
            isBase: false,
            isExpanded: false,
            toggleExpanded: () {},
            relativeValue: 0.0,
            updateRelativeValue: mockCallback.call,
            isFavorite: false,
            toggleFavorite: () {},
            onRemove: () {},
          ),
        ),
      );

      final logoFinder = find.byType(CurrencyFlagIcon);
      final labelFinder = find.text(CurrencyCode.USD.name.toUpperCase());
      final fieldFinder = find.byType(TextFormField);

      expect(logoFinder, findsNWidgets(2));
      expect((logoFinder.found.first.widget as CurrencyFlagIcon).code, CurrencyCode.USD);
      expect(labelFinder, findsOneWidget);
      expect(fieldFinder, findsOneWidget);

      await tester.enterText(fieldFinder, "1.0");
      verify(() => mockCallback.call(1.0)).called(1);
    });

    testWidgets("updates text when value updates", (tester) async {
      final mockCallback = MockCallback<double>();

      await tester.pumpWidget(TestWrapper(child: _CurrencyCardUpdateTester(mockCallback: mockCallback)));

      final updateFinder = find.byIcon(JamIcons.plus);
      final unfocusFinder = find.byIcon(JamIcons.search);
      final fieldFinder = find.byType(TextFormField);

      expect(fieldFinder, findsOneWidget);
      expect((fieldFinder.found.first.widget as TextFormField).controller?.text, "0.00");

      await tester.tap(updateFinder);
      await tester.pumpAndSettle();

      expect(fieldFinder, findsOneWidget);
      expect((fieldFinder.found.first.widget as TextFormField).controller?.text, "10.50");

      await tester.enterText(fieldFinder, "10000.0");
      await tester.tap(unfocusFinder);
      await tester.pumpAndSettle();

      expect(fieldFinder, findsOneWidget);
      expect((fieldFinder.found.first.widget as TextFormField).controller?.text, "10.50");
    });
  });
}

class _CurrencyCardUpdateTester extends StatefulWidget {
  final MockCallback<double> mockCallback;

  const _CurrencyCardUpdateTester({required this.mockCallback});

  @override
  State<StatefulWidget> createState() => _CurrencyCardUpdateTesterState();
}

class _CurrencyCardUpdateTesterState extends State<_CurrencyCardUpdateTester> {
  var value = 0.0;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CurrencyCard(
          currency: CurrencyCode.USD,
          onTapCurrency: () {},
          isBase: false,
          isExpanded: false,
          toggleExpanded: () {},
          relativeValue: value,
          updateRelativeValue: widget.mockCallback.call,
          isFavorite: false,
          toggleFavorite: () {},
          onRemove: () {},
        ),
        IconButton(
          icon: JamIcons.plus,
          onPressed: () => setState(() => value = 10.5),
        ),
        IconButton(
          icon: JamIcons.search,
          onPressed: () => FocusScope.of(context).unfocus(),
        ),
      ],
    );
  }
}
