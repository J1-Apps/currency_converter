import "package:currency_converter/model/membership.dart";

abstract class MembershipRepository {
  Future<void> purchaseMembershipLevel(MembershipLevel level);
  Stream<Membership> getMembershipStream();
}
