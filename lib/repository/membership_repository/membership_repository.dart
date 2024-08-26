import "package:currency_converter/models/membership_level.dart";

abstract class MembershipRepository {
  Future<void> purchaseMembershipLevel(MembershipLevel level);

  Stream<MembershipLevel> getMembershipStream();
}
