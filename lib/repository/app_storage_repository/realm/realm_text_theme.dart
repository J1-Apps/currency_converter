import "package:currency_converter/ui/themes/text_themes.dart";
import "package:j1_theme/j1_theme.dart";
import "package:realm/realm.dart";
// ignore: unnecessary_import, depend_on_referenced_packages
import "package:realm_common/realm_common.dart";

part "realm_text_theme.realm.dart";

@RealmModel()
class $RealmTextStyle {
  String fontFamily = "Abril Fatface";
  double fontSize = 57;
  double height = 64;
  String fontWeight = "normal";
}

@RealmModel()
class _RealmTextTheme {
  @PrimaryKey()
  late String key;

  late $RealmTextStyle? displayLarge;
  late $RealmTextStyle? displayMedium;
  late $RealmTextStyle? displaySmall;
  late $RealmTextStyle? headlineLarge;
  late $RealmTextStyle? headlineMedium;
  late $RealmTextStyle? headlineSmall;
  late $RealmTextStyle? titleLarge;
  late $RealmTextStyle? titleMedium;
  late $RealmTextStyle? titleSmall;
  late $RealmTextStyle? bodyLarge;
  late $RealmTextStyle? bodyMedium;
  late $RealmTextStyle? bodySmall;
  late $RealmTextStyle? labelLarge;
  late $RealmTextStyle? labelMedium;
  late $RealmTextStyle? labelSmall;
}

extension _RealmFontWeightExtensions on String {
  J1FontWeight toFontWeight() {
    return switch (toLowerCase()) {
      "thin" => J1FontWeight.thin,
      "extralight" => J1FontWeight.extraLight,
      "light" => J1FontWeight.light,
      "medium" => J1FontWeight.medium,
      "semibold" => J1FontWeight.semiBold,
      "bold" => J1FontWeight.bold,
      "extrabold" => J1FontWeight.extraBold,
      "black" => J1FontWeight.black,
      _ => J1FontWeight.normal,
    };
  }

  static String fromFontWeight(J1FontWeight fontWeight) {
    return fontWeight.name;
  }
}

extension _RealmTextStyleExtensions on RealmTextStyle {
  J1TextStyle toTextStyle() {
    return J1TextStyle.bodyMedium(
      fontFamily: fontFamily,
      fontSize: fontSize,
      height: height,
      fontWeight: fontWeight.toFontWeight(),
    );
  }

  static RealmTextStyle fromTextStyle(J1TextStyle textStyle) {
    return RealmTextStyle(
      fontFamily: textStyle.fontFamily,
      fontSize: textStyle.fontSize,
      height: textStyle.height,
      fontWeight: _RealmFontWeightExtensions.fromFontWeight(textStyle.fontWeight),
    );
  }
}

extension RealmTextThemeExtensions on RealmTextTheme {
  J1TextTheme toTextTheme() {
    return J1TextTheme(
      displayLarge: displayLarge?.toTextStyle() ?? defaultTextTheme.displayLarge,
      displayMedium: displayMedium?.toTextStyle() ?? defaultTextTheme.displayMedium,
      displaySmall: displaySmall?.toTextStyle() ?? defaultTextTheme.displaySmall,
      headlineLarge: headlineLarge?.toTextStyle() ?? defaultTextTheme.headlineLarge,
      headlineMedium: headlineMedium?.toTextStyle() ?? defaultTextTheme.headlineMedium,
      headlineSmall: headlineSmall?.toTextStyle() ?? defaultTextTheme.headlineSmall,
      titleLarge: titleLarge?.toTextStyle() ?? defaultTextTheme.titleLarge,
      titleMedium: titleMedium?.toTextStyle() ?? defaultTextTheme.titleMedium,
      titleSmall: titleSmall?.toTextStyle() ?? defaultTextTheme.titleSmall,
      bodyLarge: bodyLarge?.toTextStyle() ?? defaultTextTheme.bodyLarge,
      bodyMedium: bodyMedium?.toTextStyle() ?? defaultTextTheme.bodyMedium,
      bodySmall: bodySmall?.toTextStyle() ?? defaultTextTheme.bodySmall,
      labelLarge: labelLarge?.toTextStyle() ?? defaultTextTheme.labelLarge,
      labelMedium: labelMedium?.toTextStyle() ?? defaultTextTheme.labelMedium,
      labelSmall: labelSmall?.toTextStyle() ?? defaultTextTheme.labelSmall,
    );
  }

  static RealmTextTheme fromTextTheme(String key, J1TextTheme textTheme) {
    return RealmTextTheme(
      key,
      displayLarge: _RealmTextStyleExtensions.fromTextStyle(textTheme.displayLarge),
      displayMedium: _RealmTextStyleExtensions.fromTextStyle(textTheme.displayMedium),
      displaySmall: _RealmTextStyleExtensions.fromTextStyle(textTheme.displaySmall),
      headlineLarge: _RealmTextStyleExtensions.fromTextStyle(textTheme.headlineLarge),
      headlineMedium: _RealmTextStyleExtensions.fromTextStyle(textTheme.headlineMedium),
      headlineSmall: _RealmTextStyleExtensions.fromTextStyle(textTheme.headlineSmall),
      titleLarge: _RealmTextStyleExtensions.fromTextStyle(textTheme.titleLarge),
      titleMedium: _RealmTextStyleExtensions.fromTextStyle(textTheme.titleMedium),
      titleSmall: _RealmTextStyleExtensions.fromTextStyle(textTheme.titleSmall),
      bodyLarge: _RealmTextStyleExtensions.fromTextStyle(textTheme.bodyLarge),
      bodyMedium: _RealmTextStyleExtensions.fromTextStyle(textTheme.bodyMedium),
      bodySmall: _RealmTextStyleExtensions.fromTextStyle(textTheme.bodySmall),
      labelLarge: _RealmTextStyleExtensions.fromTextStyle(textTheme.labelLarge),
      labelMedium: _RealmTextStyleExtensions.fromTextStyle(textTheme.labelMedium),
      labelSmall: _RealmTextStyleExtensions.fromTextStyle(textTheme.labelSmall),
    );
  }
}
