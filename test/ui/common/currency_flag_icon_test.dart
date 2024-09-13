import "package:currency_converter/model/currency.dart";
import "package:currency_converter/ui/common/currency_flag_icon.dart";
import "package:flutter/material.dart";
import "package:flutter_test/flutter_test.dart";
import "package:vector_graphics/vector_graphics.dart";

void main() {
  group("Currency Flag Icon", () {
    testWidgets("renders vector graphic", (tester) async {
      await tester.pumpWidget(
        const Column(
          children: [
            CurrencyFlagIcon(code: CurrencyCode.USD),
            CurrencyFlagIcon(code: CurrencyCode.KRW, opacity: 0.2),
          ],
        ),
      );

      final vectorGraphicFinder = find.byType(VectorGraphic);

      expect(vectorGraphicFinder, findsNWidgets(2));
      expect((vectorGraphicFinder.found.last.widget as VectorGraphic).opacity?.value, 0.2);
    });
  });
}
