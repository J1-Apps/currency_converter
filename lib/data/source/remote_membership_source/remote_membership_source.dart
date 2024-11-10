import "package:currency_converter/data/model/membership.dart";

abstract class RemoteMembershipSource {
  Future<void> purchaseMembershipLevel(MembershipLevel level);
  Future<Stream<Membership>> getMembershipStream();
}
