import "package:currency_converter/data/model/cc_error.dart";
import "package:currency_converter/data/model/exchange_rate.dart";
import "package:currency_converter/data/repository/data_state.dart";
import "package:currency_converter/data/repository/exchange_repository.dart";
import "package:currency_converter/data/source/local_exchange_source/local_exchange_source.dart";
import "package:currency_converter/data/source/remote_exchange_source/remote_exchange_source.dart";
import "package:flutter_test/flutter_test.dart";
import "package:j1_environment/j1_environment.dart";
import "package:mocktail/mocktail.dart";

import "../../testing_utils.dart";
import "../../testing_values.dart";

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
      repository.dispose();
    });

    tearDownAll(() async {
      await locator.reset();
    });

    test("gets remote exchange snapshot", () async {
      when(remoteSource.getExchangeRate).thenAnswer((_) => Future.value(testSnapshot0));
      when(() => localSource.updateExchangeRate(any())).thenAnswer((_) => Future.value());

      expect(
        repository.exchangeRateStream,
        emitsInOrder(
          [
            const DataEmpty<ExchangeRateSnapshot>(),
            DataSuccess(testSnapshot0),
          ],
        ),
      );

      await repository.loadExchangeRate();

      verify(remoteSource.getExchangeRate).called(1);
      verifyNever(localSource.getExchangeRate);
      verify(() => localSource.updateExchangeRate(testSnapshot0)).called(1);

      expect(repository.exchangeRate, DataSuccess(testSnapshot0));
    });

    test("gets remote exchange snapshot and handles update error", () async {
      when(remoteSource.getExchangeRate).thenAnswer((_) => Future.value(testSnapshot0));
      when(() => localSource.updateExchangeRate(any()))
          .thenThrow(const CcError(ErrorCode.source_local_exchange_writeError));

      expect(
        repository.exchangeRateStream.handleErrorForTest(),
        emitsInOrder(
          [
            const DataEmpty<ExchangeRateSnapshot>(),
            DataSuccess(testSnapshot0),
            HasErrorCode(ErrorCode.source_local_exchange_writeError),
          ],
        ),
      );

      await repository.loadExchangeRate();

      verify(remoteSource.getExchangeRate).called(1);
      verifyNever(localSource.getExchangeRate);
      verify(() => localSource.updateExchangeRate(testSnapshot0)).called(1);
    });

    test("gets local exchange snapshot when remote fails", () async {
      when(remoteSource.getExchangeRate).thenThrow(const CcError(ErrorCode.source_remote_exchange_httpError));
      when(localSource.getExchangeRate).thenAnswer((_) => Future.value(testSnapshot0));

      expect(
        repository.exchangeRateStream.handleErrorForTest(),
        emitsInOrder(
          [
            const DataEmpty<ExchangeRateSnapshot>(),
            HasErrorCode(ErrorCode.source_remote_exchange_httpError),
            DataSuccess(testSnapshot0),
          ],
        ),
      );

      await repository.loadExchangeRate();

      verify(remoteSource.getExchangeRate).called(1);
      verify(localSource.getExchangeRate).called(1);
      verifyNever(() => localSource.updateExchangeRate(any()));
    });

    test("gets error when local returns null", () async {
      when(remoteSource.getExchangeRate).thenThrow(const CcError(ErrorCode.source_remote_exchange_httpError));
      when(localSource.getExchangeRate).thenAnswer((_) => Future.value());

      expect(
        repository.exchangeRateStream.handleErrorForTest(),
        emitsInOrder(
          [
            const DataEmpty<ExchangeRateSnapshot>(),
            HasErrorCode(ErrorCode.source_remote_exchange_httpError),
            const DataEmpty<ExchangeRateSnapshot>(),
            HasErrorCode(ErrorCode.repository_exchange_noExchangeError),
          ],
        ),
      );

      await repository.loadExchangeRate();

      verify(remoteSource.getExchangeRate).called(1);
      verify(localSource.getExchangeRate).called(1);
      verifyNever(() => localSource.updateExchangeRate(any()));
    });

    test("gets error when local fails", () async {
      when(remoteSource.getExchangeRate).thenThrow(const CcError(ErrorCode.source_remote_exchange_httpError));
      when(localSource.getExchangeRate).thenThrow(const CcError(ErrorCode.source_local_exchange_readError));

      final errors = <Object>[];

      expect(
        repository.exchangeRateStream.handleError(errors.add),
        emitsInOrder(
          [
            const DataEmpty<ExchangeRateSnapshot>(),
            const DataEmpty<ExchangeRateSnapshot>(),
          ],
        ),
      );

      await repository.loadExchangeRate();
      await waitMs();

      expect(
        errors,
        [
          HasErrorCode(ErrorCode.source_remote_exchange_httpError),
          HasErrorCode(ErrorCode.source_local_exchange_readError),
        ],
      );

      verify(remoteSource.getExchangeRate).called(1);
      verify(localSource.getExchangeRate).called(1);
      verifyNever(() => localSource.updateExchangeRate(any()));
    });
  });
}
