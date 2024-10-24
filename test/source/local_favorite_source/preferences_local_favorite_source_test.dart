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
      when(() => preferences.getString(any())).thenAnswer((_) => Future.value());
      when(() => preferences.getStringList(any())).thenAnswer((_) => Future.value());
      when(() => preferences.setString(any(), any())).thenAnswer((_) => Future.value());
      when(() => preferences.setStringList(any(), any())).thenAnswer((_) => Future.value());

      final source = PreferencesLocalFavoriteSource(preferences: preferences);

      when(() => preferences.getStringList("ccConfigurations")).thenAnswer((_) => Future.value([]));

      expect(await source.getFavorites(), []);
      await source.updateFavorites([CurrencyCode.USD]);

      when(() => preferences.getStringList("ccConfigurations")).thenAnswer((_) => Future.value([
            CurrencyCode.USD.toValue(),
          ]));

      expect(await source.getFavorites(), [CurrencyCode.USD]);
      await source.updateFavorites([CurrencyCode.USD, CurrencyCode.KRW]);

      when(() => preferences.getStringList("ccConfigurations")).thenAnswer((_) => Future.value([
            CurrencyCode.USD.toValue(),
            CurrencyCode.KRW.toValue(),
          ]));

      expect(await source.getFavorites(), [CurrencyCode.USD, CurrencyCode.KRW]);
    });
  });
}
