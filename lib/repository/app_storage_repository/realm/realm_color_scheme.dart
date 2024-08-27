import "package:j1_theme/j1_theme.dart";
import "package:realm/realm.dart";
// ignore: unnecessary_import, depend_on_referenced_packages
import "package:realm_common/realm_common.dart";

part "realm_color_scheme.realm.dart";

@RealmModel()
class _RealmColorScheme {
  @PrimaryKey()
  late String key;

  String brightness = "light";
  int primary = 0xFF87A0B2;
  int onPrimary = 0xFF121212;
  int secondary = 0xFF857885;
  int onSecondary = 0xFF121212;
  int tertiary = 0xFF684A52;
  int onTertiary = 0xFFEEEEEE;
  int error = 0xFFB33951;
  int onError = 0xFFEEEEEE;
  int surface = 0xFFEEEEEE;
  int onSurface = 0xFF121212;
  int background = 0xFFEEEEEE;
}

extension RealmBrightnessExtensions on String {
  J1Brightness toBrightness() {
    return switch (toLowerCase()) {
      "light" => J1Brightness.light,
      _ => J1Brightness.dark,
    };
  }

  static String fromBrightness(J1Brightness brightness) {
    return brightness.name;
  }
}

extension RealmColorSchemeExtensions on RealmColorScheme {
  J1ColorScheme toColorScheme() {
    return J1ColorScheme(
      brightness: brightness.toBrightness(),
      primary: primary,
      onPrimary: onPrimary,
      secondary: secondary,
      onSecondary: onSecondary,
      tertiary: tertiary,
      onTertiary: onTertiary,
      error: error,
      onError: onError,
      surface: surface,
      onSurface: onSurface,
      background: background,
    );
  }

  static RealmColorScheme fromColorScheme(String key, J1ColorScheme colorScheme) {
    return RealmColorScheme(
      key,
      brightness: RealmBrightnessExtensions.fromBrightness(colorScheme.brightness),
      primary: colorScheme.primary,
      onPrimary: colorScheme.onPrimary,
      secondary: colorScheme.secondary,
      onSecondary: colorScheme.onSecondary,
      tertiary: colorScheme.tertiary,
      onTertiary: colorScheme.onTertiary,
      error: colorScheme.error,
      onError: colorScheme.onError,
      surface: colorScheme.surface,
      onSurface: colorScheme.onSurface,
      background: colorScheme.background,
    );
  }
}
