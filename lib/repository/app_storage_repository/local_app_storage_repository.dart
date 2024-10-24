import "dart:async";

import "package:currency_converter/model/configuration.dart";
import "package:currency_converter/model/currency.dart";
import "package:currency_converter/repository/app_storage_repository/app_storage_repository.dart";
import "package:currency_converter/repository/app_storage_repository/defaults.dart";
import "package:currency_converter/model/cc_error.dart";
import "package:j1_theme/models/j1_color_scheme.dart";
import "package:j1_theme/models/j1_page_transition.dart";
import "package:j1_theme/models/j1_text_theme.dart";
import "package:rxdart/subjects.dart";

class LocalAppStorageRepository extends AppStorageRepository {
  Configuration? _configuration;
  var _colorSchemeController = BehaviorSubject<J1ColorScheme>.seeded(defaultColorScheme);
  var _textThemeController = BehaviorSubject<J1TextTheme>.seeded(defaultTextTheme);
  var _pageTransitionController = BehaviorSubject<J1PageTransition>.seeded(defaultPageTransition);
  var _favoritesController = BehaviorSubject<List<CurrencyCode>>.seeded(defaultFavorites);
  var _configurationsController = BehaviorSubject<List<Configuration>>.seeded(defaultConfigurations);
  var _languageController = BehaviorSubject<String>.seeded(defaultLanguage);

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

  @override
  Future<void> setFavorite(CurrencyCode code) async {
    await Future.delayed(Duration(milliseconds: _msDelay));

    if (_shouldThrow) {
      throw const CcError(ErrorCode.source_appStorage_writeError);
    }

    _favoritesController.add([..._favoritesController.value, code]);
  }

  @override
  Future<void> removeFavorite(CurrencyCode code) async {
    final updatedFavorites = [..._favoritesController.value];
    updatedFavorites.remove(code);
    _favoritesController.add(updatedFavorites);
  }

  @override
  Stream<List<CurrencyCode>> getFavoritesStream() {
    return _favoritesController.stream;
  }

  @override
  Future<Configuration?> getCurrentConfiguration() async {
    return _configuration;
  }

  @override
  Future<void> updateCurrentConfiguration(Configuration configuration) async {
    await Future.delayed(Duration(milliseconds: _msDelay));

    if (_shouldThrow) {
      throw const CcError(ErrorCode.source_appStorage_writeError);
    }

    _configuration = configuration;
  }

  @override
  Future<void> saveConfiguration(Configuration configuration) async {
    await Future.delayed(Duration(milliseconds: _msDelay));

    if (_shouldThrow) {
      throw const CcError(ErrorCode.source_appStorage_writeError);
    }

    _configurationsController.add([..._configurationsController.value, configuration]);
  }

  @override
  Future<void> removeConfiguration(Configuration configuration) async {
    await Future.delayed(Duration(milliseconds: _msDelay));

    if (_shouldThrow) {
      throw const CcError(ErrorCode.source_appStorage_writeError);
    }

    final updatedConfigurations = [..._configurationsController.value];
    updatedConfigurations.remove(configuration);
    _configurationsController.add(updatedConfigurations);
  }

  @override
  Stream<List<Configuration>> getConfigurationsStream() {
    return _configurationsController.stream;
  }

  @override
  Future<void> setLanguage(String languageCode) async {
    await Future.delayed(Duration(milliseconds: _msDelay));

    if (_shouldThrow) {
      throw const CcError(ErrorCode.source_appStorage_writeError);
    }

    _languageController.add(languageCode);
  }

  @override
  Stream<String> getLanguagesStream() {
    return _languageController.stream;
  }

  void reset() {
    _colorSchemeController = BehaviorSubject<J1ColorScheme>.seeded(defaultColorScheme);
    _textThemeController = BehaviorSubject<J1TextTheme>.seeded(defaultTextTheme);
    _pageTransitionController = BehaviorSubject<J1PageTransition>.seeded(defaultPageTransition);
    _favoritesController = BehaviorSubject<List<CurrencyCode>>.seeded(defaultFavorites);
    _configurationsController = BehaviorSubject<List<Configuration>>.seeded(defaultConfigurations);
    _languageController = BehaviorSubject<String>.seeded(defaultLanguage);
  }

  void dispose() {
    _colorSchemeController.close();
    _textThemeController.close();
    _pageTransitionController.close();
    _favoritesController.close();
    _configurationsController.close();
    _languageController.close();
  }
}
