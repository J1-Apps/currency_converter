import "dart:async";

import "package:bloc_concurrency/bloc_concurrency.dart";
import "package:currency_converter/data/repository/data_state.dart";
import "package:currency_converter/data/repository/defaults.dart";
import "package:currency_converter/data/repository/language_repository.dart";
import "package:currency_converter/state/settings/settings_event.dart";
import "package:currency_converter/state/settings/settings_state.dart";
import "package:currency_converter/util/analytics.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:j1_environment/j1_environment.dart";
import "package:j1_logger/j1_logger.dart";

// coverage:ignore-file
class SettingsBloc extends Bloc<SettingsEvent, SettingsState> {
  final LanguageRepository _language;
  final J1Logger _logger;

  StreamSubscription? _subscription;

  SettingsBloc({
    LanguageRepository? language,
    J1Logger? logger,
  })  : _language = language ?? locator.get<LanguageRepository>(),
        _logger = logger ?? locator.get<J1Logger>(),
        super(const SettingsState.initial()) {
    on<SettingsLoadEvent>(_handleLoad, transformer: droppable());
    on<SettingsUpdateLanguageEvent>(_handleUpdateLanguage);

    on<SettingsSuccessDataEvent>(_handleSuccessData, transformer: droppable());
    on<SettingsErrorDataEvent>(_handleErrorData, transformer: sequential());
  }

  Future<void> _handleLoad(SettingsLoadEvent event, Emitter<SettingsState> emit) async {
    _subscription?.cancel();

    emit(const SettingsState.loading());

    await _language.loadLanguage();

    _subscription = _language.languageStream
        .handleError((e) => _streamError(e, SettingsErrorCode.loadLanguage))
        .listen(_handleData);
  }

  void _handleData(DataState<String> data) {
    final language = data is DataSuccess<String> ? data.data : defaultLanguage;
    add(SettingsSuccessDataEvent(SettingsState.loaded(language: language)));
  }

  Future<void> _handleUpdateLanguage(SettingsUpdateLanguageEvent event, Emitter<SettingsState> emit) async {
    try {
      await _language.updateLanguage(event.language);
    } catch (e) {
      emit(state.copyWith(error: SettingsErrorCode.saveLanguage));
    }
  }

  void _handleSuccessData(SettingsSuccessDataEvent event, Emitter<SettingsState> emit) {
    emit(event.next);
  }

  void _handleErrorData(SettingsErrorDataEvent event, Emitter<SettingsState> emit) {
    emit(state.copyWith(error: event.error));
  }

  void _logError(Object e) {
    _logger.logBloc(
      bloc: Analytics.settingsBloc,
      name: Analytics.errorEvent,
      params: {Analytics.errorParam: e},
    );
  }

  void _streamError(Object e, SettingsErrorCode result) {
    _logError(e);
    add(SettingsErrorDataEvent(result));
  }

  @override
  Future<void> close() {
    _subscription?.cancel();
    return super.close();
  }
}
