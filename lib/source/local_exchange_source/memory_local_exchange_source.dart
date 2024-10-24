import "package:currency_converter/model/cc_error.dart";
import "package:currency_converter/model/exchange_rate.dart";
import "package:currency_converter/source/local_exchange_source/local_exchange_source.dart";
import "package:currency_converter/source/util/memory_source.dart";

class MemoryLocalExchangeSource extends MemorySource implements LocalExchangeSource {
  ExchangeRateSnapshot? _snapshot;

  @override
  Future<ExchangeRateSnapshot?> getExchangeRate() async {
    return wrapRequest(Future.value(_snapshot), ErrorCode.source_appStorage_readExchangeError);
  }

  @override
  Future<void> updateExchangeRate(ExchangeRateSnapshot snapshot) async {
    await wrapRequest(Future(() => _snapshot = snapshot), ErrorCode.source_appStorage_writeExchangeError);
  }
}
