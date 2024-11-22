import "package:flutter/material.dart";
import "package:j1_ui/j1_ui.dart";

class HomeLoading extends StatelessWidget {
  const HomeLoading({super.key});

  @override
  Widget build(BuildContext context) {
    final fonts = context.textTheme();

    return JLoadingProvider(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: JDimens.spacing_m),
        child: Column(
          children: [
            JLoadingText(style: fonts.headlineMedium),
            const SizedBox(height: JDimens.spacing_s),
            JLoadingText(style: fonts.labelMedium),
            const SizedBox(height: JDimens.spacing_s),
            const JLoadingBox(height: JDimens.size_56, cornerRadius: JDimens.radius_m),
            const SizedBox(height: JDimens.spacing_s),
            JLoadingText(style: fonts.headlineMedium),
            const SizedBox(height: JDimens.spacing_s),
            const JLoadingBox(height: JDimens.size_56, cornerRadius: JDimens.radius_m),
            const SizedBox(height: JDimens.spacing_s),
            const JLoadingBox(height: JDimens.size_56, cornerRadius: JDimens.radius_m),
            const SizedBox(height: JDimens.spacing_s),
            const JLoadingBox(height: JDimens.size_56, cornerRadius: JDimens.radius_m),
            const SizedBox(height: JDimens.spacing_m),
            const JLoadingBox(width: JDimens.size_48, height: JDimens.size_48, cornerRadius: JDimens.radius_xl),
          ],
        ),
      ),
    );
  }
}
