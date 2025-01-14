import "package:currency_converter/data/model/cc_error.dart";
import "package:currency_converter/data/repository/data_state.dart";
import "package:currency_converter/data/source/local_language_source/local_language_source.dart";
import "package:j1_environment/j1_environment.dart";

class LanguageRepository {
  final LocalLanguageSource _localSource;
  final DataSubject<String> _languageSubject;

  Stream<DataState<String>> get languageStream => _languageSubject.stream;

  LanguageRepository({
    LocalLanguageSource? localSource,
    String? initialState,
  })  : _localSource = localSource ?? locator.get<LocalLanguageSource>(),
        _languageSubject = DataSubject.initial(initialState);

  Future<void> loadLanguage({bool forceRefresh = false}) async {
    if (_languageSubject.value is DataSuccess<String> && !forceRefresh) {
      return;
    }

    try {
      _languageSubject.addSuccess(await _localSource.getLanguage());
    } catch (e) {
      _languageSubject.addEmpty();
      _languageSubject.addErrorEvent(CcError.fromObject(e));
    }
  }

  Future<void> updateLanguage(String language) async {
    _languageSubject.addSuccess(language);

    try {
      await _localSource.updateLanguage(language);
    } catch (e) {
      _languageSubject.addErrorEvent(CcError.fromObject(e));
    }
  }

  void dispose() {
    _languageSubject.close();
  }
}
