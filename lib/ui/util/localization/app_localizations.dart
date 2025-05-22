import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_ko.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of Strings
/// returned by `Strings.of(context)`.
///
/// Applications need to include `Strings.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'localization/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: Strings.localizationsDelegates,
///   supportedLocales: Strings.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the Strings.supportedLocales
/// property.
abstract class Strings {
  Strings(String locale) : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static Strings of(BuildContext context) {
    return Localizations.of<Strings>(context, Strings)!;
  }

  static const LocalizationsDelegate<Strings> delegate = _StringsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates = <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[Locale('en'), Locale('ko')];

  /// No description provided for @app_title.
  ///
  /// In en, this message translates to:
  /// **'Currency Converter'**
  String get app_title;

  /// No description provided for @settings.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settings;

  /// No description provided for @settings_favorites.
  ///
  /// In en, this message translates to:
  /// **'Favorites'**
  String get settings_favorites;

  /// No description provided for @settings_configurations.
  ///
  /// In en, this message translates to:
  /// **'Configurations'**
  String get settings_configurations;

  /// No description provided for @settings_language.
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get settings_language;

  /// No description provided for @settings_theme.
  ///
  /// In en, this message translates to:
  /// **'Theme'**
  String get settings_theme;

  /// No description provided for @settings_membership.
  ///
  /// In en, this message translates to:
  /// **'Membership'**
  String get settings_membership;

  /// No description provided for @settings_about.
  ///
  /// In en, this message translates to:
  /// **'About'**
  String get settings_about;

  /// No description provided for @settings_test.
  ///
  /// In en, this message translates to:
  /// **'Test'**
  String get settings_test;

  /// No description provided for @settings_languageHint.
  ///
  /// In en, this message translates to:
  /// **'Search'**
  String get settings_languageHint;

  /// No description provided for @settings_languageLabel.
  ///
  /// In en, this message translates to:
  /// **'{language, select, en{English} ko{Korean} other{Unknown}}'**
  String settings_languageLabel(String language);

  /// No description provided for @settings_error_languageEmpty.
  ///
  /// In en, this message translates to:
  /// **'Could not find any languages. Please ensure that you\'re searching by IANA language subtag (ie: \"en\", \"ko\", etc.) or language name and try again.'**
  String get settings_error_languageEmpty;

  /// No description provided for @settings_error_getLanguage.
  ///
  /// In en, this message translates to:
  /// **'Failed to fetch the current language. Using the default language.'**
  String get settings_error_getLanguage;

  /// No description provided for @settings_error_saveLanguage.
  ///
  /// In en, this message translates to:
  /// **'Failed to save language.'**
  String get settings_error_saveLanguage;

  /// No description provided for @favorites.
  ///
  /// In en, this message translates to:
  /// **'Favorites'**
  String get favorites;

  /// No description provided for @favorites_error_empty.
  ///
  /// In en, this message translates to:
  /// **'Could not find any currencies. Please ensure that you\'re searching by ISO 4217 currency code (ie: \"USD\", \"EUR\", etc.) and try again.'**
  String get favorites_error_empty;

  /// No description provided for @favorites_error_getFavorites.
  ///
  /// In en, this message translates to:
  /// **'Failed to load favorites. Please note that favorites functionality may be unavailable.'**
  String get favorites_error_getFavorites;

  /// No description provided for @favorites_error_getCurrencies.
  ///
  /// In en, this message translates to:
  /// **'Failed to load currencies. Using the default currency list.'**
  String get favorites_error_getCurrencies;

  /// No description provided for @favorites_error_saveFavorite.
  ///
  /// In en, this message translates to:
  /// **'Failed to save favorites.'**
  String get favorites_error_saveFavorite;

  /// No description provided for @theme.
  ///
  /// In en, this message translates to:
  /// **'Theme'**
  String get theme;

  /// No description provided for @theme_headerFonts.
  ///
  /// In en, this message translates to:
  /// **'Header Fonts'**
  String get theme_headerFonts;

  /// No description provided for @theme_bodyFonts.
  ///
  /// In en, this message translates to:
  /// **'Body Fonts'**
  String get theme_bodyFonts;

  /// No description provided for @theme_colorsTitle.
  ///
  /// In en, this message translates to:
  /// **'{colors, select, light{Light} dark{Dark} blue{Blue} green{Green} other{Unknown}}'**
  String theme_colorsTitle(String colors);

  /// No description provided for @theme_fontTitle.
  ///
  /// In en, this message translates to:
  /// **'{font, select, abrilFatface{Abril Fatface} poppins{Poppins} playfairDisplay{Playfair Display} other{Unknown}}'**
  String theme_fontTitle(String font);

  /// No description provided for @home_baseCurrency.
  ///
  /// In en, this message translates to:
  /// **'Base Currency'**
  String get home_baseCurrency;

  /// No description provided for @home_converted.
  ///
  /// In en, this message translates to:
  /// **'Converted'**
  String get home_converted;

  /// No description provided for @home_refresh.
  ///
  /// In en, this message translates to:
  /// **'Refresh'**
  String get home_refresh;

  /// No description provided for @home_refresh_error.
  ///
  /// In en, this message translates to:
  /// **'Refresh error'**
  String get home_refresh_error;

  /// No description provided for @home_refreshed.
  ///
  /// In en, this message translates to:
  /// **'Refreshed on {date} at {time}'**
  String home_refreshed(String date, String time);

  /// No description provided for @home_today.
  ///
  /// In en, this message translates to:
  /// **'today'**
  String get home_today;

  /// No description provided for @home_yesterday.
  ///
  /// In en, this message translates to:
  /// **'yesterday'**
  String get home_yesterday;

  /// No description provided for @home_error_getConfiguration.
  ///
  /// In en, this message translates to:
  /// **'Failed to fetch the most recent configuration. Using the default configuration.'**
  String get home_error_getConfiguration;

  /// No description provided for @home_error_getExchangeRate.
  ///
  /// In en, this message translates to:
  /// **'Failed to load current exchange rates. Please check your internet connection and try again.'**
  String get home_error_getExchangeRate;

  /// No description provided for @home_error_getFavorites.
  ///
  /// In en, this message translates to:
  /// **'Failed to load favorites. Please note that favorites functionality may be unavailable.'**
  String get home_error_getFavorites;

  /// No description provided for @home_error_getCurrencies.
  ///
  /// In en, this message translates to:
  /// **'Failed to load currencies. Using the default currency list.'**
  String get home_error_getCurrencies;

  /// No description provided for @home_error_saveConfiguration.
  ///
  /// In en, this message translates to:
  /// **'Failed to save the current configuration.'**
  String get home_error_saveConfiguration;

  /// No description provided for @home_error_saveFavorite.
  ///
  /// In en, this message translates to:
  /// **'Failed to save favorites.'**
  String get home_error_saveFavorite;

  /// No description provided for @currencyCard_favorite.
  ///
  /// In en, this message translates to:
  /// **'Favorite'**
  String get currencyCard_favorite;

  /// No description provided for @currencyCard_unfavorite.
  ///
  /// In en, this message translates to:
  /// **'Unfavorite'**
  String get currencyCard_unfavorite;

  /// No description provided for @currencyCard_remove.
  ///
  /// In en, this message translates to:
  /// **'Remove'**
  String get currencyCard_remove;

  /// No description provided for @currencyCard_error_history.
  ///
  /// In en, this message translates to:
  /// **'We encountered an error trying to fetch the currency history. Please check your internet connection and try again.'**
  String get currencyCard_error_history;

  /// No description provided for @selectDrawer_hint.
  ///
  /// In en, this message translates to:
  /// **'Search'**
  String get selectDrawer_hint;

  /// No description provided for @selectDrawer_favorites.
  ///
  /// In en, this message translates to:
  /// **'Favorites'**
  String get selectDrawer_favorites;

  /// No description provided for @selectDrawer_currencies.
  ///
  /// In en, this message translates to:
  /// **'Currencies'**
  String get selectDrawer_currencies;

  /// No description provided for @selectDrawer_error_empty.
  ///
  /// In en, this message translates to:
  /// **'Could not find any currencies. Please ensure that you\'re searching by ISO 4217 currency code (ie: \"USD\", \"EUR\", etc.) and try again.'**
  String get selectDrawer_error_empty;
}

class _StringsDelegate extends LocalizationsDelegate<Strings> {
  const _StringsDelegate();

  @override
  Future<Strings> load(Locale locale) {
    return SynchronousFuture<Strings>(lookupStrings(locale));
  }

  @override
  bool isSupported(Locale locale) => <String>['en', 'ko'].contains(locale.languageCode);

  @override
  bool shouldReload(_StringsDelegate old) => false;
}

Strings lookupStrings(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return StringsEn();
    case 'ko':
      return StringsKo();
  }

  throw FlutterError('Strings.delegate failed to load unsupported locale "$locale". This is likely '
      'an issue with the localizations generation tool. Please file an issue '
      'on GitHub with a reproducible sample app and the gen-l10n configuration '
      'that was used.');
}
