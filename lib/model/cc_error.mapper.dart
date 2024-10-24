// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'cc_error.dart';

class ErrorCodeMapper extends EnumMapper<ErrorCode> {
  ErrorCodeMapper._();

  static ErrorCodeMapper? _instance;
  static ErrorCodeMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = ErrorCodeMapper._());
    }
    return _instance!;
  }

  static ErrorCode fromValue(dynamic value) {
    ensureInitialized();
    return MapperContainer.globals.fromValue(value);
  }

  @override
  ErrorCode decode(dynamic value) {
    switch (value) {
      case 'common_unknown':
        return ErrorCode.common_unknown;
      case 'repository_appStorage_seedingError':
        return ErrorCode.repository_appStorage_seedingError;
      case 'repository_appStorage_savingError':
        return ErrorCode.repository_appStorage_savingError;
      case 'repository_appStorage_getConfigurationError':
        return ErrorCode.repository_appStorage_getConfigurationError;
      case 'repository_appStorage_getExchangeRateError':
        return ErrorCode.repository_appStorage_getExchangeRateError;
      case 'repository_exchangeRate_invalidCode':
        return ErrorCode.repository_exchangeRate_invalidCode;
      case 'repository_exchangeRate_httpError':
        return ErrorCode.repository_exchangeRate_httpError;
      case 'repository_exchangeRate_parsingError':
        return ErrorCode.repository_exchangeRate_parsingError;
      case 'source_membership_getMembershipError':
        return ErrorCode.source_membership_getMembershipError;
      case 'source_membership_purchaseError':
        return ErrorCode.source_membership_purchaseError;
      default:
        throw MapperException.unknownEnumValue(value);
    }
  }

  @override
  dynamic encode(ErrorCode self) {
    switch (self) {
      case ErrorCode.common_unknown:
        return 'common_unknown';
      case ErrorCode.repository_appStorage_seedingError:
        return 'repository_appStorage_seedingError';
      case ErrorCode.repository_appStorage_savingError:
        return 'repository_appStorage_savingError';
      case ErrorCode.repository_appStorage_getConfigurationError:
        return 'repository_appStorage_getConfigurationError';
      case ErrorCode.repository_appStorage_getExchangeRateError:
        return 'repository_appStorage_getExchangeRateError';
      case ErrorCode.repository_exchangeRate_invalidCode:
        return 'repository_exchangeRate_invalidCode';
      case ErrorCode.repository_exchangeRate_httpError:
        return 'repository_exchangeRate_httpError';
      case ErrorCode.repository_exchangeRate_parsingError:
        return 'repository_exchangeRate_parsingError';
      case ErrorCode.source_membership_getMembershipError:
        return 'source_membership_getMembershipError';
      case ErrorCode.source_membership_purchaseError:
        return 'source_membership_purchaseError';
    }
  }
}

extension ErrorCodeMapperExtension on ErrorCode {
  String toValue() {
    ErrorCodeMapper.ensureInitialized();
    return MapperContainer.globals.toValue<ErrorCode>(this) as String;
  }
}

class CcErrorMapper extends ClassMapperBase<CcError> {
  CcErrorMapper._();

  static CcErrorMapper? _instance;
  static CcErrorMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = CcErrorMapper._());
      ErrorCodeMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'CcError';

  static ErrorCode _$code(CcError v) => v.code;
  static const Field<CcError, ErrorCode> _f$code = Field('code', _$code);
  static String _$message(CcError v) => v.message;
  static const Field<CcError, String> _f$message = Field('message', _$message, opt: true, def: "");

  @override
  final MappableFields<CcError> fields = const {
    #code: _f$code,
    #message: _f$message,
  };

  static CcError _instantiate(DecodingData data) {
    return CcError(data.dec(_f$code), message: data.dec(_f$message));
  }

  @override
  final Function instantiate = _instantiate;

  static CcError fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<CcError>(map);
  }

  static CcError fromJson(String json) {
    return ensureInitialized().decodeJson<CcError>(json);
  }
}

mixin CcErrorMappable {
  String toJson() {
    return CcErrorMapper.ensureInitialized().encodeJson<CcError>(this as CcError);
  }

  Map<String, dynamic> toMap() {
    return CcErrorMapper.ensureInitialized().encodeMap<CcError>(this as CcError);
  }

  CcErrorCopyWith<CcError, CcError, CcError> get copyWith =>
      _CcErrorCopyWithImpl(this as CcError, $identity, $identity);
  @override
  String toString() {
    return CcErrorMapper.ensureInitialized().stringifyValue(this as CcError);
  }

  @override
  bool operator ==(Object other) {
    return CcErrorMapper.ensureInitialized().equalsValue(this as CcError, other);
  }

  @override
  int get hashCode {
    return CcErrorMapper.ensureInitialized().hashValue(this as CcError);
  }
}

extension CcErrorValueCopy<$R, $Out> on ObjectCopyWith<$R, CcError, $Out> {
  CcErrorCopyWith<$R, CcError, $Out> get $asCcError => $base.as((v, t, t2) => _CcErrorCopyWithImpl(v, t, t2));
}

abstract class CcErrorCopyWith<$R, $In extends CcError, $Out> implements ClassCopyWith<$R, $In, $Out> {
  $R call({ErrorCode? code, String? message});
  CcErrorCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _CcErrorCopyWithImpl<$R, $Out> extends ClassCopyWithBase<$R, CcError, $Out>
    implements CcErrorCopyWith<$R, CcError, $Out> {
  _CcErrorCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<CcError> $mapper = CcErrorMapper.ensureInitialized();
  @override
  $R call({ErrorCode? code, String? message}) =>
      $apply(FieldCopyWithData({if (code != null) #code: code, if (message != null) #message: message}));
  @override
  CcError $make(CopyWithData data) =>
      CcError(data.get(#code, or: $value.code), message: data.get(#message, or: $value.message));

  @override
  CcErrorCopyWith<$R2, CcError, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t) => _CcErrorCopyWithImpl($value, $cast, t);
}
