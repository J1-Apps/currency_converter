import "package:currency_converter/model/cc_error.dart";
import "package:flutter_test/flutter_test.dart";

void main() {
  group("CC Error", () {
    test("is created from object", () {
      final ccError = CcError.fromObject(
        const CcError(
          ErrorCode.source_exchangeRate_invalidCode,
          message: "testCcMessage",
        ),
      );

      final unknownError = CcError.fromObject(
        ArgumentError("testArgumentMessage"),
      );

      expect(ccError.code, ErrorCode.source_exchangeRate_invalidCode);
      expect(ccError.message, "testCcMessage");
      expect(unknownError.code, ErrorCode.common_unknown);
      expect(unknownError.message, "Invalid argument(s): testArgumentMessage");
    });

    test("is printed to string", () {
      const unknownError = CcError(ErrorCode.common_unknown, message: "test unknown message");
      const httpError = CcError(ErrorCode.source_exchangeRate_httpError, message: "test http message");

      expect(
        unknownError.toString(),
        "CcError(code: ErrorCode.common_unknown, message: test unknown message)",
      );

      expect(
        httpError.toString(),
        "CcError(code: ErrorCode.source_exchangeRate_httpError, message: test http message)",
      );
    });
  });
}
