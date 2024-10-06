import "dart:convert";

import "package:currency_converter/model/currency.dart";
import "package:currency_converter/model/exchange_rate.dart";
import "package:currency_converter/data/repository/exchange_rate_repository/exchange_rate_repository.dart";
import "package:currency_converter/util/errors/cc_error.dart";
import "package:http/http.dart";

class GithubExchangeRateRepository extends ExchangeRateRepository {
  final Client _client;

  GithubExchangeRateRepository({Client? client}) : _client = client ?? Client();

  @override
  Future<ExchangeRateSnapshot> getExchangeRateSnapshot(CurrencyCode currencyCode) async {
    ExchangeRateSnapshot snapshot;

    try {
      snapshot = await _getSnapshot(
        currencyCode,
        "https://cdn.jsdelivr.net/npm/@fawazahmed0/currency-api@latest/v1/currencies/${currencyCode.name.toLowerCase()}.min.json",
      );
    } catch (_) {
      snapshot = await _getSnapshot(
        currencyCode,
        "https://latest.currency-api.pages.dev/v1/currencies/${currencyCode.name.toLowerCase()}.min.json",
      );
    }

    return snapshot;
  }

  Future<ExchangeRateSnapshot> _getSnapshot(CurrencyCode currencyCode, String url) async {
    try {
      final uri = Uri.tryParse(url);

      if (uri == null) {
        // This is a defensive check that should theoretically never be hit. Thus, it can be safely ignored.
        // coverage:ignore-start
        throw CcError(
          ErrorCode.repository_exchangeRate_invalidCode,
          message: "Failed to parse uri for url: $url",
        );
        // coverage:ignore-end
      }

      Response response;

      try {
        response = await _client.get(uri);
      } catch (e) {
        throw CcError(
          ErrorCode.repository_exchangeRate_httpError,
          message: "Get snapshot experienced an unknown http error: $e.",
        );
      }

      if (response.statusCode != 200) {
        throw CcError(
          ErrorCode.repository_exchangeRate_httpError,
          message: "Get snapshot response had code: ${response.statusCode}.",
        );
      }

      Map decoded;

      try {
        decoded = jsonDecode(utf8.decode(response.bodyBytes)) as Map;
      } catch (e) {
        throw CcError(
          ErrorCode.repository_exchangeRate_parsingError,
          message: "Get snapshot experienced an error when parsing the response: $e",
        );
      }

      try {
        final rawRates = decoded[currencyCode.name.toLowerCase()] as Map;

        final mappedRates = {
          for (var code in CurrencyCode.values) code: (rawRates[code.name.toLowerCase()] as num).toDouble(),
        };

        return ExchangeRateSnapshot(DateTime.now().toUtc(), mappedRates);
      } catch (e) {
        throw CcError(
          ErrorCode.repository_exchangeRate_parsingError,
          message: "Get snapshot experienced an error when parsing the response: $e",
        );
      }
    } catch (e) {
      throw CcError.fromObject(e);
    }
  }

  void dispose() {
    _client.close();
  }
}
