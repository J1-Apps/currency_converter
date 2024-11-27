import "package:currency_converter/ui/common/cc_back_button.dart";
import "package:currency_converter/ui/test/test_currency_card_list.dart";
import "package:currency_converter/ui/util/extensions/build_context_extensions.dart";
import "package:flutter/material.dart";
import "package:j1_ui/j1_ui.dart";

// coverage:ignore-file
class TestScreen extends StatelessWidget {
  const TestScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: JAppBar(
        title: context.strings().settings_test,
        leadingAction: const CcBackButton(),
      ),
      body: const Padding(
        padding: EdgeInsets.symmetric(horizontal: JDimens.spacing_m),
        child: CurrencyCardList(),
      ),
    );
  }
}
