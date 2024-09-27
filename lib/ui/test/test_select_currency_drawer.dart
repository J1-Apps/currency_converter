import "package:currency_converter/model/currency.dart";
import "package:currency_converter/ui/common/select_currency_drawer.dart";
import "package:flutter/material.dart";

class TestSelectCurrencyDrawer extends StatefulWidget {
  final Set<CurrencyCode> currencyList;
  final Set<CurrencyCode> favorites;
  final Set<CurrencyCode> initialSelected;

  const TestSelectCurrencyDrawer({
    required this.currencyList,
    required this.favorites,
    required this.initialSelected,
    super.key,
  });

  @override
  State<StatefulWidget> createState() => TestSelectCurrencyDrawerState();
}

class TestSelectCurrencyDrawerState extends State<TestSelectCurrencyDrawer> {
  late Set<CurrencyCode> selected;

  @override
  void initState() {
    selected = widget.initialSelected;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SelectCurrencyDrawer(
      options: widget.currencyList,
      favorites: widget.favorites,
      selected: selected,
      toggleSelected: (code) => setState(() {
        if (selected.contains(code)) {
          selected = selected.difference({code});
        } else {
          selected = selected.union({code});
        }
      }),
    );
  }
}
