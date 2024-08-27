// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'realm_catalog.dart';

// **************************************************************************
// RealmObjectGenerator
// **************************************************************************

// ignore_for_file: type=lint
class RealmFavorites extends _RealmFavorites with RealmEntity, RealmObjectBase, RealmObject {
  RealmFavorites(
    String key, {
    Iterable<String> favorites = const [],
  }) {
    RealmObjectBase.set(this, 'key', key);
    RealmObjectBase.set<RealmList<String>>(this, 'favorites', RealmList<String>(favorites));
  }

  RealmFavorites._();

  @override
  String get key => RealmObjectBase.get<String>(this, 'key') as String;
  @override
  set key(String value) => RealmObjectBase.set(this, 'key', value);

  @override
  RealmList<String> get favorites => RealmObjectBase.get<String>(this, 'favorites') as RealmList<String>;
  @override
  set favorites(covariant RealmList<String> value) => throw RealmUnsupportedSetError();

  @override
  Stream<RealmObjectChanges<RealmFavorites>> get changes => RealmObjectBase.getChanges<RealmFavorites>(this);

  @override
  Stream<RealmObjectChanges<RealmFavorites>> changesFor([List<String>? keyPaths]) =>
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
    return const SchemaObject(ObjectType.realmObject, RealmFavorites, 'RealmFavorites', [
      SchemaProperty('key', RealmPropertyType.string, primaryKey: true),
      SchemaProperty('favorites', RealmPropertyType.string, collectionType: RealmCollectionType.list),
    ]);
  }();

  @override
  SchemaObject get objectSchema => RealmObjectBase.getSchema(this) ?? schema;
}

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
