import "package:currency_converter/repository/app_storage_repository/app_storage_repository.dart";
import "package:j1_theme/models/j1_color_scheme.dart";
import "package:j1_theme/models/j1_page_transition.dart";
import "package:j1_theme/models/j1_text_theme.dart";

class DeviceAppStorageRepository extends AppStorageRepository {
  @override
  Future<void> setColorScheme(J1ColorScheme colorScheme) {
    // TODO: implement setColorScheme
    throw UnimplementedError();
  }

  @override
  Future<void> setTextTheme(J1TextTheme textTheme) {
    // TODO: implement setTextTheme
    throw UnimplementedError();
  }

  @override
  Future<void> setPageTransition(J1PageTransition pageTransition) {
    // TODO: implement setPageTransition
    throw UnimplementedError();
  }

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
