import "package:currency_converter/ui/extensions/build_context_extensions.dart";
import "package:flutter/material.dart";
import "package:j1_ui/j1_ui.dart";

class HomeError extends StatelessWidget {
  const HomeError({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(child: JErrorMessage(message: context.strings().home_error_getExchange));
  }
}
