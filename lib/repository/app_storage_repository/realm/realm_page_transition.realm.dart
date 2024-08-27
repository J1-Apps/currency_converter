// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'realm_page_transition.dart';

// **************************************************************************
// RealmObjectGenerator
// **************************************************************************

// ignore_for_file: type=lint
class RealmPageTransition extends _RealmPageTransition with RealmEntity, RealmObjectBase, RealmObject {
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
  String get pageTransition => RealmObjectBase.get<String>(this, 'pageTransition') as String;
  @override
  set pageTransition(String value) => RealmObjectBase.set(this, 'pageTransition', value);

  @override
  Stream<RealmObjectChanges<RealmPageTransition>> get changes => RealmObjectBase.getChanges<RealmPageTransition>(this);

  @override
  Stream<RealmObjectChanges<RealmPageTransition>> changesFor([List<String>? keyPaths]) =>
      RealmObjectBase.getChangesFor<RealmPageTransition>(this, keyPaths);

  @override
  RealmPageTransition freeze() => RealmObjectBase.freezeObject<RealmPageTransition>(this);

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
          pageTransition: fromEJson(ejson['pageTransition'], defaultValue: "cupertino"),
        ),
      _ => raiseInvalidEJson(ejson),
    };
  }

  static final schema = () {
    RealmObjectBase.registerFactory(RealmPageTransition._);
    register(_toEJson, _fromEJson);
    return const SchemaObject(ObjectType.realmObject, RealmPageTransition, 'RealmPageTransition', [
      SchemaProperty('key', RealmPropertyType.string, primaryKey: true),
      SchemaProperty('pageTransition', RealmPropertyType.string),
    ]);
  }();

  @override
  SchemaObject get objectSchema => RealmObjectBase.getSchema(this) ?? schema;
}
