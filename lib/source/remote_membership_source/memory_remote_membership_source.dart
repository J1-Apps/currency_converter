import "package:currency_converter/model/membership.dart";
import "package:currency_converter/model/cc_error.dart";
import "package:currency_converter/source/remote_membership_source/remote_membership_source.dart";
import "package:currency_converter/source/util/memory_source.dart";
import "package:rxdart/subjects.dart";

class MemoryRemoteMembershipSource extends MemorySource implements RemoteMembershipSource {
  var _membershipController = BehaviorSubject<Membership>.seeded(
    const Membership.confirmed(level: MembershipLevel.free),
  );

  @override
  Future<Stream<Membership>> getMembershipStream() async {
    return wrapRequest(
      Future.value(_membershipController.stream),
      ErrorCode.source_membership_getMembershipError,
    );
  }

  @override
  Future<void> purchaseMembershipLevel(MembershipLevel level) async {
    await wrapRequest(
      Future(
        () async {
          _membershipController.add(Membership.pending(level: level));
          await Future.delayed(Duration(milliseconds: msDelay));
          _membershipController.add(Membership.confirmed(level: level));
        },
      ),
      ErrorCode.source_membership_purchaseError,
    );
  }

  @override
  void reset() {
    _membershipController.close();
    _membershipController = BehaviorSubject<Membership>.seeded(
      const Membership.confirmed(level: MembershipLevel.free),
    );

    super.reset();
  }

  void dispose() {
    _membershipController.close();
  }
}
