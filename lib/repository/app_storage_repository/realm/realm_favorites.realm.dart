// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'realm_favorites.dart';

// **************************************************************************
// RealmObjectGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file
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
