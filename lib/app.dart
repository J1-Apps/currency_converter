import "package:currency_converter/router.dart";
import "package:currency_converter/ui/screens/themes/color_schemes.dart";
import "package:currency_converter/ui/screens/themes/text_themes.dart";
import "package:currency_converter/util/extensions/build_context_extensions.dart";
import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:flutter_gen/gen_l10n/app_localizations.dart";
import "package:j1_theme/j1_theme.dart";

class CurrencyConverterApp extends StatelessWidget {
  const CurrencyConverterApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => J1ThemeBloc(
            defaultColorScheme: defaultColorScheme,
            defaultTextTheme: defaultTextTheme,
          ),
        )
      ],
      child: J1ThemeBuilder(
        builder: (context, theme) => MaterialApp.router(
          onGenerateTitle: (context) => context.strings().app_title,
          localizationsDelegates: Strings.localizationsDelegates,
          supportedLocales: Strings.supportedLocales,
          routerConfig: routeGraph.buildConfig(),
          theme: theme,
          scrollBehavior: ScrollConfiguration.of(context).copyWith(
            physics: const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
          ),
        ),
      ),
    );
  }
}
