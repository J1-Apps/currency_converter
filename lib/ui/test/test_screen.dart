import "package:currency_converter/ui/test/test_currency_card_list.dart";
import "package:currency_converter/ui/util/extensions/build_context_extensions.dart";
import "package:flutter/material.dart";
import "package:j1_router/j1_router.dart";
import "package:j1_ui/j1_ui.dart";

// coverage:ignore-file
class TestScreen extends StatelessWidget {
  const TestScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: JAppBar(
        title: context.strings().test,
        leadingAction: JIconButton(
          icon: JamIcons.chevronleft,
          color: JWidgetColor.secondary,
          onPressed: () {
            if (context.canPop()) {
              context.pop();
            }
          },
        ),
      ),
      body: const Padding(
        padding: EdgeInsets.symmetric(horizontal: JDimens.spacing_m),
        child: CurrencyCardList(),
      ),
    );
  }
}
