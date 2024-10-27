import "dart:async";

import "package:currency_converter/model/cc_error.dart";
import "package:currency_converter/model/membership.dart";
import "package:currency_converter/repository/data_state.dart";
import "package:currency_converter/source/remote_membership_source/remote_membership_source.dart";
import "package:j1_environment/j1_environment.dart";

class MembershipRepository {
  final RemoteMembershipSource _membershipSource;
  final DataSubject<Membership> _membershipSubject;
  StreamSubscription<Membership>? _membershipSubscription;

  Stream<DataState<Membership>> get membership => _membershipSubject.stream;

  MembershipRepository({
    RemoteMembershipSource? membershipSource,
    Membership? initialState,
  })  : _membershipSource = membershipSource ?? locator.get<RemoteMembershipSource>(),
        _membershipSubject = DataSubject.initial(initialState);

  Future<void> loadMembership() async {
    _membershipSubscription?.cancel();
    final stream = await _membershipSource.getMembershipStream();
    _membershipSubscription = stream.listen(
      _membershipSubject.addSuccess,
      onError: (e) => _membershipSubject.addErrorEvent(CcError.fromObject(e)),
    );
  }

  Future<void> purchaseMembershipLevel(MembershipLevel level) async {
    await _membershipSource.purchaseMembershipLevel(level);
  }

  void dispose() {
    _membershipSubject.dispose();
    _membershipSubscription?.cancel();
  }
}
