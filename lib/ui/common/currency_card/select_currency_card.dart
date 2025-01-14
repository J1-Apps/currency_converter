import "package:currency_converter/data/model/currency.dart";
import "package:currency_converter/ui/common/currency_card/currency_card_frame.dart";
import "package:currency_converter/ui/common/currency_card/currency_card_label.dart";
import "package:flutter/material.dart";
import "package:j1_ui/j1_ui.dart";

class SelectCurrencyCard extends StatelessWidget {
  final CurrencyCode currency;
  final bool isSelected;
  final bool isFavorite;
  final void Function() onTap;

  const SelectCurrencyCard({
    required this.currency,
    required this.isSelected,
    required this.isFavorite,
    required this.onTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return CurrencyCardFrame(
      currency: currency,
      onTap: onTap,
      child: Row(
        children: [
          CurrencyCardLabel(currency: currency),
          const Spacer(),
          const SizedBox(width: JDimens.spacing_xl),
          if (isFavorite)
            Padding(
              padding: const EdgeInsets.only(right: JDimens.spacing_m),
              child: Icon(JamIcons.starfilled, size: JDimens.size_24, color: context.colorScheme().tertiary),
            ),
          if (isSelected)
            Padding(
              padding: const EdgeInsets.only(right: JDimens.spacing_m),
              child: Icon(JamIcons.check, size: JDimens.size_24, color: context.colorScheme().tertiary),
            ),
        ],
      ),
    );
  }
}
