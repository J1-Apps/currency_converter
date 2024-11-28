import "package:collection/collection.dart";
import "package:currency_converter/router.dart";
import "package:currency_converter/state/home/home_bloc.dart";
import "package:currency_converter/state/home/home_event.dart";
import "package:currency_converter/state/settings/settings_bloc.dart";
import "package:currency_converter/state/settings/settings_event.dart";
import "package:currency_converter/state/settings/settings_state.dart";
import "package:currency_converter/ui/theme/cc_color_scheme.dart";
import "package:currency_converter/ui/theme/cc_text_theme.dart";
import "package:currency_converter/ui/util/extensions/build_context_extensions.dart";
import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:flutter_gen/gen_l10n/app_localizations.dart";
import "package:j1_theme/j1_theme.dart";

class CurrencyConverterApp extends StatelessWidget {
  final _router = routeGraph.buildConfig();

  CurrencyConverterApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<J1ThemeBloc>(
          create: (_) => J1ThemeBloc(
            defaultColorScheme: CcColorScheme.light.scheme,
            defaultTextTheme: CcTextTheme.initial,
          ),
        ),
        BlocProvider(create: (_) => HomeBloc()..add(const HomeLoadEvent())),
        BlocProvider(create: (_) => SettingsBloc()..add(const SettingsLoadEvent())),
      ],
      child: J1ThemeBuilder(
        builder: (context, theme) => BlocSelector<SettingsBloc, SettingsState, Locale?>(
          selector: (state) => Strings.supportedLocales.firstWhereOrNull(
            (locale) => locale.languageCode.toLowerCase() == state.language,
          ),
          builder: (context, locale) => MaterialApp.router(
            onGenerateTitle: (context) => context.strings().app_title,
            localizationsDelegates: Strings.localizationsDelegates,
            supportedLocales: Strings.supportedLocales,
            locale: locale,
            routerConfig: _router,
            theme: theme,
            scrollBehavior: ScrollConfiguration.of(context).copyWith(
              physics: const ClampingScrollPhysics(),
            ),
          ),
        ),
      ),
    );
  }
}
