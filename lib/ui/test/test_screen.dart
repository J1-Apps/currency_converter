import "package:currency_converter/model/currency.dart";
import "package:currency_converter/ui/common/currency_card/currency_card.dart";
import "package:currency_converter/util/extensions/build_context_extensions.dart";
import "package:flutter/material.dart" hide IconButton;
import "package:j1_router/j1_router.dart";
import "package:j1_ui/j1_ui.dart";

// coverage:ignore-file
class TestScreen extends StatelessWidget {
  const TestScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Header(
        title: context.strings().test,
        leadingAction: IconButton(
          icon: JamIcons.chevronleft,
          color: WidgetColor.secondary,
          onPressed: () {
            if (context.canPop()) {
              context.pop();
            }
          },
        ),
      ),
      body: const Padding(
        padding: EdgeInsets.symmetric(horizontal: Dimens.spacing_m),
        child: _CurrencyCardList(),
      ),
    );
  }
}

class _CurrencyCardList extends StatefulWidget {
  const _CurrencyCardList();

  @override
  State<StatefulWidget> createState() => _CurrencyCardListState();
}

class _CurrencyCardListState extends State<_CurrencyCardList> {
  final expandedMap = {for (var code in CurrencyCode.values) code: false};
  final favoriteMap = {for (var code in CurrencyCode.values) code: false};
  var value = 1.0;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: CurrencyCode.values.length + 2,
      itemBuilder: (context, index) {
        if (index == 0) {
          return const SizedBox(height: Dimens.spacing_m);
        }

        if (index == CurrencyCode.values.length + 1) {
          return const SizedBox(height: Dimens.spacing_xxl);
        }

        final currency = CurrencyCode.values[index - 1];
        final isExpanded = expandedMap[currency] ?? false;
        final isFavorite = favoriteMap[currency] ?? false;

        return Padding(
          padding: const EdgeInsets.only(bottom: Dimens.spacing_s),
          child: CurrencyCard(
            currency: CurrencyCode.values[index - 1],
            onTapCurrency: () => context.showToastWithText(
              text: "Tapped currency with code: ${currency.name}",
              hasClose: true,
            ),
            isBase: index == 1,
            isExpanded: isExpanded,
            toggleExpanded: () => setState(() => expandedMap[currency] = !isExpanded),
            relativeValue: value,
            updateRelativeValue: _updateValue,
            isFavorite: isFavorite,
            toggleFavorite: () => setState(() => favoriteMap[currency] = !isFavorite),
            onRemove: () => context.showToastWithText(
              text: "Removed currency with code: ${currency.name}",
              hasClose: true,
            ),
          ),
        );
      },
    );
  }

  void _updateValue(double updated) => setState(() => value = updated);
}
