import "package:currency_converter/model/cc_error.dart";
import "package:currency_converter/model/currency.dart";
import "package:currency_converter/source/local_favorite_source/local_favorite_source.dart";
import "package:currency_converter/source/util/memory_source.dart";

class MemoryLocalFavoriteSource extends MemorySource implements LocalFavoriteSource {
  List<CurrencyCode> _favorites = [];

  MemoryLocalFavoriteSource({super.initialShouldThrow, super.initialMsDelay});

  @override
  Future<List<CurrencyCode>> getFavorites() {
    return wrapRequest(Future.value(_favorites), ErrorCode.source_local_favorite_readError);
  }

  @override
  Future<void> updateFavorites(List<CurrencyCode> favorites) async {
    await wrapRequest(Future(() => _favorites = favorites), ErrorCode.source_local_favorite_writeError);
  }
}
