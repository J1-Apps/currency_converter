import "package:currency_converter/data/model/currency.dart";
import "package:currency_converter/ui/common/currency_card/select_currency_card.dart";
import "package:currency_converter/ui/util/extensions/build_context_extensions.dart";
import "package:flutter/material.dart";
import "package:flutter_gen/gen_l10n/app_localizations.dart";
import "package:j1_ui/j1_ui.dart";

const selectCurrencyDrawerHeightRatio = 0.8;

class SelectCurrencyDrawer extends StatefulWidget {
  final List<CurrencyCode> options;
  final List<CurrencyCode> favorites;
  final List<CurrencyCode> selected;
  final void Function(CurrencyCode) toggleSelected;

  const SelectCurrencyDrawer({
    required this.options,
    required this.favorites,
    required this.selected,
    required this.toggleSelected,
    super.key,
  });

  @override
  State<StatefulWidget> createState() => SelectCurrencyDrawerState();
}

class SelectCurrencyDrawerState extends State<SelectCurrencyDrawer> {
  var query = "";

  @override
  Widget build(BuildContext context) {
    final strings = context.strings();
    final filteredOptions = query.isEmpty ? widget.options : _filterQuery(widget.options, query);

    return Padding(
      padding: const EdgeInsets.only(
        left: JDimens.spacing_m,
        top: JDimens.spacing_m,
        right: JDimens.spacing_m,
      ),
      child: Column(
        children: [
          JTextField(
            type: JTextFieldType.underlined,
            size: JWidgetSize.large,
            hint: strings.selectDrawer_hint,
            onChanged: (value) => setState(() => query = value),
            autocorrect: false,
            icon: JamIcons.search,
          ),
          Expanded(
            child: _SelectCurrencyDrawerList(
              strings: strings,
              options: filteredOptions,
              favorites: widget.favorites,
              selected: widget.selected,
              toggleSelected: widget.toggleSelected,
            ),
          ),
        ],
      ),
    );
  }
}

class _SelectCurrencyDrawerList extends StatelessWidget {
  final Strings strings;
  final List<CurrencyCode> options;
  final List<CurrencyCode> favorites;
  final List<CurrencyCode> selected;
  final void Function(CurrencyCode) toggleSelected;

  const _SelectCurrencyDrawerList({
    required this.strings,
    required this.options,
    required this.favorites,
    required this.selected,
    required this.toggleSelected,
  });

  @override
  Widget build(BuildContext context) {
    if (options.isEmpty) {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: JDimens.spacing_m, vertical: JDimens.spacing_xl),
        child: JErrorMessage(message: strings.selectDrawer_error_empty),
      );
    }

    final items = _createItems(strings, options, favorites, selected, toggleSelected);

    return ListView.builder(
      itemCount: items.length,
      itemBuilder: (context, index) => items[index].build(context),
    );
  }
}

List<_SelectCurrencyDrawerItem> _createItems(
  Strings strings,
  List<CurrencyCode> options,
  List<CurrencyCode> favorites,
  List<CurrencyCode> selected,
  void Function(CurrencyCode) toggleSelected,
) {
  final filteredSelectedFavorites = <CurrencyCode>[];
  final filteredSelectedCurrencies = <CurrencyCode>[];
  final filteredFavorites = <CurrencyCode>[];
  final filteredCurrencies = <CurrencyCode>[];

  for (final option in options) {
    switch ((selected.contains(option), favorites.contains(option))) {
      case (true, true):
        filteredSelectedFavorites.add(option);
      case (true, false):
        filteredSelectedCurrencies.add(option);
      case (false, true):
        filteredFavorites.add(option);
      case (false, false):
        filteredCurrencies.add(option);
    }
  }

  return [
    const _SelectCurrencyPaddingItem(height: JDimens.spacing_s),
    for (final selectedFavorite in filteredSelectedFavorites)
      _SelectCurrencyCardItem(
        currency: selectedFavorite,
        isSelected: true,
        isFavorite: true,
        onSelected: () => toggleSelected(selectedFavorite),
      ),
    for (final selectedCurrency in filteredSelectedCurrencies)
      _SelectCurrencyCardItem(
        currency: selectedCurrency,
        isSelected: true,
        isFavorite: false,
        onSelected: () => toggleSelected(selectedCurrency),
      ),
    for (final favorite in filteredFavorites)
      _SelectCurrencyCardItem(
        currency: favorite,
        isSelected: false,
        isFavorite: true,
        onSelected: () => toggleSelected(favorite),
      ),
    for (final currency in filteredCurrencies)
      _SelectCurrencyCardItem(
        currency: currency,
        isSelected: false,
        isFavorite: false,
        onSelected: () => toggleSelected(currency),
      ),
    const _SelectCurrencyPaddingItem(height: JDimens.spacing_xxxl),
  ];
}

List<CurrencyCode> _filterQuery(List<CurrencyCode> original, String query) {
  return original.where((code) => code.name.toLowerCase().contains(query.toLowerCase())).toList();
}

sealed class _SelectCurrencyDrawerItem {
  const _SelectCurrencyDrawerItem();

  Widget build(BuildContext context);
}

final class _SelectCurrencyPaddingItem extends _SelectCurrencyDrawerItem {
  final double height;

  const _SelectCurrencyPaddingItem({required this.height});

  @override
  Widget build(BuildContext context) {
    return SizedBox(height: height);
  }
}

final class _SelectCurrencyCardItem extends _SelectCurrencyDrawerItem {
  final CurrencyCode currency;
  final bool isFavorite;
  final bool isSelected;
  final void Function() onSelected;

  const _SelectCurrencyCardItem({
    required this.currency,
    required this.isFavorite,
    required this.isSelected,
    required this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: JDimens.spacing_s),
      child: SelectCurrencyCard(
        currency: currency,
        isFavorite: isFavorite,
        isSelected: isSelected,
        onTap: onSelected,
      ),
    );
  }
}
