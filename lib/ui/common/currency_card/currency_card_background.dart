import "dart:ui";

import "package:currency_converter/model/currency.dart";
import "package:currency_converter/ui/common/currency_flag_icon.dart";
import "package:flutter/material.dart";

const double _backgroundOpacity = 0.1;
const double _backgroundBlur = 4;

class CurrencyCardBackground extends StatelessWidget {
  final CurrencyCode currency;

  const CurrencyCardBackground({required this.currency, super.key});

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
