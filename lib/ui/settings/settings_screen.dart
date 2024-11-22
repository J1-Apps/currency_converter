import "package:currency_converter/router.dart";
import "package:currency_converter/state/settings/settings_bloc.dart";
import "package:currency_converter/state/settings/settings_state.dart";
import "package:currency_converter/ui/util/extensions/build_context_extensions.dart";
import "package:flutter/foundation.dart";
import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:j1_router/j1_router.dart";
import "package:j1_ui/j1_ui.dart";

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final strings = context.strings();

    return Scaffold(
      appBar: JAppBar(
        title: strings.settings,
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
      body: Column(
        children: [
          _SettingsItem(
            icon: JamIcons.star,
            label: strings.settings_favorites,
            // TODO: Test in #26.
            onPressed: () {}, // coverage:ignore-line
          ),
          _SettingsItem(
            icon: JamIcons.home,
            label: strings.settings_configurations,
            // TODO: Test in #44.
            onPressed: () {}, // coverage:ignore-line
          ),
          _SettingsItem(
            icon: JamIcons.language,
            label: strings.settings_language,
            trailingItem: const _LanguageSwitcher(),
            onPressed: () {},
          ),
          _SettingsItem(
            icon: JamIcons.paintbrush,
            label: strings.settings_theme,
            // TODO: Test in #27.
            onPressed: () {}, // coverage:ignore-line
          ),
          _SettingsItem(
            icon: JamIcons.crown,
            label: strings.settings_membership,
            // TODO: Test in #45.
            onPressed: () {}, // coverage:ignore-line
          ),
          _SettingsItem(
            icon: JamIcons.info,
            label: strings.settings_about,
            // TODO: Test in #28.
            onPressed: () {}, // coverage:ignore-line
          ),
          // coverage:ignore-start
          if (kDebugMode)
            _SettingsItem(
              icon: JamIcons.settings,
              label: strings.settings_test,
              onPressed: () => context.navigate(CcRoute.testRoute.build(const EmptyRouteConfig())),
            ),
          // coverage:ignore-end
        ],
      ),
    );
  }
}

class _SettingsItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback? onPressed;
  final Widget? trailingItem;

  const _SettingsItem({
    required this.icon,
    required this.label,
    required this.onPressed,
    this.trailingItem,
  });

  @override
  Widget build(BuildContext context) {
    return JListItem(
      padding: const EdgeInsets.symmetric(horizontal: JDimens.spacing_m, vertical: JDimens.spacing_s),
      onPressed: onPressed,
      children: [
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon),
            const SizedBox(width: JDimens.spacing_xs),
            Text(label, style: context.textTheme().headlineSmall),
          ],
        ),
        trailingItem ?? const Icon(JamIcons.chevronright),
      ],
    );
  }
}

class _LanguageSwitcher extends StatelessWidget {
  const _LanguageSwitcher();

  @override
  Widget build(BuildContext context) {
    final textTheme = context.textTheme();
    final strings = context.strings();

    return BlocSelector<SettingsBloc, SettingsState, String>(
      selector: (state) => state.language ?? "",
      builder: (context, language) => Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(strings.settings_languageLabel(language), style: textTheme.titleMedium),
          const SizedBox(width: JDimens.spacing_xs),
          Text("▼", style: textTheme.labelSmall),
        ],
      ),
    );
  }
}
