import "dart:math";

import "package:currency_converter/model/currency.dart";
import "package:currency_converter/model/exchange_rate.dart";
import "package:currency_converter/repository/exchange_rate_repository/exchange_rate_repository.dart";
import "package:currency_converter/repository/local_repository_config.dart";
import "package:currency_converter/model/cc_error.dart";

class LocalExchangeRateRepository extends ExchangeRateRepository {
  final Random _random;

  var _shouldThrow = false;
  var _msDelay = LocalRepositoryConfig.mockNetworkDelayMs;

  set shouldThrow(bool value) => _shouldThrow = value;
  set msDelay(int value) => _msDelay = value;

  LocalExchangeRateRepository({Random? random}) : _random = random ?? Random();

  @override
  Future<ExchangeRateSnapshot> getExchangeRateSnapshot() async {
    await Future.delayed(Duration(milliseconds: _msDelay));

    if (_shouldThrow) {
      throw const CcError(ErrorCode.repository_exchangeRate_httpError);
    }

    final ratesMap = {for (var code in CurrencyCode.values) code: _random.nextDouble() + 1};
    return ExchangeRateSnapshot(DateTime.now().toUtc(), ratesMap);
  }

  void reset() {
    shouldThrow = false;
    msDelay = LocalRepositoryConfig.mockNetworkDelayMs;
  }
}
