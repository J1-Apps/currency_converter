import "dart:async";

import "package:currency_converter/model/configuration.dart";
import "package:currency_converter/repository/app_storage_repository/app_storage_repository.dart";
import "package:currency_converter/repository/app_storage_repository/defaults.dart";
import "package:currency_converter/model/cc_error.dart";
import "package:j1_theme/models/j1_color_scheme.dart";
import "package:j1_theme/models/j1_page_transition.dart";
import "package:j1_theme/models/j1_text_theme.dart";
import "package:rxdart/subjects.dart";

class LocalAppStorageRepository extends AppStorageRepository {
  var _colorSchemeController = BehaviorSubject<J1ColorScheme>.seeded(defaultColorScheme);
  var _textThemeController = BehaviorSubject<J1TextTheme>.seeded(defaultTextTheme);
  var _pageTransitionController = BehaviorSubject<J1PageTransition>.seeded(defaultPageTransition);
  var _configurationsController = BehaviorSubject<List<Configuration>>.seeded(defaultConfigurations);

  final _msDelay = 100;
  final _shouldThrow = false;

  int msDelay = 1;
  bool shouldThrow = false;

  @override
  Future<void> setColorScheme(J1ColorScheme colorScheme) async {
    await Future.delayed(Duration(milliseconds: _msDelay));

    if (_shouldThrow) {
      throw const CcError(ErrorCode.source_appStorage_writeError);
    }

    _colorSchemeController.add(colorScheme);
  }

  @override
  Future<void> setTextTheme(J1TextTheme textTheme) async {
    await Future.delayed(Duration(milliseconds: _msDelay));

    if (_shouldThrow) {
      throw const CcError(ErrorCode.source_appStorage_writeError);
    }

    _textThemeController.add(textTheme);
  }

  @override
  Future<void> setPageTransition(J1PageTransition pageTransition) async {
    await Future.delayed(Duration(milliseconds: _msDelay));

    if (_shouldThrow) {
      throw const CcError(ErrorCode.source_appStorage_writeError);
    }

    _pageTransitionController.add(pageTransition);
  }

  @override
  Stream<J1ColorScheme> getColorStream() {
    return _colorSchemeController.stream;
  }

  @override
  Stream<J1TextTheme> getTextStream() {
    return _textThemeController.stream;
  }

  @override
  Stream<J1PageTransition> getTransitionStream() {
    return _pageTransitionController.stream;
  }

  void reset() {
    _colorSchemeController = BehaviorSubject<J1ColorScheme>.seeded(defaultColorScheme);
    _textThemeController = BehaviorSubject<J1TextTheme>.seeded(defaultTextTheme);
    _pageTransitionController = BehaviorSubject<J1PageTransition>.seeded(defaultPageTransition);
    _configurationsController = BehaviorSubject<List<Configuration>>.seeded(defaultConfigurations);
  }

  void dispose() {
    _colorSchemeController.close();
    _textThemeController.close();
    _pageTransitionController.close();
    _configurationsController.close();
  }
}
