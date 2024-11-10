import "dart:async";

import "package:currency_converter/data/repository/configuration_repository.dart";
import "package:currency_converter/data/repository/exchange_repository.dart";
import "package:currency_converter/state/home/home_bloc.dart";
import "package:currency_converter/data/model/cc_error.dart";
import "package:flutter/material.dart";
import "package:flutter_gen/gen_l10n/app_localizations.dart";
import "package:flutter_test/flutter_test.dart";
import "package:mocktail/mocktail.dart";
import "package:shared_preferences/shared_preferences.dart";

Future<void> waitMs({int ms = 1}) async {
  await Future.delayed(Duration(milliseconds: ms));
}

class TestWrapper extends StatelessWidget {
  final Widget child;

  const TestWrapper({required this.child, super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      locale: const Locale("en", "US"),
      localizationsDelegates: Strings.localizationsDelegates,
      supportedLocales: Strings.supportedLocales,
      home: Material(child: child),
    );
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

class MockExchangeRepository extends Mock implements ExchangeRepository {}

// Mock Blocs

class MockHomeBloc extends Mock implements HomeBloc {}
