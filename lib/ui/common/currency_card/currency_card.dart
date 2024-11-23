import "package:currency_converter/data/model/currency.dart";
import "package:currency_converter/data/model/exchange_rate.dart";
import "package:currency_converter/ui/common/currency_card/currency_card_field.dart";
import "package:currency_converter/ui/common/currency_card/currency_card_frame.dart";
import "package:currency_converter/ui/common/currency_card/currency_card_history.dart";
import "package:currency_converter/ui/common/currency_card/currency_card_label.dart";
import "package:currency_converter/ui/util/extensions/build_context_extensions.dart";
import "package:flutter/material.dart";
import "package:j1_ui/j1_ui.dart";

const _animationDuration = Duration(milliseconds: 200);

class CurrencyCard extends StatelessWidget {
  final CurrencyCode currency;
  final void Function() onTapCurrency;
  final bool isBase;
  final bool? isExpanded;
  final void Function()? toggleExpanded;
  final double relativeValue;
  final void Function(double) updateRelativeValue;
  final bool? isFavorite;
  final void Function()? toggleFavorite;
  final void Function()? onRemove;
  final ExchangeRateHistorySnapshot? snapshot;
  final void Function(HistorySnapshotPeriod)? onSnapshotPeriodUpdate;

  const CurrencyCard.base({
    required this.currency,
    required this.onTapCurrency,
    required this.relativeValue,
    required this.updateRelativeValue,
    super.key,
  })  : isBase = true,
        isExpanded = null,
        toggleExpanded = null,
        isFavorite = null,
        toggleFavorite = null,
        onRemove = null,
        snapshot = null,
        onSnapshotPeriodUpdate = null;

  const CurrencyCard.converted({
    required this.currency,
    required this.onTapCurrency,
    required this.isExpanded,
    required this.toggleExpanded,
    required this.relativeValue,
    required this.updateRelativeValue,
    required this.isFavorite,
    required this.toggleFavorite,
    required this.onRemove,
    required this.snapshot,
    required this.onSnapshotPeriodUpdate,
    super.key,
  }) : isBase = false;

  @override
  Widget build(BuildContext context) {
    return CurrencyCardFrame(
      currency: currency,
      child: AnimatedSize(
        alignment: Alignment.topCenter,
        duration: _animationDuration,
        curve: Curves.easeInOut,
        child: Column(
          children: [
            _CurrencyCardHeader(
              currency: currency,
              onTapCurrency: onTapCurrency,
              isBase: isBase,
              isExpanded: isExpanded ?? false,
              toggleExpanded: toggleExpanded,
              relativeValue: relativeValue,
              updateRelativeValue: updateRelativeValue,
            ),
            if (!isBase)
              _CurrencyCardContent(
                isExpanded: isExpanded ?? false,
                isFavorite: isFavorite ?? false,
                toggleFavorite: toggleFavorite,
                onRemove: onRemove,
                snapshot: snapshot,
                onSnapshotPeriodUpdate: onSnapshotPeriodUpdate,
              ),
          ],
        ),
      ),
    );
  }
}

class _CurrencyCardHeader extends StatelessWidget {
  final CurrencyCode currency;
  final void Function() onTapCurrency;
  final bool isBase;
  final bool isExpanded;
  final void Function()? toggleExpanded;
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
        CurrencyCardField(
          code: currency,
          relativeValue: relativeValue,
          updateRelativeValue: updateRelativeValue,
        ),
        if (!isBase)
          Padding(
            padding: const EdgeInsets.only(
              left: JDimens.spacing_xxs,
              right: JDimens.spacing_xs,
            ),
            child: JIconButton(
              icon: isExpanded ? JamIcons.infofilled : JamIcons.info,
              type: JButtonType.flat,
              color: JWidgetColor.tertiary,
              size: JWidgetSize.small,
              onPressed: toggleExpanded,
            ),
          ),
        if (isBase) const SizedBox(width: JDimens.spacing_m - 2),
      ],
    );
  }
}

class _CurrencyCardContent extends StatelessWidget {
  final bool isExpanded;
  final bool isFavorite;
  final void Function()? toggleFavorite;
  final void Function()? onRemove;
  final ExchangeRateHistorySnapshot? snapshot;
  final void Function(HistorySnapshotPeriod)? onSnapshotPeriodUpdate;

  const _CurrencyCardContent({
    required this.isExpanded,
    required this.isFavorite,
    required this.toggleFavorite,
    required this.onRemove,
    required this.snapshot,
    required this.onSnapshotPeriodUpdate,
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
                CurrencyCardHistory(
                  snapshot: snapshot,
                  onSnapshotPeriodUpdate: onSnapshotPeriodUpdate,
                ),
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
  final void Function()? toggleFavorite;
  final void Function()? onRemove;

  const _CurrencyCardActions({
    required this.isFavorite,
    required this.toggleFavorite,
    required this.onRemove,
  });

  @override
  Widget build(BuildContext context) {
    final strings = context.strings();

    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: JDimens.spacing_m,
        vertical: JDimens.spacing_s,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          JTextButton(
            text: isFavorite ? strings.currencyCard_unfavorite : strings.currencyCard_favorite,
            icon: isFavorite ? JamIcons.starfilled : JamIcons.star,
            type: JButtonType.flat,
            size: JWidgetSize.small,
            color: JWidgetColor.onSurface,
            onPressed: toggleFavorite,
          ),
          JTextButton(
            text: strings.currencyCard_remove,
            icon: JamIcons.trash,
            type: JButtonType.flat,
            size: JWidgetSize.small,
            color: JWidgetColor.onSurface,
            onPressed: onRemove,
          ),
        ],
      ),
    );
  }
}
