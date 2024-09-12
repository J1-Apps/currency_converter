import "package:currency_converter/model/configuration.dart";
import "package:currency_converter/model/currency.dart";
import "package:currency_converter/repository/app_storage_repository/defaults.dart";
import "package:currency_converter/repository/app_storage_repository/local_app_storage_repository.dart";
import "package:flutter/material.dart";
import "package:flutter_test/flutter_test.dart";
import "package:j1_theme/models/j1_page_transition.dart";

import "../../testing_utils.dart";

final _testColorScheme = defaultColorScheme.copyWith(primary: Colors.black.value);

const _config0 = Configuration(
  "test 0",
  1.0,
  CurrencyCode.USD,
  {CurrencyCode.EUR, CurrencyCode.KRW},
);

const _config1 = Configuration(
  "test 1",
  2.0,
  CurrencyCode.KRW,
  {CurrencyCode.EUR, CurrencyCode.USD},
);

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

      await repository.updateCurrentConfiguration(_config0);
      final config0 = await repository.getCurrentConfiguration();
      expect(config0, _config0);

      await repository.updateCurrentConfiguration(_config1);
      final config1 = await repository.getCurrentConfiguration();
      expect(config1, _config1);

      repository.dispose();
    });

    test("gets and sets configurations", () async {
      final repository = LocalAppStorageRepository();

      expect(
        repository.getConfigurationsStream(),
        emitsInOrder(
          [
            [],
            [_config0],
            [_config0, _config1],
            [_config1],
            [],
          ],
        ),
      );

      await repository.saveConfiguration(_config0);
      await repository.saveConfiguration(_config1);

      await waitMs();
      await repository.removeConfiguration(_config0);
      await waitMs();
      await repository.removeConfiguration(_config1);

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
