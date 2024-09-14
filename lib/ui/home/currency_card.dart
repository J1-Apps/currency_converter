import "dart:ui";

import "package:currency_converter/model/currency.dart";
import "package:currency_converter/ui/common/currency_flag_icon.dart";
import "package:flutter/material.dart" hide Card, TextField;
import "package:flutter/services.dart";
import "package:j1_ui/j1_ui.dart";

const double _backgroundOpacity = 0.1;
const double _backgroundBlur = 1;

class CurrencyCard extends StatelessWidget {
  final CurrencyCode currency;
  final double relativeValue;
  final void Function(double) updateRelativeValue;

  const CurrencyCard({
    required this.currency,
    required this.relativeValue,
    required this.updateRelativeValue,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Stack(
        children: [
          _CurrencyCardBackground(currency: currency),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _CurrencyCardSelector(currency: currency),
              const SizedBox(width: Dimens.spacing_xl),
              _CurrencyCardField(
                code: currency,
                relativeValue: relativeValue,
                updateRelativeValue: updateRelativeValue,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _CurrencyCardBackground extends StatelessWidget {
  final CurrencyCode currency;

  const _CurrencyCardBackground({required this.currency});

  @override
  Widget build(BuildContext context) {
    return Positioned.fill(
      child: Stack(
        children: [
          CurrencyFlagIcon(
            code: currency,
            width: null,
            height: null,
            fit: BoxFit.cover,
            opacity: _backgroundOpacity,
          ),
          BackdropFilter(
            filter: ImageFilter.blur(sigmaX: _backgroundBlur, sigmaY: _backgroundBlur),
            child: Container(
              color: Colors.transparent,
            ),
          ),
        ],
      ),
    );
  }
}

class _CurrencyCardSelector extends StatelessWidget {
  final CurrencyCode currency;

  const _CurrencyCardSelector({required this.currency});

  @override
  Widget build(BuildContext context) {
    final textTheme = context.textTheme();

    return GestureDetector(
      // coverage:ignore-start
      onTap: () {
        // TODO: Open currency selector.
      },
      // coverage:ignore-end
      child: Padding(
        padding: const EdgeInsets.all(Dimens.spacing_m),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            CurrencyFlagIcon(code: currency),
            const SizedBox(width: Dimens.spacing_xs),
            Text(currency.name.toUpperCase(), style: textTheme.titleMedium),
            const SizedBox(width: Dimens.spacing_xs),
            Text("▼", style: textTheme.labelSmall),
          ],
        ),
      ),
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
      child: Padding(
        padding: const EdgeInsets.only(right: Dimens.spacing_m - 2),
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
                overrides: const TextFieldOverrides(
                  padding: EdgeInsets.fromLTRB(
                    Dimens.spacing_s,
                    Dimens.spacing_xs,
                    Dimens.size_0,
                    Dimens.spacing_xs,
                  ),
                ),
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
