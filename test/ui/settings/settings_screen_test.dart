import "package:currency_converter/router.dart";
import "package:currency_converter/state/settings/settings_bloc.dart";
import "package:currency_converter/state/settings/settings_event.dart";
import "package:currency_converter/state/settings/settings_state.dart";
import "package:currency_converter/ui/settings/select_language_drawer.dart";
import "package:currency_converter/ui/settings/settings_screen.dart";
import "package:flutter/material.dart";
import "package:flutter_test/flutter_test.dart";
import "package:j1_environment/j1_environment.dart";
import "package:j1_router/j1_router.dart";
import "package:j1_ui/j1_ui.dart";
import "package:mocktail/mocktail.dart";
import "package:rxdart/subjects.dart";

import "../../testing_utils.dart";
import "../../testing_values.dart";

const _settingsState = SettingsState.loaded(language: testLanguage0);

void main() {
  group("Settings Screen", () {
    final SettingsBloc settingsBloc = MockSettingsBloc();
    final router = MockRouter();
    late BehaviorSubject<SettingsState> stateController;

    setUpAll(() {
      locator.registerSingleton<J1Router>(router);

      registerFallbackValue(const SettingsLoadEvent());
      registerFallbackValue(FakeBuildContext());
    });

    setUp(() {
      stateController = BehaviorSubject<SettingsState>.seeded(_settingsState);

      when(() => settingsBloc.stream).thenAnswer((_) => stateController.stream);
      when(() => settingsBloc.state).thenAnswer((_) => stateController.value);
      when(() => settingsBloc.add(any())).thenAnswer((_) => Future.value());
      when(settingsBloc.close).thenAnswer((_) => Future.value());

      when(() => router.navigate(any(), any())).thenAnswer((_) => Future.value());
      when(() => router.canPop(any())).thenAnswer((_) => true);
      when(() => router.pop(any())).thenAnswer((_) => Future.value());
    });

    tearDown(() {
      reset(settingsBloc);
      reset(router);
      stateController.close();
    });

    tearDownAll(() async {
      await locator.reset();
    });

    group("error messages", () {
      testWidgets("shows load language error message", (tester) async {
        await tester.pumpWidget(_TestWidget(settingsBloc));

        stateController.add(_settingsState.copyWith(error: SettingsErrorCode.loadLanguage));
        await tester.pumpAndSettle();

        expect(find.byType(SnackBar), findsOneWidget);
      });

      testWidgets("shows save language error message", (tester) async {
        await tester.pumpWidget(_TestWidget(settingsBloc));

        stateController.add(_settingsState.copyWith(error: SettingsErrorCode.saveLanguage));
        await tester.pumpAndSettle();

        expect(find.byType(SnackBar), findsOneWidget);
      });
    });

    group("user flows", () {
      testWidgets("navigates back", (tester) async {
        await tester.pumpWidget(_TestWidget(settingsBloc));
        await tester.tap(find.byIcon(JamIcons.chevronleft));
        await tester.pumpAndSettle();

        verify(() => router.pop(any())).called(1);
      });

      testWidgets("opens language drawer, filters, and selects", (tester) async {
        tester.view.physicalSize = const Size(720, 2000);
        tester.view.devicePixelRatio = 1.0;

        addTearDown(() => tester.view.resetPhysicalSize());
        addTearDown(() => tester.view.resetDevicePixelRatio());

        await tester.pumpWidget(_TestWidget(settingsBloc));
        await tester.tap(find.byIcon(JamIcons.language));
        await tester.pumpAndSettle();

        final searchFinder = find.byType(JTextField);
        final cardFinder = find.byType(SelectLanguageCard);
        expect(searchFinder, findsOneWidget);
        expect(cardFinder, findsAtLeastNWidgets(1));

        await tester.enterText(searchFinder, "invalid filter");
        await tester.pumpAndSettle();

        expect(cardFinder, findsNothing);

        await tester.enterText(searchFinder, "");
        await tester.pumpAndSettle();

        await tester.tap(cardFinder.at(1));
        verify(() => settingsBloc.add(any(that: isInstanceOf<SettingsUpdateLanguageEvent>()))).called(1);
      });
    });

    testWidgets("navigates to favorites", (tester) async {
      when(() => router.navigate(any(), any())).thenAnswer((_) => Future.value());

      await tester.pumpWidget(_TestWidget(settingsBloc));
      await tester.tap(find.byIcon(JamIcons.star));
      await tester.pumpAndSettle();

      verify(() => router.navigate(any(), CcRoute.favoritesRoute.build(const EmptyRouteConfig()))).called(1);
    });
  });
}

class _TestWidget extends StatelessWidget {
  final SettingsBloc bloc;

  const _TestWidget(this.bloc);

  @override
  Widget build(BuildContext context) {
    return TestWrapper<SettingsBloc>(
      globalBloc: bloc,
      child: const Scaffold(body: SettingsScreen()),
    );
  }
}
