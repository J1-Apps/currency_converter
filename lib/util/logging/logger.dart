/// A class that handles event logging.
abstract class Logger {
  /// Sets the default parameters that should be passed with every logged event.
  void setDefaultParams({required Map<String, Object?> params});

  /// Logs an event with the given [name], [page], and [params].
  ///
  /// The [page] argument will be added to the [params] map with the key 'page'.
  void logUi({
    required String name,
    required String page,
    Map<String, Object> params = const {},
  }) {
    _logNamed(name: name, categoryName: "page", categoryValue: page, params: params);
  }

  /// Logs an event with the given [name], [bloc], and [params].
  ///
  /// The [bloc] argument will be added to the [params] map with the key 'bloc'.
  void logBloc({
    required String name,
    required String bloc,
    Map<String, Object> params = const {},
  }) {
    _logNamed(name: name, categoryName: "bloc", categoryValue: bloc, params: params);
  }

  /// Logs an event with the given [name], [repository], and [params].
  ///
  /// The [repository] argument will be added to the [params] map with the key 'repository'.
  void logRepository({
    required String name,
    required String repository,
    Map<String, Object> params = const {},
  }) {
    _logNamed(name: name, categoryName: "repository", categoryValue: repository, params: params);
  }

  /// Logs an event with the given [name], and [params].
  void log({
    required String name,
    Map<String, Object>? params,
  });

  void _logNamed({
    required String name,
    required String categoryName,
    required String categoryValue,
    Map<String, Object> params = const {},
  }) {
    params[categoryName] = categoryValue;
    log(name: "$categoryValue-$categoryName-$name", params: params);
  }
}
