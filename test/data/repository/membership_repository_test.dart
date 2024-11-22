import "package:currency_converter/data/model/cc_error.dart";
import "package:currency_converter/data/model/membership.dart";
import "package:currency_converter/data/repository/data_state.dart";
import "package:currency_converter/data/repository/membership_repository.dart";
import "package:currency_converter/data/source/remote_membership_source/remote_membership_source.dart";
import "package:flutter_test/flutter_test.dart";
import "package:j1_environment/j1_environment.dart";
import "package:mocktail/mocktail.dart";

import "../../testing_utils.dart";

class MockRemoteMembershipSource extends Mock implements RemoteMembershipSource {}

void main() {
  group("Membership Repository", () {
    final source = MockRemoteMembershipSource();
    late MembershipRepository repository;

    setUpAll(() {
      locator.registerSingleton<RemoteMembershipSource>(source);
    });

    setUp(() {
      repository = MembershipRepository();
    });

    tearDown(() {
      reset(source);
      repository.dispose();
    });

    tearDownAll(() async {
      await locator.reset();
    });

    test("purchases membership levels", () async {
      when(() => source.purchaseMembershipLevel(MembershipLevel.noAds)).thenAnswer((_) => Future.value());
      await repository.purchaseMembershipLevel(MembershipLevel.noAds);
      verify(() => source.purchaseMembershipLevel(MembershipLevel.noAds)).called(1);
    });

    test("gets membership levels and handles error", () async {
      when(source.getMembershipStream).thenAnswer((_) => Future.value(_membershipStream()));

      expect(
        repository.membershipStream.handleErrorForTest(),
        emitsInOrder(
          [
            const DataEmpty<Membership>(),
            const DataSuccess(Membership.confirmed(level: MembershipLevel.noAds)),
            HasErrorCode(ErrorCode.source_remote_membership_getMembershipError),
          ],
        ),
      );

      await repository.loadMembership();

      verify(source.getMembershipStream).called(1);
    });
  });
}

Stream<Membership> _membershipStream() async* {
  yield const Membership.confirmed(level: MembershipLevel.noAds);
  throw const CcError(ErrorCode.source_remote_membership_getMembershipError);
}
