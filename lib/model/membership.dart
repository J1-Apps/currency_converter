import "package:equatable/equatable.dart";

enum MembershipLevel {
  free,
  noAds,
}

final class Membership extends Equatable {
  final MembershipLevel level;
  final bool isPending;

  const Membership({required this.level}) : isPending = false;

  const Membership.pending({required this.level}) : isPending = true;

  @override
  String toString() {
    return "Membership(level: $level, isPending: $isPending)";
  }

  @override
  List<Object?> get props => [level, isPending];
}
