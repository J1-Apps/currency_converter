import "package:currency_converter/model/configuration.dart";
import "package:currency_converter/model/currency.dart";
import "package:j1_theme/j1_theme.dart";

const defaultColorScheme = J1ColorScheme(
  brightness: J1Brightness.light,
  primary: 0xFF87A0B2,
  onPrimary: 0xFF121212,
  secondary: 0xFF857885,
  onSecondary: 0xFF121212,
  tertiary: 0xFF684A52,
  onTertiary: 0xFFEEEEEE,
  error: 0xFFB33951,
  onError: 0xFFEEEEEE,
  surface: 0xFFEEEEEE,
  onSurface: 0xFF121212,
  background: 0xFFEEEEEE,
);

const defaultTextTheme = J1TextTheme(
  displayLarge: J1TextStyle.displayLarge(fontFamily: "Abril Fatface"),
  displayMedium: J1TextStyle.displayMedium(fontFamily: "Abril Fatface"),
  displaySmall: J1TextStyle.displaySmall(fontFamily: "Abril Fatface"),
  headlineLarge: J1TextStyle.headlineLarge(fontFamily: "Abril Fatface"),
  headlineMedium: J1TextStyle.headlineMedium(fontFamily: "Abril Fatface"),
  headlineSmall: J1TextStyle.headlineSmall(fontFamily: "Abril Fatface"),
  titleLarge: J1TextStyle.titleLarge(fontFamily: "Abril Fatface"),
  titleMedium: J1TextStyle.titleMedium(fontFamily: "Abril Fatface", fontSize: 16),
  titleSmall: J1TextStyle.titleSmall(fontFamily: "Abril Fatface"),
  bodyLarge: J1TextStyle.bodyLarge(fontFamily: "Poppins"),
  bodyMedium: J1TextStyle.bodyMedium(fontFamily: "Poppins"),
  bodySmall: J1TextStyle.bodySmall(fontFamily: "Poppins"),
  labelLarge: J1TextStyle.labelLarge(fontFamily: "Poppins"),
  labelMedium: J1TextStyle.labelMedium(fontFamily: "Poppins"),
  labelSmall: J1TextStyle.labelSmall(fontFamily: "Poppins"),
);

const defaultPageTransition = J1PageTransition.cupertino;

const defaultFavorites = <CurrencyCode>{};

const defaultConfigurations = <Configuration>{};

const defaultLanguage = "en";

const defaultConfiguration = Configuration(
  "default",
  1.0,
  CurrencyCode.USD,
  {CurrencyCode.EUR, CurrencyCode.KRW, CurrencyCode.JPY},
);
