import "package:j1_theme/j1_theme.dart";

class ThemeRepository extends J1ThemeRepository {
  @override
  Stream<J1ColorScheme> getColorStream() {
    return const Stream.empty();
  }

  @override
  Stream<J1TextTheme> getTextStream() {
    return const Stream.empty();
  }

  @override
  Stream<J1PageTransition> getTransitionStream() {
    return const Stream.empty();
  }

  @override
  Future<void> setColorScheme(J1ColorScheme colorScheme) async {}

  @override
  Future<void> setPageTransition(J1PageTransition pageTransition) async {}

  @override
  Future<void> setTextTheme(J1TextTheme textTheme) async {}
}
