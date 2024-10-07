import "package:currency_converter/router.dart";
import "package:currency_converter/state/home/home_bloc.dart";
import "package:currency_converter/state/home/home_state.dart";
import "package:currency_converter/ui/home/home_screen.dart";
import "package:currency_converter/ui/settings/settings_screen.dart";
import "package:flutter/material.dart";
import "package:flutter_gen/gen_l10n/app_localizations.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:flutter_test/flutter_test.dart";
import "package:j1_environment/j1_environment.dart";
import "package:j1_router/j1_router.dart";
import "package:j1_ui/j1_ui.dart";
import "package:mocktail/mocktail.dart";

import "../../testing_utils.dart";
import "../../testing_values.dart";

final _homeState = HomeState(
  status: HomeStatus.loaded,
  configuration: testConfig0,
  snapshot: testSnapshot0,
);

void main() {
  group("Home Screen", () {
    final HomeBloc homeBloc = MockHomeBloc();

    setUp(() {
      when(() => homeBloc.stream).thenAnswer((_) => Stream.value(_homeState));
      when(() => homeBloc.state).thenAnswer((_) => _homeState);
      when(homeBloc.close).thenAnswer((_) => Future.value());
    });

    tearDown(() {
      reset(homeBloc);
    });

    testWidgets("shows refresh and settings buttons", (tester) async {
      await tester.pumpWidget(
        TestWrapper(
          child: BlocProvider(
            create: (_) => homeBloc,
            child: const HomeScreen(),
          ),
        ),
      );

      expect(find.byIcon(JamIcons.refresh), findsOneWidget);
      expect(find.byIcon(JamIcons.settings), findsOneWidget);
    });

    testWidgets("navigates to settings", (tester) async {
      locator.registerSingleton<J1Router>(GoRouter());

      await tester.pumpWidget(
        BlocProvider(
          create: (_) => homeBloc,
          child: MaterialApp.router(
            localizationsDelegates: Strings.localizationsDelegates,
            supportedLocales: Strings.supportedLocales,
            routerConfig: routeGraph.buildConfig(),
          ),
        ),
      );
      await tester.tap(find.byIcon(JamIcons.settings));
      await tester.pumpAndSettle();

      expect(find.byType(SettingsScreen), findsOneWidget);

      await locator.reset();
    });
  });
}
