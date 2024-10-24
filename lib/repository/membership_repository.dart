import "package:currency_converter/model/membership.dart";
import "package:currency_converter/source/remote_membership_source/remote_membership_source.dart";
import "package:j1_environment/j1_environment.dart";

class MembershipRepository {
  final RemoteMembershipSource _membershipSource;

  MembershipRepository({RemoteMembershipSource? membershipSource})
      : _membershipSource = membershipSource ?? locator.get<RemoteMembershipSource>();

  Future<void> purchaseMembershipLevel(MembershipLevel level) async {
    await _membershipSource.purchaseMembershipLevel(level);
  }

  Future<Stream<Membership>> getMembershipStream() {
    return _membershipSource.getMembershipStream();
  }
}
