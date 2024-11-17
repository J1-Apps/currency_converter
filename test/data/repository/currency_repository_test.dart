import "package:currency_converter/data/model/cc_error.dart";
import "package:currency_converter/data/model/currency.dart";
import "package:currency_converter/data/repository/currency_repository.dart";
import "package:currency_converter/data/repository/data_state.dart";
import "package:currency_converter/data/source/local_currency_source/local_currency_source.dart";
import "package:flutter_test/flutter_test.dart";
import "package:j1_environment/j1_environment.dart";
import "package:mocktail/mocktail.dart";

import "../../testing_utils.dart";
import "../../testing_values.dart";

class MockLocalCurrencySource extends Mock implements LocalCurrencySource {}

void main() {
  group("Currency Repository", () {
    final localSource = MockLocalCurrencySource();
    late CurrencyRepository repository;

    setUpAll(() {
      locator.registerSingleton<LocalCurrencySource>(localSource);
    });

    setUp(() {
      repository = CurrencyRepository();
    });

    tearDown(() {
      reset(localSource);
      repository.dispose();
    });

    tearDownAll(() async {
      await locator.reset();
    });

    test("gets all currencies, handling errors", () async {
      expect(
        repository.allCurrenciesStream.handleErrorForTest(),
        emitsInOrder(
          [
            const DataEmpty<List<CurrencyCode>>(),
            DataSuccess(testCurrencies0),
            HasErrorCode(ErrorCode.source_local_currency_allReadError),
            DataSuccess(testCurrencies0),
          ],
        ),
      );

      when(localSource.getAllCurrencies).thenThrow(
        const CcError(ErrorCode.source_local_currency_allReadError),
      );
      await repository.loadAllCurrencies();

      when(localSource.getAllCurrencies).thenAnswer((_) => Future.value(testCurrencies0));
      await repository.loadAllCurrencies();

      verify(localSource.getAllCurrencies).called(2);
    });
  });
}
