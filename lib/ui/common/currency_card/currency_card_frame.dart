import "dart:ui";

import "package:currency_converter/model/currency.dart";
import "package:currency_converter/ui/common/currency_flag_icon.dart";
import "package:flutter/material.dart";
import "package:j1_ui/j1_ui.dart";

const double _backgroundOpacity = 0.1;
const double _backgroundBlur = 4;

class CurrencyCardFrame extends StatelessWidget {
  final CurrencyCode currency;
  final Widget child;
  final void Function()? onTap;

  const CurrencyCardFrame({
    required this.currency,
    required this.child,
    this.onTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return JCard(
      onPressed: onTap,
      child: Stack(children: [_CurrencyCardBackground(currency: currency), child]),
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
            child: Container(color: Colors.transparent),
          ),
        ],
      ),
    );
  }
}
