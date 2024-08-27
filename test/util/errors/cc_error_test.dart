import "package:currency_converter/util/errors/cc_error.dart";
import "package:flutter_test/flutter_test.dart";

void main() {
  group("CC Error", () {
    test("is created from object", () {
      final ccError = CcError.fromObject(
        CcError(
          ErrorCode.repository_exchangeRate_invalidCode,
          message: "testCcMessage",
        ),
      );

      final unknownError = CcError.fromObject(
        ArgumentError("testArgumentMessage"),
      );

      expect(ccError.code, ErrorCode.repository_exchangeRate_invalidCode);
      expect(ccError.message, "testCcMessage");
      expect(unknownError.code, ErrorCode.common_unknown);
      expect(unknownError.message, "Invalid argument(s): testArgumentMessage");
    });
  });
}
