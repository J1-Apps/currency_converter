import "package:currency_converter/model/currency.dart";
import "package:currency_converter/ui/common/currency_card/currency_card_background.dart";
import "package:currency_converter/ui/common/currency_flag_icon.dart";
import "package:flutter/material.dart";
import "package:flutter_test/flutter_test.dart";

import "../../../testing_utils.dart";

void main() {
  group("Currency Card Background", () {
    testWidgets("renders a blurred flag", (tester) async {
      await tester.pumpWidget(
        const TestWrapper(
          child: Stack(
            children: [
              CurrencyCardBackground(currency: CurrencyCode.USD),
            ],
          ),
        ),
      );

      expect(find.byType(CurrencyFlagIcon), findsOneWidget);
      expect(find.byType(BackdropFilter), findsOneWidget);
    });
  });
}
