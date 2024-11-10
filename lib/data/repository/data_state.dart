import "dart:async";

import "package:currency_converter/data/model/cc_error.dart";
import "package:dart_mappable/dart_mappable.dart";
import "package:rxdart/subjects.dart";

part "data_state.mapper.dart";

/// Encapsulates the data returned by a repository to indicate what state the data is in.
@MappableClass(discriminatorKey: "state")
sealed class DataState<T> with DataStateMappable {
  const DataState();

  factory DataState.initial(T? initialState) {
    if (initialState == null) {
      return DataEmpty<T>();
    } else {
      return DataSuccess(initialState);
    }
  }
}

/// Represents succesfully loaded data.
@MappableClass(discriminatorValue: "success")
class DataSuccess<T> extends DataState<T> with DataSuccessMappable {
  final T data;

  const DataSuccess(this.data);
}

/// Represents empty or missing data.
@MappableClass(discriminatorValue: "empty")
class DataEmpty<T> extends DataState<T> with DataEmptyMappable {
  const DataEmpty();
}

/// A special type of [BehaviorSubject] for producing observable data for repositories.
class DataSubject<T> {
  final BehaviorSubject<DataState<T>> _subject;

  Stream<DataState<T>> get stream => _subject.stream;
  DataState<T> get value => _subject.value;

  /// Gets a nullable [T], returning:
  /// - `null` if the current [DataState] is [DataEmpty]
  /// - [value] if the current [DataState] is [DataSuccess]
  T? get dataValue {
    final dataState = value;

    return switch (dataState) {
      DataEmpty() => null,
      DataSuccess() => dataState.data,
    };
  }

  /// Creates a seeded [DataSubject], with either:
  /// - [DataEmpty] if [initialState] was `null`
  /// - [DataSuccess] with `data = initialState` if [initialState] was not `null`
  DataSubject.initial(T? initialState)
      : _subject = BehaviorSubject<DataState<T>>.seeded(
          DataState<T>.initial(initialState),
        );

  /// Adds a success state with [data].
  void addSuccess(T data) {
    _subject.add(DataSuccess<T>(data));
  }

  /// Adds a:
  /// - [DataEmpty] if the current value is [DataEmpty]
  /// - [DataSuccess] copy if the current value is [DataSuccess]
  void addEmpty() {
    final currentValue = value;
    _subject.add(currentValue is DataSuccess<T> ? DataSuccess(currentValue.data) : DataEmpty<T>());
  }

  /// Adds an error event to the subject. Note that this method does not emit a new state.
  void addErrorEvent(CcError error) {
    _subject.addError(error);
  }

  void close() {
    _subject.close();
  }
}
