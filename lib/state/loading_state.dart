import "package:dart_mappable/dart_mappable.dart";

part "loading_state.mapper.dart";

@MappableEnum()
enum LoadingState {
  initial,
  loading,
  error,
  loaded,
}
