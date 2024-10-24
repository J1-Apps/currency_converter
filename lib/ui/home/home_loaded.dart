import "package:currency_converter/model/currency.dart";
import "package:currency_converter/state/home/home_bloc.dart";
import "package:currency_converter/state/home/home_event.dart";
import "package:currency_converter/state/home/home_state.dart";
import "package:currency_converter/ui/common/currency_card/currency_card.dart";
import "package:currency_converter/ui/common/select_currency_drawer.dart";
import "package:currency_converter/ui/extensions/build_context_extensions.dart";
import "package:flutter/material.dart";
import "package:flutter_gen/gen_l10n/app_localizations.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:intl/intl.dart";
import "package:j1_router/router_extensions.dart";
import "package:j1_ui/j1_ui.dart";

const _dateFormatString = "MMM d";
const _timeFormatString = "H:mm";

class HomeLoaded extends StatelessWidget {
  const HomeLoaded({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: JDimens.spacing_m),
      child: BlocSelector<HomeBloc, HomeState, List<CurrencyCode>>(
        selector: (state) => state.configuration?.currencies ?? [],
        builder: (context, currencies) {
          final items = _createItems(context.strings(), currencies);

          return ListView.builder(
            itemCount: items.length,
            itemBuilder: (context, index) => items[index].build(context),
          );
        },
      ),
    );
  }
}

List<_HomePageItem> _createItems(
  Strings strings,
  List<CurrencyCode> currencies,
) {
  return [
    _HomePageTitleItem(text: strings.home_baseCurrency),
    const _HomePagePaddingItem(),
    const _HomePageRefreshItem(),
    const _HomePagePaddingItem(),
    const _HomePageBaseCurrencyItem(),
    _HomePageTitleItem(text: strings.home_converted),
    const _HomePagePaddingItem(),
    for (final currency in currencies) _HomePageCurrencyItem(code: currency),
    const _HomePageSelectorItem(),
    const _HomePagePaddingItem(height: JDimens.spacing_xxxl),
  ];
}

class _HomePageBaseCurrencyCard extends StatelessWidget {
  const _HomePageBaseCurrencyCard();

  @override
  Widget build(BuildContext context) {
    return BlocSelector<HomeBloc, HomeState, (CurrencyCode, double)>(
      selector: (state) => (
        state.configuration?.baseCurrency ?? CurrencyCode.USD,
        state.configuration?.baseValue ?? 0,
      ),
      builder: (context, config) => CurrencyCard(
        currency: config.$1,
        onTapCurrency: () => context.showJBottomSheet(
          child: _HomePageChangerDrawer(
            code: config.$1,
            onSelected: (updated) => context.read<HomeBloc>().add(HomeUpdateBaseCurrencyEvent(updated)),
          ),
          scrollControlDisabledMaxHeightRatio: selectCurrencyDrawerHeightRatio,
        ),
        isBase: true,
        isExpanded: false,
        toggleExpanded: () {},
        relativeValue: config.$2,
        updateRelativeValue: (value) => context.read<HomeBloc>().add(HomeUpdateBaseValueEvent(value)),
        isFavorite: false,
        toggleFavorite: () {},
        onRemove: () {},
        snapshot: null,
        onSnapshotPeriodUpdate: (period) {},
      ),
    );
  }
}

class _HomePageCurrencyCard extends StatelessWidget {
  final CurrencyCode code;

  const _HomePageCurrencyCard({required this.code});

  @override
  Widget build(BuildContext context) {
    // We need to use context.select here because BlocSelector doesn't handle parameter changes.
    // https://github.com/felangel/bloc/issues/2644
    final (baseValue, targetRate) = context.select<HomeBloc, (double, double)>((bloc) {
      final config = bloc.state.configuration;
      final snapshot = bloc.state.snapshot;

      if (config != null && snapshot != null) {
        return (config.baseValue, snapshot.getTargetRate(config.baseCurrency, code));
      } else {
        return (1, 1);
      }
    });

    return CurrencyCard(
      currency: code,
      onTapCurrency: () {}, // TODO: Open changer.
      isBase: false,
      isExpanded: false, // TODO: Handle expanded.
      toggleExpanded: () {}, // TODO: Handle expanded.
      relativeValue: baseValue * targetRate,
      updateRelativeValue: (value) => context.read<HomeBloc>().add(HomeUpdateBaseValueEvent(value / targetRate)),
      isFavorite: false, // TODO: Handle favorite.
      toggleFavorite: () {}, // TODO: Handle favorite.
      onRemove: () => context.read<HomeBloc>().add(HomeToggleCurrencyEvent(code)),
      snapshot: null, // TODO: Handle this in #36.
      onSnapshotPeriodUpdate: (period) {}, // TODO: Handle this in #36.
    );
  }
}

class _HomePageSelectorButton extends StatelessWidget {
  const _HomePageSelectorButton();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: JIconButton(
        size: JWidgetSize.large,
        icon: JamIcons.plus,
        onPressed: () => context.showJBottomSheet(
          child: const _HomePageSelectorDrawer(),
          scrollControlDisabledMaxHeightRatio: selectCurrencyDrawerHeightRatio,
        ),
      ),
    );
  }
}

class _HomePageSelectorDrawer extends StatelessWidget {
  const _HomePageSelectorDrawer();

  @override
  Widget build(BuildContext context) {
    return BlocSelector<HomeBloc, HomeState, (CurrencyCode, List<CurrencyCode>)>(
      selector: (state) => (
        state.configuration?.baseCurrency ?? CurrencyCode.USD,
        state.configuration?.currencies ?? [],
      ),
      builder: (context, state) {
        final options = [...CurrencyCode.values];
        options.remove(state.$1);

        return SelectCurrencyDrawer(
          options: options,
          favorites: const [], // TODO: Make this an actual value.
          selected: state.$2,
          toggleSelected: (code) => context.read<HomeBloc>().add(HomeToggleCurrencyEvent(code)),
        );
      },
    );
  }
}

class _HomePageChangerDrawer extends StatelessWidget {
  final CurrencyCode code;
  final void Function(CurrencyCode) onSelected;

  const _HomePageChangerDrawer({required this.code, required this.onSelected});

  @override
  Widget build(BuildContext context) {
    final options = [...CurrencyCode.values];
    options.remove(code);

    return SelectCurrencyDrawer(
      options: options,
      favorites: const [], // TODO: Make this an actual value.
      selected: const [],
      toggleSelected: (code) {
        onSelected(code);
        context.pop();
      },
    );
  }
}

sealed class _HomePageItem {
  const _HomePageItem();

  Widget build(BuildContext context);
}

final class _HomePagePaddingItem extends _HomePageItem {
  final double height;

  const _HomePagePaddingItem({this.height = JDimens.spacing_s});

  @override
  Widget build(BuildContext context) {
    return SizedBox(height: height);
  }
}

final class _HomePageTitleItem extends _HomePageItem {
  final String text;

  const _HomePageTitleItem({required this.text});

  @override
  Widget build(BuildContext context) {
    return Text(text, style: context.textTheme().headlineMedium);
  }
}

final class _HomePageBaseCurrencyItem extends _HomePageItem {
  const _HomePageBaseCurrencyItem();

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.only(bottom: JDimens.spacing_s),
      child: _HomePageBaseCurrencyCard(),
    );
  }
}

final class _HomePageCurrencyItem extends _HomePageItem {
  final CurrencyCode code;

  const _HomePageCurrencyItem({required this.code});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: JDimens.spacing_s),
      child: _HomePageCurrencyCard(code: code),
    );
  }
}

final class _HomePageRefreshItem extends _HomePageItem {
  const _HomePageRefreshItem();

  @override
  Widget build(BuildContext context) {
    final strings = context.strings();

    return BlocSelector<HomeBloc, HomeState, DateTime>(
      selector: (state) => state.snapshot?.timestamp.toLocal() ?? DateTime.now(),
      builder: (context, refreshed) {
        final date = DateFormat(_dateFormatString).format(refreshed);
        final time = DateFormat(_timeFormatString).format(refreshed);

        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: JDimens.spacing_xxxs),
          child: Text(
            strings.home_refreshed(date, time),
            style: context.textTheme().labelMedium,
          ),
        );
      },
    );
  }
}

final class _HomePageSelectorItem extends _HomePageItem {
  const _HomePageSelectorItem();

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.only(top: JDimens.spacing_xxs),
      child: _HomePageSelectorButton(),
    );
  }
}
