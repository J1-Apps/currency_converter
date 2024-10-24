import "package:currency_converter/repository/configuration_repository.dart";
import "package:currency_converter/source/local_configuration_source/local_configuration_source.dart";
import "package:flutter_test/flutter_test.dart";
import "package:j1_environment/j1_environment.dart";
import "package:mocktail/mocktail.dart";

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
    });

    tearDownAll(() async {
      await locator.reset();
    });

    test("gets current configuration", () async {
      when(localSource.getCurrentConfiguration).thenAnswer((_) => Future.value(testConfig0));

      final configuration = await repository.getCurrentConfiguration();

      expect(configuration, testConfig0);
      verify(localSource.getCurrentConfiguration).called(1);
    });

    test("updates current configuration", () async {
      when(() => localSource.updateCurrentConfiguration(any())).thenAnswer((_) => Future.value());

      await repository.updateCurrentConfiguration(testConfig0);

      verify(() => localSource.updateCurrentConfiguration(testConfig0)).called(1);
    });

    test("gets configurations", () async {
      when(localSource.getConfigurations).thenAnswer((_) => Future.value([testConfig0, testConfig1]));

      final configurations = await repository.getConfigurations();

      expect(configurations, [testConfig0, testConfig1]);
      verify(localSource.getConfigurations).called(1);
    });

    test("updates configurations", () async {
      when(() => localSource.updateConfigurations(any())).thenAnswer((_) => Future.value());

      await repository.updateConfigurations([testConfig0, testConfig1]);

      verify(() => localSource.updateConfigurations([testConfig0, testConfig1])).called(1);
    });
  });
}
