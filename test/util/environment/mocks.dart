import "package:currency_converter/repository/app_storage_repository/realm/realm_color_scheme.dart";
import "package:firebase_core_platform_interface/firebase_core_platform_interface.dart";
import "package:flutter/services.dart";
import "package:flutter_test/flutter_test.dart";
import "package:mocktail/mocktail.dart";
import "package:realm/realm.dart";

// Firebase

typedef Callback = void Function(MethodCall call);

void setupFirebaseAuthMocks([Callback? customHandlers]) {
  TestWidgetsFlutterBinding.ensureInitialized();

  setupFirebaseCoreMocks();
}

Future<T> neverEndingFuture<T>() async {
  // ignore: literal_only_boolean_expressions
  while (true) {
    await Future.delayed(const Duration(minutes: 5));
  }
}

// Realm

class MockRealm extends Mock implements Realm {}

class MockRealmColorScheme extends Mock implements RealmColorScheme {}
