import "dart:math";

import "package:currency_converter/model/currency.dart";
import "package:currency_converter/model/exchange_rate.dart";
import "package:currency_converter/source/remote_exchange_source.dart/remote_exchange_source.dart";
import "package:currency_converter/source/memory_source_config.dart";
import "package:currency_converter/model/cc_error.dart";

class MemoryRemoteExchangeSource extends RemoteExchangeSource {
  final Random _random;

  var _shouldThrow = false;
  var _msDelay = MemorySourceConfig.memoryNetworkDelayMs;

  set shouldThrow(bool value) => _shouldThrow = value;
  set msDelay(int value) => _msDelay = value;

  MemoryRemoteExchangeSource({Random? random}) : _random = random ?? Random();

  @override
  Future<ExchangeRateSnapshot> getExchangeRateSnapshot() async {
    await Future.delayed(Duration(milliseconds: _msDelay));

    if (_shouldThrow) {
      throw const CcError(ErrorCode.source_exchangeRate_httpError);
    }

    final ratesMap = {for (var code in CurrencyCode.values) code: _random.nextDouble() + 1};
    return ExchangeRateSnapshot(DateTime.now().toUtc(), ratesMap);
  }

  void reset() {
    shouldThrow = false;
    msDelay = MemorySourceConfig.memoryNetworkDelayMs;
  }
}
