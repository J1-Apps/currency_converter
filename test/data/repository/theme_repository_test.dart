import "package:currency_converter/data/model/cc_error.dart";
import "package:currency_converter/data/repository/defaults.dart";
import "package:currency_converter/data/repository/theme_repository.dart";
import "package:currency_converter/data/source/local_theme_source/local_theme_source.dart";
import "package:flutter_test/flutter_test.dart";
import "package:j1_environment/j1_environment.dart";
import "package:mocktail/mocktail.dart";

import "../../testing_values.dart";

class MockLocalThemeSource extends Mock implements LocalThemeSource {}

void main() {
  group("Theme Repository", () {
    final localSource = MockLocalThemeSource();

    setUpAll(() {
      locator.registerSingleton<LocalThemeSource>(localSource);
      registerFallbackValue(defaultColorScheme);
      registerFallbackValue(defaultTextTheme);
      registerFallbackValue(defaultPageTransition);
    });

    tearDown(() {
      reset(localSource);
    });

    tearDownAll(() async {
      await locator.reset();
    });

    test("gets and updates color scheme, handling errors", () async {
      when(localSource.getColorScheme).thenThrow(const CcError(ErrorCode.source_local_theme_colorReadError));

      final repository = ThemeRepository();

      expect(
        repository.getColorStream(),
        emitsInOrder(
          [
            defaultColorScheme,
            colorScheme0,
            colorScheme1,
          ],
        ),
      );

      when(() => localSource.updateColorScheme(any())).thenThrow(
        const CcError(ErrorCode.source_local_theme_colorWriteError),
      );
      await repository.setColorScheme(colorScheme0);

      when(() => localSource.updateColorScheme(any())).thenAnswer((_) => Future.value());
      await repository.setColorScheme(colorScheme1);

      repository.dispose();
    });

    test("gets and updates text theme, handling errors", () async {
      when(localSource.getTextTheme).thenThrow(const CcError(ErrorCode.source_local_theme_textReadError));

      final repository = ThemeRepository();

      expect(
        repository.getTextStream(),
        emitsInOrder(
          [
            defaultTextTheme,
            textTheme0,
            textTheme1,
          ],
        ),
      );

      when(() => localSource.updateTextTheme(any())).thenThrow(
        const CcError(ErrorCode.source_local_theme_textWriteError),
      );
      await repository.setTextTheme(textTheme0);

      when(() => localSource.updateTextTheme(any())).thenAnswer((_) => Future.value());
      await repository.setTextTheme(textTheme1);

      repository.dispose();
    });

    test("gets and updates page transition, handling errors", () async {
      when(localSource.getPageTransition).thenThrow(const CcError(ErrorCode.source_local_theme_transitionReadError));

      final repository = ThemeRepository();

      expect(
        repository.getTransitionStream(),
        emitsInOrder(
          [
            defaultPageTransition,
            pageTransition0,
            defaultPageTransition,
          ],
        ),
      );

      when(() => localSource.updatePageTransition(any())).thenThrow(
        const CcError(ErrorCode.source_local_theme_transitionWriteError),
      );
      await repository.setPageTransition(pageTransition0);

      when(() => localSource.updatePageTransition(any())).thenAnswer((_) => Future.value());
      await repository.setPageTransition(defaultPageTransition);

      repository.dispose();
    });
  });
}
