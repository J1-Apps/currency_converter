import "package:cloud_firestore/cloud_firestore.dart";
import "package:currency_converter/data/model/cc_error.dart";
import "package:currency_converter/data/model/currency.dart";
import "package:currency_converter/data/source/remote_exchange_source/firebase_remote_exchange_source.dart";
import "package:flutter_test/flutter_test.dart";
import "package:mocktail/mocktail.dart";

import "../../../testing_utils.dart";

class MockFirestore extends Mock implements FirebaseFirestore {}

class MockCollection extends Mock implements CollectionReference<Map<String, dynamic>> {}

class MockDocument extends Mock implements DocumentReference<Map<String, dynamic>> {}

class MockSnapshot extends Mock implements DocumentSnapshot<Map<String, dynamic>> {}

// ignore_for_file: subtype_of_sealed_class
void main() {
  final firestore = MockFirestore();
  final collection = MockCollection();
  final document = MockDocument();
  final snapshot = MockSnapshot();

  setUp(() {
    when(() => firestore.collection("current")).thenReturn(collection);
    when(() => collection.doc("current")).thenReturn(document);
    when(document.get).thenAnswer((_) => Future.value(snapshot));
  });

  tearDown(() {
    reset(firestore);
    reset(document);
    reset(snapshot);
  });

  group("Firebase Remote Exchange Source", () {
    test("gets exchange rate", () async {
      when(snapshot.data).thenReturn(_exchangeData);

      final source = FirebaseRemoteExchangeSource(firestore: firestore);
      final rates = await source.getExchangeRate();

      expect(rates.exchangeRates[CurrencyCode.USD], 1);
      expect(rates.exchangeRates[CurrencyCode.KRW], 2);
      expect(rates.exchangeRates[CurrencyCode.MXN], 3);
    });

    test("handles null snapshot data", () async {
      when(snapshot.data).thenReturn(null);

      final source = FirebaseRemoteExchangeSource(firestore: firestore);

      expect(
        () async => source.getExchangeRate(),
        throwsA(HasErrorCode(ErrorCode.source_remote_exchange_parsingError)),
      );
    });
  });
}

const _exchangeData = {
  "exchangeRates": {
    "usd": 1,
    "krw": 2,
    "mxn": 3,
  },
};
