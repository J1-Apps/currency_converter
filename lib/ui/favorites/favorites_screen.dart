import "package:currency_converter/data/model/currency.dart";
import "package:currency_converter/state/favorites/favorites_bloc.dart";
import "package:currency_converter/state/favorites/favorites_event.dart";
import "package:currency_converter/state/favorites/favorites_state.dart";
import "package:currency_converter/ui/common/currency_card/select_currency_card.dart";
import "package:currency_converter/ui/util/extensions/build_context_extensions.dart";
import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:flutter_gen/gen_l10n/app_localizations.dart";
import "package:j1_ui/j1_ui.dart";

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: JAppBar(
        title: context.strings().favorites,
        leadingAction: const BackButton(),
      ),
      body: BlocConsumer<FavoritesBloc, FavoritesState>(
        listenWhen: (previous, current) => previous.error != current.error,
        listener: _listenErrors,
        buildWhen: (previous, current) =>
            previous.favorites != current.favorites || previous.nonFavorites != current.nonFavorites,
        builder: (context, state) => _FavoritesContent(
          favorites: state.favorites ?? [],
          options: state.nonFavorites ?? [],
          toggleFavorite: (code, isFavorite) => context.read<FavoritesBloc>().add(
                FavoritesToggleEvent(code, isFavorite),
              ),
        ),
      ),
    );
  }
}

void _listenErrors(BuildContext context, FavoritesState state) {
  final error = state.error;

  if (error == null) {
    return;
  }

  final strings = context.strings();
  final errorString = switch (error) {
    FavoritesErrorCode.loadFavorites => strings.settings_error_getLanguage,
    FavoritesErrorCode.saveFavorite => strings.settings_error_saveLanguage,
    FavoritesErrorCode.loadCurrencies => strings.settings_error_saveLanguage,
  };

  context.showJToastWithText(text: errorString, hasClose: true);
}

class _FavoritesContent extends StatefulWidget {
  final List<CurrencyCode> favorites;
  final List<CurrencyCode> options;
  final void Function(CurrencyCode, bool) toggleFavorite;

  const _FavoritesContent({
    required this.favorites,
    required this.options,
    required this.toggleFavorite,
  });

  @override
  State<StatefulWidget> createState() => _FavoritesContentState();
}

class _FavoritesContentState extends State<_FavoritesContent> {
  var query = "";

  @override
  Widget build(BuildContext context) {
    final strings = context.strings();
    final filteredOptions = query.isEmpty ? widget.options : _filterQuery(widget.options, query);
    final filteredFavorites = query.isEmpty ? widget.favorites : _filterQuery(widget.favorites, query);

    return Padding(
      padding: const EdgeInsets.only(
        left: JDimens.spacing_m,
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
            child: _FavoritesScreenList(
              strings: strings,
              options: filteredOptions,
              favorites: filteredFavorites,
              toggleFavorite: widget.toggleFavorite,
            ),
          ),
        ],
      ),
    );
  }
}

List<CurrencyCode> _filterQuery(List<CurrencyCode> original, String query) {
  return original.where((code) => code.name.toLowerCase().contains(query.toLowerCase())).toList();
}

class _FavoritesScreenList extends StatelessWidget {
  final Strings strings;
  final List<CurrencyCode> options;
  final List<CurrencyCode> favorites;
  final void Function(CurrencyCode, bool) toggleFavorite;

  const _FavoritesScreenList({
    required this.strings,
    required this.options,
    required this.favorites,
    required this.toggleFavorite,
  });

  @override
  Widget build(BuildContext context) {
    final items = _createItems(strings, options, favorites, toggleFavorite);

    if (items.length == 2) {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: JDimens.spacing_m, vertical: JDimens.spacing_xl),
        child: JErrorMessage(message: strings.favorites_error_empty),
      );
    }

    return ListView.builder(
      itemCount: items.length,
      itemBuilder: (context, index) => items[index].build(context),
    );
  }
}

List<_FavoritesScreenItem> _createItems(
  Strings strings,
  List<CurrencyCode> options,
  List<CurrencyCode> favorites,
  void Function(CurrencyCode, bool) toggleFavorite,
) {
  return [
    const _FavoritesScreenPaddingItem(height: JDimens.spacing_s),
    for (final code in favorites)
      _FavoritesScreenCardItem(
        currency: code,
        isFavorite: true,
        onToggled: () => toggleFavorite(code, false),
      ),
    for (final code in options)
      _FavoritesScreenCardItem(
        currency: code,
        isFavorite: false,
        onToggled: () => toggleFavorite(code, true),
      ),
    const _FavoritesScreenPaddingItem(height: JDimens.spacing_xxxl),
  ];
}

sealed class _FavoritesScreenItem {
  const _FavoritesScreenItem();

  Widget build(BuildContext context);
}

final class _FavoritesScreenPaddingItem extends _FavoritesScreenItem {
  final double height;

  const _FavoritesScreenPaddingItem({required this.height});

  @override
  Widget build(BuildContext context) {
    return SizedBox(height: height);
  }
}

final class _FavoritesScreenCardItem extends _FavoritesScreenItem {
  final CurrencyCode currency;
  final bool isFavorite;
  final void Function() onToggled;

  const _FavoritesScreenCardItem({
    required this.currency,
    required this.isFavorite,
    required this.onToggled,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: JDimens.spacing_s),
      child: SelectCurrencyCard(
        currency: currency,
        isFavorite: isFavorite,
        isSelected: false,
        onTap: onToggled,
      ),
    );
  }
}
