import "package:currency_converter/model/currency.dart";
import "package:flutter/material.dart";

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
    // TODO: implement build
    throw UnimplementedError();
  }
}

class _CurrencyCardSelector extends StatelessWidget {
  final CurrencyCode currency;

  const _CurrencyCardSelector({required this.currency});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    throw UnimplementedError();
  }
}

class _CurrencyCardField extends StatefulWidget {
  final CurrencyCode currency;
  final double relativeValue;
  final void Function(double) updateRelativeValue;

  const _CurrencyCardField({
    required this.currency,
    required this.relativeValue,
    required this.updateRelativeValue,
  });

  @override
  State<StatefulWidget> createState() => _CurrencyCardFieldState();
}

class _CurrencyCardFieldState extends State<_CurrencyCardField> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    throw UnimplementedError();
  }
}
