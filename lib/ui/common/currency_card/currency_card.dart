import "package:currency_converter/model/currency.dart";
import "package:currency_converter/ui/common/currency_card/currency_card_background.dart";
import "package:currency_converter/ui/common/currency_card/currency_card_label.dart";
import "package:currency_converter/util/extensions/build_context_extensions.dart";
import "package:flutter/material.dart" hide Card, TextField, TextButton, IconButton;
import "package:flutter/services.dart";
import "package:j1_ui/j1_ui.dart";

class CurrencyCard extends StatelessWidget {
  final CurrencyCode currency;
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
          Column(
            children: [
              _CurrencyCardHeader(
                currency: currency,
                isBase: isBase,
                isExpanded: isExpanded,
                toggleExpanded: toggleExpanded,
                relativeValue: relativeValue,
                updateRelativeValue: updateRelativeValue,
              ),
              if (isExpanded) const _CurrencyCardDivider(),
              if (isExpanded)
                _CurrencyCardContentActions(
                  isFavorite: isFavorite,
                  toggleFavorite: toggleFavorite,
                  onRemove: onRemove,
                ),
            ],
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
  final bool isBase;
  final bool isExpanded;
  final void Function() toggleExpanded;
  final double relativeValue;
  final void Function(double) updateRelativeValue;

  const _CurrencyCardHeader({
    required this.currency,
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
          // coverage:ignore-start
          // TODO: Open add/change.
          onTap: () {},
          // coverage:ignore-end
          hasArrow: true,
        ),
        const Spacer(),
        const SizedBox(width: Dimens.spacing_xl),
        _CurrencyCardField(
          code: currency,
          relativeValue: relativeValue,
          updateRelativeValue: updateRelativeValue,
        ),
        if (!isBase) const SizedBox(width: Dimens.spacing_xxs),
        if (!isBase)
          IconButton(
            icon: isExpanded ? JamIcons.infofilled : JamIcons.info,
            type: ButtonType.flat,
            color: WidgetColor.tertiary,
            size: WidgetSize.small,
            onPressed: toggleExpanded,
          ),
        SizedBox(width: isBase ? Dimens.spacing_m - 2 : Dimens.spacing_xs),
      ],
    );
  }
}

class _CurrencyCardField extends StatefulWidget {
  final CurrencyCode code;
  final double relativeValue;
  final void Function(double) updateRelativeValue;

  Currency get currency => Currency.fromCode(code);

  const _CurrencyCardField({
    required this.code,
    required this.relativeValue,
    required this.updateRelativeValue,
  });

  @override
  State<StatefulWidget> createState() => _CurrencyCardFieldState();
}

class _CurrencyCardFieldState extends State<_CurrencyCardField> {
  final controller = TextEditingController();
  final focusNode = FocusNode();

  @override
  void initState() {
    super.initState();

    controller.text = widget.currency.formatValue(widget.relativeValue);

    focusNode.addListener(() {
      if (!focusNode.hasFocus) {
        controller.text = widget.currency.formatValue(widget.relativeValue);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = context.textTheme();

    return Expanded(
      child: Row(
        children: [
          Expanded(
            child: TextField(
              type: TextFieldType.flat,
              hint: widget.currency.formatValue(0.0),
              focusNode: focusNode,
              controller: controller,
              keyboardType: const TextInputType.numberWithOptions(decimal: true),
              textAlign: TextAlign.end,
              inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r"[0-9\.]"))],
              autocorrect: false,
              overrides: const TextFieldOverrides(padding: EdgeInsets.symmetric(vertical: Dimens.spacing_xs)),
              onChanged: (value) {
                final relativeValue = double.tryParse(value.isEmpty ? "0" : value);
                if (relativeValue != null) {
                  widget.updateRelativeValue(relativeValue);
                }
              },
            ),
          ),
          Text(widget.currency.symbol, style: textTheme.titleMedium),
        ],
      ),
    );
  }

  @override
  void didUpdateWidget(covariant _CurrencyCardField oldWidget) {
    if (!focusNode.hasFocus) {
      controller.text = widget.currency.formatValue(widget.relativeValue);
    }

    super.didUpdateWidget(oldWidget);
  }

  @override
  void dispose() {
    controller.dispose();
    focusNode.dispose();
    super.dispose();
  }
}

class _CurrencyCardContentActions extends StatelessWidget {
  final bool isFavorite;
  final void Function() toggleFavorite;
  final void Function() onRemove;

  const _CurrencyCardContentActions({
    required this.isFavorite,
    required this.toggleFavorite,
    required this.onRemove,
  });

  @override
  Widget build(BuildContext context) {
    final strings = context.strings();

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: Dimens.spacing_s, vertical: Dimens.spacing_xs),
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
