// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'membership.dart';

class MembershipLevelMapper extends EnumMapper<MembershipLevel> {
  MembershipLevelMapper._();

  static MembershipLevelMapper? _instance;
  static MembershipLevelMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = MembershipLevelMapper._());
    }
    return _instance!;
  }

  static MembershipLevel fromValue(dynamic value) {
    ensureInitialized();
    return MapperContainer.globals.fromValue(value);
  }

  @override
  MembershipLevel decode(dynamic value) {
    switch (value) {
      case 'free':
        return MembershipLevel.free;
      case 'noAds':
        return MembershipLevel.noAds;
      default:
        throw MapperException.unknownEnumValue(value);
    }
  }

  @override
  dynamic encode(MembershipLevel self) {
    switch (self) {
      case MembershipLevel.free:
        return 'free';
      case MembershipLevel.noAds:
        return 'noAds';
    }
  }
}

extension MembershipLevelMapperExtension on MembershipLevel {
  String toValue() {
    MembershipLevelMapper.ensureInitialized();
    return MapperContainer.globals.toValue<MembershipLevel>(this) as String;
  }
}

class MembershipMapper extends ClassMapperBase<Membership> {
  MembershipMapper._();

  static MembershipMapper? _instance;
  static MembershipMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = MembershipMapper._());
      MembershipLevelMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'Membership';

  static MembershipLevel _$level(Membership v) => v.level;
  static const Field<Membership, MembershipLevel> _f$level =
      Field('level', _$level);
  static bool _$isPending(Membership v) => v.isPending;
  static const Field<Membership, bool> _f$isPending =
      Field('isPending', _$isPending);

  @override
  final MappableFields<Membership> fields = const {
    #level: _f$level,
    #isPending: _f$isPending,
  };

  static Membership _instantiate(DecodingData data) {
    return Membership(data.dec(_f$level), data.dec(_f$isPending));
  }

  @override
  final Function instantiate = _instantiate;

  static Membership fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<Membership>(map);
  }

  static Membership fromJson(String json) {
    return ensureInitialized().decodeJson<Membership>(json);
  }
}

mixin MembershipMappable {
  String toJson() {
    return MembershipMapper.ensureInitialized()
        .encodeJson<Membership>(this as Membership);
  }

  Map<String, dynamic> toMap() {
    return MembershipMapper.ensureInitialized()
        .encodeMap<Membership>(this as Membership);
  }

  MembershipCopyWith<Membership, Membership, Membership> get copyWith =>
      _MembershipCopyWithImpl(this as Membership, $identity, $identity);
  @override
  String toString() {
    return MembershipMapper.ensureInitialized()
        .stringifyValue(this as Membership);
  }

  @override
  bool operator ==(Object other) {
    return MembershipMapper.ensureInitialized()
        .equalsValue(this as Membership, other);
  }

  @override
  int get hashCode {
    return MembershipMapper.ensureInitialized().hashValue(this as Membership);
  }
}

extension MembershipValueCopy<$R, $Out>
    on ObjectCopyWith<$R, Membership, $Out> {
  MembershipCopyWith<$R, Membership, $Out> get $asMembership =>
      $base.as((v, t, t2) => _MembershipCopyWithImpl(v, t, t2));
}

abstract class MembershipCopyWith<$R, $In extends Membership, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  $R call({MembershipLevel? level, bool? isPending});
  MembershipCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _MembershipCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, Membership, $Out>
    implements MembershipCopyWith<$R, Membership, $Out> {
  _MembershipCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<Membership> $mapper =
      MembershipMapper.ensureInitialized();
  @override
  $R call({MembershipLevel? level, bool? isPending}) =>
      $apply(FieldCopyWithData({
        if (level != null) #level: level,
        if (isPending != null) #isPending: isPending
      }));
  @override
  Membership $make(CopyWithData data) => Membership(
      data.get(#level, or: $value.level),
      data.get(#isPending, or: $value.isPending));

  @override
  MembershipCopyWith<$R2, Membership, $Out2> $chain<$R2, $Out2>(
          Then<$Out2, $R2> t) =>
      _MembershipCopyWithImpl($value, $cast, t);
}
