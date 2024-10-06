import "package:currency_converter/repository/app_storage_repository/defaults.dart";
import "package:currency_converter/router.dart";
import "package:currency_converter/state/home/home_bloc.dart";
import "package:currency_converter/state/settings/settings_bloc.dart";
import "package:currency_converter/ui/extensions/build_context_extensions.dart";
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
            defaultColorScheme: defaultColorScheme,
            defaultTextTheme: defaultTextTheme,
          ),
        ),
        BlocProvider<HomeBloc>(create: (_) => HomeBloc()),
        BlocProvider<SettingsBloc>(create: (_) => SettingsBloc()),
      ],
      child: J1ThemeBuilder(
        builder: (context, theme) => MaterialApp.router(
          onGenerateTitle: (context) => context.strings().app_title,
          localizationsDelegates: Strings.localizationsDelegates,
          supportedLocales: Strings.supportedLocales,
          routerConfig: _router,
          theme: theme,
          scrollBehavior: ScrollConfiguration.of(context).copyWith(
            physics: const ClampingScrollPhysics(),
          ),
        ),
      ),
    );
  }
}
