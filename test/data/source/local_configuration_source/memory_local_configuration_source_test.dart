import "package:currency_converter/data/source/local_configuration_source/memory_local_configuration_source.dart";
import "package:flutter_test/flutter_test.dart";

import "../../../testing_values.dart";

void main() {
  group("Memory Local Configuration Source", () {
    test("gets and updates current configuration", () async {
      final source = MemoryLocalConfigurationSource(initialMsDelay: 1);

      final initialConfig = await source.getCurrentConfiguration();
      expect(initialConfig, null);

      await source.updateCurrentConfiguration(testConfig0);
      final config0 = await source.getCurrentConfiguration();
      expect(config0, testConfig0);

      await source.updateCurrentConfiguration(testConfig1);
      final config1 = await source.getCurrentConfiguration();
      expect(config1, testConfig1);
    });

    test("gets and sets configurations", () async {
      final source = MemoryLocalConfigurationSource(initialMsDelay: 1);

      expect(await source.getConfigurations(), []);

      await source.updateConfigurations([testConfig0]);
      expect(await source.getConfigurations(), [testConfig0]);

      await source.updateConfigurations([testConfig0, testConfig1]);
      expect(await source.getConfigurations(), [testConfig0, testConfig1]);
    });
  });
}
