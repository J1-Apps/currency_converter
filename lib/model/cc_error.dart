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

  repository_exchange_noExchangeError,

  // Source error codes.

  source_appStorage_writeError, // TODO: remove.
  source_appStorage_readError, // TODO: remove.

  source_appStorage_readExchangeError,
  source_appStorage_writeExchangeError,
  source_appStorage_readConfigurationError,
  source_appStorage_writeConfigurationError,

  source_exchange_invalidCode,
  source_exchange_httpError,
  source_exchange_parsingError,

  source_membership_getMembershipError,
  source_membership_purchaseError,
}
