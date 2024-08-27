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
}

enum ErrorCode {
  // Common error codes.
  common_unknown,

  // Repository error codes.
  repository_exchangeRate_invalidCode,
}
