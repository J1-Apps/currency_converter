import "package:currency_converter/model/membership.dart";
import "package:currency_converter/repository/membership_repository.dart";
import "package:currency_converter/source/remote_membership_source/remote_membership_source.dart";
import "package:flutter_test/flutter_test.dart";
import "package:j1_environment/j1_environment.dart";
import "package:mocktail/mocktail.dart";

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
    });

    tearDownAll(() async {
      await locator.reset();
    });

    test("purchases membership levels", () async {
      when(() => source.purchaseMembershipLevel(MembershipLevel.noAds)).thenAnswer((_) => Future.value());

      await repository.purchaseMembershipLevel(MembershipLevel.noAds);

      verify(() => source.purchaseMembershipLevel(MembershipLevel.noAds)).called(1);
    });

    test("gets membership levels", () async {
      when(
        source.getMembershipStream,
      ).thenAnswer((_) => Future.value(Stream.value(const Membership.confirmed(level: MembershipLevel.noAds))));

      expect(
        await repository.getMembershipStream(),
        emitsInOrder([const Membership.confirmed(level: MembershipLevel.noAds)]),
      );

      verify(source.getMembershipStream).called(1);
    });
  });
}
