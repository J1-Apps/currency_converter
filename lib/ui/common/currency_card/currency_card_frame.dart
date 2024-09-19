import "package:currency_converter/model/currency.dart";
import "package:currency_converter/ui/common/currency_card/currency_card_background.dart";
import "package:flutter/material.dart";
import "package:j1_ui/j1_ui.dart";

class CurrencyCardFrame extends StatelessWidget {
  final CurrencyCode currency;
  final Widget child;

  const CurrencyCardFrame({
    required this.currency,
    required this.child,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return JCard(
      child: Stack(
        children: [
          CurrencyCardBackground(currency: currency),
          child,
        ],
      ),
    );
  }
}
