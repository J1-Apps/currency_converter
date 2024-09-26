import "package:currency_converter/model/currency.dart";
import "package:currency_converter/ui/common/currency_card/currency_card_frame.dart";
import "package:currency_converter/ui/common/currency_card/currency_card_label.dart";
import "package:flutter/material.dart";
import "package:j1_ui/j1_ui.dart";

class FavoriteCurrencyCard extends StatelessWidget {
  final CurrencyCode currency;
  final bool isFavorite;
  final void Function() onTap;

  const FavoriteCurrencyCard({
    required this.currency,
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
          Icon(
            isFavorite ? JamIcons.starfilled : JamIcons.star,
            size: JDimens.size_24,
            color: context.colorScheme().tertiary,
          ),
          const SizedBox(width: JDimens.spacing_m),
        ],
      ),
    );
  }
}
