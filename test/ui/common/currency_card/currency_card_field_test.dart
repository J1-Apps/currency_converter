import "package:currency_converter/model/currency.dart";
import "package:currency_converter/ui/common/currency_card/currency_card_field.dart";
import "package:flutter/material.dart" hide IconButton;
import "package:flutter_test/flutter_test.dart";
import "package:j1_ui/j1_ui.dart";
import "package:mocktail/mocktail.dart";

import "../../../testing_utils.dart";

void main() {
  group("Currency Card Field", () {
    testWidgets("renders and handles text updates", (tester) async {
      final mockCallback = MockCallback<double>();

      await tester.pumpWidget(
        TestWrapper(
          child: Row(
            children: [
              CurrencyCardField(
                code: CurrencyCode.USD,
                relativeValue: 0.0,
                updateRelativeValue: mockCallback.call,
              ),
            ],
          ),
        ),
      );

      final fieldFinder = find.byType(TextFormField);
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
    return Row(
      children: [
        CurrencyCardField(
          code: CurrencyCode.USD,
          relativeValue: value,
          updateRelativeValue: widget.mockCallback.call,
        ),
        JIconButton(
          icon: JamIcons.plus,
          onPressed: () => setState(() => value = 10.5),
        ),
        JIconButton(
          icon: JamIcons.search,
          onPressed: () => FocusScope.of(context).unfocus(),
        ),
      ],
    );
  }
}
