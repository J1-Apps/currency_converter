import "package:currency_converter/model/currency.dart";
import "package:currency_converter/ui/common/currency_card/currency_card_background.dart";
import "package:currency_converter/ui/common/currency_card/currency_card_field.dart";
import "package:currency_converter/ui/common/currency_card/currency_card_history.dart";
import "package:currency_converter/ui/common/currency_card/currency_card_label.dart";
import "package:currency_converter/util/extensions/build_context_extensions.dart";
import "package:flutter/material.dart" hide Card, TextButton, IconButton;
import "package:j1_ui/j1_ui.dart";

const _animationDuration = Duration(milliseconds: 200);

class CurrencyCard extends StatelessWidget {
  final CurrencyCode currency;
  final void Function() onTapCurrency;
  final bool isBase;
  final bool isExpanded;
  final void Function() toggleExpanded;
  final double relativeValue;
  final void Function(double) updateRelativeValue;
  final bool isFavorite;
  final void Function() toggleFavorite;
  final void Function() onRemove;

  const CurrencyCard({
    required this.currency,
    required this.onTapCurrency,
    required this.isBase,
    required this.isExpanded,
    required this.toggleExpanded,
    required this.relativeValue,
    required this.updateRelativeValue,
    required this.isFavorite,
    required this.toggleFavorite,
    required this.onRemove,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Stack(
        children: [
          CurrencyCardBackground(currency: currency),
          AnimatedSize(
            alignment: Alignment.topCenter,
            duration: _animationDuration,
            curve: Curves.easeInOut,
            child: Column(
              children: [
                _CurrencyCardHeader(
                  currency: currency,
                  onTapCurrency: onTapCurrency,
                  isBase: isBase,
                  isExpanded: isExpanded,
                  toggleExpanded: toggleExpanded,
                  relativeValue: relativeValue,
                  updateRelativeValue: updateRelativeValue,
                ),
                _CurrencyCardContent(
                  isExpanded: isExpanded,
                  isFavorite: isFavorite,
                  toggleFavorite: toggleFavorite,
                  onRemove: onRemove,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _CurrencyCardDivider extends StatelessWidget {
  const _CurrencyCardDivider();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: Dimens.size_1,
      margin: const EdgeInsets.symmetric(horizontal: Dimens.spacing_m),
      color: context.colorScheme().onSurface,
    );
  }
}

class _CurrencyCardHeader extends StatelessWidget {
  final CurrencyCode currency;
  final void Function() onTapCurrency;
  final bool isBase;
  final bool isExpanded;
  final void Function() toggleExpanded;
  final double relativeValue;
  final void Function(double) updateRelativeValue;

  const _CurrencyCardHeader({
    required this.currency,
    required this.onTapCurrency,
    required this.isBase,
    required this.isExpanded,
    required this.toggleExpanded,
    required this.relativeValue,
    required this.updateRelativeValue,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CurrencyCardLabel(
          currency: currency,
          onTap: onTapCurrency,
          hasArrow: true,
        ),
        const Spacer(),
        const SizedBox(width: Dimens.spacing_xl),
        CurrencyCardField(
          code: currency,
          relativeValue: relativeValue,
          updateRelativeValue: updateRelativeValue,
        ),
        if (!isBase)
          Padding(
            padding: const EdgeInsets.only(
              left: Dimens.spacing_xxs,
              right: Dimens.spacing_xs,
            ),
            child: IconButton(
              icon: isExpanded ? JamIcons.infofilled : JamIcons.info,
              type: ButtonType.flat,
              color: WidgetColor.tertiary,
              size: WidgetSize.small,
              onPressed: toggleExpanded,
            ),
          ),
        if (isBase) const SizedBox(width: Dimens.spacing_m - 2),
      ],
    );
  }
}

class _CurrencyCardContent extends StatelessWidget {
  final bool isExpanded;
  final bool isFavorite;
  final void Function() toggleFavorite;
  final void Function() onRemove;

  const _CurrencyCardContent({
    required this.isExpanded,
    required this.isFavorite,
    required this.toggleFavorite,
    required this.onRemove,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedSize(
      alignment: Alignment.topCenter,
      duration: _animationDuration,
      curve: Curves.easeIn,
      child: isExpanded
          ? Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const _CurrencyCardDivider(),
                const CurrencyCardHistory(),
                _CurrencyCardActions(
                  isFavorite: isFavorite,
                  toggleFavorite: toggleFavorite,
                  onRemove: onRemove,
                ),
              ],
            )
          : const SizedBox.shrink(),
    );
  }
}

class _CurrencyCardActions extends StatelessWidget {
  final bool isFavorite;
  final void Function() toggleFavorite;
  final void Function() onRemove;

  const _CurrencyCardActions({
    required this.isFavorite,
    required this.toggleFavorite,
    required this.onRemove,
  });

  @override
  Widget build(BuildContext context) {
    final strings = context.strings();

    return Padding(
      padding: const EdgeInsets.only(
        left: Dimens.spacing_s,
        right: Dimens.spacing_s,
        bottom: Dimens.spacing_xs,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          TextButton(
            text: isFavorite ? strings.currencyCard_unfavorite : strings.currencyCard_favorite,
            icon: isFavorite ? JamIcons.starfilled : JamIcons.star,
            type: ButtonType.flat,
            size: WidgetSize.small,
            color: WidgetColor.onSurface,
            onPressed: toggleFavorite,
          ),
          TextButton(
            text: strings.currencyCard_remove,
            icon: JamIcons.trash,
            type: ButtonType.flat,
            size: WidgetSize.small,
            color: WidgetColor.onSurface,
            onPressed: onRemove,
          ),
        ],
      ),
    );
  }
}
