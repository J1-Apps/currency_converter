import "package:currency_converter/data/model/cc_error.dart";
import "package:currency_converter/data/model/exchange_rate.dart";
import "package:currency_converter/data/source/local_exchange_source/local_exchange_source.dart";
import "package:currency_converter/data/source/util/memory_source.dart";

class MemoryLocalExchangeSource extends MemorySource implements LocalExchangeSource {
  ExchangeRateSnapshot? _snapshot;

  MemoryLocalExchangeSource({super.initialShouldThrow, super.initialMsDelay});

  @override
  Future<ExchangeRateSnapshot?> getExchangeRate() async {
    return wrapRequest(Future.value(_snapshot), ErrorCode.source_local_exchange_readError);
  }

  @override
  Future<void> updateExchangeRate(ExchangeRateSnapshot snapshot) async {
    await wrapRequest(Future(() => _snapshot = snapshot), ErrorCode.source_local_exchange_writeError);
  }
}
