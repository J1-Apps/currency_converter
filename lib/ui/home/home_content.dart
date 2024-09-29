import "package:currency_converter/state/home/home_bloc.dart";
import "package:currency_converter/state/home/home_state.dart";
import "package:currency_converter/ui/extensions/build_context_extensions.dart";
import "package:currency_converter/ui/home/home_loading.dart";
import "package:currency_converter/ui/home/home_error.dart";
import "package:currency_converter/util/errors/cc_error.dart";
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
        HomeStatus.initial => const HomeLoading(),
        HomeStatus.loading => const HomeLoading(),
        HomeStatus.error => const HomeError(),
        HomeStatus.loaded => const HomeLoaded(),
      },
    );
  }
}

class HomeLoaded extends StatelessWidget {
  const HomeLoaded({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(child: CircularProgressIndicator());
  }
}

void _listenErrors(BuildContext context, HomeState state) {
  final error = state.error;

  if (error == null) {
    return;
  }

  final errorString = switch (error.code) {
    ErrorCode.repository_appStorage_getConfigurationError => context.strings().home_error_getConfiguration,
    ErrorCode.repository_exchangeRate_invalidCode => context.strings().home_error_getExchange,
    ErrorCode.repository_exchangeRate_httpError => context.strings().home_error_getExchange,
    ErrorCode.repository_exchangeRate_parsingError => context.strings().home_error_getExchange,
    _ => null,
  };

  if (errorString != null) {
    context.showJToastWithText(text: errorString, hasClose: true);
  }
}
