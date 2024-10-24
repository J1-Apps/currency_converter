import "package:currency_converter/model/cc_error.dart";
import "package:currency_converter/model/exchange_rate.dart";
import "package:currency_converter/source/local_exchange_source/local_exchange_source.dart";
import "package:currency_converter/source/util/preferences_source.dart";

const _snapshotKey = "ccSnapshot";

class PreferencesLocalExchangeSource extends PreferencesSource implements LocalExchangeSource {
  PreferencesLocalExchangeSource({super.preferences});

  @override
  Future<ExchangeRateSnapshot?> getExchangeRate() async {
    return getItem(_snapshotKey, ErrorCode.source_appStorage_readExchangeError, (preferences) async {
      final snapshotJson = await preferences.getString(_snapshotKey);

      if (snapshotJson == null || snapshotJson.isEmpty) {
        return null;
      }

      return ExchangeRateSnapshot.fromJson(snapshotJson);
    });
  }

  @override
  Future<void> updateExchangeRate(ExchangeRateSnapshot snapshot) async {
    await saveItem(_snapshotKey, ErrorCode.source_appStorage_writeExchangeError, (preferences) async {
      await preferences.setString(_snapshotKey, snapshot.toJson());
    });
  }
}
