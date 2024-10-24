import "package:currency_converter/model/cc_error.dart";
import "package:currency_converter/repository/exchange_repository.dart";
import "package:currency_converter/source/local_exchange_source/local_exchange_source.dart";
import "package:currency_converter/source/remote_exchange_source/remote_exchange_source.dart";
import "package:flutter_test/flutter_test.dart";
import "package:j1_environment/j1_environment.dart";
import "package:mocktail/mocktail.dart";

import "../testing_values.dart";

class MockRemoteExchangeSource extends Mock implements RemoteExchangeSource {}

class MockLocalExchangeSource extends Mock implements LocalExchangeSource {}

void main() {
  group("Exchange Repository", () {
    final remoteSource = MockRemoteExchangeSource();
    final localSource = MockLocalExchangeSource();
    late ExchangeRepository repository;

    setUpAll(() {
      locator.registerSingleton<RemoteExchangeSource>(remoteSource);
      locator.registerSingleton<LocalExchangeSource>(localSource);
      registerFallbackValue(testSnapshot0);
    });

    setUp(() {
      repository = ExchangeRepository();
    });

    tearDown(() {
      reset(remoteSource);
      reset(localSource);
    });

    tearDownAll(() async {
      await locator.reset();
    });

    test("gets remote exchange snapshot", () async {
      when(remoteSource.getExchangeRate).thenAnswer((_) => Future.value(testSnapshot0));

      final snapshot = await repository.getExchangeRate();

      expect(snapshot, testSnapshot0);
      verify(remoteSource.getExchangeRate).called(1);
      verify(() => localSource.updateExchangeRate(any())).called(1);
    });

    test("gets local exchange snapshot when remote fails", () async {
      when(remoteSource.getExchangeRate).thenThrow(const CcError(ErrorCode.source_appStorage_readExchangeError));
      when(localSource.getExchangeRate).thenAnswer((_) => Future.value(testSnapshot0));

      final snapshot = await repository.getExchangeRate();

      expect(snapshot, testSnapshot0);
      verify(remoteSource.getExchangeRate).called(1);
      verify(localSource.getExchangeRate).called(1);
      verifyNever(() => localSource.updateExchangeRate(any()));
    });
  });
}
