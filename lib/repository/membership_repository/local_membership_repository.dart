import "package:currency_converter/model/membership.dart";
import "package:currency_converter/repository/local_repository_config.dart";
import "package:currency_converter/repository/membership_repository/membership_repository.dart";
import "package:currency_converter/util/errors/cc_error.dart";
import "package:rxdart/subjects.dart";

class LocalMembershipRepository extends MembershipRepository {
  var _membershipController = BehaviorSubject<Membership>.seeded(
    const Membership.confirmed(level: MembershipLevel.free),
  );

  var _shouldThrow = false;
  var _msDelay = LocalRepositoryConfig.mockNetworkDelayMs;

  set shouldThrow(bool value) => _shouldThrow = value;
  set msDelay(int value) => _msDelay = value;

  @override
  Stream<Membership> getMembershipStream() {
    return _membershipController.stream;
  }

  @override
  Future<void> purchaseMembershipLevel(MembershipLevel level) async {
    await Future.delayed(Duration(milliseconds: _msDelay));

    if (_shouldThrow) {
      throw const CcError(ErrorCode.repository_membership_purchaseError);
    }

    _membershipController.add(Membership.pending(level: level));
    await Future.delayed(Duration(milliseconds: _msDelay));
    _membershipController.add(Membership.confirmed(level: level));
  }

  void reset() {
    _membershipController.close();
    _membershipController = BehaviorSubject<Membership>.seeded(
      const Membership.confirmed(level: MembershipLevel.free),
    );

    shouldThrow = false;
    msDelay = LocalRepositoryConfig.mockNetworkDelayMs;
  }

  void dispose() {
    _membershipController.close();
  }
}
