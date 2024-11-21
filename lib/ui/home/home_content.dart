import "package:currency_converter/state/home/home_bloc.dart";
import "package:currency_converter/state/home/home_state.dart";
import "package:currency_converter/state/loading_state.dart";
import "package:currency_converter/ui/home/home_loaded.dart";
import "package:currency_converter/ui/home/home_loading.dart";
import "package:currency_converter/ui/home/home_error.dart";
import "package:currency_converter/ui/util/extensions/build_context_extensions.dart";
import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:j1_ui/j1_ui.dart";

class HomeContent extends StatelessWidget {
  const HomeContent({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeBloc, HomeState>(
      listenWhen: (prev, next) => prev.error != next.error,
      buildWhen: (prev, next) => prev.status != next.status,
      listener: _listenErrors,
      builder: (context, state) => switch (state.status) {
        LoadingState.initial => const HomeLoading(),
        LoadingState.loading => const HomeLoading(),
        LoadingState.error => const HomeError(),
        LoadingState.loaded => const HomeLoaded(),
      },
    );
  }
}

void _listenErrors(BuildContext context, HomeState state) {
  final error = state.error;

  if (error == null) {
    return;
  }

  final strings = context.strings();
  final errorString = switch (error) {
    HomeErrorCode.loadCurrentConfiguration => strings.home_error_getConfiguration,
    HomeErrorCode.loadExchangeRate => strings.home_error_getExchangeRate,
    HomeErrorCode.loadFavorites => strings.home_error_getFavorites,
    HomeErrorCode.loadCurrencies => strings.home_error_getCurrencies,
    HomeErrorCode.saveCurrentConfiguration => strings.home_error_saveConfiguration,
    HomeErrorCode.saveFavorite => strings.home_error_saveFavorite,
  };

  context.showJToastWithText(text: errorString, hasClose: true);
}
