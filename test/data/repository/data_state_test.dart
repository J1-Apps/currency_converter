import "package:currency_converter/data/model/cc_error.dart";
import "package:currency_converter/data/repository/data_state.dart";
import "package:flutter_test/flutter_test.dart";

import "../../testing_utils.dart";

void main() {
  group("Data State", () {
    test("creates initial state", () {
      expect(DataState<int>.initial(1), const DataSuccess(1));
      expect(DataState<int>.initial(null), const DataEmpty<int>());
    });
  });

  group("Data Subject", () {
    test("adds events and gets values", () {
      final subject = DataSubject<int>.initial(null);

      expect(
        subject.stream.handleErrorForTest(),
        emitsInOrder(
          [
            const DataEmpty<int>(),
            const DataEmpty<int>(),
            const DataSuccess(1),
            const DataSuccess(1),
            HasErrorCode(ErrorCode.common_unknown),
          ],
        ),
      );

      subject.addEmpty();
      subject.addSuccess(1);
      subject.addEmpty();
      subject.addErrorEvent(const CcError(ErrorCode.common_unknown));

      subject.close();
    });
  });
}
