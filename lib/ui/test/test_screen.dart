import "dart:math";

import "package:currency_converter/model/currency.dart";
import "package:currency_converter/model/exchange_rate.dart";
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
  final currencyList = [...CurrencyCode.values];
  final expandedMap = {for (var code in CurrencyCode.values) code: false};
  final favoriteMap = {for (var code in CurrencyCode.values) code: false};
  var value = 1.0;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: currencyList.length + 2,
      itemBuilder: (context, index) {
        if (index == 0) {
          return const SizedBox(height: Dimens.spacing_m);
        }

        if (index == currencyList.length + 1) {
          return const SizedBox(height: Dimens.spacing_xxl);
        }

        final currency = currencyList[index - 1];
        final isExpanded = expandedMap[currency] ?? false;
        final isFavorite = favoriteMap[currency] ?? false;

        return Padding(
          padding: const EdgeInsets.only(bottom: Dimens.spacing_s),
          child: CurrencyCard(
            currency: currency,
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
            onRemove: () => setState(() => currencyList.remove(currency)),
            snapshot: switch (index % 5) {
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
