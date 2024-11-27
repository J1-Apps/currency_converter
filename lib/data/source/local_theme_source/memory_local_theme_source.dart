import "package:currency_converter/data/model/cc_error.dart";
import "package:currency_converter/data/repository/defaults.dart";
import "package:currency_converter/data/source/local_theme_source/local_theme_source.dart";
import "package:currency_converter/data/source/util/memory_source.dart";
import "package:currency_converter/ui/theme/cc_color_scheme.dart";
import "package:currency_converter/ui/theme/cc_text_theme.dart";
import "package:j1_theme/j1_theme.dart";

class MemoryLocalThemeSource extends MemorySource implements LocalThemeSource {
  J1ColorScheme _colorScheme = CcColorScheme.light;
  J1TextTheme _textTheme = CcTextTheme.initial;
  J1PageTransition _pageTransition = defaultPageTransition;

  MemoryLocalThemeSource({super.initialShouldThrow, super.initialMsDelay});

  @override
  Future<J1ColorScheme> getColorScheme() {
    return wrapRequest(Future.value(_colorScheme), ErrorCode.source_local_theme_colorReadError);
  }

  @override
  Future<void> updateColorScheme(J1ColorScheme colorScheme) async {
    await wrapRequest(Future(() => _colorScheme = colorScheme), ErrorCode.source_local_theme_colorWriteError);
  }

  @override
  Future<J1TextTheme> getTextTheme() {
    return wrapRequest(Future.value(_textTheme), ErrorCode.source_local_theme_textReadError);
  }

  @override
  Future<void> updateTextTheme(J1TextTheme textTheme) async {
    await wrapRequest(Future(() => _textTheme = textTheme), ErrorCode.source_local_theme_textWriteError);
  }

  @override
  Future<J1PageTransition> getPageTransition() {
    return wrapRequest(Future.value(_pageTransition), ErrorCode.source_local_theme_transitionReadError);
  }

  @override
  Future<void> updatePageTransition(J1PageTransition pageTransition) async {
    await wrapRequest(
      Future(() => _pageTransition = pageTransition),
      ErrorCode.source_local_theme_transitionWriteError,
    );
  }
}
