import "package:currency_converter/util/environment/environment.dart";
import "package:firebase_core/firebase_core.dart";

class ProdEnvironment extends Environment {
  @override
  FirebaseOptions? get firebaseOptions => throw UnimplementedError();
}
