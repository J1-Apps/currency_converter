import "package:currency_converter/model/membership.dart";

abstract class RemoteMembershipSource {
  Future<void> purchaseMembershipLevel(MembershipLevel level);
  Future<Stream<Membership>> getMembershipStream();
}
