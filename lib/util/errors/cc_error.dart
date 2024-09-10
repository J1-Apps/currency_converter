// ignore_for_file: constant_identifier_names

class CcError implements Exception {
  final ErrorCode code;
  final String message;

  CcError(this.code, {this.message = ""});

  factory CcError.fromObject(Object e) {
    if (e is CcError) {
      return e;
    }

    return CcError(ErrorCode.common_unknown, message: e.toString());
  }

  @override
  String toString() {
    return "CcError(code: $code, message: $message)";
  }
}

enum ErrorCode {
  // Common error codes.

  common_unknown,

  // Repository error codes.

  repository_appStorage_seedingError,
  repository_appStorage_savingError,
  repository_appStorage_getConfigurationError,

  repository_exchangeRate_invalidCode,
  repository_exchangeRate_httpError,
  repository_exchangeRate_parsingError,

  repository_membership_purchaseError,
}
