import "package:currency_converter/model/cc_error.dart";
import "package:currency_converter/repository/defaults.dart";
import "package:currency_converter/source/local_theme_source/preferences_local_theme_source.dart";
import "package:flutter_test/flutter_test.dart";
import "package:j1_theme/j1_theme.dart";
import "package:mocktail/mocktail.dart";

import "../../testing_utils.dart";
import "../../testing_values.dart";

void main() {
  group("Preferences Local Theme Source", () {
    final preferences = MockSharedPreferences();

    tearDown(() {
      reset(preferences);
    });

    test("gets and sets color scheme", () async {
      when(() => preferences.setString("ccColorScheme", any())).thenAnswer((_) => Future.value());

      final source = PreferencesLocalThemeSource(preferences: preferences);

      when(() => preferences.getString("ccColorScheme")).thenAnswer((_) => Future.value());

      expect(await source.getColorScheme(), defaultColorScheme);
      await source.updateColorScheme(colorScheme0);

      when(() => preferences.getString("ccColorScheme")).thenAnswer((_) => Future.value(colorScheme0.toJson()));

      expect(await source.getColorScheme(), colorScheme0);
    });

    test("handles get color scheme error", () async {
      when(() => preferences.getString("ccColorScheme")).thenThrow(StateError("test error"));

      final repository = PreferencesLocalThemeSource(preferences: preferences);

      expect(
        () async => repository.getColorScheme(),
        throwsA(HasErrorCode(ErrorCode.source_local_theme_colorReadError)),
      );
    });

    test("handles set color scheme error", () async {
      when(() => preferences.setString("ccColorScheme", any())).thenThrow(StateError("test error"));

      final repository = PreferencesLocalThemeSource(preferences: preferences);

      expect(
        () async => repository.updateColorScheme(colorScheme0),
        throwsA(HasErrorCode(ErrorCode.source_local_theme_colorWriteError)),
      );
    });

    test("gets and sets text theme", () async {
      when(() => preferences.setString("ccTextTheme", any())).thenAnswer((_) => Future.value());

      final source = PreferencesLocalThemeSource(preferences: preferences);

      when(() => preferences.getString("ccTextTheme")).thenAnswer((_) => Future.value());

      expect(await source.getTextTheme(), defaultTextTheme);
      await source.updateTextTheme(textTheme0);

      when(() => preferences.getString("ccTextTheme")).thenAnswer((_) => Future.value(textTheme0.toJson()));

      expect(await source.getTextTheme(), textTheme0);
    });

    test("handles get text theme error", () async {
      when(() => preferences.getString("ccTextTheme")).thenThrow(StateError("test error"));

      final repository = PreferencesLocalThemeSource(preferences: preferences);

      expect(
        () async => repository.getTextTheme(),
        throwsA(HasErrorCode(ErrorCode.source_local_theme_textReadError)),
      );
    });

    test("handles set text theme error", () async {
      when(() => preferences.setString("ccTextTheme", any())).thenThrow(StateError("test error"));

      final repository = PreferencesLocalThemeSource(preferences: preferences);

      expect(
        () async => repository.updateTextTheme(textTheme0),
        throwsA(HasErrorCode(ErrorCode.source_local_theme_textWriteError)),
      );
    });

    test("gets and sets page transition", () async {
      when(() => preferences.setString("ccPageTransition", any())).thenAnswer((_) => Future.value());

      final source = PreferencesLocalThemeSource(preferences: preferences);

      when(() => preferences.getString("ccPageTransition")).thenAnswer((_) => Future.value());

      expect(await source.getPageTransition(), defaultPageTransition);
      await source.updatePageTransition(pageTransition0);

      when(() => preferences.getString("ccPageTransition")).thenAnswer((_) => Future.value(pageTransition0.toValue()));

      expect(await source.getPageTransition(), pageTransition0);
    });

    test("handles get page transition error", () async {
      when(() => preferences.getString("ccPageTransition")).thenThrow(StateError("test error"));

      final repository = PreferencesLocalThemeSource(preferences: preferences);

      expect(
        () async => repository.getPageTransition(),
        throwsA(HasErrorCode(ErrorCode.source_local_theme_transitionReadError)),
      );
    });

    test("handles set page transition error", () async {
      when(() => preferences.setString("ccPageTransition", any())).thenThrow(StateError("test error"));

      final repository = PreferencesLocalThemeSource(preferences: preferences);

      expect(
        () async => repository.updatePageTransition(pageTransition0),
        throwsA(HasErrorCode(ErrorCode.source_local_theme_transitionWriteError)),
      );
    });
  });
}
