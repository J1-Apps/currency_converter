import "package:currency_converter/model/currency.dart";
import "package:currency_converter/ui/home/currency_card.dart";
import "package:currency_converter/util/extensions/build_context_extensions.dart";
import "package:flutter/material.dart" hide IconButton;
import "package:j1_router/j1_router.dart";
import "package:j1_ui/j1_ui.dart";

// coverage:ignore-file
class TestScreen extends StatelessWidget {
  const TestScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Header(
        title: context.strings().test,
        leadingAction: IconButton(
          icon: JamIcons.chevronleft,
          color: WidgetColor.secondary,
          onPressed: () {
            if (context.canPop()) {
              context.pop();
            }
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(
          Dimens.spacing_m,
          Dimens.size_0,
          Dimens.spacing_m,
          Dimens.size_0,
        ),
        child: ListView.builder(
          itemCount: CurrencyCode.values.length + 2,
          itemBuilder: (context, index) {
            if (index == 0) {
              return const SizedBox(height: Dimens.spacing_m);
            }

            if (index == CurrencyCode.values.length + 1) {
              return const SizedBox(height: Dimens.spacing_xl);
            }

            return Padding(
              padding: const EdgeInsets.only(bottom: Dimens.spacing_s),
              child: CurrencyCard(
                currency: CurrencyCode.values[index - 1],
                relativeValue: 1.0,
                updateRelativeValue: (_) {},
              ),
            );
          },
        ),
      ),
    );
  }
}
