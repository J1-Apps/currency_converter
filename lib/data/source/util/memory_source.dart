import "package:currency_converter/data/model/cc_error.dart";

abstract class MemorySource {
  static const memoryNetworkDelayMs = 500;

  final bool _initialShouldThrow;
  final int _initialMsDelay;

  bool shouldThrow;
  int msDelay;

  MemorySource({
    required bool? initialShouldThrow,
    required int? initialMsDelay,
  })  : _initialShouldThrow = initialShouldThrow ?? false,
        _initialMsDelay = initialMsDelay ?? memoryNetworkDelayMs,
        shouldThrow = initialShouldThrow ?? false,
        msDelay = initialMsDelay ?? memoryNetworkDelayMs;

  Future<T> wrapRequest<T>(Future<T> request, ErrorCode code) async {
    await Future.delayed(Duration(milliseconds: msDelay));

    if (shouldThrow) {
      throw CcError(code);
    }

    return request;
  }

  void reset() {
    shouldThrow = _initialShouldThrow;
    msDelay = _initialMsDelay;
  }
}
