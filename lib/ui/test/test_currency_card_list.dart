import "dart:math";

import "package:currency_converter/model/currency.dart";
import "package:currency_converter/model/exchange_rate.dart";
import "package:currency_converter/ui/common/currency_card/currency_card.dart";
import "package:currency_converter/ui/common/currency_card/favorite_currency_card.dart";
import "package:currency_converter/ui/common/currency_card/select_currency_card.dart";
import "package:currency_converter/ui/test/test_select_currency_drawer.dart";
import "package:flutter/material.dart";
import "package:j1_ui/j1_ui.dart";

// coverage:ignore-file
class CurrencyCardList extends StatefulWidget {
  const CurrencyCardList({super.key});

  @override
  State<StatefulWidget> createState() => CurrencyCardListState();
}

class CurrencyCardListState extends State<CurrencyCardList> {
  final currencyList = [...CurrencyCode.values];
  final expandedMap = {for (var code in CurrencyCode.values) code: false};
  final favoriteMap = {for (var code in CurrencyCode.values) code: false};
  final selectedMap = {for (var code in CurrencyCode.values) code: false};
  var value = 1.0;

  var isSelected = false;
  var isFavorite = false;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: currencyList.length + 5,
      itemBuilder: (context, index) {
        if (index == 0) {
          return const SizedBox(height: JDimens.spacing_m);
        }

        if (index == 1) {
          return Padding(
            padding: const EdgeInsets.only(bottom: JDimens.spacing_s),
            child: FavoriteCurrencyCard(
              currency: CurrencyCode.USD,
              isFavorite: isFavorite,
              onTap: () => setState(() => isFavorite = !isFavorite),
            ),
          );
        }

        if (index == 2) {
          return Padding(
            padding: const EdgeInsets.only(bottom: JDimens.spacing_s),
            child: SelectCurrencyCard(
              currency: CurrencyCode.USD,
              isSelected: isSelected,
              onTap: () => setState(() => isSelected = !isSelected),
            ),
          );
        }

        if (index == 3) {
          return Padding(
            padding: const EdgeInsets.only(bottom: JDimens.spacing_s),
            child: JTextButton(
              text: "Select Drawer",
              onPressed: () {
                context.showJBottomSheet(
                  child: TestSelectCurrencyDrawer(
                    currencyList: currencyList,
                    favorites: favoriteMap.entries.where((code) => code.value).map((code) => code.key).toList(),
                    initialSelected: selectedMap.entries.where((code) => code.value).map((code) => code.key).toList(),
                  ),
                  scrollControlDisabledMaxHeightRatio: 0.8,
                );
              },
            ),
          );
        }

        if (index == currencyList.length + 4) {
          return const SizedBox(height: JDimens.spacing_xxl);
        }

        final currency = currencyList[index - 4];
        final expanded = expandedMap[currency] ?? false;
        final favorite = favoriteMap[currency] ?? false;

        return Padding(
          padding: const EdgeInsets.only(bottom: JDimens.spacing_s),
          child: CurrencyCard(
            currency: currency,
            onTapCurrency: () => context.showJToastWithText(
              text: "Tapped currency with code: ${currency.name}",
              hasClose: true,
            ),
            isBase: index == 1,
            isExpanded: expanded,
            toggleExpanded: () => setState(() => expandedMap[currency] = !expanded),
            relativeValue: value,
            updateRelativeValue: _updateValue,
            isFavorite: favorite,
            toggleFavorite: () => setState(() => favoriteMap[currency] = !favorite),
            onRemove: () => setState(() => currencyList.remove(currency)),
            snapshot: switch ((index - 4) % 5) {
              0 => _oneWeekSnapshot(currency),
              1 => _oneMonthSnapshot(currency),
              2 => _threeMonthSnapshot(currency),
              3 => _sixMonthSnapshot(currency),
              _ => _oneYearSnapshot(currency),
            },
            onSnapshotPeriodUpdate: (_) {},
          ),
        );
      },
    );
  }

  void _updateValue(double updated) => setState(() => value = updated);
}

final _random = Random();
final _currentDate = DateTime.utc(2000);

ExchangeRateHistorySnapshot _oneWeekSnapshot(CurrencyCode code) => ExchangeRateHistorySnapshot(
      HistorySnapshotPeriod.oneWeek,
      DateTime.now().toUtc(),
      CurrencyCode.USD,
      code,
      {for (var i = 0; i < 7; i++) _currentDate.subtract(Duration(days: i)): _random.nextDouble() + 1},
    );

ExchangeRateHistorySnapshot _oneMonthSnapshot(CurrencyCode code) => ExchangeRateHistorySnapshot(
      HistorySnapshotPeriod.oneMonth,
      DateTime.now().toUtc(),
      CurrencyCode.USD,
      code,
      {for (var i = 0; i < 30; i++) _currentDate.subtract(Duration(days: i)): _random.nextDouble() + 1},
    );

ExchangeRateHistorySnapshot _threeMonthSnapshot(CurrencyCode code) => ExchangeRateHistorySnapshot(
      HistorySnapshotPeriod.threeMonths,
      DateTime.now().toUtc(),
      CurrencyCode.USD,
      code,
      {for (var i = 0; i < 90; i++) _currentDate.subtract(Duration(days: i)): _random.nextDouble() + 1},
    );

ExchangeRateHistorySnapshot _sixMonthSnapshot(CurrencyCode code) => ExchangeRateHistorySnapshot(
      HistorySnapshotPeriod.sixMonths,
      DateTime.now().toUtc(),
      CurrencyCode.USD,
      code,
      {for (var i = 0; i < 180; i++) _currentDate.subtract(Duration(days: i)): _random.nextDouble() + 1},
    );

ExchangeRateHistorySnapshot _oneYearSnapshot(CurrencyCode code) => ExchangeRateHistorySnapshot(
      HistorySnapshotPeriod.oneYear,
      DateTime.now().toUtc(),
      CurrencyCode.USD,
      code,
      {for (var i = 0; i < 366; i++) _currentDate.subtract(Duration(days: i)): _random.nextDouble() + 1},
    );
