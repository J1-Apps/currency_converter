import "package:currency_converter/model/currency.dart";
import "package:flutter/material.dart";
import "package:j1_ui/j1_ui.dart";
import "package:vector_graphics/vector_graphics.dart";

class CountryFlagIcon extends StatelessWidget {
  final CurrencyCode code;
  final double width;
  final double height;
  final BoxFit fit;

  const CountryFlagIcon({
    required this.code,
    this.width = Dimens.size_32,
    this.height = Dimens.size_24,
    this.fit = BoxFit.contain,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return VectorGraphic(
      loader: AssetBytesLoader("assets/flags/${code.name.toLowerCase()}.svg"),
      width: width,
      height: height,
      fit: fit,
    );
  }
}
