import "package:currency_converter/model/currency.dart";
import "package:currency_converter/repository/app_storage_repository/defaults.dart";
import "package:currency_converter/repository/app_storage_repository/local_app_storage_repository.dart";
import "package:flutter/material.dart";
import "package:flutter_test/flutter_test.dart";
import "package:j1_theme/models/j1_page_transition.dart";

import "../../testing_utils.dart";
import "../../testing_values.dart";

final _testColorScheme = defaultColorScheme.copyWith(primary: Colors.black.value);

void main() {
  group("Local App Storage Repository", () {
    test("gets and sets theme data", () async {
      final repository = LocalAppStorageRepository();

      expect(repository.getColorStream(), emitsInOrder([defaultColorScheme, _testColorScheme]));
      expect(repository.getTextStream(), emitsInOrder([defaultTextTheme]));
      expect(repository.getTransitionStream(), emitsInOrder([J1PageTransition.cupertino, J1PageTransition.zoom]));

      await repository.setColorScheme(_testColorScheme);
      await repository.setTextTheme(defaultTextTheme);
      await repository.setPageTransition(J1PageTransition.zoom);

      repository.dispose();
    });

    test("gets and sets favorites", () async {
      final repository = LocalAppStorageRepository();

      expect(
        repository.getFavoritesStream(),
        emitsInOrder(
          [
            [],
            [CurrencyCode.USD],
            [CurrencyCode.USD, CurrencyCode.EUR],
            [CurrencyCode.USD, CurrencyCode.EUR, CurrencyCode.GBP],
            [CurrencyCode.USD, CurrencyCode.EUR],
            [CurrencyCode.USD],
            [],
          ],
        ),
      );

      await repository.setFavorite(CurrencyCode.USD);
      await repository.setFavorite(CurrencyCode.EUR);
      await repository.setFavorite(CurrencyCode.GBP);

      await waitMs();
      await repository.removeFavorite(CurrencyCode.GBP);
      await waitMs();
      await repository.removeFavorite(CurrencyCode.EUR);
      await waitMs();
      await repository.removeFavorite(CurrencyCode.USD);

      repository.dispose();
    });

    test("gets and updates current configuration", () async {
      final repository = LocalAppStorageRepository();

      final initialConfig = await repository.getCurrentConfiguration();
      expect(initialConfig, null);

      await repository.updateCurrentConfiguration(testConfig0);
      final config0 = await repository.getCurrentConfiguration();
      expect(config0, testConfig0);

      await repository.updateCurrentConfiguration(testConfig1);
      final config1 = await repository.getCurrentConfiguration();
      expect(config1, testConfig1);

      repository.dispose();
    });

    test("gets and sets configurations", () async {
      final repository = LocalAppStorageRepository();

      expect(
        repository.getConfigurationsStream(),
        emitsInOrder(
          [
            [],
            [testConfig0],
            [testConfig0, testConfig1],
            [testConfig1],
            [],
          ],
        ),
      );

      await repository.saveConfiguration(testConfig0);
      await repository.saveConfiguration(testConfig1);

      await waitMs();
      await repository.removeConfiguration(testConfig0);
      await waitMs();
      await repository.removeConfiguration(testConfig1);

      repository.dispose();
    });

    test("gets and updates exchange rate", () async {
      final repository = LocalAppStorageRepository();

      final initialRate = await repository.getCurrentExchangeRate();
      expect(initialRate, null);

      await repository.updateCurrentExchangeRate(testSnapshot0);
      final snapshot0 = await repository.getCurrentExchangeRate();
      expect(snapshot0, testSnapshot0);

      await repository.updateCurrentExchangeRate(testSnapshot1);
      final snapshot1 = await repository.getCurrentExchangeRate();
      expect(snapshot1, testSnapshot1);

      repository.dispose();
    });

    test("gets and sets language", () async {
      final repository = LocalAppStorageRepository();

      expect(repository.getLanguagesStream(), emitsInOrder(["en", "ko"]));
      await repository.setLanguage("ko");

      repository.dispose();
    });
  });
}
