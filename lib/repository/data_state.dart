import "package:rxdart/subjects.dart";

/// Encapsulates the data returned by a repository to indicate what state the data is in.
sealed class DataState<T> {
  const DataState();
}

/// Represents succesfully loaded data.
class DataSuccess<T> extends DataState<T> {
  final T data;

  const DataSuccess({required this.data});
}

/// Represents sucessfully loaded data, which is currently being updated.
class DataRefreshing<T> extends DataSuccess<T> {
  const DataRefreshing({required super.data});
}

/// Represents data that has not yet been loaded successfully, and is currently loading.
class DataLoading<T> extends DataState<T> {
  const DataLoading();
}

/// Represents data that was failed to be retrieved due to an error.
class DataError<T> extends DataState<T> {
  const DataError();
}

extension DataStateExtensions<T> on BehaviorSubject<DataState<T>> {
  void addSuccessState(T data) {
    add(DataSuccess(data: data));
  }

  void addErrorState() {
    add(const DataError());
  }

  void addLoadingState() {
    final currentState = value;

    switch (currentState) {
      case DataRefreshing():
        break;
      case DataSuccess():
        add(DataRefreshing(data: currentState.data));
      case DataLoading():
        break;
      case DataError():
        add(const DataLoading());
    }
  }
}
