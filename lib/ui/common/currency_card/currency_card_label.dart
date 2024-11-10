import "package:currency_converter/data/model/currency.dart";
import "package:currency_converter/ui/common/currency_flag_icon.dart";
import "package:flutter/material.dart";
import "package:j1_ui/j1_ui.dart";

class CurrencyCardLabel extends StatelessWidget {
  final CurrencyCode currency;
  final void Function()? onTap;
  final bool hasArrow;

  const CurrencyCardLabel({
    required this.currency,
    this.onTap,
    this.hasArrow = false,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final textTheme = context.textTheme();

    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.all(JDimens.spacing_m),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            CurrencyFlagIcon(code: currency),
            const SizedBox(width: JDimens.spacing_xs),
            Text(currency.name.toUpperCase(), style: textTheme.titleMedium),
            if (hasArrow) const SizedBox(width: JDimens.spacing_xs),
            if (hasArrow) Text("▼", style: textTheme.labelSmall),
          ],
        ),
      ),
    );
  }
}
