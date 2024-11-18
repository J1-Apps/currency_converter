import "dart:async";

import "package:currency_converter/data/repository/configuration_repository.dart";
import "package:currency_converter/data/repository/currency_repository.dart";
import "package:currency_converter/data/repository/exchange_repository.dart";
import "package:currency_converter/data/repository/favorite_repository.dart";
import "package:currency_converter/state/home/home_bloc.dart";
import "package:currency_converter/data/model/cc_error.dart";
import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:flutter_gen/gen_l10n/app_localizations.dart";
import "package:flutter_test/flutter_test.dart";
import "package:mocktail/mocktail.dart";
import "package:shared_preferences/shared_preferences.dart";

Future<void> waitMs({int ms = 1}) async {
  await Future.delayed(Duration(milliseconds: ms));
}

class TestWrapper<T extends Bloc> extends StatelessWidget {
  final Widget child;
  final T? globalBloc;

  const TestWrapper({required this.child, this.globalBloc, super.key});

  @override
  Widget build(BuildContext context) {
    final app = MaterialApp(
      locale: const Locale("en", "US"),
      localizationsDelegates: Strings.localizationsDelegates,
      supportedLocales: Strings.supportedLocales,
      home: Material(child: child),
    );

    final bloc = globalBloc;
    return bloc == null ? app : BlocProvider<T>(create: (_) => bloc, child: app);
  }
}

extension TestStreamExtensions<T> on Stream<T> {
  Stream<dynamic> handleErrorForTest() {
    return transform(
      StreamTransformer.fromHandlers(
        handleData: (data, sink) => sink.add(data),
        handleError: (error, _, sink) => sink.add(error),
      ),
    );
  }
}

// Mock Callbacks

abstract class _MockVoidCallback {
  void call();
}

class MockVoidCallback extends Mock implements _MockVoidCallback {}

abstract class _MockCallback<T> {
  void call(value);
}

class MockCallback<T> extends Mock implements _MockCallback<T> {}

// Custom Matchers

class HasErrorCode extends CustomMatcher {
  HasErrorCode(matcher) : super("CcError with code that is", "code", matcher);

  @override
  Object? featureValueOf(actual) => (actual as CcError).code;
}

// Mock Data Sources

class MockSharedPreferences extends Mock implements SharedPreferencesAsync {}

// Mock Repositories

class MockConfigurationRepository extends Mock implements ConfigurationRepository {}

class MockCurrencyRepository extends Mock implements CurrencyRepository {}

class MockExchangeRepository extends Mock implements ExchangeRepository {}

class MockFavoriteRepository extends Mock implements FavoriteRepository {}

// Mock Blocs

class MockHomeBloc extends Mock implements HomeBloc {}
