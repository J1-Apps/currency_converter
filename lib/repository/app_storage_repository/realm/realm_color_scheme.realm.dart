// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'realm_color_scheme.dart';

// **************************************************************************
// RealmObjectGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file
class RealmColorScheme extends _RealmColorScheme with RealmEntity, RealmObjectBase, RealmObject {
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
  String get brightness => RealmObjectBase.get<String>(this, 'brightness') as String;
  @override
  set brightness(String value) => RealmObjectBase.set(this, 'brightness', value);

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
  Stream<RealmObjectChanges<RealmColorScheme>> get changes => RealmObjectBase.getChanges<RealmColorScheme>(this);

  @override
  Stream<RealmObjectChanges<RealmColorScheme>> changesFor([List<String>? keyPaths]) =>
      RealmObjectBase.getChangesFor<RealmColorScheme>(this, keyPaths);

  @override
  RealmColorScheme freeze() => RealmObjectBase.freezeObject<RealmColorScheme>(this);

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
          onSecondary: fromEJson(ejson['onSecondary'], defaultValue: 0xFF121212),
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
    return const SchemaObject(ObjectType.realmObject, RealmColorScheme, 'RealmColorScheme', [
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
