import "package:currency_converter/router.dart";
import "package:currency_converter/state/settings/settings_bloc.dart";
import "package:currency_converter/state/settings/settings_state.dart";
import "package:currency_converter/ui/common/cc_back_button.dart";
import "package:currency_converter/ui/settings/select_language_drawer.dart";
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
        leadingAction: const CcBackButton(),
      ),
      body: Column(
        children: [
          _SettingsItem(
            icon: JamIcons.star,
            label: strings.settings_favorites,
            onPressed: () => context.navigate(CcRoute.favoritesRoute.build(const EmptyRouteConfig())),
          ),
          // TODO: Implement this in #44.
          // _SettingsItem(
          //   icon: JamIcons.home,
          //   label: strings.settings_configurations,
          //   onPressed: () {},
          // ),
          _SettingsItem(
            icon: JamIcons.language,
            label: strings.settings_language,
            trailingItem: const _LanguageSwitcher(),
            onPressed: () => context.showJBottomSheet(
              child: const SelectLanguageDrawer(),
              scrollControlDisabledMaxHeightRatio: selectLanguageDrawerHeightRatio,
            ),
          ),
          _SettingsItem(
            icon: JamIcons.paintbrush,
            label: strings.settings_theme,
            onPressed: () => context.navigate(CcRoute.themeRoute.build(const EmptyRouteConfig())),
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

    return BlocConsumer<SettingsBloc, SettingsState>(
      listenWhen: (previous, current) => previous.error != current.error,
      listener: _listenErrors,
      buildWhen: (previous, current) => previous.language != current.language,
      builder: (context, state) {
        final language = state.language;

        if (language == null) {
          return const JLoadingIndicator();
        } else {
          return Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(strings.settings_languageLabel(language), style: textTheme.titleMedium),
              const SizedBox(width: JDimens.spacing_xs),
              Text("▼", style: textTheme.labelSmall),
            ],
          );
        }
      },
    );
  }
}

void _listenErrors(BuildContext context, SettingsState state) {
  final error = state.error;

  if (error == null) {
    return;
  }

  final strings = context.strings();
  final errorString = switch (error) {
    SettingsErrorCode.loadLanguage => strings.settings_error_getLanguage,
    SettingsErrorCode.saveLanguage => strings.settings_error_saveLanguage,
  };

  context.showJToastWithText(text: errorString, hasClose: true);
}
