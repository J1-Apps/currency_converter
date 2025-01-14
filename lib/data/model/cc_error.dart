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

  repository_favorite_notSeededError,

  repository_configuration_notSeededError,
  repository_configuration_missingIndexError,

  repository_membership_notSeededError,

  // Source error codes.

  source_remote_exchange_invalidCode,
  source_remote_exchange_httpError,
  source_remote_exchange_parsingError,

  source_local_exchange_readError,
  source_local_exchange_writeError,

  source_local_configuration_currentReadError,
  source_local_configuration_currentWriteError,
  source_local_configuration_readError,
  source_local_configuration_writeError,

  source_local_currency_allReadError,

  source_local_favorite_readError,
  source_local_favorite_writeError,

  source_local_language_readError,
  source_local_language_writeError,

  source_local_theme_colorReadError,
  source_local_theme_colorWriteError,
  source_local_theme_textReadError,
  source_local_theme_textWriteError,
  source_local_theme_transitionReadError,
  source_local_theme_transitionWriteError,

  source_remote_membership_getMembershipError,
  source_remote_membership_purchaseError,
}
