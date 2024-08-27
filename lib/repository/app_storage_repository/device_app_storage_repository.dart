import "dart:async";

import "package:currency_converter/models/currency.dart";
import "package:currency_converter/repository/app_storage_repository/app_storage_repository.dart";
import "package:currency_converter/repository/app_storage_repository/realm/realm_color_scheme.dart";
import "package:currency_converter/repository/app_storage_repository/realm/realm_page_transition.dart";
import "package:currency_converter/repository/app_storage_repository/realm/realm_text_theme.dart";
import "package:currency_converter/repository/app_storage_repository/realm_catalog.dart";
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
    final colorSchemeRef = _realm.find<RealmColorScheme>(_settingsKey) ??
        _realm.write<RealmColorScheme>(
          () => _realm.add<RealmColorScheme>(
            RealmColorSchemeExtensions.fromColorScheme(_settingsKey, defaultColorScheme),
          ),
        );

    return colorSchemeRef.changes.map((changes) => changes.object.toColorScheme());
  }

  @override
  Stream<J1TextTheme> getTextStream() {
    final textThemeRef = _realm.find<RealmTextTheme>(_settingsKey) ??
        _realm.write<RealmTextTheme>(
          () => _realm.add<RealmTextTheme>(
            RealmTextThemeExtensions.fromTextTheme(_settingsKey, defaultTextTheme),
          ),
        );

    return textThemeRef.changes.map((changes) => changes.object.toTextTheme());
  }

  @override
  Stream<J1PageTransition> getTransitionStream() {
    final pageTransitionRef = _realm.find<RealmPageTransition>(_settingsKey) ??
        _realm.write<RealmPageTransition>(
          () => _realm.add<RealmPageTransition>(
            RealmPageTransitionExtensions.fromPageTransition(_settingsKey, J1PageTransition.cupertino),
          ),
        );

    return pageTransitionRef.changes.map((changes) => changes.object.toPageTransition());
  }

  @override
  Future<void> setFavorite(CurrencyCode code) {
    // TODO: implement setFavorite
    throw UnimplementedError();
  }

  @override
  Future<void> removeFavorite(CurrencyCode code) {
    // TODO: implement removeFavorite
    throw UnimplementedError();
  }

  @override
  Stream<List<CurrencyCode>> getFavoritesStream() {
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
