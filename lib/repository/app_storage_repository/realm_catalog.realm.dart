// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'realm_catalog.dart';

// **************************************************************************
// RealmObjectGenerator
// **************************************************************************

// ignore_for_file: type=lint
class RealmColorScheme extends _RealmColorScheme
    with RealmEntity, RealmObjectBase, RealmObject {
  static var _defaultsSet = false;

  RealmColorScheme(
    String key, {
    String brightness = "light",
    int primary = 0xFF87A0B2,
    int onPrimary = 0xFF121212,
    int secondary = 0xFF857885,
    int onSecondary = 0xFF121212,
    int tertiary = 0xFF684A52,
    int onTertiary = 0xFFEEEEEE,
    int error = 0xFFB33951,
    int onError = 0xFFEEEEEE,
    int surface = 0xFFEEEEEE,
    int onSurface = 0xFF121212,
    int background = 0xFFEEEEEE,
  }) {
    if (!_defaultsSet) {
      _defaultsSet = RealmObjectBase.setDefaults<RealmColorScheme>({
        'brightness': "light",
        'primary': 0xFF87A0B2,
        'onPrimary': 0xFF121212,
        'secondary': 0xFF857885,
        'onSecondary': 0xFF121212,
        'tertiary': 0xFF684A52,
        'onTertiary': 0xFFEEEEEE,
        'error': 0xFFB33951,
        'onError': 0xFFEEEEEE,
        'surface': 0xFFEEEEEE,
        'onSurface': 0xFF121212,
        'background': 0xFFEEEEEE,
      });
    }
    RealmObjectBase.set(this, 'key', key);
    RealmObjectBase.set(this, 'brightness', brightness);
    RealmObjectBase.set(this, 'primary', primary);
    RealmObjectBase.set(this, 'onPrimary', onPrimary);
    RealmObjectBase.set(this, 'secondary', secondary);
    RealmObjectBase.set(this, 'onSecondary', onSecondary);
    RealmObjectBase.set(this, 'tertiary', tertiary);
    RealmObjectBase.set(this, 'onTertiary', onTertiary);
    RealmObjectBase.set(this, 'error', error);
    RealmObjectBase.set(this, 'onError', onError);
    RealmObjectBase.set(this, 'surface', surface);
    RealmObjectBase.set(this, 'onSurface', onSurface);
    RealmObjectBase.set(this, 'background', background);
  }

  RealmColorScheme._();

  @override
  String get key => RealmObjectBase.get<String>(this, 'key') as String;
  @override
  set key(String value) => RealmObjectBase.set(this, 'key', value);

  @override
  String get brightness =>
      RealmObjectBase.get<String>(this, 'brightness') as String;
  @override
  set brightness(String value) =>
      RealmObjectBase.set(this, 'brightness', value);

  @override
  int get primary => RealmObjectBase.get<int>(this, 'primary') as int;
  @override
  set primary(int value) => RealmObjectBase.set(this, 'primary', value);

  @override
  int get onPrimary => RealmObjectBase.get<int>(this, 'onPrimary') as int;
  @override
  set onPrimary(int value) => RealmObjectBase.set(this, 'onPrimary', value);

  @override
  int get secondary => RealmObjectBase.get<int>(this, 'secondary') as int;
  @override
  set secondary(int value) => RealmObjectBase.set(this, 'secondary', value);

  @override
  int get onSecondary => RealmObjectBase.get<int>(this, 'onSecondary') as int;
  @override
  set onSecondary(int value) => RealmObjectBase.set(this, 'onSecondary', value);

  @override
  int get tertiary => RealmObjectBase.get<int>(this, 'tertiary') as int;
  @override
  set tertiary(int value) => RealmObjectBase.set(this, 'tertiary', value);

  @override
  int get onTertiary => RealmObjectBase.get<int>(this, 'onTertiary') as int;
  @override
  set onTertiary(int value) => RealmObjectBase.set(this, 'onTertiary', value);

  @override
  int get error => RealmObjectBase.get<int>(this, 'error') as int;
  @override
  set error(int value) => RealmObjectBase.set(this, 'error', value);

  @override
  int get onError => RealmObjectBase.get<int>(this, 'onError') as int;
  @override
  set onError(int value) => RealmObjectBase.set(this, 'onError', value);

  @override
  int get surface => RealmObjectBase.get<int>(this, 'surface') as int;
  @override
  set surface(int value) => RealmObjectBase.set(this, 'surface', value);

  @override
  int get onSurface => RealmObjectBase.get<int>(this, 'onSurface') as int;
  @override
  set onSurface(int value) => RealmObjectBase.set(this, 'onSurface', value);

  @override
  int get background => RealmObjectBase.get<int>(this, 'background') as int;
  @override
  set background(int value) => RealmObjectBase.set(this, 'background', value);

  @override
  Stream<RealmObjectChanges<RealmColorScheme>> get changes =>
      RealmObjectBase.getChanges<RealmColorScheme>(this);

  @override
  Stream<RealmObjectChanges<RealmColorScheme>> changesFor(
          [List<String>? keyPaths]) =>
      RealmObjectBase.getChangesFor<RealmColorScheme>(this, keyPaths);

  @override
  RealmColorScheme freeze() =>
      RealmObjectBase.freezeObject<RealmColorScheme>(this);

  EJsonValue toEJson() {
    return <String, dynamic>{
      'key': key.toEJson(),
      'brightness': brightness.toEJson(),
      'primary': primary.toEJson(),
      'onPrimary': onPrimary.toEJson(),
      'secondary': secondary.toEJson(),
      'onSecondary': onSecondary.toEJson(),
      'tertiary': tertiary.toEJson(),
      'onTertiary': onTertiary.toEJson(),
      'error': error.toEJson(),
      'onError': onError.toEJson(),
      'surface': surface.toEJson(),
      'onSurface': onSurface.toEJson(),
      'background': background.toEJson(),
    };
  }

  static EJsonValue _toEJson(RealmColorScheme value) => value.toEJson();
  static RealmColorScheme _fromEJson(EJsonValue ejson) {
    if (ejson is! Map<String, dynamic>) return raiseInvalidEJson(ejson);
    return switch (ejson) {
      {
        'key': EJsonValue key,
      } =>
        RealmColorScheme(
          fromEJson(key),
          brightness: fromEJson(ejson['brightness'], defaultValue: "light"),
          primary: fromEJson(ejson['primary'], defaultValue: 0xFF87A0B2),
          onPrimary: fromEJson(ejson['onPrimary'], defaultValue: 0xFF121212),
          secondary: fromEJson(ejson['secondary'], defaultValue: 0xFF857885),
          onSecondary:
              fromEJson(ejson['onSecondary'], defaultValue: 0xFF121212),
          tertiary: fromEJson(ejson['tertiary'], defaultValue: 0xFF684A52),
          onTertiary: fromEJson(ejson['onTertiary'], defaultValue: 0xFFEEEEEE),
          error: fromEJson(ejson['error'], defaultValue: 0xFFB33951),
          onError: fromEJson(ejson['onError'], defaultValue: 0xFFEEEEEE),
          surface: fromEJson(ejson['surface'], defaultValue: 0xFFEEEEEE),
          onSurface: fromEJson(ejson['onSurface'], defaultValue: 0xFF121212),
          background: fromEJson(ejson['background'], defaultValue: 0xFFEEEEEE),
        ),
      _ => raiseInvalidEJson(ejson),
    };
  }

  static final schema = () {
    RealmObjectBase.registerFactory(RealmColorScheme._);
    register(_toEJson, _fromEJson);
    return const SchemaObject(
        ObjectType.realmObject, RealmColorScheme, 'RealmColorScheme', [
      SchemaProperty('key', RealmPropertyType.string, primaryKey: true),
      SchemaProperty('brightness', RealmPropertyType.string),
      SchemaProperty('primary', RealmPropertyType.int),
      SchemaProperty('onPrimary', RealmPropertyType.int),
      SchemaProperty('secondary', RealmPropertyType.int),
      SchemaProperty('onSecondary', RealmPropertyType.int),
      SchemaProperty('tertiary', RealmPropertyType.int),
      SchemaProperty('onTertiary', RealmPropertyType.int),
      SchemaProperty('error', RealmPropertyType.int),
      SchemaProperty('onError', RealmPropertyType.int),
      SchemaProperty('surface', RealmPropertyType.int),
      SchemaProperty('onSurface', RealmPropertyType.int),
      SchemaProperty('background', RealmPropertyType.int),
    ]);
  }();

  @override
  SchemaObject get objectSchema => RealmObjectBase.getSchema(this) ?? schema;
}

class RealmTextStyle extends $RealmTextStyle
    with RealmEntity, RealmObjectBase, RealmObject {
  static var _defaultsSet = false;

  RealmTextStyle(
    String key, {
    String fontFamily = "Abril Fatface",
    double fontSize = 57,
    double height = 64,
    String fontWeight = "normal",
  }) {
    if (!_defaultsSet) {
      _defaultsSet = RealmObjectBase.setDefaults<RealmTextStyle>({
        'fontFamily': "Abril Fatface",
        'fontSize': 57,
        'height': 64,
        'fontWeight': "normal",
      });
    }
    RealmObjectBase.set(this, 'key', key);
    RealmObjectBase.set(this, 'fontFamily', fontFamily);
    RealmObjectBase.set(this, 'fontSize', fontSize);
    RealmObjectBase.set(this, 'height', height);
    RealmObjectBase.set(this, 'fontWeight', fontWeight);
  }

  RealmTextStyle._();

  @override
  String get key => RealmObjectBase.get<String>(this, 'key') as String;
  @override
  set key(String value) => RealmObjectBase.set(this, 'key', value);

  @override
  String get fontFamily =>
      RealmObjectBase.get<String>(this, 'fontFamily') as String;
  @override
  set fontFamily(String value) =>
      RealmObjectBase.set(this, 'fontFamily', value);

  @override
  double get fontSize =>
      RealmObjectBase.get<double>(this, 'fontSize') as double;
  @override
  set fontSize(double value) => RealmObjectBase.set(this, 'fontSize', value);

  @override
  double get height => RealmObjectBase.get<double>(this, 'height') as double;
  @override
  set height(double value) => RealmObjectBase.set(this, 'height', value);

  @override
  String get fontWeight =>
      RealmObjectBase.get<String>(this, 'fontWeight') as String;
  @override
  set fontWeight(String value) =>
      RealmObjectBase.set(this, 'fontWeight', value);

  @override
  Stream<RealmObjectChanges<RealmTextStyle>> get changes =>
      RealmObjectBase.getChanges<RealmTextStyle>(this);

  @override
  Stream<RealmObjectChanges<RealmTextStyle>> changesFor(
          [List<String>? keyPaths]) =>
      RealmObjectBase.getChangesFor<RealmTextStyle>(this, keyPaths);

  @override
  RealmTextStyle freeze() => RealmObjectBase.freezeObject<RealmTextStyle>(this);

  EJsonValue toEJson() {
    return <String, dynamic>{
      'key': key.toEJson(),
      'fontFamily': fontFamily.toEJson(),
      'fontSize': fontSize.toEJson(),
      'height': height.toEJson(),
      'fontWeight': fontWeight.toEJson(),
    };
  }

  static EJsonValue _toEJson(RealmTextStyle value) => value.toEJson();
  static RealmTextStyle _fromEJson(EJsonValue ejson) {
    if (ejson is! Map<String, dynamic>) return raiseInvalidEJson(ejson);
    return switch (ejson) {
      {
        'key': EJsonValue key,
      } =>
        RealmTextStyle(
          fromEJson(key),
          fontFamily:
              fromEJson(ejson['fontFamily'], defaultValue: "Abril Fatface"),
          fontSize: fromEJson(ejson['fontSize'], defaultValue: 57),
          height: fromEJson(ejson['height'], defaultValue: 64),
          fontWeight: fromEJson(ejson['fontWeight'], defaultValue: "normal"),
        ),
      _ => raiseInvalidEJson(ejson),
    };
  }

  static final schema = () {
    RealmObjectBase.registerFactory(RealmTextStyle._);
    register(_toEJson, _fromEJson);
    return const SchemaObject(
        ObjectType.realmObject, RealmTextStyle, 'RealmTextStyle', [
      SchemaProperty('key', RealmPropertyType.string, primaryKey: true),
      SchemaProperty('fontFamily', RealmPropertyType.string),
      SchemaProperty('fontSize', RealmPropertyType.double),
      SchemaProperty('height', RealmPropertyType.double),
      SchemaProperty('fontWeight', RealmPropertyType.string),
    ]);
  }();

  @override
  SchemaObject get objectSchema => RealmObjectBase.getSchema(this) ?? schema;
}

class RealmTextTheme extends _RealmTextTheme
    with RealmEntity, RealmObjectBase, RealmObject {
  RealmTextTheme(
    String key, {
    RealmTextStyle? displayLarge,
    RealmTextStyle? displayMedium,
    RealmTextStyle? displaySmall,
    RealmTextStyle? headlineLarge,
    RealmTextStyle? headlineMedium,
    RealmTextStyle? headlineSmall,
    RealmTextStyle? titleLarge,
    RealmTextStyle? titleMedium,
    RealmTextStyle? titleSmall,
    RealmTextStyle? bodyLarge,
    RealmTextStyle? bodyMedium,
    RealmTextStyle? bodySmall,
    RealmTextStyle? labelLarge,
    RealmTextStyle? labelMedium,
    RealmTextStyle? labelSmall,
  }) {
    RealmObjectBase.set(this, 'key', key);
    RealmObjectBase.set(this, 'displayLarge', displayLarge);
    RealmObjectBase.set(this, 'displayMedium', displayMedium);
    RealmObjectBase.set(this, 'displaySmall', displaySmall);
    RealmObjectBase.set(this, 'headlineLarge', headlineLarge);
    RealmObjectBase.set(this, 'headlineMedium', headlineMedium);
    RealmObjectBase.set(this, 'headlineSmall', headlineSmall);
    RealmObjectBase.set(this, 'titleLarge', titleLarge);
    RealmObjectBase.set(this, 'titleMedium', titleMedium);
    RealmObjectBase.set(this, 'titleSmall', titleSmall);
    RealmObjectBase.set(this, 'bodyLarge', bodyLarge);
    RealmObjectBase.set(this, 'bodyMedium', bodyMedium);
    RealmObjectBase.set(this, 'bodySmall', bodySmall);
    RealmObjectBase.set(this, 'labelLarge', labelLarge);
    RealmObjectBase.set(this, 'labelMedium', labelMedium);
    RealmObjectBase.set(this, 'labelSmall', labelSmall);
  }

  RealmTextTheme._();

  @override
  String get key => RealmObjectBase.get<String>(this, 'key') as String;
  @override
  set key(String value) => RealmObjectBase.set(this, 'key', value);

  @override
  RealmTextStyle? get displayLarge =>
      RealmObjectBase.get<RealmTextStyle>(this, 'displayLarge')
          as RealmTextStyle?;
  @override
  set displayLarge(covariant RealmTextStyle? value) =>
      RealmObjectBase.set(this, 'displayLarge', value);

  @override
  RealmTextStyle? get displayMedium =>
      RealmObjectBase.get<RealmTextStyle>(this, 'displayMedium')
          as RealmTextStyle?;
  @override
  set displayMedium(covariant RealmTextStyle? value) =>
      RealmObjectBase.set(this, 'displayMedium', value);

  @override
  RealmTextStyle? get displaySmall =>
      RealmObjectBase.get<RealmTextStyle>(this, 'displaySmall')
          as RealmTextStyle?;
  @override
  set displaySmall(covariant RealmTextStyle? value) =>
      RealmObjectBase.set(this, 'displaySmall', value);

  @override
  RealmTextStyle? get headlineLarge =>
      RealmObjectBase.get<RealmTextStyle>(this, 'headlineLarge')
          as RealmTextStyle?;
  @override
  set headlineLarge(covariant RealmTextStyle? value) =>
      RealmObjectBase.set(this, 'headlineLarge', value);

  @override
  RealmTextStyle? get headlineMedium =>
      RealmObjectBase.get<RealmTextStyle>(this, 'headlineMedium')
          as RealmTextStyle?;
  @override
  set headlineMedium(covariant RealmTextStyle? value) =>
      RealmObjectBase.set(this, 'headlineMedium', value);

  @override
  RealmTextStyle? get headlineSmall =>
      RealmObjectBase.get<RealmTextStyle>(this, 'headlineSmall')
          as RealmTextStyle?;
  @override
  set headlineSmall(covariant RealmTextStyle? value) =>
      RealmObjectBase.set(this, 'headlineSmall', value);

  @override
  RealmTextStyle? get titleLarge =>
      RealmObjectBase.get<RealmTextStyle>(this, 'titleLarge')
          as RealmTextStyle?;
  @override
  set titleLarge(covariant RealmTextStyle? value) =>
      RealmObjectBase.set(this, 'titleLarge', value);

  @override
  RealmTextStyle? get titleMedium =>
      RealmObjectBase.get<RealmTextStyle>(this, 'titleMedium')
          as RealmTextStyle?;
  @override
  set titleMedium(covariant RealmTextStyle? value) =>
      RealmObjectBase.set(this, 'titleMedium', value);

  @override
  RealmTextStyle? get titleSmall =>
      RealmObjectBase.get<RealmTextStyle>(this, 'titleSmall')
          as RealmTextStyle?;
  @override
  set titleSmall(covariant RealmTextStyle? value) =>
      RealmObjectBase.set(this, 'titleSmall', value);

  @override
  RealmTextStyle? get bodyLarge =>
      RealmObjectBase.get<RealmTextStyle>(this, 'bodyLarge') as RealmTextStyle?;
  @override
  set bodyLarge(covariant RealmTextStyle? value) =>
      RealmObjectBase.set(this, 'bodyLarge', value);

  @override
  RealmTextStyle? get bodyMedium =>
      RealmObjectBase.get<RealmTextStyle>(this, 'bodyMedium')
          as RealmTextStyle?;
  @override
  set bodyMedium(covariant RealmTextStyle? value) =>
      RealmObjectBase.set(this, 'bodyMedium', value);

  @override
  RealmTextStyle? get bodySmall =>
      RealmObjectBase.get<RealmTextStyle>(this, 'bodySmall') as RealmTextStyle?;
  @override
  set bodySmall(covariant RealmTextStyle? value) =>
      RealmObjectBase.set(this, 'bodySmall', value);

  @override
  RealmTextStyle? get labelLarge =>
      RealmObjectBase.get<RealmTextStyle>(this, 'labelLarge')
          as RealmTextStyle?;
  @override
  set labelLarge(covariant RealmTextStyle? value) =>
      RealmObjectBase.set(this, 'labelLarge', value);

  @override
  RealmTextStyle? get labelMedium =>
      RealmObjectBase.get<RealmTextStyle>(this, 'labelMedium')
          as RealmTextStyle?;
  @override
  set labelMedium(covariant RealmTextStyle? value) =>
      RealmObjectBase.set(this, 'labelMedium', value);

  @override
  RealmTextStyle? get labelSmall =>
      RealmObjectBase.get<RealmTextStyle>(this, 'labelSmall')
          as RealmTextStyle?;
  @override
  set labelSmall(covariant RealmTextStyle? value) =>
      RealmObjectBase.set(this, 'labelSmall', value);

  @override
  Stream<RealmObjectChanges<RealmTextTheme>> get changes =>
      RealmObjectBase.getChanges<RealmTextTheme>(this);

  @override
  Stream<RealmObjectChanges<RealmTextTheme>> changesFor(
          [List<String>? keyPaths]) =>
      RealmObjectBase.getChangesFor<RealmTextTheme>(this, keyPaths);

  @override
  RealmTextTheme freeze() => RealmObjectBase.freezeObject<RealmTextTheme>(this);

  EJsonValue toEJson() {
    return <String, dynamic>{
      'key': key.toEJson(),
      'displayLarge': displayLarge.toEJson(),
      'displayMedium': displayMedium.toEJson(),
      'displaySmall': displaySmall.toEJson(),
      'headlineLarge': headlineLarge.toEJson(),
      'headlineMedium': headlineMedium.toEJson(),
      'headlineSmall': headlineSmall.toEJson(),
      'titleLarge': titleLarge.toEJson(),
      'titleMedium': titleMedium.toEJson(),
      'titleSmall': titleSmall.toEJson(),
      'bodyLarge': bodyLarge.toEJson(),
      'bodyMedium': bodyMedium.toEJson(),
      'bodySmall': bodySmall.toEJson(),
      'labelLarge': labelLarge.toEJson(),
      'labelMedium': labelMedium.toEJson(),
      'labelSmall': labelSmall.toEJson(),
    };
  }

  static EJsonValue _toEJson(RealmTextTheme value) => value.toEJson();
  static RealmTextTheme _fromEJson(EJsonValue ejson) {
    if (ejson is! Map<String, dynamic>) return raiseInvalidEJson(ejson);
    return switch (ejson) {
      {
        'key': EJsonValue key,
      } =>
        RealmTextTheme(
          fromEJson(key),
          displayLarge: fromEJson(ejson['displayLarge']),
          displayMedium: fromEJson(ejson['displayMedium']),
          displaySmall: fromEJson(ejson['displaySmall']),
          headlineLarge: fromEJson(ejson['headlineLarge']),
          headlineMedium: fromEJson(ejson['headlineMedium']),
          headlineSmall: fromEJson(ejson['headlineSmall']),
          titleLarge: fromEJson(ejson['titleLarge']),
          titleMedium: fromEJson(ejson['titleMedium']),
          titleSmall: fromEJson(ejson['titleSmall']),
          bodyLarge: fromEJson(ejson['bodyLarge']),
          bodyMedium: fromEJson(ejson['bodyMedium']),
          bodySmall: fromEJson(ejson['bodySmall']),
          labelLarge: fromEJson(ejson['labelLarge']),
          labelMedium: fromEJson(ejson['labelMedium']),
          labelSmall: fromEJson(ejson['labelSmall']),
        ),
      _ => raiseInvalidEJson(ejson),
    };
  }

  static final schema = () {
    RealmObjectBase.registerFactory(RealmTextTheme._);
    register(_toEJson, _fromEJson);
    return const SchemaObject(
        ObjectType.realmObject, RealmTextTheme, 'RealmTextTheme', [
      SchemaProperty('key', RealmPropertyType.string, primaryKey: true),
      SchemaProperty('displayLarge', RealmPropertyType.object,
          optional: true, linkTarget: 'RealmTextStyle'),
      SchemaProperty('displayMedium', RealmPropertyType.object,
          optional: true, linkTarget: 'RealmTextStyle'),
      SchemaProperty('displaySmall', RealmPropertyType.object,
          optional: true, linkTarget: 'RealmTextStyle'),
      SchemaProperty('headlineLarge', RealmPropertyType.object,
          optional: true, linkTarget: 'RealmTextStyle'),
      SchemaProperty('headlineMedium', RealmPropertyType.object,
          optional: true, linkTarget: 'RealmTextStyle'),
      SchemaProperty('headlineSmall', RealmPropertyType.object,
          optional: true, linkTarget: 'RealmTextStyle'),
      SchemaProperty('titleLarge', RealmPropertyType.object,
          optional: true, linkTarget: 'RealmTextStyle'),
      SchemaProperty('titleMedium', RealmPropertyType.object,
          optional: true, linkTarget: 'RealmTextStyle'),
      SchemaProperty('titleSmall', RealmPropertyType.object,
          optional: true, linkTarget: 'RealmTextStyle'),
      SchemaProperty('bodyLarge', RealmPropertyType.object,
          optional: true, linkTarget: 'RealmTextStyle'),
      SchemaProperty('bodyMedium', RealmPropertyType.object,
          optional: true, linkTarget: 'RealmTextStyle'),
      SchemaProperty('bodySmall', RealmPropertyType.object,
          optional: true, linkTarget: 'RealmTextStyle'),
      SchemaProperty('labelLarge', RealmPropertyType.object,
          optional: true, linkTarget: 'RealmTextStyle'),
      SchemaProperty('labelMedium', RealmPropertyType.object,
          optional: true, linkTarget: 'RealmTextStyle'),
      SchemaProperty('labelSmall', RealmPropertyType.object,
          optional: true, linkTarget: 'RealmTextStyle'),
    ]);
  }();

  @override
  SchemaObject get objectSchema => RealmObjectBase.getSchema(this) ?? schema;
}

class RealmPageTransition extends _RealmPageTransition
    with RealmEntity, RealmObjectBase, RealmObject {
  static var _defaultsSet = false;

  RealmPageTransition(
    String key, {
    String pageTransition = "cupertino",
  }) {
    if (!_defaultsSet) {
      _defaultsSet = RealmObjectBase.setDefaults<RealmPageTransition>({
        'pageTransition': "cupertino",
      });
    }
    RealmObjectBase.set(this, 'key', key);
    RealmObjectBase.set(this, 'pageTransition', pageTransition);
  }

  RealmPageTransition._();

  @override
  String get key => RealmObjectBase.get<String>(this, 'key') as String;
  @override
  set key(String value) => RealmObjectBase.set(this, 'key', value);

  @override
  String get pageTransition =>
      RealmObjectBase.get<String>(this, 'pageTransition') as String;
  @override
  set pageTransition(String value) =>
      RealmObjectBase.set(this, 'pageTransition', value);

  @override
  Stream<RealmObjectChanges<RealmPageTransition>> get changes =>
      RealmObjectBase.getChanges<RealmPageTransition>(this);

  @override
  Stream<RealmObjectChanges<RealmPageTransition>> changesFor(
          [List<String>? keyPaths]) =>
      RealmObjectBase.getChangesFor<RealmPageTransition>(this, keyPaths);

  @override
  RealmPageTransition freeze() =>
      RealmObjectBase.freezeObject<RealmPageTransition>(this);

  EJsonValue toEJson() {
    return <String, dynamic>{
      'key': key.toEJson(),
      'pageTransition': pageTransition.toEJson(),
    };
  }

  static EJsonValue _toEJson(RealmPageTransition value) => value.toEJson();
  static RealmPageTransition _fromEJson(EJsonValue ejson) {
    if (ejson is! Map<String, dynamic>) return raiseInvalidEJson(ejson);
    return switch (ejson) {
      {
        'key': EJsonValue key,
      } =>
        RealmPageTransition(
          fromEJson(key),
          pageTransition:
              fromEJson(ejson['pageTransition'], defaultValue: "cupertino"),
        ),
      _ => raiseInvalidEJson(ejson),
    };
  }

  static final schema = () {
    RealmObjectBase.registerFactory(RealmPageTransition._);
    register(_toEJson, _fromEJson);
    return const SchemaObject(
        ObjectType.realmObject, RealmPageTransition, 'RealmPageTransition', [
      SchemaProperty('key', RealmPropertyType.string, primaryKey: true),
      SchemaProperty('pageTransition', RealmPropertyType.string),
    ]);
  }();

  @override
  SchemaObject get objectSchema => RealmObjectBase.getSchema(this) ?? schema;
}

class RealmFavorites extends _RealmFavorites
    with RealmEntity, RealmObjectBase, RealmObject {
  RealmFavorites(
    String key, {
    Iterable<String> favorites = const [],
  }) {
    RealmObjectBase.set(this, 'key', key);
    RealmObjectBase.set<RealmList<String>>(
        this, 'favorites', RealmList<String>(favorites));
  }

  RealmFavorites._();

  @override
  String get key => RealmObjectBase.get<String>(this, 'key') as String;
  @override
  set key(String value) => RealmObjectBase.set(this, 'key', value);

  @override
  RealmList<String> get favorites =>
      RealmObjectBase.get<String>(this, 'favorites') as RealmList<String>;
  @override
  set favorites(covariant RealmList<String> value) =>
      throw RealmUnsupportedSetError();

  @override
  Stream<RealmObjectChanges<RealmFavorites>> get changes =>
      RealmObjectBase.getChanges<RealmFavorites>(this);

  @override
  Stream<RealmObjectChanges<RealmFavorites>> changesFor(
          [List<String>? keyPaths]) =>
      RealmObjectBase.getChangesFor<RealmFavorites>(this, keyPaths);

  @override
  RealmFavorites freeze() => RealmObjectBase.freezeObject<RealmFavorites>(this);

  EJsonValue toEJson() {
    return <String, dynamic>{
      'key': key.toEJson(),
      'favorites': favorites.toEJson(),
    };
  }

  static EJsonValue _toEJson(RealmFavorites value) => value.toEJson();
  static RealmFavorites _fromEJson(EJsonValue ejson) {
    if (ejson is! Map<String, dynamic>) return raiseInvalidEJson(ejson);
    return switch (ejson) {
      {
        'key': EJsonValue key,
      } =>
        RealmFavorites(
          fromEJson(key),
          favorites: fromEJson(ejson['favorites'], defaultValue: const []),
        ),
      _ => raiseInvalidEJson(ejson),
    };
  }

  static final schema = () {
    RealmObjectBase.registerFactory(RealmFavorites._);
    register(_toEJson, _fromEJson);
    return const SchemaObject(
        ObjectType.realmObject, RealmFavorites, 'RealmFavorites', [
      SchemaProperty('key', RealmPropertyType.string, primaryKey: true),
      SchemaProperty('favorites', RealmPropertyType.string,
          collectionType: RealmCollectionType.list),
    ]);
  }();

  @override
  SchemaObject get objectSchema => RealmObjectBase.getSchema(this) ?? schema;
}

class RealmLanguage extends _RealmLanguage
    with RealmEntity, RealmObjectBase, RealmObject {
  static var _defaultsSet = false;

  RealmLanguage(
    String key, {
    String language = "en",
  }) {
    if (!_defaultsSet) {
      _defaultsSet = RealmObjectBase.setDefaults<RealmLanguage>({
        'language': "en",
      });
    }
    RealmObjectBase.set(this, 'key', key);
    RealmObjectBase.set(this, 'language', language);
  }

  RealmLanguage._();

  @override
  String get key => RealmObjectBase.get<String>(this, 'key') as String;
  @override
  set key(String value) => RealmObjectBase.set(this, 'key', value);

  @override
  String get language =>
      RealmObjectBase.get<String>(this, 'language') as String;
  @override
  set language(String value) => RealmObjectBase.set(this, 'language', value);

  @override
  Stream<RealmObjectChanges<RealmLanguage>> get changes =>
      RealmObjectBase.getChanges<RealmLanguage>(this);

  @override
  Stream<RealmObjectChanges<RealmLanguage>> changesFor(
          [List<String>? keyPaths]) =>
      RealmObjectBase.getChangesFor<RealmLanguage>(this, keyPaths);

  @override
  RealmLanguage freeze() => RealmObjectBase.freezeObject<RealmLanguage>(this);

  EJsonValue toEJson() {
    return <String, dynamic>{
      'key': key.toEJson(),
      'language': language.toEJson(),
    };
  }

  static EJsonValue _toEJson(RealmLanguage value) => value.toEJson();
  static RealmLanguage _fromEJson(EJsonValue ejson) {
    if (ejson is! Map<String, dynamic>) return raiseInvalidEJson(ejson);
    return switch (ejson) {
      {
        'key': EJsonValue key,
      } =>
        RealmLanguage(
          fromEJson(key),
          language: fromEJson(ejson['language'], defaultValue: "en"),
        ),
      _ => raiseInvalidEJson(ejson),
    };
  }

  static final schema = () {
    RealmObjectBase.registerFactory(RealmLanguage._);
    register(_toEJson, _fromEJson);
    return const SchemaObject(
        ObjectType.realmObject, RealmLanguage, 'RealmLanguage', [
      SchemaProperty('key', RealmPropertyType.string, primaryKey: true),
      SchemaProperty('language', RealmPropertyType.string),
    ]);
  }();

  @override
  SchemaObject get objectSchema => RealmObjectBase.getSchema(this) ?? schema;
}
