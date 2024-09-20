import "package:currency_converter/model/currency.dart";
import "package:currency_converter/ui/common/currency_card/select_currency_card.dart";
import "package:currency_converter/util/extensions/build_context_extensions.dart";
import "package:flutter/material.dart" hide TextField;
import "package:flutter_gen/gen_l10n/app_localizations.dart";
import "package:j1_ui/j1_ui.dart";

const _drawerHeightFactor = 0.6;

class SelectCurrencyDrawer extends StatefulWidget {
  final Set<CurrencyCode> options;
  final Set<CurrencyCode> favorites;
  final Set<CurrencyCode> selected;
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
  late final Set<CurrencyCode> selected;

  @override
  void initState() {
    selected = widget.selected;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final strings = context.strings();

    final items = _createItems(
      strings,
      widget.options,
      widget.favorites,
      selected,
      widget.toggleSelected,
      query,
    );

    return FractionallySizedBox(
      heightFactor: _drawerHeightFactor,
      child: Padding(
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
            const SizedBox(height: JDimens.spacing_s),
            Expanded(
              child: ListView.builder(
                itemCount: items.length,
                itemBuilder: (context, index) => items[index].build(context),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

List<_SelectCurrencyDrawerItem> _createItems(
  Strings strings,
  Set<CurrencyCode> options,
  Set<CurrencyCode> favorites,
  Set<CurrencyCode> selected,
  void Function(CurrencyCode) toggleSelected,
  String query,
) {
  final filteredOptions = query.isEmpty ? options : _filterQuery(options, query);

  if (filteredOptions.isEmpty) {
    return [_SelectCurrencyEmptyItem(emptyMessage: strings.selectDrawer_error_empty)];
  }

  final filteredFavorites = <CurrencyCode, bool>{};
  final filteredCurrencies = <CurrencyCode, bool>{};

  for (var option in filteredOptions) {
    if (favorites.contains(option)) {
      filteredFavorites[option] = selected.contains(option);
    } else {
      filteredCurrencies[option] = selected.contains(option);
    }
  }

  return [
    if (filteredFavorites.isNotEmpty) _SelectCurrencyTitleItem(text: strings.selectDrawer_favorites),
    if (filteredFavorites.isNotEmpty) const _SelectCurrencyPaddingItem(height: JDimens.spacing_s),
    for (var favorite in filteredFavorites.entries)
      _SelectCurrencyCardItem(
        currency: favorite.key,
        isSelected: favorite.value,
        onSelected: () => toggleSelected(favorite.key),
      ),
    if (filteredCurrencies.isNotEmpty) _SelectCurrencyTitleItem(text: strings.selectDrawer_currencies),
    if (filteredCurrencies.isNotEmpty) const _SelectCurrencyPaddingItem(height: JDimens.spacing_s),
    for (var currency in filteredCurrencies.entries)
      _SelectCurrencyCardItem(
        currency: currency.key,
        isSelected: currency.value,
        onSelected: () => toggleSelected(currency.key),
      ),
    const _SelectCurrencyPaddingItem(height: JDimens.spacing_xxxl),
  ];
}

Set<CurrencyCode> _filterQuery(Set<CurrencyCode> original, String query) {
  return original.where((code) => code.name.toLowerCase().contains(query.toLowerCase())).toSet();
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

final class _SelectCurrencyTitleItem extends _SelectCurrencyDrawerItem {
  final String text;

  const _SelectCurrencyTitleItem({required this.text});

  @override
  Widget build(BuildContext context) {
    return Text(text, style: context.textTheme().headlineMedium);
  }
}

final class _SelectCurrencyCardItem extends _SelectCurrencyDrawerItem {
  final CurrencyCode currency;
  final bool isSelected;
  final void Function() onSelected;

  const _SelectCurrencyCardItem({
    required this.currency,
    required this.isSelected,
    required this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: JDimens.spacing_s),
      child: SelectCurrencyCard(
        currency: currency,
        isSelected: isSelected,
        onTap: onSelected,
      ),
    );
  }
}

final class _SelectCurrencyEmptyItem extends _SelectCurrencyDrawerItem {
  final String emptyMessage;

  const _SelectCurrencyEmptyItem({required this.emptyMessage});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: JDimens.spacing_xxl, horizontal: JDimens.spacing_m),
      child: JErrorMessage(message: emptyMessage),
    );
  }
}
