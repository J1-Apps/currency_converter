import "package:currency_converter/data/model/currency.dart";
import "package:currency_converter/ui/common/select_currency_drawer.dart";
import "package:flutter/material.dart";

// coverage:ignore-file
class TestSelectCurrencyDrawer extends StatefulWidget {
  final List<CurrencyCode> currencyList;
  final List<CurrencyCode> favorites;
  final List<CurrencyCode> initialSelected;

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
  late List<CurrencyCode> selected;

  @override
  void initState() {
    selected = [...widget.initialSelected];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SelectCurrencyDrawer(
      allOptions: widget.currencyList,
      selected: selected,
      favorites: widget.favorites,
      toggleSelected: (code) => setState(() {
        if (selected.contains(code)) {
          selected.remove(code);
        } else {
          selected.add(code);
        }
      }),
    );
  }
}
