import "package:currency_converter/model/cc_error.dart";
import "package:currency_converter/repository/app_storage_repository/defaults.dart";
import "package:currency_converter/source/local_language_source/preferences_local_language_source.dart";
import "package:flutter_test/flutter_test.dart";
import "package:mocktail/mocktail.dart";

import "../../testing_utils.dart";

void main() {
  group("Preferences Local Language Source", () {
    final preferences = MockSharedPreferences();

    tearDown(() {
      reset(preferences);
    });

    test("gets and sets language", () async {
      when(() => preferences.setString("ccLanguage", any())).thenAnswer((_) => Future.value());

      final source = PreferencesLocalLanguageSource(preferences: preferences);

      when(() => preferences.getString("ccLanguage")).thenAnswer((_) => Future.value());

      expect(await source.getLanguage(), defaultLanguage);
      await source.updateLanguage("kr");

      when(() => preferences.getString("ccLanguage")).thenAnswer((_) => Future.value("kr"));

      expect(await source.getLanguage(), "kr");
      await source.updateLanguage("es");

      when(() => preferences.getString("ccLanguage")).thenAnswer((_) => Future.value("es"));

      expect(await source.getLanguage(), "es");
    });

    test("handles get language error", () async {
      when(() => preferences.getString("ccLanguage")).thenThrow(StateError("test error"));

      final repository = PreferencesLocalLanguageSource(preferences: preferences);

      expect(
        () async => repository.getLanguage(),
        throwsA(HasErrorCode(ErrorCode.source_local_language_readError)),
      );
    });

    test("handles set favorites error", () async {
      when(() => preferences.setString("ccLanguage", any())).thenThrow(StateError("test error"));

      final repository = PreferencesLocalLanguageSource(preferences: preferences);

      expect(
        () async => repository.updateLanguage("kr"),
        throwsA(HasErrorCode(ErrorCode.source_local_language_writeError)),
      );
    });
  });
}
