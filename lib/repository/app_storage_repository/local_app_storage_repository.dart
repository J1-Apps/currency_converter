import "dart:async";

import "package:currency_converter/repository/app_storage_repository/app_storage_repository.dart";
import "package:j1_theme/models/j1_color_scheme.dart";
import "package:j1_theme/models/j1_page_transition.dart";
import "package:j1_theme/models/j1_text_theme.dart";

class LocalAppStorageRepository extends AppStorageRepository {
  final _colorSchemeController = StreamController<J1ColorScheme>.broadcast();
  final _textThemeController = StreamController<J1TextTheme>.broadcast();
  final _pageTransitionController = StreamController<J1PageTransition>.broadcast();
  final _favoritesController = StreamController<List<String>>.broadcast();
  final _languageController = StreamController<String>.broadcast();

  List<String> _favorites = [];

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
  Future<void> setFavorite(String code) async {
    _favorites = {..._favorites, code}.toList();
    _favoritesController.add(_favorites);
  }

  @override
  Future<void> removeFavorite(String code) async {
    _favorites.remove(code);
    _favoritesController.add(_favorites);
  }

  @override
  Stream<List<String>> getFavoritesStream() {
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
