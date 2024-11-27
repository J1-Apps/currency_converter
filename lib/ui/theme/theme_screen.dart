import "package:currency_converter/ui/common/cc_back_button.dart";
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
        leadingAction: const CcBackButton(),
      ),
      body: const _FavoritesContent(),
    );
  }
}

class _FavoritesContent extends StatelessWidget {
  const _FavoritesContent();

  @override
  Widget build(BuildContext context) {
    final strings = context.strings();
    final fonts = context.textTheme();

    return Column(
      children: [
        const SizedBox(height: JDimens.spacing_s),
        const SizedBox(height: JDimens.spacing_xs),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: JDimens.spacing_m),
          child: Text(strings.theme_headerFonts, style: fonts.headlineMedium),
        ),
        const SizedBox(height: JDimens.spacing_xs),
        const SizedBox(height: JDimens.spacing_xs),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: JDimens.spacing_m),
          child: Text(strings.theme_bodyFonts, style: fonts.headlineMedium),
        ),
        const SizedBox(height: JDimens.spacing_xs),
        const SizedBox(height: JDimens.spacing_xxl),
      ],
    );
  }
}
