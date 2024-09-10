import "dart:async";

import "package:currency_converter/model/currency.dart";
import "package:currency_converter/repository/app_storage_repository/app_storage_repository.dart";
import "package:currency_converter/repository/app_storage_repository/realm/realm_color_scheme.dart";
import "package:currency_converter/repository/app_storage_repository/realm/realm_favorites.dart";
import "package:currency_converter/repository/app_storage_repository/realm/realm_language.dart";
import "package:currency_converter/repository/app_storage_repository/realm/realm_page_transition.dart";
import "package:currency_converter/repository/app_storage_repository/realm/realm_text_theme.dart";
import "package:currency_converter/ui/theme/color_schemes.dart";
import "package:currency_converter/ui/theme/text_themes.dart";
import "package:j1_theme/models/j1_color_scheme.dart";
import "package:j1_theme/models/j1_page_transition.dart";
import "package:j1_theme/models/j1_text_theme.dart";
import "package:realm/realm.dart";

const _settingsKey = "settingsKey";

final _defaultColorScheme = RealmColorSchemeExtensions.fromColorScheme(
  _settingsKey,
  defaultColorScheme,
);

final _defaultTextTheme = RealmTextThemeExtensions.fromTextTheme(
  _settingsKey,
  defaultTextTheme,
);

final _defaultPageTransition = RealmPageTransitionExtensions.fromPageTransition(
  _settingsKey,
  J1PageTransition.cupertino,
);

final _defaultFavorites = RealmFavoritesExtensions.fromFavorites(
  _settingsKey,
  const [],
);

final _defaultLanguage = RealmLanguageExtensions.fromLanguage(
  _settingsKey,
  "en",
);

class DeviceAppStorageRepository extends AppStorageRepository {
  final Realm _realm;

  // coverage:ignore-start
  DeviceAppStorageRepository({Realm? realm})
      : _realm = realm ??
            Realm(Configuration.local([
              RealmColorScheme.schema,
              RealmTextTheme.schema,
              RealmTextStyle.schema,
              RealmPageTransition.schema,
              RealmFavorites.schema,
              RealmLanguage.schema,
            ]));
  // coverage:ignore-end

  @override
  Future<void> setColorScheme(J1ColorScheme colorScheme) async {
    final colorSchemeRef = await _getRealmAsync<RealmColorScheme>(_defaultColorScheme);
    await _realm.writeAsync<RealmColorScheme>(() {
      colorSchemeRef.brightness = RealmBrightnessExtensions.fromBrightness(colorScheme.brightness);
      colorSchemeRef.primary = colorScheme.primary;
      colorSchemeRef.onPrimary = colorScheme.onPrimary;
      colorSchemeRef.secondary = colorScheme.secondary;
      colorSchemeRef.onSecondary = colorScheme.onSecondary;
      colorSchemeRef.tertiary = colorScheme.tertiary;
      colorSchemeRef.onTertiary = colorScheme.onTertiary;
      colorSchemeRef.error = colorScheme.error;
      colorSchemeRef.onError = colorScheme.onError;
      colorSchemeRef.surface = colorScheme.surface;
      colorSchemeRef.onSurface = colorScheme.onSurface;
      colorSchemeRef.background = colorScheme.background;
      return colorSchemeRef;
    });
  }

  @override
  Future<void> setTextTheme(J1TextTheme textTheme) async {
    final textThemeRef = await _getRealmAsync<RealmTextTheme>(_defaultTextTheme);
    await _realm.writeAsync<RealmTextTheme>(() {
      textThemeRef.displayLarge = RealmTextStyleExtensions.fromTextStyle(textTheme.displayLarge);
      textThemeRef.displayMedium = RealmTextStyleExtensions.fromTextStyle(textTheme.displayMedium);
      textThemeRef.displaySmall = RealmTextStyleExtensions.fromTextStyle(textTheme.displaySmall);
      textThemeRef.headlineLarge = RealmTextStyleExtensions.fromTextStyle(textTheme.headlineLarge);
      textThemeRef.headlineMedium = RealmTextStyleExtensions.fromTextStyle(textTheme.headlineMedium);
      textThemeRef.headlineSmall = RealmTextStyleExtensions.fromTextStyle(textTheme.headlineSmall);
      textThemeRef.titleLarge = RealmTextStyleExtensions.fromTextStyle(textTheme.titleLarge);
      textThemeRef.titleMedium = RealmTextStyleExtensions.fromTextStyle(textTheme.titleMedium);
      textThemeRef.titleSmall = RealmTextStyleExtensions.fromTextStyle(textTheme.titleSmall);
      textThemeRef.bodyLarge = RealmTextStyleExtensions.fromTextStyle(textTheme.bodyLarge);
      textThemeRef.bodyMedium = RealmTextStyleExtensions.fromTextStyle(textTheme.bodyMedium);
      textThemeRef.bodySmall = RealmTextStyleExtensions.fromTextStyle(textTheme.bodySmall);
      textThemeRef.labelLarge = RealmTextStyleExtensions.fromTextStyle(textTheme.labelLarge);
      textThemeRef.labelMedium = RealmTextStyleExtensions.fromTextStyle(textTheme.labelMedium);
      textThemeRef.labelSmall = RealmTextStyleExtensions.fromTextStyle(textTheme.labelSmall);
      return textThemeRef;
    });
  }

  @override
  Future<void> setPageTransition(J1PageTransition pageTransition) async {
    final pageTransitionRef = await _getRealmAsync<RealmPageTransition>(_defaultPageTransition);
    await _realm.writeAsync<RealmPageTransition>(() {
      pageTransitionRef.pageTransition = pageTransition.name;
      return pageTransitionRef;
    });
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
    final favoritesRef = await _getRealmAsync<RealmFavorites>(_defaultFavorites);
    await _realm.writeAsync<RealmFavorites>(() {
      final favorites = favoritesRef.toFavorites();
      favoritesRef.favorites.clear();
      favoritesRef.favorites.addAll({...favorites, code}.map((code) => code.name).toList());
      return favoritesRef;
    });
  }

  @override
  Future<void> removeFavorite(CurrencyCode code) async {
    final favoritesRef = await _getRealmAsync<RealmFavorites>(_defaultFavorites);
    await _realm.writeAsync<RealmFavorites>(() {
      final favorites = favoritesRef.toFavorites();
      favorites.remove(code);
      favoritesRef.favorites.clear();
      favoritesRef.favorites.addAll(favorites.map((code) => code.name).toList());
      return favoritesRef;
    });
  }

  @override
  Stream<List<CurrencyCode>> getFavoritesStream() {
    final favoritesRef = _getRealm<RealmFavorites>(RealmFavoritesExtensions.fromFavorites(_settingsKey, const []));
    return favoritesRef.changes.map((changes) => changes.object.toFavorites());
  }

  @override
  Future<void> setLanguage(String languageCode) async {
    final languageRef = await _getRealmAsync<RealmLanguage>(_defaultLanguage);
    await _realm.writeAsync<RealmLanguage>(() {
      languageRef.language = languageCode;
      return languageRef;
    });
  }

  @override
  Stream<String> getLanguagesStream() {
    final languageRef = _getRealm<RealmLanguage>(RealmLanguageExtensions.fromLanguage(_settingsKey, "en"));
    return languageRef.changes.map((changes) => changes.object.toLanguage());
  }

  T _getRealm<T extends RealmObject>(T defaultValue) {
    return _realm.find<T>(_settingsKey) ?? _realm.write<T>(() => _realm.add<T>(defaultValue));
  }

  Future<T> _getRealmAsync<T extends RealmObject>(T defaultValue) async {
    return _realm.find<T>(_settingsKey) ?? await _realm.writeAsync<T>(() => _realm.add<T>(defaultValue));
  }

  void dispose() {
    _realm.close();
  }
}
