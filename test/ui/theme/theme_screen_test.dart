import "package:currency_converter/ui/theme/cc_color_scheme.dart";
import "package:currency_converter/ui/theme/cc_text_theme.dart";
import "package:currency_converter/ui/theme/theme_screen.dart";
import "package:flutter/material.dart";
import "package:flutter_test/flutter_test.dart";
import "package:j1_environment/j1_environment.dart";
import "package:j1_router/j1_router.dart";
import "package:j1_theme/j1_theme.dart";
import "package:j1_ui/j1_ui.dart";
import "package:mocktail/mocktail.dart";
import "package:rxdart/rxdart.dart";

import "../../testing_utils.dart";

final _themeState = J1ThemeState(
  colorScheme: CcColorScheme.light.scheme,
  textTheme: CcTextTheme.initial,
);

void main() {
  group("Theme Screen", () {
    final J1ThemeBloc bloc = MockThemeBloc();
    final router = MockRouter();
    late BehaviorSubject<J1ThemeState> stateController;

    setUpAll(() {
      locator.registerSingleton<J1Router>(router);

      registerFallbackValue(const UpdateTextThemeEvent(CcTextTheme.initial));
      registerFallbackValue(FakeBuildContext());
    });

    setUp(() {
      stateController = BehaviorSubject<J1ThemeState>.seeded(_themeState);

      when(() => bloc.stream).thenAnswer((_) => stateController.stream);
      when(() => bloc.state).thenAnswer((_) => stateController.value);
      when(() => bloc.add(any())).thenAnswer((_) => Future.value());
      when(bloc.close).thenAnswer((_) => Future.value());

      when(() => router.navigate(any(), any())).thenAnswer((_) => Future.value());
      when(() => router.canPop(any())).thenAnswer((_) => true);
      when(() => router.pop(any())).thenAnswer((_) => Future.value());
    });

    tearDown(() {
      reset(bloc);
      reset(router);
      stateController.close();
    });

    tearDownAll(() async {
      await locator.reset();
    });

    group("user flows", () {
      testWidgets("navigates back", (tester) async {
        await tester.pumpWidget(_TestWidget(bloc));
        await tester.tap(find.byIcon(JamIcons.chevronleft));
        await tester.pumpAndSettle();

        verify(() => router.pop(any())).called(1);
      });

      testWidgets("updates colors", (tester) async {
        tester.view.physicalSize = const Size(720, 2000);
        tester.view.devicePixelRatio = 1.0;

        addTearDown(() => tester.view.resetPhysicalSize());
        addTearDown(() => tester.view.resetDevicePixelRatio());

        await tester.pumpWidget(_TestWidget(bloc));
        await tester.tap(find.byType(JThemeCard).first);
        await tester.pumpAndSettle();

        verify(() => bloc.add(any(that: isInstanceOf<UpdateColorSchemeEvent>()))).called(1);
      });

      testWidgets("updates header font", (tester) async {
        tester.view.physicalSize = const Size(720, 2000);
        tester.view.devicePixelRatio = 1.0;

        addTearDown(() => tester.view.resetPhysicalSize());
        addTearDown(() => tester.view.resetDevicePixelRatio());

        await tester.pumpWidget(_TestWidget(bloc));
        await tester.tap(find.byType(JFontCard).first);
        await tester.pumpAndSettle();

        verify(() => bloc.add(any(that: isInstanceOf<UpdateTextThemeEvent>()))).called(1);
      });

      testWidgets("updates body font", (tester) async {
        tester.view.physicalSize = const Size(720, 2000);
        tester.view.devicePixelRatio = 1.0;

        addTearDown(() => tester.view.resetPhysicalSize());
        addTearDown(() => tester.view.resetDevicePixelRatio());

        await tester.pumpWidget(_TestWidget(bloc));
        await tester.tap(find.byType(JFontCard).last);
        await tester.pumpAndSettle();

        verify(() => bloc.add(any(that: isInstanceOf<UpdateTextThemeEvent>()))).called(1);
      });
    });
  });
}

class _TestWidget extends StatelessWidget {
  final J1ThemeBloc bloc;

  const _TestWidget(this.bloc);

  @override
  Widget build(BuildContext context) {
    return TestWrapper<J1ThemeBloc>(
      globalBloc: bloc,
      child: const Scaffold(body: ThemeScreen()),
    );
  }
}
