import "package:currency_converter/data/model/cc_error.dart";
import "package:currency_converter/data/model/configuration.dart";
import "package:currency_converter/data/model/currency.dart";
import "package:currency_converter/data/repository/configuration_repository.dart";
import "package:currency_converter/data/repository/data_state.dart";
import "package:currency_converter/data/repository/defaults.dart";
import "package:currency_converter/data/source/local_configuration_source/local_configuration_source.dart";
import "package:flutter_test/flutter_test.dart";
import "package:j1_environment/j1_environment.dart";
import "package:mocktail/mocktail.dart";

import "../../testing_utils.dart";
import "../../testing_values.dart";

class MockLocalConfigurationSource extends Mock implements LocalConfigurationSource {}

void main() {
  group("Configuration Repository", () {
    final localSource = MockLocalConfigurationSource();
    late ConfigurationRepository repository;

    setUpAll(() {
      locator.registerSingleton<LocalConfigurationSource>(localSource);
      registerFallbackValue(testConfig0);
    });

    setUp(() {
      repository = ConfigurationRepository();
    });

    tearDown(() {
      reset(localSource);
      repository.dispose();
    });

    tearDownAll(() async {
      await locator.reset();
    });

    test("gets current configuration, handling errors", () async {
      expect(
        repository.currentConfigurationStream.handleErrorForTest(),
        emitsInOrder(
          [
            const DataEmpty<Configuration>(),
            const DataSuccess(defaultConfiguration),
            HasErrorCode(ErrorCode.source_local_configuration_currentReadError),
            const DataSuccess(testConfig0),
          ],
        ),
      );

      when(localSource.getCurrentConfiguration).thenThrow(
        const CcError(ErrorCode.source_local_configuration_currentReadError),
      );
      await repository.loadCurrentConfiguration();

      when(localSource.getCurrentConfiguration).thenAnswer((_) => Future.value(testConfig0));
      await repository.loadCurrentConfiguration();

      verify(localSource.getCurrentConfiguration).called(2);
    });

    test("handles update error when current configuration is not seeded", () async {
      expect(
        repository.currentConfigurationStream.handleErrorForTest(),
        emitsInOrder(
          [
            const DataEmpty<Configuration>(),
            const DataSuccess(defaultConfiguration),
            HasErrorCode(ErrorCode.source_local_configuration_currentReadError),
            DataSuccess(defaultConfiguration.copyWith(baseValue: 10.0)),
            HasErrorCode(ErrorCode.repository_configuration_notSeededError),
          ],
        ),
      );

      when(localSource.getCurrentConfiguration).thenThrow(
        const CcError(ErrorCode.source_local_configuration_currentReadError),
      );
      await repository.loadCurrentConfiguration();

      await repository.updateCurrentBaseValue(10.0);
    });

    test("updates current base value, handling errors", () async {
      expect(
        repository.currentConfigurationStream.handleErrorForTest(),
        emitsInOrder(
          [
            const DataEmpty<Configuration>(),
            const DataSuccess(testConfig0),
            DataSuccess(testConfig0.copyWith(baseValue: 10.0)),
            HasErrorCode(ErrorCode.source_local_configuration_currentWriteError),
          ],
        ),
      );

      when(localSource.getCurrentConfiguration).thenAnswer((_) => Future.value(testConfig0));
      await repository.loadCurrentConfiguration();

      when(() => localSource.updateCurrentConfiguration(any())).thenThrow(
        const CcError(ErrorCode.source_local_configuration_currentWriteError),
      );
      await repository.updateCurrentBaseValue(10.0);
    });

    test("updates current base currency, handling errors", () async {
      expect(
        repository.currentConfigurationStream.handleErrorForTest(),
        emitsInOrder(
          [
            const DataEmpty<Configuration>(),
            const DataSuccess(testConfig0),
            DataSuccess(
              testConfig0.copyWith(
                baseCurrency: CurrencyCode.KRW,
                currencyData: const [
                  ConfigurationCurrency(CurrencyCode.EUR, false),
                  ConfigurationCurrency(CurrencyCode.USD, false),
                ],
              ),
            ),
            HasErrorCode(ErrorCode.source_local_configuration_currentWriteError),
          ],
        ),
      );

      when(localSource.getCurrentConfiguration).thenAnswer((_) => Future.value(testConfig0));
      await repository.loadCurrentConfiguration();

      when(() => localSource.updateCurrentConfiguration(any())).thenThrow(
        const CcError(ErrorCode.source_local_configuration_currentWriteError),
      );
      await repository.updateCurrentBaseCurrency(CurrencyCode.KRW, 1.0);
    });

    test("toggles and update current currencies", () async {
      expect(
        repository.currentConfigurationStream.handleErrorForTest(),
        emitsInOrder(
          [
            const DataEmpty<Configuration>(),
            const DataSuccess(testConfig0),
            DataSuccess(
              testConfig0.copyWith(
                currencyData: const [
                  ConfigurationCurrency(CurrencyCode.EUR, false),
                ],
              ),
            ),
            const DataSuccess(testConfig0),
            HasErrorCode(ErrorCode.repository_configuration_missingIndexError),
            DataSuccess(
              testConfig0.copyWith(
                currencyData: const [
                  ConfigurationCurrency(CurrencyCode.EUR, false),
                  ConfigurationCurrency(CurrencyCode.MXN, false),
                ],
              ),
            ),
          ],
        ),
      );

      when(localSource.getCurrentConfiguration).thenAnswer((_) => Future.value(testConfig0));
      await repository.loadCurrentConfiguration();

      when(() => localSource.updateCurrentConfiguration(any())).thenAnswer((_) => Future.value());
      await repository.toggleCurrentCurrency(CurrencyCode.KRW);
      await repository.toggleCurrentCurrency(CurrencyCode.KRW);

      await repository.updateCurrentCurrency(CurrencyCode.MXN, -1);
      await repository.updateCurrentCurrency(CurrencyCode.MXN, 1);
    });

    test("gets and updates configurations, handling errors", () async {
      expect(
        repository.configurationsStream.handleErrorForTest(),
        emitsInOrder(
          [
            const DataEmpty<List<Configuration>>(),
            const DataEmpty<List<Configuration>>(),
            HasErrorCode(ErrorCode.source_local_configuration_readError),
            const DataSuccess([testConfig0]),
            const DataSuccess([testConfig0, testConfig1]),
            HasErrorCode(ErrorCode.source_local_configuration_writeError),
            const DataSuccess([testConfig1]),
          ],
        ),
      );

      when(localSource.getConfigurations).thenThrow(const CcError(ErrorCode.source_local_configuration_readError));
      await repository.loadConfigurations();

      when(localSource.getConfigurations).thenAnswer((_) => Future.value([testConfig0]));
      await repository.loadConfigurations();

      when(() => localSource.updateConfigurations(any())).thenThrow(
        const CcError(ErrorCode.source_local_configuration_writeError),
      );
      await repository.updateConfigurations([testConfig0, testConfig1]);

      when(() => localSource.updateConfigurations(any())).thenAnswer((_) => Future.value());
      await repository.updateConfigurations([testConfig1]);

      verify(localSource.getConfigurations).called(2);
      verify(() => localSource.updateConfigurations([testConfig1])).called(1);
      verify(() => localSource.updateConfigurations([testConfig0, testConfig1])).called(1);
    });
  });
}
