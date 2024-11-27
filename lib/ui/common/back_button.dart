import "package:flutter/material.dart";
import "package:j1_router/j1_router.dart";
import "package:j1_ui/j1_ui.dart";

class BackButton extends StatelessWidget {
  const BackButton({super.key});

  @override
  Widget build(BuildContext context) {
    return JIconButton(
      icon: JamIcons.chevronleft,
      color: JWidgetColor.secondary,
      onPressed: () {
        if (context.canPop()) {
          context.pop();
        }
      },
    );
  }
}
