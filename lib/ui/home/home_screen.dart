import "package:currency_converter/router.dart";
import "package:flutter/material.dart" hide IconButton;
import "package:j1_router/j1_router.dart";
import "package:j1_ui/j1_ui.dart";

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: JAppBar(
        trailingActions: [
          JIconButton(icon: JamIcons.refresh, onPressed: () {}),
          JIconButton(
            icon: JamIcons.settings,
            onPressed: () => context.navigate(CcRoute.settingsRoute.build(const EmptyRouteConfig())),
          ),
        ],
      ),
    );
  }
}
