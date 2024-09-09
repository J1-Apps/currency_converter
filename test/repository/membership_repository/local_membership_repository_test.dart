import "package:currency_converter/models/membership.dart";
import "package:currency_converter/repository/membership_repository/local_membership_repository.dart";
import "package:currency_converter/util/errors/cc_error.dart";
import "package:flutter_test/flutter_test.dart";

import "../../testing_utils.dart";

void main() {
  group("Local Membership Repository", () {
    final repository = LocalMembershipRepository();

    tearDown(repository.reset);

    tearDownAll(repository.dispose);

    test("gets and purchases membership levels", () async {
      repository.msDelay = 1;

      expect(
        repository.getMembershipStream(),
        emitsInOrder(
          [
            const Membership(level: MembershipLevel.free),
            const Membership.pending(level: MembershipLevel.noAds),
            const Membership(level: MembershipLevel.noAds),
          ],
        ),
      );

      await repository.purchaseMembershipLevel(MembershipLevel.noAds);
    });

    test("throws on purchase when requested", () async {
      final repository = LocalMembershipRepository();
      repository.shouldThrow = true;
      repository.msDelay = 1;

      expect(
        () async => repository.purchaseMembershipLevel(MembershipLevel.noAds),
        throwsA(HasErrorCode(ErrorCode.repository_membership_purchaseError)),
      );
    });
  });
}
