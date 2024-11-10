import "package:currency_converter/data/model/cc_error.dart";
import "package:currency_converter/data/repository/defaults.dart";
import "package:currency_converter/data/source/local_configuration_source/preferences_local_configuration_source.dart";
import "package:flutter_test/flutter_test.dart";
import "package:mocktail/mocktail.dart";

import "../../../testing_utils.dart";
import "../../../testing_values.dart";

void main() {
  group("Preferences Local Configuration Source", () {
    final preferences = MockSharedPreferences();

    tearDown(() {
      reset(preferences);
    });

    test("gets and updates current configuration", () async {
      when(() => preferences.setString("ccCurrentConfiguration", any())).thenAnswer((_) => Future.value());

      final source = PreferencesLocalConfigurationSource(preferences: preferences);

      when(() => preferences.getString("ccCurrentConfiguration")).thenAnswer((_) => Future.value());

      final initialConfig = await source.getCurrentConfiguration();
      expect(initialConfig, defaultConfiguration);

      when(() => preferences.getString("ccCurrentConfiguration")).thenAnswer((_) => Future.value(testConfig0.toJson()));

      await source.updateCurrentConfiguration(testConfig0);
      verify(() => preferences.setString("ccCurrentConfiguration", testConfig0.toJson())).called(1);

      final config0 = await source.getCurrentConfiguration();
      expect(config0, testConfig0);

      when(() => preferences.getString("ccCurrentConfiguration")).thenAnswer((_) => Future.value(testConfig1.toJson()));

      await source.updateCurrentConfiguration(testConfig1);
      verify(() => preferences.setString("ccCurrentConfiguration", testConfig1.toJson())).called(1);

      final config1 = await source.getCurrentConfiguration();
      expect(config1, testConfig1);
    });

    test("handles get current configuration error", () async {
      when(() => preferences.getString("ccCurrentConfiguration")).thenThrow(StateError("test error"));

      final source = PreferencesLocalConfigurationSource(preferences: preferences);

      expect(
        () async => source.getCurrentConfiguration(),
        throwsA(HasErrorCode(ErrorCode.source_local_configuration_currentReadError)),
      );
    });

    test("handles set current configuration error", () async {
      when(() => preferences.setString("ccCurrentConfiguration", any())).thenThrow(StateError("test error"));

      final repository = PreferencesLocalConfigurationSource(preferences: preferences);

      expect(
        () async => repository.updateCurrentConfiguration(testConfig0),
        throwsA(HasErrorCode(ErrorCode.source_local_configuration_currentWriteError)),
      );
    });

    test("gets and sets configurations", () async {
      when(() => preferences.setStringList("ccConfigurations", any())).thenAnswer((_) => Future.value());

      final source = PreferencesLocalConfigurationSource(preferences: preferences);

      when(() => preferences.getStringList("ccConfigurations")).thenAnswer((_) => Future.value());

      expect(await source.getConfigurations(), []);
      await source.updateConfigurations([testConfig0]);

      when(() => preferences.getStringList("ccConfigurations")).thenAnswer((_) => Future.value([
            testConfig0.toJson(),
          ]));

      expect(await source.getConfigurations(), [testConfig0]);
      await source.updateConfigurations([testConfig0, testConfig1]);

      when(() => preferences.getStringList("ccConfigurations")).thenAnswer((_) => Future.value([
            testConfig0.toJson(),
            testConfig1.toJson(),
          ]));

      expect(await source.getConfigurations(), [testConfig0, testConfig1]);
    });

    test("handles get configurations error", () async {
      when(() => preferences.getStringList("ccConfigurations")).thenThrow(StateError("test error"));

      final source = PreferencesLocalConfigurationSource(preferences: preferences);

      expect(
        () async => source.getConfigurations(),
        throwsA(HasErrorCode(ErrorCode.source_local_configuration_readError)),
      );
    });

    test("handles set configuration error", () async {
      when(() => preferences.setStringList("ccConfigurations", any())).thenThrow(StateError("test error"));

      final repository = PreferencesLocalConfigurationSource(preferences: preferences);

      expect(
        () async => repository.updateConfigurations([]),
        throwsA(HasErrorCode(ErrorCode.source_local_configuration_writeError)),
      );
    });
  });
}
