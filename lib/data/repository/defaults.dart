import "package:currency_converter/data/model/configuration.dart";
import "package:currency_converter/data/model/currency.dart";
import "package:j1_theme/j1_theme.dart";

const defaultPageTransition = J1PageTransition.cupertino;

const defaultFavorites = <CurrencyCode>[];

const defaultConfigurations = <Configuration>[];

const defaultLanguage = "en";

const defaultConfiguration = Configuration(
  "default",
  "default",
  1.0,
  CurrencyCode.USD,
  [
    ConfigurationCurrency(CurrencyCode.EUR, false),
    ConfigurationCurrency(CurrencyCode.KRW, false),
    ConfigurationCurrency(CurrencyCode.JPY, false),
  ],
);
