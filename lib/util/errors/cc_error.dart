import "package:equatable/equatable.dart";

// ignore_for_file: constant_identifier_names
class CcError with EquatableMixin implements Exception {
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
  List<Object?> get props => [code, message];
}

enum ErrorCode {
  // Common error codes.
  common_unknown,
}
