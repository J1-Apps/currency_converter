import "package:currency_converter/repository/app_storage_repository/app_storage_repository.dart";
import "package:currency_converter/repository/exchange_rate_repository/exchange_rate_repository.dart";
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

// Mock Repositories

class MockAppStorageRepository extends Mock implements AppStorageRepository {}

class MockExchangeRateRepository extends Mock implements ExchangeRateRepository {}
