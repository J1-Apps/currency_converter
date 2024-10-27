import "package:currency_converter/model/cc_error.dart";
import "package:currency_converter/source/local_language_source/local_language_source.dart";
import "package:currency_converter/source/util/memory_source.dart";

class MemoryLocalLanguageSource extends MemorySource implements LocalLanguageSource {
  String _language = "en";

  MemoryLocalLanguageSource({super.initialShouldThrow, super.initialMsDelay});

  @override
  Future<String> getLanguage() {
    return wrapRequest(Future.value(_language), ErrorCode.source_local_language_readError);
  }

  @override
  Future<void> updateLanguage(String language) async {
    await wrapRequest(Future(() => _language = language), ErrorCode.source_local_language_writeError);
  }
}
