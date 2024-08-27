import "dart:async";

import "package:currency_converter/models/currency.dart";
import "package:currency_converter/repository/app_storage_repository/app_storage_repository.dart";
import "package:currency_converter/ui/themes/color_schemes.dart";
import "package:currency_converter/ui/themes/text_themes.dart";
import "package:j1_theme/models/j1_color_scheme.dart";
import "package:j1_theme/models/j1_page_transition.dart";
import "package:j1_theme/models/j1_text_theme.dart";
import "package:rxdart/subjects.dart";

class LocalAppStorageRepository extends AppStorageRepository {
  final _colorSchemeController = BehaviorSubject<J1ColorScheme>.seeded(defaultColorScheme);
  final _textThemeController = BehaviorSubject<J1TextTheme>.seeded(defaultTextTheme);
  final _pageTransitionController = BehaviorSubject<J1PageTransition>.seeded(J1PageTransition.cupertino);
  final _favoritesController = BehaviorSubject<List<CurrencyCode>>.seeded([]);
  final _languageController = BehaviorSubject<String>.seeded("en");

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
    _languageController.close();
  }
}
