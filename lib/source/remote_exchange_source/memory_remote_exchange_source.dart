import "dart:math";

import "package:currency_converter/model/currency.dart";
import "package:currency_converter/model/exchange_rate.dart";
import "package:currency_converter/source/remote_exchange_source/remote_exchange_source.dart";
import "package:currency_converter/model/cc_error.dart";
import "package:currency_converter/source/util/memory_source.dart";

class MemoryRemoteExchangeSource extends MemorySource implements RemoteExchangeSource {
  final Random _random;

  MemoryRemoteExchangeSource({
    Random? random,
    super.initialShouldThrow,
    super.initialMsDelay,
  }) : _random = random ?? Random();

  @override
  Future<ExchangeRateSnapshot> getExchangeRate() async {
    return wrapRequest(
      Future(() {
        final ratesMap = {for (var code in CurrencyCode.values) code: _random.nextDouble() + 1};
        return ExchangeRateSnapshot(DateTime.now().toUtc(), ratesMap);
      }),
      ErrorCode.source_remote_exchange_httpError,
    );
  }
}
