import "package:currency_converter/state/home/home_bloc.dart";
import "package:currency_converter/state/home/home_event.dart";
import "package:currency_converter/ui/util/extensions/build_context_extensions.dart";
import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:j1_ui/j1_ui.dart";

class HomeError extends StatelessWidget {
  const HomeError({super.key});

  @override
  Widget build(BuildContext context) {
    final strings = context.strings();
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: JDimens.spacing_xl),
        child: JErrorMessage(
          message: strings.home_error_getExchangeRate,
          cta: strings.home_refresh,
          ctaAction: () => context.read<HomeBloc>().add(const HomeLoadEvent()),
        ),
      ),
    );
  }
}
