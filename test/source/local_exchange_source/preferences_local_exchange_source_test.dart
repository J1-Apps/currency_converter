import "package:currency_converter/model/cc_error.dart";
import "package:currency_converter/source/local_exchange_source/preferences_local_exchange_source.dart";
import "package:flutter_test/flutter_test.dart";
import "package:mocktail/mocktail.dart";

import "../../testing_utils.dart";
import "../../testing_values.dart";

void main() {
  group("Preferences Local Exchange Source", () {
    final preferences = MockSharedPreferences();

    tearDown(() {
      reset(preferences);
    });

    test("gets and updates current exchange rate", () async {
      when(() => preferences.getString(any())).thenAnswer((_) => Future.value());
      when(() => preferences.getStringList(any())).thenAnswer((_) => Future.value());
      when(() => preferences.setString(any(), any())).thenAnswer((_) => Future.value());
      when(() => preferences.setStringList(any(), any())).thenAnswer((_) => Future.value());

      final source = PreferencesLocalExchangeSource(preferences: preferences);

      when(() => preferences.getString("ccSnapshot")).thenAnswer((_) => Future.value());

      final initialConfig = await source.getExchangeRate();
      expect(initialConfig, null);

      when(() => preferences.getString("ccSnapshot")).thenAnswer((_) => Future.value(testSnapshot0.toJson()));

      await source.updateExchangeRate(testSnapshot0);
      verify(() => preferences.setString("ccSnapshot", testSnapshot0.toJson())).called(1);

      final snapshot0 = await source.getExchangeRate();
      expect(snapshot0, testSnapshot0);

      when(() => preferences.getString("ccSnapshot")).thenAnswer((_) => Future.value(testSnapshot1.toJson()));

      await source.updateExchangeRate(testSnapshot1);
      verify(() => preferences.setString("ccSnapshot", testSnapshot1.toJson())).called(1);

      final snapshot1 = await source.getExchangeRate();
      expect(snapshot1, testSnapshot1);
    });

    test("handles get exchange rate error", () async {
      when(() => preferences.getString(any())).thenAnswer((_) => Future.value());
      when(() => preferences.getStringList(any())).thenAnswer((_) => Future.value());
      when(() => preferences.setString(any(), any())).thenAnswer((_) => Future.value());
      when(() => preferences.setStringList(any(), any())).thenAnswer((_) => Future.value());

      when(() => preferences.getString("ccSnapshot")).thenThrow(StateError("test error"));

      final repository = PreferencesLocalExchangeSource(preferences: preferences);

      expect(
        () async => repository.getExchangeRate(),
        throwsA(HasErrorCode(ErrorCode.source_appStorage_readExchangeError)),
      );
    });
  });
}
