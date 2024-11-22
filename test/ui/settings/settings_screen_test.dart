import "package:currency_converter/state/settings/settings_bloc.dart";
import "package:currency_converter/state/settings/settings_event.dart";
import "package:currency_converter/state/settings/settings_state.dart";
import "package:currency_converter/ui/settings/settings_screen.dart";
import "package:flutter/material.dart";
import "package:flutter_test/flutter_test.dart";
import "package:j1_environment/j1_environment.dart";
import "package:j1_router/j1_router.dart";
import "package:j1_ui/icons/jam_icons.dart";
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

    group("user flows", () {
      testWidgets("navigates back", (tester) async {
        await tester.pumpWidget(_TestWidget(settingsBloc));
        await tester.tap(find.byIcon(JamIcons.chevronleft));
        await tester.pumpAndSettle();

        verify(() => router.pop(any())).called(1);
      });
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
