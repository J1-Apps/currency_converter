import "dart:async";

import "package:currency_converter/model/configuration.dart";
import "package:currency_converter/model/currency.dart";
import "package:currency_converter/repository/app_storage_repository/app_storage_repository.dart";
import "package:currency_converter/repository/app_storage_repository/defaults.dart";
import "package:j1_theme/models/j1_color_scheme.dart";
import "package:j1_theme/models/j1_page_transition.dart";
import "package:j1_theme/models/j1_text_theme.dart";
import "package:rxdart/subjects.dart";

class LocalAppStorageRepository extends AppStorageRepository {
  Configuration? _configuration;
  final _colorSchemeController = BehaviorSubject<J1ColorScheme>.seeded(defaultColorScheme);
  final _textThemeController = BehaviorSubject<J1TextTheme>.seeded(defaultTextTheme);
  final _pageTransitionController = BehaviorSubject<J1PageTransition>.seeded(defaultPageTransition);
  final _favoritesController = BehaviorSubject<List<CurrencyCode>>.seeded(defaultFavorites);
  final _configurationsController = BehaviorSubject<List<Configuration>>.seeded(defaultConfigurations);
  final _languageController = BehaviorSubject<String>.seeded(defaultLanguage);

  @override
  Future<void> setColorScheme(J1ColorScheme colorScheme) async {
    _colorSchemeController.add(colorScheme);
  }

  @override
  Future<void> setTextTheme(J1TextTheme textTheme) async {
    _textThemeController.add(textTheme);
  }

  @override
  Future<void> setPageTransition(J1PageTransition pageTransition) async {
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
    _favoritesController.add({..._favoritesController.value, code}.toList());
  }

  @override
  Future<void> removeFavorite(CurrencyCode code) async {
    final updatedFavorites = _favoritesController.value;
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
    _configuration = configuration;
  }

  @override
  Future<void> saveConfiguration(Configuration configuration) async {
    _configurationsController.add({..._configurationsController.value, configuration}.toList());
  }

  @override
  Future<void> removeConfiguration(Configuration configuration) async {
    final updatedConfigurations = _configurationsController.value;
    updatedConfigurations.remove(configuration);
    _configurationsController.add(updatedConfigurations);
  }

  @override
  Stream<List<Configuration>> getConfigurationsStream() {
    return _configurationsController.stream;
  }

  @override
  Future<void> setLanguage(String languageCode) async {
    _languageController.add(languageCode);
  }

  @override
  Stream<String> getLanguagesStream() {
    return _languageController.stream;
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
