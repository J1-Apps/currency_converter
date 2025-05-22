// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Korean (`ko`).
class StringsKo extends Strings {
  StringsKo([String locale = 'ko']) : super(locale);

  @override
  String get app_title => '환율 계산기';

  @override
  String get settings => '설정';

  @override
  String get settings_favorites => 'Favorites';

  @override
  String get settings_configurations => 'Configurations';

  @override
  String get settings_language => '언어';

  @override
  String get settings_theme => 'Theme';

  @override
  String get settings_membership => 'Membership';

  @override
  String get settings_about => 'About';

  @override
  String get settings_test => 'Test';

  @override
  String get settings_languageHint => 'Search';

  @override
  String settings_languageLabel(String language) {
    String _temp0 = intl.Intl.selectLogic(
      language,
      {
        'en': '영어',
        'ko': '한국어',
        'other': 'Unknown',
      },
    );
    return '$_temp0';
  }

  @override
  String get settings_error_languageEmpty =>
      'Could not find any languages. Please ensure that you\'re searching by IANA language subtag (ie: \"en\", \"ko\", etc.) or language name and try again.';

  @override
  String get settings_error_getLanguage => 'Failed to fetch the current language. Using the default language.';

  @override
  String get settings_error_saveLanguage => 'Failed to save language.';

  @override
  String get favorites => 'Favorites';

  @override
  String get favorites_error_empty =>
      'Could not find any currencies. Please ensure that you\'re searching by ISO 4217 currency code (ie: \"USD\", \"EUR\", etc.) and try again.';

  @override
  String get favorites_error_getFavorites =>
      'Failed to load favorites. Please note that favorites functionality may be unavailable.';

  @override
  String get favorites_error_getCurrencies => 'Failed to load currencies. Using the default currency list.';

  @override
  String get favorites_error_saveFavorite => 'Failed to save favorites.';

  @override
  String get theme => 'Theme';

  @override
  String get theme_headerFonts => 'Header Fonts';

  @override
  String get theme_bodyFonts => 'Body Fonts';

  @override
  String theme_colorsTitle(String colors) {
    String _temp0 = intl.Intl.selectLogic(
      colors,
      {
        'light': 'Light',
        'dark': 'Dark',
        'blue': 'Blue',
        'green': 'Green',
        'other': 'Unknown',
      },
    );
    return '$_temp0';
  }

  @override
  String theme_fontTitle(String font) {
    String _temp0 = intl.Intl.selectLogic(
      font,
      {
        'abrilFatface': 'Abril Fatface',
        'poppins': 'Poppins',
        'playfairDisplay': 'Playfair Display',
        'other': 'Unknown',
      },
    );
    return '$_temp0';
  }

  @override
  String get home_baseCurrency => 'Base Currency';

  @override
  String get home_converted => 'Converted';

  @override
  String get home_refresh => 'Refresh';

  @override
  String get home_refresh_error => 'Refresh error';

  @override
  String home_refreshed(String date, String time) {
    return 'Refreshed on $date at $time';
  }

  @override
  String get home_today => 'today';

  @override
  String get home_yesterday => 'yesterday';

  @override
  String get home_error_getConfiguration =>
      'Failed to fetch the most recent configuration. Using the default configuration.';

  @override
  String get home_error_getExchangeRate =>
      'Failed to load current exchange rates. Please check your internet connection and try again.';

  @override
  String get home_error_getFavorites =>
      'Failed to load favorites. Please note that favorites functionality may be unavailable.';

  @override
  String get home_error_getCurrencies => 'Failed to load currencies. Using the default currency list.';

  @override
  String get home_error_saveConfiguration => 'Failed to save the current configuration.';

  @override
  String get home_error_saveFavorite => 'Failed to save favorites.';

  @override
  String get currencyCard_favorite => 'Favorite';

  @override
  String get currencyCard_unfavorite => 'Unfavorite';

  @override
  String get currencyCard_remove => 'Remove';

  @override
  String get currencyCard_error_history =>
      'We encountered an error trying to fetch the currency history. Please check your internet connection and try again.';

  @override
  String get selectDrawer_hint => '검색';

  @override
  String get selectDrawer_favorites => 'Favorites';

  @override
  String get selectDrawer_currencies => 'Currencies';

  @override
  String get selectDrawer_error_empty =>
      'Could not find any currencies. Please ensure that you\'re searching by ISO 4217 currency code (ie: \"USD\", \"EUR\", etc.) and try again.';
}
