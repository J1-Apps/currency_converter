import "package:currency_converter/model/currency.dart";
import "package:currency_converter/ui/home/currency_card.dart";
import "package:flutter/material.dart" hide IconButton;
import "package:j1_ui/j1_ui.dart";

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Header(
        trailingActions: [
          IconButton(icon: JamIcons.refresh, onPressed: () {}),
          IconButton(icon: JamIcons.settings, onPressed: () {}),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(
          Dimens.spacing_m,
          Dimens.spacing_m,
          Dimens.spacing_m,
          Dimens.size_0,
        ),
        child: ListView.builder(
          itemCount: CurrencyCode.values.length,
          itemBuilder: (context, index) => Padding(
            padding: const EdgeInsets.only(bottom: Dimens.spacing_s),
            child: CurrencyCard(
              currency: CurrencyCode.values[index],
              relativeValue: 1.0,
              updateRelativeValue: (_) {}, // coverage:ignore-line
            ),
          ),
        ),
      ),
    );
  }
}
