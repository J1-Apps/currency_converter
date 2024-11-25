import "dart:async";

import "package:currency_converter/data/model/cc_error.dart";
import "package:currency_converter/data/model/membership.dart";
import "package:currency_converter/data/repository/data_state.dart";
import "package:currency_converter/data/source/remote_membership_source/remote_membership_source.dart";
import "package:j1_environment/j1_environment.dart";

class MembershipRepository {
  final RemoteMembershipSource _membershipSource;
  final DataSubject<Membership> _membershipSubject;
  StreamSubscription<Membership>? _membershipSubscription;

  Stream<DataState<Membership>> get membershipStream => _membershipSubject.stream;

  MembershipRepository({
    RemoteMembershipSource? membershipSource,
    Membership? initialState,
  })  : _membershipSource = membershipSource ?? locator.get<RemoteMembershipSource>(),
        _membershipSubject = DataSubject.initial(initialState);

  Future<void> loadMembership({bool forceRefresh = false}) async {
    if (_membershipSubject.value is DataSuccess<Membership> && !forceRefresh) {
      return;
    }

    _membershipSubscription?.cancel();
    final stream = await _membershipSource.getMembershipStream();
    _membershipSubscription = stream.listen(
      _membershipSubject.addSuccess,
      onError: (e) => _membershipSubject.addErrorEvent(CcError.fromObject(e)),
    );
  }

  Future<void> purchaseMembershipLevel(MembershipLevel level) async {
    if (_membershipSubject.dataValue == null) {
      _membershipSubject.addErrorEvent(const CcError(ErrorCode.repository_membership_notSeededError));
    }

    await _membershipSource.purchaseMembershipLevel(level);
  }

  void dispose() {
    _membershipSubject.close();
    _membershipSubscription?.cancel();
  }
}
