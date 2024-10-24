import "package:currency_converter/model/cc_error.dart";
import "package:currency_converter/source/local_configuration_source/preferences_local_configuration_source.dart";
import "package:flutter_test/flutter_test.dart";
import "package:mocktail/mocktail.dart";

import "../../testing_utils.dart";
import "../../testing_values.dart";

void main() {
  group("Preferences Local Configuration Source", () {
    final preferences = MockSharedPreferences();

    tearDown(() {
      reset(preferences);
    });

    test("gets and updates current configuration", () async {
      when(() => preferences.getString(any())).thenAnswer((_) => Future.value());
      when(() => preferences.getStringList(any())).thenAnswer((_) => Future.value());
      when(() => preferences.setString(any(), any())).thenAnswer((_) => Future.value());
      when(() => preferences.setStringList(any(), any())).thenAnswer((_) => Future.value());

      final source = PreferencesLocalConfigurationSource(preferences: preferences);

      when(() => preferences.getString("ccCurrentConfiguration")).thenAnswer((_) => Future.value());

      final initialConfig = await source.getCurrentConfiguration();
      expect(initialConfig, null);

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

    test("handles get configuration error", () async {
      when(() => preferences.getString(any())).thenAnswer((_) => Future.value());
      when(() => preferences.getStringList(any())).thenAnswer((_) => Future.value());
      when(() => preferences.setString(any(), any())).thenAnswer((_) => Future.value());
      when(() => preferences.setStringList(any(), any())).thenAnswer((_) => Future.value());

      when(() => preferences.getString("ccCurrentConfiguration")).thenThrow(StateError("test error"));

      final source = PreferencesLocalConfigurationSource(preferences: preferences);

      expect(
        () async => source.getCurrentConfiguration(),
        throwsA(HasErrorCode(ErrorCode.source_local_configuration_currentReadError)),
      );
    });

    test("gets and sets configurations", () async {
      when(() => preferences.getString(any())).thenAnswer((_) => Future.value());
      when(() => preferences.getStringList(any())).thenAnswer((_) => Future.value());
      when(() => preferences.setString(any(), any())).thenAnswer((_) => Future.value());
      when(() => preferences.setStringList(any(), any())).thenAnswer((_) => Future.value());

      final source = PreferencesLocalConfigurationSource(preferences: preferences);

      when(() => preferences.getStringList("ccConfigurations")).thenAnswer((_) => Future.value([]));

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
  });
}
