import "dart:async";

import "package:currency_converter/model/cc_error.dart";
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

class DataSubject<T> {
  final BehaviorSubject<DataState<T>> _subject;

  Stream<DataState<T>> get stream => _subject.stream;
  DataState<T> get value => _subject.value;

  T? get dataValue {
    final dataState = value;

    return switch (dataState) {
      DataEmpty() => null,
      DataSuccess() => dataState.data,
    };
  }

  DataSubject.initial(T? initialState)
      : _subject = BehaviorSubject<DataState<T>>.seeded(
          DataState<T>.initial(initialState),
        );

  void addSuccess(T data) {
    _subject.add(DataSuccess<T>(data));
  }

  void addEmpty() {
    final currentValue = dataValue;
    _subject.add(currentValue == null ? DataEmpty<T>() : DataSuccess(currentValue));
  }

  void addErrorEvent(CcError error) {
    _subject.addError(error);
  }

  void dispose() {
    _subject.close();
  }
}
