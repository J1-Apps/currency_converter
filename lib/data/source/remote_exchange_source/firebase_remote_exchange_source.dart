import "package:cloud_firestore/cloud_firestore.dart";
import "package:currency_converter/data/model/cc_error.dart";
import "package:currency_converter/data/model/currency.dart";
import "package:currency_converter/data/model/exchange_rate.dart";
import "package:currency_converter/data/source/remote_exchange_source/remote_exchange_source.dart";

const _currentPath = "current";
const _ratesPath = "exchangeRates";

class FirebaseRemoteExchangeSource extends RemoteExchangeSource {
  final FirebaseFirestore _firestore;

  FirebaseRemoteExchangeSource({FirebaseFirestore? firestore}) : _firestore = firestore ?? FirebaseFirestore.instance;

  @override
  Future<ExchangeRateSnapshot> getExchangeRate() async {
    final document = _firestore.collection(_currentPath).doc(_currentPath);
    final data = (await document.get()).data();

    if (data == null) {
      throw CcError(
        ErrorCode.source_remote_exchange_parsingError,
        message: "Get snapshot had a missing data map.",
      );
    }

    final rawRates = data[_ratesPath] as Map;

    final mappedRates = {
      for (var code in CurrencyCode.values) code: ((rawRates[code.name.toLowerCase()] ?? 1) as num).toDouble(),
    };

    return ExchangeRateSnapshot(DateTime.now().toUtc(), mappedRates);
  }
}
