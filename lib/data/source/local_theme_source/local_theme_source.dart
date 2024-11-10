import "package:j1_theme/j1_theme.dart";

abstract class LocalThemeSource {
  Future<J1ColorScheme> getColorScheme();
  Future<void> updateColorScheme(J1ColorScheme colorScheme);

  Future<J1TextTheme> getTextTheme();
  Future<void> updateTextTheme(J1TextTheme textTheme);

  Future<J1PageTransition> getPageTransition();
  Future<void> updatePageTransition(J1PageTransition pageTransition);
}
