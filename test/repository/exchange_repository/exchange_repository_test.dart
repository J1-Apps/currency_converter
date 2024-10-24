import "package:currency_converter/repository/exchange_repository/exchange_repository.dart";
import "package:currency_converter/source/remote_exchange_source.dart/remote_exchange_source.dart";
import "package:flutter_test/flutter_test.dart";
import "package:mocktail/mocktail.dart";

import "../../testing_values.dart";

class MockRemoteExchangeSource extends Mock implements RemoteExchangeSource {}

void main() {
  group("Exchange Repository", () {
    final source = MockRemoteExchangeSource();
    late ExchangeRepository repository;

    setUp(() {
      repository = ExchangeRepository(exchangeSource: source);
    });

    tearDown(() {
      reset(source);
    });

    test("gets exchange snapshot", () async {
      when(source.getExchangeRateSnapshot).thenAnswer((_) => Future.value(testSnapshot0));

      expect(
        await repository.getExchangeRateSnapshot(),
        testSnapshot0,
      );

      verify(source.getExchangeRateSnapshot).called(1);
    });
  });
}
