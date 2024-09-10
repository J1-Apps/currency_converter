import "package:dart_mappable/dart_mappable.dart";

part "membership.mapper.dart";

@MappableEnum()
enum MembershipLevel {
  free,
  noAds,
}

@MappableClass()
final class Membership with MembershipMappable {
  final MembershipLevel level;
  final bool isPending;

  // Only used for dart_mappable.
  // coverage:ignore-start
  const Membership(this.level, this.isPending);
  // coverage:ignore-end

  const Membership.confirmed({required this.level}) : isPending = false;

  const Membership.pending({required this.level}) : isPending = true;
}
