import "package:currency_converter/util/errors/cc_error.dart";
import "package:flutter_test/flutter_test.dart";
import "package:mocktail/mocktail.dart";
import "package:shared_preferences/shared_preferences.dart";

class HasErrorCode extends CustomMatcher {
  HasErrorCode(matcher) : super("CcError with code that is", "code", matcher);

  @override
  Object? featureValueOf(actual) => (actual as CcError).code;
}

class MockSharedPreferences extends Mock implements SharedPreferencesAsync {}
