import "dart:async";

import "package:currency_converter/model/currency.dart";
import "package:currency_converter/repository/app_storage_repository/app_storage_repository.dart";
import "package:currency_converter/repository/app_storage_repository/defaults.dart";
import "package:currency_converter/model/cc_error.dart";
import "package:j1_theme/models/j1_color_scheme.dart";
import "package:j1_theme/models/j1_page_transition.dart";
import "package:j1_theme/models/j1_text_theme.dart";
import "package:rxdart/subjects.dart";
import "package:shared_preferences/shared_preferences.dart";

const _colorSchemeKey = "ccColorScheme";
const _textThemeKey = "ccTextTheme";
const _pageTransitionKey = "ccPageTransition";
const _favoritesKey = "ccFavorites";
const _languageKey = "ccLanguage";

class DeviceAppStorageRepository extends AppStorageRepository {
  final SharedPreferencesAsync _preferences;

  final _colorSchemeController = BehaviorSubject<J1ColorScheme>.seeded(defaultColorScheme);
  final _textThemeController = BehaviorSubject<J1TextTheme>.seeded(defaultTextTheme);
  final _pageTransitionController = BehaviorSubject<J1PageTransition>.seeded(defaultPageTransition);
  final _favoritesController = BehaviorSubject<List<CurrencyCode>>.seeded(defaultFavorites);
  final _languageController = BehaviorSubject<String>.seeded(defaultLanguage);

  var _favoritesSeeded = false;

  DeviceAppStorageRepository({SharedPreferencesAsync? preferences})
      : _preferences = preferences ?? SharedPreferencesAsync() {
    _seedInitialValues();
  }

  Future<void> _seedItem(String key, Future<void> Function() seeder) async {
    try {
      await seeder();
    } catch (e) {
      throw CcError(
        ErrorCode.source_appStorage_readError,
        message: "$key seeding error: $e",
      );
    }
  }

  Future<void> _saveItem(String key, bool isSeeded, Future<void> Function() saver) async {
    if (!isSeeded) {
      throw CcError(
        ErrorCode.source_appStorage_readError,
        message: "$key saved before repository was seeded",
      );
    }

    try {
      await saver();
    } catch (e) {
      throw CcError(
        ErrorCode.source_appStorage_writeError,
        message: "$key saving error: $e",
      );
    }
  }

  Future<void> _seedInitialValues() async {
    try {
      await Future.wait([
        _seedItem(_colorSchemeKey, () async {
          final colorScheme = await _preferences.getString(_colorSchemeKey);
          if (colorScheme != null) {
            _colorSchemeController.add(J1ColorScheme.fromJson(colorScheme));
          }
        }),
        _seedItem(_textThemeKey, () async {
          final textTheme = await _preferences.getString(_textThemeKey);
          if (textTheme != null) {
            _textThemeController.add(J1TextTheme.fromJson(textTheme));
          }
        }),
        _seedItem(_pageTransitionKey, () async {
          final pageTransition = await _preferences.getString(_pageTransitionKey);
          if (pageTransition != null) {
            _pageTransitionController.add(J1PageTransition.fromValue(pageTransition));
          }
        }),
        _seedItem(_favoritesKey, () async {
          final favorites = await _preferences.getStringList(_favoritesKey);
          if (favorites != null) {
            _favoritesController.add(favorites.map(CurrencyCode.fromValue).toList());
          }
          _favoritesSeeded = true;
        }),
        _seedItem(_languageKey, () async {
          final language = await _preferences.getString(_languageKey);
          if (language != null) {
            _languageController.add(language);
          }
        }),
      ]);
    } catch (e) {
      // No-op.
    }
  }

  @override
  Future<void> setColorScheme(J1ColorScheme colorScheme) async {
    await _saveItem(_colorSchemeKey, true, () async {
      _preferences.setString(_colorSchemeKey, colorScheme.toJson());
      _colorSchemeController.add(colorScheme);
    });
  }

  @override
  Future<void> setTextTheme(J1TextTheme textTheme) async {
    await _saveItem(_textThemeKey, true, () async {
      _preferences.setString(_textThemeKey, textTheme.toJson());
      _textThemeController.add(textTheme);
    });
  }

  @override
  Future<void> setPageTransition(J1PageTransition pageTransition) async {
    await _saveItem(_pageTransitionKey, true, () async {
      await _preferences.setString(_pageTransitionKey, pageTransition.toValue());
      _pageTransitionController.add(pageTransition);
    });
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
    final updatedFavorites = [..._favoritesController.value, code];

    await _saveItem(_favoritesKey, _favoritesSeeded, () async {
      await _preferences.setStringList(
        _favoritesKey,
        updatedFavorites.map((code) => code.toValue()).toList(),
      );

      _favoritesController.add(updatedFavorites);
    });
  }

  @override
  Future<void> removeFavorite(CurrencyCode code) async {
    final updatedFavorites = [..._favoritesController.value];
    updatedFavorites.remove(code);

    await _saveItem(_favoritesKey, _favoritesSeeded, () async {
      await _preferences.setStringList(
        _favoritesKey,
        updatedFavorites.map((code) => code.toValue()).toList(),
      );

      _favoritesController.add(updatedFavorites);
    });
  }

  @override
  Stream<List<CurrencyCode>> getFavoritesStream() {
    return _favoritesController.stream;
  }

  @override
  Future<void> setLanguage(String languageCode) async {
    await _saveItem(_languageKey, true, () async {
      await _preferences.setString(_languageKey, languageCode);
      _languageController.add(languageCode);
    });
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
