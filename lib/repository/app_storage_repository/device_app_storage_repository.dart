import "dart:async";

import "package:currency_converter/models/currency.dart";
import "package:currency_converter/repository/app_storage_repository/app_storage_repository.dart";
import "package:currency_converter/repository/app_storage_repository/realm/realm_color_scheme.dart";
import "package:currency_converter/repository/app_storage_repository/realm/realm_favorites.dart";
import "package:currency_converter/repository/app_storage_repository/realm/realm_language.dart";
import "package:currency_converter/repository/app_storage_repository/realm/realm_page_transition.dart";
import "package:currency_converter/repository/app_storage_repository/realm/realm_text_theme.dart";
import "package:currency_converter/ui/themes/color_schemes.dart";
import "package:currency_converter/ui/themes/text_themes.dart";
import "package:j1_theme/models/j1_color_scheme.dart";
import "package:j1_theme/models/j1_page_transition.dart";
import "package:j1_theme/models/j1_text_theme.dart";
import "package:realm/realm.dart";

const _settingsKey = "settingsKey";

class DeviceAppStorageRepository extends AppStorageRepository {
  final Realm _realm;

  DeviceAppStorageRepository({Realm? realm})
      : _realm = realm ??
            Realm(
              Configuration.local(
                [
                  RealmColorScheme.schema,
                  RealmTextTheme.schema,
                  RealmTextStyle.schema,
                  RealmPageTransition.schema,
                  RealmFavorites.schema,
                  RealmLanguage.schema,
                ],
              ),
            );

  @override
  Future<void> setColorScheme(J1ColorScheme colorScheme) async {
    await _realm.writeAsync<RealmColorScheme>(
      () => _realm.add<RealmColorScheme>(
        RealmColorSchemeExtensions.fromColorScheme(_settingsKey, colorScheme),
      ),
    );
  }

  @override
  Future<void> setTextTheme(J1TextTheme textTheme) async {
    await _realm.writeAsync<RealmTextTheme>(
      () => _realm.add<RealmTextTheme>(
        RealmTextThemeExtensions.fromTextTheme(_settingsKey, textTheme),
      ),
    );
  }

  @override
  Future<void> setPageTransition(J1PageTransition pageTransition) async {
    await _realm.writeAsync<RealmPageTransition>(
      () => _realm.add<RealmPageTransition>(
        RealmPageTransitionExtensions.fromPageTransition(_settingsKey, pageTransition),
      ),
    );
  }

  @override
  Stream<J1ColorScheme> getColorStream() {
    final colorSchemeRef = _getRealm<RealmColorScheme>(
      RealmColorSchemeExtensions.fromColorScheme(_settingsKey, defaultColorScheme),
    );

    return colorSchemeRef.changes.map((changes) => changes.object.toColorScheme());
  }

  @override
  Stream<J1TextTheme> getTextStream() {
    final textThemeRef = _getRealm<RealmTextTheme>(
      RealmTextThemeExtensions.fromTextTheme(_settingsKey, defaultTextTheme),
    );

    return textThemeRef.changes.map((changes) => changes.object.toTextTheme());
  }

  @override
  Stream<J1PageTransition> getTransitionStream() {
    final pageTransitionRef = _getRealm<RealmPageTransition>(
      RealmPageTransitionExtensions.fromPageTransition(_settingsKey, J1PageTransition.cupertino),
    );

    return pageTransitionRef.changes.map((changes) => changes.object.toPageTransition());
  }

  @override
  Future<void> setFavorite(CurrencyCode code) async {
    final favorites = _realm.find<RealmFavorites>(_settingsKey)?.toFavorites() ?? [];
    await _realm.writeAsync<RealmFavorites>(
      () => _realm.add<RealmFavorites>(
        RealmFavoritesExtensions.fromFavorites(_settingsKey, {...favorites, code}.toList()),
      ),
    );
  }

  @override
  Future<void> removeFavorite(CurrencyCode code) async {
    final favorites = _realm.find<RealmFavorites>(_settingsKey)?.toFavorites() ?? [];
    favorites.remove(code);
    await _realm.writeAsync<RealmFavorites>(
      () => _realm.add<RealmFavorites>(
        RealmFavoritesExtensions.fromFavorites(_settingsKey, favorites),
      ),
    );
  }

  @override
  Stream<List<CurrencyCode>> getFavoritesStream() {
    final favoritesRef = _getRealm<RealmFavorites>(RealmFavoritesExtensions.fromFavorites(_settingsKey, const []));
    return favoritesRef.changes.map((changes) => changes.object.toFavorites());
  }

  @override
  Future<void> setLanguage(String languageCode) async {
    await _realm.writeAsync<RealmLanguage>(
      () => _realm.add<RealmLanguage>(
        RealmLanguageExtensions.fromLanguage(_settingsKey, languageCode),
      ),
    );
  }

  @override
  Stream<String> getLanguagesStream() {
    final languageRef = _getRealm<RealmLanguage>(RealmLanguageExtensions.fromLanguage(_settingsKey, "en"));
    return languageRef.changes.map((changes) => changes.object.toLanguage());
  }

  T _getRealm<T extends RealmObject>(T defaultValue) {
    return _realm.find<T>(_settingsKey) ?? _realm.write<T>(() => _realm.add<T>(defaultValue));
  }
}
