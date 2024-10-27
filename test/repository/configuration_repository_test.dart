import "package:currency_converter/model/cc_error.dart";
import "package:currency_converter/model/configuration.dart";
import "package:currency_converter/repository/configuration_repository.dart";
import "package:currency_converter/repository/data_state.dart";
import "package:currency_converter/source/local_configuration_source/local_configuration_source.dart";
import "package:flutter_test/flutter_test.dart";
import "package:j1_environment/j1_environment.dart";
import "package:mocktail/mocktail.dart";

import "../testing_utils.dart";
import "../testing_values.dart";

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

    test("gets and updates current configuration, handling errors", () async {
      expect(
        repository.currentConfiguration.handleErrorForTest(),
        emitsInOrder(
          [
            const DataEmpty<Configuration>(),
            const DataEmpty<Configuration>(),
            HasErrorCode(ErrorCode.source_local_configuration_currentReadError),
            const DataSuccess(testConfig0),
            const DataSuccess(testConfig1),
            HasErrorCode(ErrorCode.source_local_configuration_currentWriteError),
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

      when(() => localSource.updateCurrentConfiguration(any())).thenThrow(
        const CcError(ErrorCode.source_local_configuration_currentWriteError),
      );
      await repository.updateCurrentConfiguration(testConfig1);

      when(() => localSource.updateCurrentConfiguration(any())).thenAnswer((_) => Future.value());
      await repository.updateCurrentConfiguration(testConfig0);

      verify(localSource.getCurrentConfiguration).called(2);
      verify(() => localSource.updateCurrentConfiguration(testConfig0)).called(1);
      verify(() => localSource.updateCurrentConfiguration(testConfig1)).called(1);
    });

    test("gets and updates configurations, handling errors", () async {
      expect(
        repository.configurations.handleErrorForTest(),
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
