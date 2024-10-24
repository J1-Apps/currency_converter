import "dart:async";

import "package:bloc_concurrency/bloc_concurrency.dart";
import "package:currency_converter/model/currency.dart";
import "package:currency_converter/repository/app_storage_repository/app_storage_repository.dart";
import "package:currency_converter/repository/app_storage_repository/defaults.dart";
import "package:currency_converter/repository/configuration_repository.dart";
import "package:currency_converter/state/settings/settings_event.dart";
import "package:currency_converter/state/settings/settings_state.dart";
import "package:currency_converter/model/cc_error.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:j1_environment/j1_environment.dart";

const _initialState = SettingsState(defaultFavorites, defaultConfigurations, defaultLanguage, null);

class SettingsBloc extends Bloc<SettingsEvent, SettingsState> {
  final AppStorageRepository _appStorage;
  final ConfigurationRepository _configuration;

  late final StreamSubscription<List<CurrencyCode>> _favoritesSubscription;
  late final StreamSubscription<String> _languageSubscription;

  SettingsBloc({
    AppStorageRepository? appStorage,
    ConfigurationRepository? configuration,
  })  : _appStorage = appStorage ?? locator.get<AppStorageRepository>(),
        _configuration = configuration ?? locator.get<ConfigurationRepository>(),
        super(_initialState) {
    on<SettingsToggleFavoriteEvent>(_handleToggleFavorite, transformer: droppable());
    on<SettingsSaveConfigurationEvent>(_handleSaveConfiguration, transformer: droppable());
    on<SettingsRemoveConfigurationEvent>(_handleRemoveConfiguration, transformer: droppable());
    on<SettingsUpdateLanguageEvent>(_handleUpdateLanguage, transformer: droppable());
    on<SettingsSetFavoritesEvent>(_handleSetFavorites, transformer: sequential());
    on<SettingsSetLanguageEvent>(_handleSetLanguage, transformer: sequential());

    _favoritesSubscription = _appStorage.getFavoritesStream().listen(
          (favorites) => add(SettingsSetFavoritesEvent(favorites)),
        );
    _languageSubscription = _appStorage.getLanguagesStream().listen(
          (language) => add(SettingsSetLanguageEvent(language)),
        );
  }

  Future<void> _handleToggleFavorite(SettingsToggleFavoriteEvent event, Emitter<SettingsState> emit) async {
    try {
      if (state.favorites.contains(event.code)) {
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
      final updatedConfiguration = [...state.configurations];
      updatedConfiguration.add(event.configuration);
      await _configuration.updateConfigurations(updatedConfiguration);
    } catch (e) {
      emit(state.copyWith(error: CcError.fromObject(e)));
    }
  }

  Future<void> _handleRemoveConfiguration(SettingsRemoveConfigurationEvent event, Emitter<SettingsState> emit) async {
    try {
      final updatedConfiguration = [...state.configurations];
      updatedConfiguration.remove(event.configuration);
      await _configuration.updateConfigurations(updatedConfiguration);
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
    if (event.favorites == state.favorites) {
      return;
    }

    emit(state.copyWith(favorites: event.favorites));
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
    _languageSubscription.cancel();
    return super.close();
  }
}
