import "dart:async";

import "package:bloc_concurrency/bloc_concurrency.dart";
import "package:currency_converter/model/configuration.dart";
import "package:currency_converter/model/currency.dart";
import "package:currency_converter/repository/app_storage_repository/app_storage_repository.dart";
import "package:currency_converter/repository/app_storage_repository/defaults.dart";
import "package:currency_converter/state/settings/settings_event.dart";
import "package:currency_converter/state/settings/settings_state.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:j1_environment/j1_environment.dart";

const _initialState = SettingsState(defaultFavorites, defaultConfigurations, defaultLanguage);

class SettingsBloc extends Bloc<SettingsEvent, SettingsState> {
  final AppStorageRepository _appStorage;

  late final StreamSubscription<List<CurrencyCode>> _favoritesSubscription;
  late final StreamSubscription<List<Configuration>> _configurationsSubscription;
  late final StreamSubscription<String> _languageSubscription;

  SettingsBloc({AppStorageRepository? appStorage})
      : _appStorage = appStorage ?? locator.get<AppStorageRepository>(),
        super(_initialState) {
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

  Future<void> _handleSetFavorites(SettingsSetFavoritesEvent event, Emitter<SettingsState> emit) async {
    if (event.favorites == state.favorites) {
      return;
    }

    emit(state.copyWith(favorites: event.favorites));
  }

  Future<void> _handleSetConfigurations(SettingsSetConfigurationsEvent event, Emitter<SettingsState> emit) async {
    if (event.configurations == state.configurations) {
      return;
    }

    emit(state.copyWith(configurations: event.configurations));
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
