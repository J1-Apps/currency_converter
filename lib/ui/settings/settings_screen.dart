import "package:currency_converter/router.dart";
import "package:currency_converter/ui/extensions/build_context_extensions.dart";
import "package:flutter/foundation.dart";
import "package:flutter/material.dart";
import "package:j1_router/j1_router.dart";
import "package:j1_ui/j1_ui.dart";

// TODO: Remove this ignore once settings screen is implemented (#25).
// coverage:ignore-file
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
      body: const Column(
        children: [
          _FavoritesItem(),
          if (kDebugMode) _TestItem(),
        ],
      ),
    );
  }
}

class _FavoritesItem extends StatelessWidget {
  const _FavoritesItem();

  @override
  Widget build(BuildContext context) {
    return JListItem(
      padding: const EdgeInsets.symmetric(horizontal: JDimens.spacing_m, vertical: JDimens.spacing_s),
      children: [
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(JamIcons.star),
            const SizedBox(width: JDimens.spacing_xs),
            Text(context.strings().settings_favorites, style: context.textTheme().headlineSmall),
          ],
        ),
        const Icon(JamIcons.chevronright),
      ],
      onPressed: () {},
    );
  }
}

class _TestItem extends StatelessWidget {
  const _TestItem();

  @override
  Widget build(BuildContext context) {
    return JListItem(
      padding: const EdgeInsets.symmetric(horizontal: JDimens.spacing_m, vertical: JDimens.spacing_s),
      children: [
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(JamIcons.settings),
            const SizedBox(width: JDimens.spacing_xs),
            Text(context.strings().test, style: context.textTheme().headlineSmall),
          ],
        ),
        const Icon(JamIcons.chevronright),
      ],
      onPressed: () => context.navigate(CcRoute.testRoute.build(const EmptyRouteConfig())),
    );
  }
}
