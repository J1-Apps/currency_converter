import "dart:async";

import "package:currency_converter/repository/app_storage_repository/app_storage_repository.dart";
import "package:j1_theme/models/j1_color_scheme.dart";
import "package:j1_theme/models/j1_page_transition.dart";
import "package:j1_theme/models/j1_text_theme.dart";

const _colorSchemeKey = "ccColorScheme";
const _textThemeKey = "ccTextTheme";
const _pageTransitionKey = "ccPageTransition";

class DeviceAppStorageRepository extends AppStorageRepository {
  DeviceAppStorageRepository();

  @override
  Future<void> setColorScheme(J1ColorScheme colorScheme) async {}

  @override
  Future<void> setTextTheme(J1TextTheme textTheme) async {}

  @override
  Future<void> setPageTransition(J1PageTransition pageTransition) async {}

  @override
  Stream<J1ColorScheme> getColorStream() {
    // TODO: implement getColorStream
    throw UnimplementedError();
  }

  @override
  Stream<J1TextTheme> getTextStream() {
    // TODO: implement getTextStream
    throw UnimplementedError();
  }

  @override
  Stream<J1PageTransition> getTransitionStream() {
    // TODO: implement getTransitionStream
    throw UnimplementedError();
  }

  @override
  Future<void> setFavorite(String code) {
    // TODO: implement setFavorite
    throw UnimplementedError();
  }

  @override
  Future<void> removeFavorite(String code) {
    // TODO: implement removeFavorite
    throw UnimplementedError();
  }

  @override
  Stream<List<String>> getFavoritesStream() {
    // TODO: implement listenFavorites
    throw UnimplementedError();
  }

  @override
  Future<void> setLanguage(String languageCode) {
    // TODO: implement setLanguage
    throw UnimplementedError();
  }

  @override
  Stream<String> getLanguagesStream() {
    // TODO: implement listenLanguages
    throw UnimplementedError();
  }
}
