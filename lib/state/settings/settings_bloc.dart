import "dart:async";

import "package:bloc_concurrency/bloc_concurrency.dart";
import "package:currency_converter/data/model/currency.dart";
import "package:currency_converter/data/repository/defaults.dart";
import "package:currency_converter/data/repository/configuration_repository.dart";
import "package:currency_converter/data/repository/data_state.dart";
import "package:currency_converter/data/repository/language_repository.dart";
import "package:currency_converter/state/settings/settings_event.dart";
import "package:currency_converter/state/settings/settings_state.dart";
import "package:currency_converter/data/model/cc_error.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:j1_environment/j1_environment.dart";

const _initialState = SettingsState(defaultConfigurations, defaultLanguage, null);

class SettingsBloc extends Bloc<SettingsEvent, SettingsState> {
  final ConfigurationRepository _configuration;
  final LanguageRepository _language;

  late final StreamSubscription<List<CurrencyCode>> _favoritesSubscription;
  late final StreamSubscription<DataState<String>> _languageSubscription;

  SettingsBloc({
    ConfigurationRepository? configuration,
    LanguageRepository? language,
  })  : _configuration = configuration ?? locator.get<ConfigurationRepository>(),
        _language = language ?? locator.get<LanguageRepository>(),
        super(_initialState) {
    on<SettingsSaveConfigurationEvent>(_handleSaveConfiguration, transformer: droppable());
    on<SettingsRemoveConfigurationEvent>(_handleRemoveConfiguration, transformer: droppable());
    on<SettingsUpdateLanguageEvent>(_handleUpdateLanguage, transformer: droppable());
    on<SettingsSetLanguageEvent>(_handleSetLanguage, transformer: sequential());

    _languageSubscription = _language.languageStream.listen((data) {
      if (data is DataSuccess<String>) {
        add(SettingsSetLanguageEvent(data.data));
      }
    });
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
      await _language.updateLanguage(event.language);
    } catch (e) {
      emit(state.copyWith(error: CcError.fromObject(e)));
    }
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
