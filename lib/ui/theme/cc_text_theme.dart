import "package:j1_theme/j1_theme.dart";

const _abrilFatface = "Abril Fatface";
const _poppins = "Poppins";
const _playfairDisplay = "Playfair Display";

enum CcFontFamily {
  abrilFatface(_abrilFatface),
  poppins(_poppins),
  playfairDisplay(_playfairDisplay);

  final String fontFamily;

  const CcFontFamily(this.fontFamily);
}

abstract class CcTextTheme {
  static const initial = J1TextTheme(
    displayLarge: J1TextStyle.displayLarge(fontFamily: _abrilFatface),
    displayMedium: J1TextStyle.displayMedium(fontFamily: _abrilFatface),
    displaySmall: J1TextStyle.displaySmall(fontFamily: _abrilFatface),
    headlineLarge: J1TextStyle.headlineLarge(fontFamily: _abrilFatface),
    headlineMedium: J1TextStyle.headlineMedium(fontFamily: _abrilFatface),
    headlineSmall: J1TextStyle.headlineSmall(fontFamily: _abrilFatface),
    titleLarge: J1TextStyle.titleLarge(fontFamily: _abrilFatface),
    titleMedium: J1TextStyle.titleMedium(fontFamily: _abrilFatface),
    titleSmall: J1TextStyle.titleSmall(fontFamily: _abrilFatface),
    bodyLarge: J1TextStyle.bodyLarge(fontFamily: _poppins),
    bodyMedium: J1TextStyle.bodyMedium(fontFamily: _poppins),
    bodySmall: J1TextStyle.bodySmall(fontFamily: _poppins),
    labelLarge: J1TextStyle.labelLarge(fontFamily: _poppins),
    labelMedium: J1TextStyle.labelMedium(fontFamily: _poppins),
    labelSmall: J1TextStyle.labelSmall(fontFamily: _poppins),
  );
}
