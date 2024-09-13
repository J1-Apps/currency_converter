import "package:currency_converter/model/currency.dart";
import "package:currency_converter/ui/common/currency_flag_icon.dart";
import "package:currency_converter/ui/home/currency_card.dart";
import "package:flutter/material.dart";
import "package:flutter_test/flutter_test.dart";
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
            relativeValue: 0.0,
            updateRelativeValue: mockCallback.call,
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
  });
}
