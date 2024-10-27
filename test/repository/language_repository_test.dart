import "package:currency_converter/model/cc_error.dart";
import "package:currency_converter/repository/data_state.dart";
import "package:currency_converter/repository/language_repository.dart";
import "package:currency_converter/source/local_language_source/local_language_source.dart";
import "package:flutter_test/flutter_test.dart";
import "package:j1_environment/j1_environment.dart";
import "package:mocktail/mocktail.dart";

import "../testing_utils.dart";

class MockLocalLanguageSource extends Mock implements LocalLanguageSource {}

void main() {
  group("Language Repository", () {
    final localSource = MockLocalLanguageSource();
    late LanguageRepository repository;

    setUpAll(() {
      locator.registerSingleton<LocalLanguageSource>(localSource);
    });

    setUp(() {
      repository = LanguageRepository();
    });

    tearDown(() {
      reset(localSource);
      repository.dispose();
    });

    tearDownAll(() async {
      await locator.reset();
    });

    test("gets and updates language, handling errors", () async {
      expect(
        repository.language.handleErrorForTest(),
        emitsInOrder(
          [
            const DataEmpty<String>(),
            const DataEmpty<String>(),
            HasErrorCode(ErrorCode.source_local_language_readError),
            const DataSuccess("en"),
            const DataSuccess("kr"),
            HasErrorCode(ErrorCode.source_local_language_writeError),
            const DataSuccess("es"),
          ],
        ),
      );

      when(localSource.getLanguage).thenThrow(const CcError(ErrorCode.source_local_language_readError));
      await repository.loadLanguage();

      when(localSource.getLanguage).thenAnswer((_) => Future.value("en"));
      await repository.loadLanguage();

      when(() => localSource.updateLanguage(any())).thenThrow(
        const CcError(ErrorCode.source_local_language_writeError),
      );
      await repository.updateLanguage("kr");

      when(() => localSource.updateLanguage(any())).thenAnswer((_) => Future.value());
      await repository.updateLanguage("es");

      verify(localSource.getLanguage).called(2);
      verify(() => localSource.updateLanguage(any())).called(2);
      repository.dispose();
    });
  });
}
