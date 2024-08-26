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
    );
  }
}
