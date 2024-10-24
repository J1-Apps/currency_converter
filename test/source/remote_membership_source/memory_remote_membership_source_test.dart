import "package:currency_converter/model/membership.dart";
import "package:currency_converter/model/cc_error.dart";
import "package:currency_converter/source/remote_membership_source/memory_remote_membership_source.dart";
import "package:flutter_test/flutter_test.dart";

import "../../testing_utils.dart";

void main() {
  group("Memory Remote Membership Source", () {
    final source = MemoryRemoteMembershipSource();

    tearDown(source.reset);

    tearDownAll(source.dispose);

    test("gets and purchases membership levels", () async {
      source.msDelay = 1;

      expect(
        await source.getMembershipStream(),
        emitsInOrder(
          [
            const Membership.confirmed(level: MembershipLevel.free),
            const Membership.pending(level: MembershipLevel.noAds),
            const Membership.confirmed(level: MembershipLevel.noAds),
          ],
        ),
      );

      await source.purchaseMembershipLevel(MembershipLevel.noAds);
    });

    test("throws on purchase when requested", () async {
      source.shouldThrow = true;
      source.msDelay = 1;

      expect(
        () async => source.purchaseMembershipLevel(MembershipLevel.noAds),
        throwsA(HasErrorCode(ErrorCode.source_remote_membership_purchaseError)),
      );
    });
  });
}
