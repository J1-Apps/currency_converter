import "package:currency_converter/data/model/currency.dart";
import "package:currency_converter/state/home/home_bloc.dart";
import "package:currency_converter/state/home/home_event.dart";
import "package:currency_converter/state/home/home_state.dart";
import "package:currency_converter/ui/common/select_currency_drawer.dart";
import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:j1_router/j1_router.dart";

typedef _HomeDrawerData = (CurrencyCode, List<CurrencyCode>, List<CurrencyCode>, List<CurrencyCode>);

class HomePageSelectorDrawer extends StatelessWidget {
  const HomePageSelectorDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocSelector<HomeBloc, HomeState, _HomeDrawerData>(
      selector: (state) => (
        state.baseCurrency?.code ?? CurrencyCode.USD,
        state.currencies?.map((converted) => converted.code).toList() ?? [],
        state.allFavorites ?? [],
        state.allCurrencies ?? [],
      ),
      builder: (context, state) {
        final options = [...state.$4];
        options.remove(state.$1);

        return SelectCurrencyDrawer(
          options: options,
          favorites: state.$3,
          selected: state.$2,
          toggleSelected: (code) => context.read<HomeBloc>().add(HomeToggleCurrencyEvent(code)),
        );
      },
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
    return BlocSelector<HomeBloc, HomeState, _HomeDrawerData>(
      selector: (state) => (
        state.baseCurrency?.code ?? CurrencyCode.USD,
        state.currencies?.map((converted) => converted.code).toList() ?? [],
        state.allFavorites ?? [],
        state.allCurrencies ?? [],
      ),
      builder: (context, state) {
        final options = [...state.$4];
        final current = [if (!isBase) ...state.$2, state.$1, code];
        options.removeWhere(current.contains);

        return SelectCurrencyDrawer(
          options: options,
          favorites: state.$3,
          selected: const [],
          toggleSelected: (updatedCode) {
            onSelected(updatedCode);
            context.pop();
          },
        );
      },
    );
  }
}
