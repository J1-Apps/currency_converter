import "package:dart_mappable/dart_mappable.dart";

part "cc_error.mapper.dart";

// ignore_for_file: constant_identifier_names
@MappableClass()
class CcError with CcErrorMappable implements Exception {
  final ErrorCode code;
  final String message;

  const CcError(this.code, {this.message = ""});

  factory CcError.fromObject(Object e) {
    if (e is CcError) {
      return e;
    }

    return CcError(ErrorCode.common_unknown, message: e.toString());
  }
}

@MappableEnum()
enum ErrorCode {
  // Common error codes.

  common_unknown,

  // Repository error codes.

  repository_appStorage_seedingError,
  repository_appStorage_savingError,
  repository_appStorage_getConfigurationError,
  repository_appStorage_getExchangeRateError,

  repository_exchangeRate_invalidCode,
  repository_exchangeRate_httpError,
  repository_exchangeRate_parsingError,

  source_membership_getMembershipError,
  source_membership_purchaseError,
}
