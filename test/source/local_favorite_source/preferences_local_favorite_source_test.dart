import "package:currency_converter/model/cc_error.dart";
import "package:currency_converter/model/currency.dart";
import "package:currency_converter/source/local_favorite_source/preferences_local_favorite_source.dart";
import "package:flutter_test/flutter_test.dart";
import "package:mocktail/mocktail.dart";

import "../../testing_utils.dart";

void main() {
  group("Preferences Local Favorite Source", () {
    final preferences = MockSharedPreferences();

    tearDown(() {
      reset(preferences);
    });

    test("gets and sets favorites", () async {
      when(() => preferences.setStringList("ccFavorites", any())).thenAnswer((_) => Future.value());

      final source = PreferencesLocalFavoriteSource(preferences: preferences);

      when(() => preferences.getStringList("ccFavorites")).thenAnswer((_) => Future.value([]));

      expect(await source.getFavorites(), []);
      await source.updateFavorites([CurrencyCode.USD]);

      when(() => preferences.getStringList("ccFavorites")).thenAnswer((_) => Future.value([
            CurrencyCode.USD.toValue(),
          ]));

      expect(await source.getFavorites(), [CurrencyCode.USD]);
      await source.updateFavorites([CurrencyCode.USD, CurrencyCode.KRW]);

      when(() => preferences.getStringList("ccFavorites")).thenAnswer((_) => Future.value([
            CurrencyCode.USD.toValue(),
            CurrencyCode.KRW.toValue(),
          ]));

      expect(await source.getFavorites(), [CurrencyCode.USD, CurrencyCode.KRW]);
    });

    test("handles get favorites error", () async {
      when(() => preferences.getStringList("ccFavorites")).thenThrow(StateError("test error"));

      final repository = PreferencesLocalFavoriteSource(preferences: preferences);

      expect(
        () async => repository.getFavorites(),
        throwsA(HasErrorCode(ErrorCode.source_local_favorite_readError)),
      );
    });

    test("handles set favorites error", () async {
      when(() => preferences.setStringList("ccFavorites", any())).thenThrow(StateError("test error"));

      final repository = PreferencesLocalFavoriteSource(preferences: preferences);

      expect(
        () async => repository.updateFavorites([]),
        throwsA(HasErrorCode(ErrorCode.source_local_favorite_writeError)),
      );
    });
  });
}
