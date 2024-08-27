// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'realm_text_theme.dart';

// **************************************************************************
// RealmObjectGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file
class RealmTextStyle extends $RealmTextStyle with RealmEntity, RealmObjectBase, RealmObject {
  static var _defaultsSet = false;

  RealmTextStyle({
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
    RealmObjectBase.set(this, 'fontFamily', fontFamily);
    RealmObjectBase.set(this, 'fontSize', fontSize);
    RealmObjectBase.set(this, 'height', height);
    RealmObjectBase.set(this, 'fontWeight', fontWeight);
  }

  RealmTextStyle._();

  @override
  String get fontFamily => RealmObjectBase.get<String>(this, 'fontFamily') as String;
  @override
  set fontFamily(String value) => RealmObjectBase.set(this, 'fontFamily', value);

  @override
  double get fontSize => RealmObjectBase.get<double>(this, 'fontSize') as double;
  @override
  set fontSize(double value) => RealmObjectBase.set(this, 'fontSize', value);

  @override
  double get height => RealmObjectBase.get<double>(this, 'height') as double;
  @override
  set height(double value) => RealmObjectBase.set(this, 'height', value);

  @override
  String get fontWeight => RealmObjectBase.get<String>(this, 'fontWeight') as String;
  @override
  set fontWeight(String value) => RealmObjectBase.set(this, 'fontWeight', value);

  @override
  Stream<RealmObjectChanges<RealmTextStyle>> get changes => RealmObjectBase.getChanges<RealmTextStyle>(this);

  @override
  Stream<RealmObjectChanges<RealmTextStyle>> changesFor([List<String>? keyPaths]) =>
      RealmObjectBase.getChangesFor<RealmTextStyle>(this, keyPaths);

  @override
  RealmTextStyle freeze() => RealmObjectBase.freezeObject<RealmTextStyle>(this);

  EJsonValue toEJson() {
    return <String, dynamic>{
      'fontFamily': fontFamily.toEJson(),
      'fontSize': fontSize.toEJson(),
      'height': height.toEJson(),
      'fontWeight': fontWeight.toEJson(),
    };
  }

  static EJsonValue _toEJson(RealmTextStyle value) => value.toEJson();
  static RealmTextStyle _fromEJson(EJsonValue ejson) {
    if (ejson is! Map<String, dynamic>) return raiseInvalidEJson(ejson);
    return RealmTextStyle(
      fontFamily: fromEJson(ejson['fontFamily'], defaultValue: "Abril Fatface"),
      fontSize: fromEJson(ejson['fontSize'], defaultValue: 57),
      height: fromEJson(ejson['height'], defaultValue: 64),
      fontWeight: fromEJson(ejson['fontWeight'], defaultValue: "normal"),
    );
  }

  static final schema = () {
    RealmObjectBase.registerFactory(RealmTextStyle._);
    register(_toEJson, _fromEJson);
    return const SchemaObject(ObjectType.realmObject, RealmTextStyle, 'RealmTextStyle', [
      SchemaProperty('fontFamily', RealmPropertyType.string),
      SchemaProperty('fontSize', RealmPropertyType.double),
      SchemaProperty('height', RealmPropertyType.double),
      SchemaProperty('fontWeight', RealmPropertyType.string),
    ]);
  }();

  @override
  SchemaObject get objectSchema => RealmObjectBase.getSchema(this) ?? schema;
}

class RealmTextTheme extends _RealmTextTheme with RealmEntity, RealmObjectBase, RealmObject {
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
  RealmTextStyle? get displayLarge => RealmObjectBase.get<RealmTextStyle>(this, 'displayLarge') as RealmTextStyle?;
  @override
  set displayLarge(covariant RealmTextStyle? value) => RealmObjectBase.set(this, 'displayLarge', value);

  @override
  RealmTextStyle? get displayMedium => RealmObjectBase.get<RealmTextStyle>(this, 'displayMedium') as RealmTextStyle?;
  @override
  set displayMedium(covariant RealmTextStyle? value) => RealmObjectBase.set(this, 'displayMedium', value);

  @override
  RealmTextStyle? get displaySmall => RealmObjectBase.get<RealmTextStyle>(this, 'displaySmall') as RealmTextStyle?;
  @override
  set displaySmall(covariant RealmTextStyle? value) => RealmObjectBase.set(this, 'displaySmall', value);

  @override
  RealmTextStyle? get headlineLarge => RealmObjectBase.get<RealmTextStyle>(this, 'headlineLarge') as RealmTextStyle?;
  @override
  set headlineLarge(covariant RealmTextStyle? value) => RealmObjectBase.set(this, 'headlineLarge', value);

  @override
  RealmTextStyle? get headlineMedium => RealmObjectBase.get<RealmTextStyle>(this, 'headlineMedium') as RealmTextStyle?;
  @override
  set headlineMedium(covariant RealmTextStyle? value) => RealmObjectBase.set(this, 'headlineMedium', value);

  @override
  RealmTextStyle? get headlineSmall => RealmObjectBase.get<RealmTextStyle>(this, 'headlineSmall') as RealmTextStyle?;
  @override
  set headlineSmall(covariant RealmTextStyle? value) => RealmObjectBase.set(this, 'headlineSmall', value);

  @override
  RealmTextStyle? get titleLarge => RealmObjectBase.get<RealmTextStyle>(this, 'titleLarge') as RealmTextStyle?;
  @override
  set titleLarge(covariant RealmTextStyle? value) => RealmObjectBase.set(this, 'titleLarge', value);

  @override
  RealmTextStyle? get titleMedium => RealmObjectBase.get<RealmTextStyle>(this, 'titleMedium') as RealmTextStyle?;
  @override
  set titleMedium(covariant RealmTextStyle? value) => RealmObjectBase.set(this, 'titleMedium', value);

  @override
  RealmTextStyle? get titleSmall => RealmObjectBase.get<RealmTextStyle>(this, 'titleSmall') as RealmTextStyle?;
  @override
  set titleSmall(covariant RealmTextStyle? value) => RealmObjectBase.set(this, 'titleSmall', value);

  @override
  RealmTextStyle? get bodyLarge => RealmObjectBase.get<RealmTextStyle>(this, 'bodyLarge') as RealmTextStyle?;
  @override
  set bodyLarge(covariant RealmTextStyle? value) => RealmObjectBase.set(this, 'bodyLarge', value);

  @override
  RealmTextStyle? get bodyMedium => RealmObjectBase.get<RealmTextStyle>(this, 'bodyMedium') as RealmTextStyle?;
  @override
  set bodyMedium(covariant RealmTextStyle? value) => RealmObjectBase.set(this, 'bodyMedium', value);

  @override
  RealmTextStyle? get bodySmall => RealmObjectBase.get<RealmTextStyle>(this, 'bodySmall') as RealmTextStyle?;
  @override
  set bodySmall(covariant RealmTextStyle? value) => RealmObjectBase.set(this, 'bodySmall', value);

  @override
  RealmTextStyle? get labelLarge => RealmObjectBase.get<RealmTextStyle>(this, 'labelLarge') as RealmTextStyle?;
  @override
  set labelLarge(covariant RealmTextStyle? value) => RealmObjectBase.set(this, 'labelLarge', value);

  @override
  RealmTextStyle? get labelMedium => RealmObjectBase.get<RealmTextStyle>(this, 'labelMedium') as RealmTextStyle?;
  @override
  set labelMedium(covariant RealmTextStyle? value) => RealmObjectBase.set(this, 'labelMedium', value);

  @override
  RealmTextStyle? get labelSmall => RealmObjectBase.get<RealmTextStyle>(this, 'labelSmall') as RealmTextStyle?;
  @override
  set labelSmall(covariant RealmTextStyle? value) => RealmObjectBase.set(this, 'labelSmall', value);

  @override
  Stream<RealmObjectChanges<RealmTextTheme>> get changes => RealmObjectBase.getChanges<RealmTextTheme>(this);

  @override
  Stream<RealmObjectChanges<RealmTextTheme>> changesFor([List<String>? keyPaths]) =>
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
    return const SchemaObject(ObjectType.realmObject, RealmTextTheme, 'RealmTextTheme', [
      SchemaProperty('key', RealmPropertyType.string, primaryKey: true),
      SchemaProperty('displayLarge', RealmPropertyType.object, optional: true, linkTarget: 'RealmTextStyle'),
      SchemaProperty('displayMedium', RealmPropertyType.object, optional: true, linkTarget: 'RealmTextStyle'),
      SchemaProperty('displaySmall', RealmPropertyType.object, optional: true, linkTarget: 'RealmTextStyle'),
      SchemaProperty('headlineLarge', RealmPropertyType.object, optional: true, linkTarget: 'RealmTextStyle'),
      SchemaProperty('headlineMedium', RealmPropertyType.object, optional: true, linkTarget: 'RealmTextStyle'),
      SchemaProperty('headlineSmall', RealmPropertyType.object, optional: true, linkTarget: 'RealmTextStyle'),
      SchemaProperty('titleLarge', RealmPropertyType.object, optional: true, linkTarget: 'RealmTextStyle'),
      SchemaProperty('titleMedium', RealmPropertyType.object, optional: true, linkTarget: 'RealmTextStyle'),
      SchemaProperty('titleSmall', RealmPropertyType.object, optional: true, linkTarget: 'RealmTextStyle'),
      SchemaProperty('bodyLarge', RealmPropertyType.object, optional: true, linkTarget: 'RealmTextStyle'),
      SchemaProperty('bodyMedium', RealmPropertyType.object, optional: true, linkTarget: 'RealmTextStyle'),
      SchemaProperty('bodySmall', RealmPropertyType.object, optional: true, linkTarget: 'RealmTextStyle'),
      SchemaProperty('labelLarge', RealmPropertyType.object, optional: true, linkTarget: 'RealmTextStyle'),
      SchemaProperty('labelMedium', RealmPropertyType.object, optional: true, linkTarget: 'RealmTextStyle'),
      SchemaProperty('labelSmall', RealmPropertyType.object, optional: true, linkTarget: 'RealmTextStyle'),
    ]);
  }();

  @override
  SchemaObject get objectSchema => RealmObjectBase.getSchema(this) ?? schema;
}
