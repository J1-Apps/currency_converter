import "package:currency_converter/repository/defaults.dart";
import "package:currency_converter/repository/app_storage_repository/local_app_storage_repository.dart";
import "package:flutter/material.dart";
import "package:flutter_test/flutter_test.dart";
import "package:j1_theme/models/j1_page_transition.dart";

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
  });
}
