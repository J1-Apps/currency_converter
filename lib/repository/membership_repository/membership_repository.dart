import "package:currency_converter/models/membership.dart";

abstract class MembershipRepository {
  Future<void> purchaseMembershipLevel(MembershipLevel level);
  Stream<Membership> getMembershipStream();
}
