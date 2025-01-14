import "package:currency_converter/data/model/currency.dart";
import "package:currency_converter/state/home/home_bloc.dart";
import "package:currency_converter/state/home/home_event.dart";
import "package:currency_converter/state/home/home_state.dart";
import "package:currency_converter/ui/common/currency_card/currency_card.dart";
import "package:currency_converter/ui/common/select_currency_drawer.dart";
import "package:currency_converter/ui/home/home_drawer.dart";
import "package:currency_converter/ui/util/extensions/build_context_extensions.dart";
import "package:flutter/material.dart";
import "package:flutter_gen/gen_l10n/app_localizations.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:intl/intl.dart";
import "package:j1_ui/j1_ui.dart";

const _dateFormatString = "MMM d";
const _timeFormatString = "H:mm";

class HomeLoaded extends StatelessWidget {
  const HomeLoaded({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: JDimens.spacing_m),
      child: BlocSelector<HomeBloc, HomeState, List<HomeConvertedCurrency>>(
        selector: (state) => state.currencies ?? [],
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
  List<HomeConvertedCurrency> currencies,
) {
  return [
    _HomePageTitleItem(text: strings.home_baseCurrency),
    const _HomePagePaddingItem(),
    const _HomePageRefreshItem(),
    const _HomePagePaddingItem(),
    const _HomePageBaseCurrencyItem(),
    _HomePageTitleItem(text: strings.home_converted),
    const _HomePagePaddingItem(),
    for (final (index, currency) in currencies.indexed) _HomePageCurrencyItem(currency: currency, index: index),
    const _HomePageSelectorItem(),
    const _HomePagePaddingItem(height: JDimens.spacing_xxxl),
  ];
}

class _HomePageBaseCurrencyCard extends StatelessWidget {
  const _HomePageBaseCurrencyCard();

  @override
  Widget build(BuildContext context) {
    return BlocSelector<HomeBloc, HomeState, HomeBaseCurrency>(
      selector: (state) => state.baseCurrency ?? const HomeBaseCurrency(code: CurrencyCode.USD, value: 1.0),
      builder: (context, baseCurrency) => CurrencyCard.base(
        currency: baseCurrency.code,
        onTapCurrency: () => context.showJBottomSheet(
          child: HomePageChangerDrawer(
            code: baseCurrency.code,
            isBase: true,
            onSelected: (updated) => context.read<HomeBloc>().add(HomeUpdateBaseCurrencyEvent(updated)),
          ),
          scrollControlDisabledMaxHeightRatio: selectCurrencyDrawerHeightRatio,
        ),
        relativeValue: baseCurrency.value,
        updateRelativeValue: (value) => context.read<HomeBloc>().add(
              HomeUpdateBaseValueEvent(baseCurrency.code, value),
            ),
      ),
    );
  }
}

class _HomePageCurrencyCard extends StatelessWidget {
  final HomeConvertedCurrency currency;
  final int index;

  const _HomePageCurrencyCard({required this.currency, required this.index});

  @override
  Widget build(BuildContext context) {
    return CurrencyCard.converted(
      currency: currency.code,
      onTapCurrency: () => context.showJBottomSheet(
        child: HomePageChangerDrawer(
          code: currency.code,
          isBase: false,
          onSelected: (updated) => context.read<HomeBloc>().add(HomeUpdateCurrencyEvent(index, updated)),
        ),
        scrollControlDisabledMaxHeightRatio: selectCurrencyDrawerHeightRatio,
      ),
      isExpanded: currency.isExpanded,
      toggleExpanded: () => context.read<HomeBloc>().add(HomeToggleExpandedEvent(index)),
      relativeValue: currency.value,
      updateRelativeValue: (value) => context.read<HomeBloc>().add(HomeUpdateBaseValueEvent(currency.code, value)),
      isFavorite: currency.isFavorite,
      toggleFavorite: () => context.read<HomeBloc>().add(HomeToggleFavoriteEvent(currency.code, !currency.isFavorite)),
      onRemove: () => context.read<HomeBloc>().add(HomeToggleCurrencyEvent(currency.code)),
      snapshot: null, // TODO: Handle this in #36.
      onSnapshotPeriodUpdate: null, // TODO: Handle this in #36.
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
          child: const HomePageSelectorDrawer(),
          scrollControlDisabledMaxHeightRatio: selectCurrencyDrawerHeightRatio,
        ),
      ),
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
  final HomeConvertedCurrency currency;
  final int index;

  const _HomePageCurrencyItem({required this.currency, required this.index});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: JDimens.spacing_s),
      child: _HomePageCurrencyCard(currency: currency, index: index),
    );
  }
}

final class _HomePageRefreshItem extends _HomePageItem {
  const _HomePageRefreshItem();

  @override
  Widget build(BuildContext context) {
    final strings = context.strings();

    return BlocSelector<HomeBloc, HomeState, HomeRefresh?>(
      selector: (state) => state.refresh,
      builder: (context, refreshed) {
        final refreshString = refreshed == null
            ? strings.home_refresh_error
            : strings.home_refreshed(
                DateFormat(_dateFormatString).format(refreshed.refreshed.toLocal()),
                DateFormat(_timeFormatString).format(refreshed.refreshed.toLocal()),
              );

        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: JDimens.spacing_xxxs),
          child: Text(refreshString, style: context.textTheme().labelMedium),
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
