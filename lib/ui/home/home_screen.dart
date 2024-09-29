import "package:currency_converter/router.dart";
import "package:currency_converter/state/home/home_bloc.dart";
import "package:currency_converter/state/home/home_event.dart";
import "package:currency_converter/ui/home/home_content.dart";
import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:j1_router/j1_router.dart";
import "package:j1_ui/j1_ui.dart";

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: JAppBar(
        trailingActions: const [
          _HomeRefreshButton(),
          _HomeSettingsButton(),
        ],
      ),
      body: const HomeContent(),
    );
  }
}

class _HomeRefreshButton extends StatelessWidget {
  const _HomeRefreshButton();

  @override
  Widget build(BuildContext context) {
    return JIconButton(
      icon: JamIcons.refresh,
      onPressed: () => context.read<HomeBloc>().add(const HomeRefreshSnapshotEvent()),
    );
  }
}

class _HomeSettingsButton extends StatelessWidget {
  const _HomeSettingsButton();

  @override
  Widget build(BuildContext context) {
    return JIconButton(
      icon: JamIcons.settings,
      onPressed: () => context.navigate(CcRoute.settingsRoute.build(const EmptyRouteConfig())),
    );
  }
}
