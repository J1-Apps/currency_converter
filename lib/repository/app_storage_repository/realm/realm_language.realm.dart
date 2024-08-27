// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'realm_language.dart';

// **************************************************************************
// RealmObjectGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file
class RealmLanguage extends _RealmLanguage with RealmEntity, RealmObjectBase, RealmObject {
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
  String get language => RealmObjectBase.get<String>(this, 'language') as String;
  @override
  set language(String value) => RealmObjectBase.set(this, 'language', value);

  @override
  Stream<RealmObjectChanges<RealmLanguage>> get changes => RealmObjectBase.getChanges<RealmLanguage>(this);

  @override
  Stream<RealmObjectChanges<RealmLanguage>> changesFor([List<String>? keyPaths]) =>
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
    return const SchemaObject(ObjectType.realmObject, RealmLanguage, 'RealmLanguage', [
      SchemaProperty('key', RealmPropertyType.string, primaryKey: true),
      SchemaProperty('language', RealmPropertyType.string),
    ]);
  }();

  @override
  SchemaObject get objectSchema => RealmObjectBase.getSchema(this) ?? schema;
}
