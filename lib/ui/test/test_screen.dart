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

        return Padding(
          padding: const EdgeInsets.only(bottom: Dimens.spacing_s),
          child: CurrencyCard(
            currency: CurrencyCode.values[index - 1],
            isBase: index == 1,
            isExpanded: false,
            toggleExpanded: () {},
            relativeValue: value,
            updateRelativeValue: _updateValue,
            isFavorite: false,
            toggleFavorite: () {},
            onRemove: () {},
          ),
        );
      },
    );
  }

  void _updateValue(double updated) => setState(() => value = updated);
}
