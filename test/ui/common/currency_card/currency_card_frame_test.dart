import "package:currency_converter/data/model/currency.dart";
import "package:currency_converter/ui/common/currency_card/currency_card_frame.dart";
import "package:currency_converter/ui/common/currency_flag_icon.dart";
import "package:flutter/material.dart";
import "package:flutter_test/flutter_test.dart";

import "../../../testing_utils.dart";

void main() {
  group("Currency Card Frame", () {
    testWidgets("renders a blurred flag", (tester) async {
      await tester.pumpWidget(
        const TestWrapper(
          child: CurrencyCardFrame(
            currency: CurrencyCode.USD,
            child: Center(
              child: Text("test"),
            ),
          ),
        ),
      );

      expect(find.byType(CurrencyFlagIcon), findsOneWidget);
      expect(find.byType(BackdropFilter), findsOneWidget);
      expect(find.text("test"), findsOneWidget);
    });
  });
}
