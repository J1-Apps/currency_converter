// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'loading_state.dart';

class LoadingStateMapper extends EnumMapper<LoadingState> {
  LoadingStateMapper._();

  static LoadingStateMapper? _instance;
  static LoadingStateMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = LoadingStateMapper._());
    }
    return _instance!;
  }

  static LoadingState fromValue(dynamic value) {
    ensureInitialized();
    return MapperContainer.globals.fromValue(value);
  }

  @override
  LoadingState decode(dynamic value) {
    switch (value) {
      case 'initial':
        return LoadingState.initial;
      case 'loading':
        return LoadingState.loading;
      case 'error':
        return LoadingState.error;
      case 'loaded':
        return LoadingState.loaded;
      default:
        throw MapperException.unknownEnumValue(value);
    }
  }

  @override
  dynamic encode(LoadingState self) {
    switch (self) {
      case LoadingState.initial:
        return 'initial';
      case LoadingState.loading:
        return 'loading';
      case LoadingState.error:
        return 'error';
      case LoadingState.loaded:
        return 'loaded';
    }
  }
}

extension LoadingStateMapperExtension on LoadingState {
  String toValue() {
    LoadingStateMapper.ensureInitialized();
    return MapperContainer.globals.toValue<LoadingState>(this) as String;
  }
}
