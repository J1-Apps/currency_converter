import "package:j1_theme/j1_theme.dart";

abstract class CcColorScheme {
  static const list = [
    light,
    dark,
    blue,
    green,
  ];

  static const light = J1ColorScheme(
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

  static const dark = J1ColorScheme(
    brightness: J1Brightness.dark,
    primary: 0xFF87A0B2,
    onPrimary: 0xFF121212,
    secondary: 0xFF857885,
    onSecondary: 0xFF121212,
    tertiary: 0xFF684A52,
    onTertiary: 0xFFEEEEEE,
    error: 0xFFB33951,
    onError: 0xFFEEEEEE,
    surface: 0xFF121212,
    onSurface: 0xFFEEEEEE,
    background: 0xFF121212,
  );

  static const blue = J1ColorScheme(
    brightness: J1Brightness.light,
    primary: 0xFF8DA5A5,
    onPrimary: 0xFF111111,
    secondary: 0xFFAFC0C0,
    onSecondary: 0xFF111111,
    tertiary: 0xFF2A324B,
    onTertiary: 0xFFE5E3C9,
    error: 0xFFB33951,
    onError: 0xFFEEEEEE,
    surface: 0xFFE5E3C9,
    onSurface: 0xFF111111,
    background: 0xFFE5E3C9,
  );

  static const green = J1ColorScheme(
    brightness: J1Brightness.light,
    primary: 0xFF90A578,
    onPrimary: 0xFF111111,
    secondary: 0xFFAEBE9D,
    onSecondary: 0xFF111111,
    tertiary: 0xFF526241,
    onTertiary: 0xFFE5E3C9,
    error: 0xFFB33951,
    onError: 0xFFEEEEEE,
    surface: 0xFFE5E3C9,
    onSurface: 0xFF111111,
    background: 0xFFE5E3C9,
  );
}
