import "package:currency_converter/ui/util/extensions/build_context_extensions.dart";
import "package:flutter/material.dart";
import "package:j1_ui/j1_ui.dart";

class ThemeScreen extends StatelessWidget {
  const ThemeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: JAppBar(
        title: context.strings().theme,
        leadingAction: const BackButton(),
      ),
      body: const Center(child: JLoadingIndicator()),
    );
  }
}
