import "package:currency_converter/model/membership.dart";
import "package:currency_converter/source/memory_source_config.dart";
import "package:currency_converter/model/cc_error.dart";
import "package:currency_converter/source/remote_membership_source/remote_membership_source.dart";
import "package:rxdart/subjects.dart";

class MemoryRemoteMembershipSource extends RemoteMembershipSource {
  var _membershipController = BehaviorSubject<Membership>.seeded(
    const Membership.confirmed(level: MembershipLevel.free),
  );

  var _shouldThrow = false;
  var _msDelay = MemorySourceConfig.memoryNetworkDelayMs;

  set shouldThrow(bool value) => _shouldThrow = value;
  set msDelay(int value) => _msDelay = value;

  @override
  Future<Stream<Membership>> getMembershipStream() async {
    await Future.delayed(Duration(milliseconds: _msDelay));

    if (_shouldThrow) {
      throw const CcError(ErrorCode.source_membership_getMembershipError);
    }

    return _membershipController.stream;
  }

  @override
  Future<void> purchaseMembershipLevel(MembershipLevel level) async {
    await Future.delayed(Duration(milliseconds: _msDelay));

    if (_shouldThrow) {
      throw const CcError(ErrorCode.source_membership_purchaseError);
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
    msDelay = MemorySourceConfig.memoryNetworkDelayMs;
  }

  void dispose() {
    _membershipController.close();
  }
}
