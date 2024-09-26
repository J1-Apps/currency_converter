import "package:currency_converter/model/currency.dart";
import "package:flutter/material.dart";
import "package:flutter/services.dart";
import "package:j1_ui/j1_ui.dart";

class CurrencyCardField extends StatefulWidget {
  final CurrencyCode code;
  final double relativeValue;
  final void Function(double) updateRelativeValue;

  Currency get currency => Currency.fromCode(code);

  const CurrencyCardField({
    required this.code,
    required this.relativeValue,
    required this.updateRelativeValue,
    super.key,
  });

  @override
  State<StatefulWidget> createState() => _CurrencyCardFieldState();
}

class _CurrencyCardFieldState extends State<CurrencyCardField> {
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
            child: JTextField(
              type: JTextFieldType.flat,
              hint: widget.currency.formatValue(0.0),
              focusNode: focusNode,
              controller: controller,
              keyboardType: const TextInputType.numberWithOptions(decimal: true),
              textAlign: TextAlign.end,
              inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r"[0-9\.]"))],
              autocorrect: false,
              overrides: const JTextFieldOverrides(padding: EdgeInsets.symmetric(vertical: JDimens.spacing_xs)),
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
  void didUpdateWidget(covariant CurrencyCardField oldWidget) {
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
