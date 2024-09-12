import "dart:async";

import "package:bloc_concurrency/bloc_concurrency.dart";
import "package:currency_converter/model/configuration.dart";
import "package:currency_converter/model/currency.dart";
import "package:currency_converter/repository/app_storage_repository/app_storage_repository.dart";
import "package:currency_converter/repository/app_storage_repository/defaults.dart";
import "package:currency_converter/state/settings/settings_event.dart";
import "package:currency_converter/state/settings/settings_state.dart";
import "package:currency_converter/util/errors/cc_error.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:j1_environment/j1_environment.dart";

final _initialState = SettingsState(defaultFavorites.toSet(), defaultConfigurations.toSet(), defaultLanguage, null);

class SettingsBloc extends Bloc<SettingsEvent, SettingsState> {
  final AppStorageRepository _appStorage;

  late final StreamSubscription<List<CurrencyCode>> _favoritesSubscription;
  late final StreamSubscription<List<Configuration>> _configurationsSubscription;
  late final StreamSubscription<String> _languageSubscription;

  SettingsBloc({AppStorageRepository? appStorage})
      : _appStorage = appStorage ?? locator.get<AppStorageRepository>(),
        super(_initialState) {
    on<SettingsToggleFavoriteEvent>(_handleToggleFavorite, transformer: droppable());
    on<SettingsUpdateLanguageEvent>(_handleUpdateLanguage, transformer: droppable());
    on<SettingsSaveConfigurationEvent>(_handleSaveConfiguration, transformer: droppable());
    on<SettingsRemoveConfigurationEvent>(_handleRemoveConfiguration, transformer: droppable());
    on<SettingsUpdateLanguageEvent>(_handleUpdateLanguage, transformer: droppable());
    on<SettingsSetFavoritesEvent>(_handleSetFavorites, transformer: sequential());
    on<SettingsSetConfigurationsEvent>(_handleSetConfigurations, transformer: sequential());
    on<SettingsSetLanguageEvent>(_handleSetLanguage, transformer: sequential());

    _favoritesSubscription = _appStorage.getFavoritesStream().listen(
          (favorites) => add(SettingsSetFavoritesEvent(favorites)),
        );
    _configurationsSubscription = _appStorage.getConfigurationsStream().listen(
          (configurations) => add(SettingsSetConfigurationsEvent(configurations)),
        );
    _languageSubscription = _appStorage.getLanguagesStream().listen(
          (language) => add(SettingsSetLanguageEvent(language)),
        );
  }

  Future<void> _handleToggleFavorite(SettingsToggleFavoriteEvent event, Emitter<SettingsState> emit) async {
    var favorites = state.favorites;
    if (favorites.contains(event.code)) {
      favorites = favorites.difference({event.code});
    } else {
      favorites = {...favorites, event.code};
    }

    try {
      if (favorites.contains(event.code)) {
        await _appStorage.removeFavorite(event.code);
      } else {
        await _appStorage.setFavorite(event.code);
      }
    } catch (e) {
      emit(state.copyWith(error: CcError.fromObject(e)));
    }
  }

  Future<void> _handleSaveConfiguration(SettingsSaveConfigurationEvent event, Emitter<SettingsState> emit) async {
    try {
      await _appStorage.saveConfiguration(event.configuration);
    } catch (e) {
      emit(state.copyWith(error: CcError.fromObject(e)));
    }
  }

  Future<void> _handleRemoveConfiguration(SettingsRemoveConfigurationEvent event, Emitter<SettingsState> emit) async {
    try {
      await _appStorage.removeConfiguration(event.configuration);
    } catch (e) {
      emit(state.copyWith(error: CcError.fromObject(e)));
    }
  }

  Future<void> _handleUpdateLanguage(SettingsUpdateLanguageEvent event, Emitter<SettingsState> emit) async {
    try {
      await _appStorage.setLanguage(event.language);
    } catch (e) {
      emit(state.copyWith(error: CcError.fromObject(e)));
    }
  }

  Future<void> _handleSetFavorites(SettingsSetFavoritesEvent event, Emitter<SettingsState> emit) async {
    final favorites = event.favorites.toSet();

    if (favorites == state.favorites) {
      return;
    }

    emit(state.copyWith(favorites: favorites));
  }

  Future<void> _handleSetConfigurations(SettingsSetConfigurationsEvent event, Emitter<SettingsState> emit) async {
    final configurations = event.configurations.toSet();

    if (configurations == state.configurations) {
      return;
    }

    emit(state.copyWith(configurations: configurations));
  }

  Future<void> _handleSetLanguage(SettingsSetLanguageEvent event, Emitter<SettingsState> emit) async {
    if (event.language == state.language) {
      return;
    }

    emit(state.copyWith(language: event.language));
  }

  @override
  Future<void> close() {
    _favoritesSubscription.cancel();
    _configurationsSubscription.cancel();
    _languageSubscription.cancel();
    return super.close();
  }
}
