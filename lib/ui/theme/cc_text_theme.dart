import "package:j1_theme/j1_theme.dart";

abstract class CcTextTheme {
  static const list = [
    abrilFatface,
    poppins,
    playfairDisplay,
  ];

  static const abrilFatface = "Abril Fatface";

  static const poppins = "Poppins";

  static const playfairDisplay = "Playfair Display";

  static const initial = J1TextTheme(
    displayLarge: J1TextStyle.displayLarge(fontFamily: abrilFatface),
    displayMedium: J1TextStyle.displayMedium(fontFamily: abrilFatface),
    displaySmall: J1TextStyle.displaySmall(fontFamily: abrilFatface),
    headlineLarge: J1TextStyle.headlineLarge(fontFamily: abrilFatface),
    headlineMedium: J1TextStyle.headlineMedium(fontFamily: abrilFatface),
    headlineSmall: J1TextStyle.headlineSmall(fontFamily: abrilFatface),
    titleLarge: J1TextStyle.titleLarge(fontFamily: abrilFatface),
    titleMedium: J1TextStyle.titleMedium(fontFamily: abrilFatface),
    titleSmall: J1TextStyle.titleSmall(fontFamily: abrilFatface),
    bodyLarge: J1TextStyle.bodyLarge(fontFamily: poppins),
    bodyMedium: J1TextStyle.bodyMedium(fontFamily: poppins),
    bodySmall: J1TextStyle.bodySmall(fontFamily: poppins),
    labelLarge: J1TextStyle.labelLarge(fontFamily: poppins),
    labelMedium: J1TextStyle.labelMedium(fontFamily: poppins),
    labelSmall: J1TextStyle.labelSmall(fontFamily: poppins),
  );
}
