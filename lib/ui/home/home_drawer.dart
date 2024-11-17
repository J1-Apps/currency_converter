import "package:currency_converter/data/model/currency.dart";
import "package:currency_converter/state/home/home_bloc.dart";
import "package:currency_converter/state/home/home_event.dart";
import "package:currency_converter/state/home/home_state.dart";
import "package:currency_converter/ui/common/select_currency_drawer.dart";
import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:j1_router/j1_router.dart";

class HomePageSelectorDrawer extends StatelessWidget {
  const HomePageSelectorDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocSelector<HomeBloc, HomeState, (List<CurrencyCode>, List<CurrencyCode>, List<CurrencyCode>)>(
      selector: (state) => (
        (state.allCurrencies ?? []).where((code) => code != state.baseCurrency?.code).toList(),
        state.selectedCurrencies,
        state.allFavorites ?? [],
      ),
      builder: (context, state) => SelectCurrencyDrawer(
        allOptions: state.$1,
        selected: state.$2,
        favorites: state.$3,
        toggleSelected: (code) => context.read<HomeBloc>().add(HomeToggleCurrencyEvent(code)),
      ),
    );
  }
}

class HomePageChangerDrawer extends StatelessWidget {
  final CurrencyCode code;
  final bool isBase;
  final void Function(CurrencyCode) onSelected;

  const HomePageChangerDrawer({
    required this.code,
    required this.isBase,
    required this.onSelected,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocSelector<HomeBloc, HomeState, (List<CurrencyCode>, List<CurrencyCode>)>(
      selector: (state) {
        final baseCurrency = state.baseCurrency?.code;
        final selectedCodes = isBase ? [if (baseCurrency != null) baseCurrency] : [state.selectedCurrencies];

        return (
          (state.allCurrencies ?? []).where((code) => !selectedCodes.contains(code)).toList(),
          state.allFavorites ?? [],
        );
      },
      builder: (context, state) => SelectCurrencyDrawer(
        allOptions: state.$1,
        selected: const [],
        favorites: state.$2,
        toggleSelected: (updatedCode) {
          onSelected(updatedCode);
          context.pop();
        },
      ),
    );
  }
}
