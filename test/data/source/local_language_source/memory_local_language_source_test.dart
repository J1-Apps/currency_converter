import "package:currency_converter/data/source/local_language_source/memory_local_language_source.dart";
import "package:flutter_test/flutter_test.dart";

void main() {
  group("Memory Local Language Source", () {
    test("gets and sets language", () async {
      final source = MemoryLocalLanguageSource(initialMsDelay: 1);

      expect(await source.getLanguage(), "en");

      await source.updateLanguage("kr");
      expect(await source.getLanguage(), "kr");

      await source.updateLanguage("es");
      expect(await source.getLanguage(), "es");
    });
  });
}
