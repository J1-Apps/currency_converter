import "package:currency_converter/router.dart";
import "package:currency_converter/state/home/home_bloc.dart";
import "package:currency_converter/state/home/home_event.dart";
import "package:currency_converter/state/home/home_state.dart";
import "package:currency_converter/ui/home/home_error.dart";
import "package:currency_converter/ui/home/home_loading.dart";
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
import "package:rxdart/subjects.dart";

import "../../testing_utils.dart";
import "../../testing_values.dart";

final _homeState = HomeState.fromValues(
  configuration: testConfig0,
  exchange: testSnapshot0,
  favorites: testFavorites0,
  currencies: testCurrencies0,
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

    testWidgets("shows loading screen", (tester) async {
      final stateController = BehaviorSubject<HomeState>.seeded(const HomeState.loading());

      when(() => homeBloc.stream).thenAnswer((_) => stateController.stream);
      when(() => homeBloc.state).thenAnswer((_) => const HomeState.loading());

      await tester.pumpWidget(
        TestWrapper(
          child: BlocProvider(
            create: (_) => homeBloc,
            child: const HomeScreen(),
          ),
        ),
      );

      expect(find.byType(HomeLoading), findsOneWidget);

      stateController.add(_homeState);
      await tester.pumpAndSettle();

      expect(find.byIcon(JamIcons.refresh), findsOneWidget);
      expect(find.byIcon(JamIcons.settings), findsOneWidget);

      stateController.close();
    });

    testWidgets("shows error screen", (tester) async {
      final stateController = BehaviorSubject<HomeState>.seeded(const HomeState.error());

      when(() => homeBloc.stream).thenAnswer((_) => stateController.stream);
      when(() => homeBloc.state).thenAnswer((_) => const HomeState.error());

      await tester.pumpWidget(
        TestWrapper(
          child: BlocProvider(
            create: (_) => homeBloc,
            child: const HomeScreen(),
          ),
        ),
      );

      expect(find.byType(HomeError), findsOneWidget);

      when(() => homeBloc.add(const HomeLoadEvent())).thenAnswer((_) => Future.value());

      await tester.tap(find.byType(JTextButton));

      verify(() => homeBloc.add(const HomeLoadEvent())).called(1);

      stateController.add(_homeState);
      await tester.pumpAndSettle();

      expect(find.byIcon(JamIcons.refresh), findsOneWidget);
      expect(find.byIcon(JamIcons.settings), findsOneWidget);

      stateController.close();
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

      when(() => homeBloc.add(const HomeRefreshEvent())).thenAnswer((_) => Future.value());

      await tester.tap(find.byIcon(JamIcons.refresh));

      verify(() => homeBloc.add(const HomeRefreshEvent())).called(1);
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
