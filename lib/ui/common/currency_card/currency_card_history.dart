import "dart:math";

import "package:currency_converter/model/exchange_rate.dart";
import "package:fl_chart/fl_chart.dart";
import "package:flutter/material.dart" hide SegmentedButton, ButtonSegment;
import "package:j1_ui/j1_ui.dart";

const _chartHeight = 212.0;
const _chartFillOpacityTop = 0.5;
const _chartFillOpacityBottom = 0.1;
const _chartGridOpacity = 0.2;

class CurrencyCardHistory extends StatelessWidget {
  final ExchangeRateHistorySnapshot? snapshot;
  final void Function(HistorySnapshotPeriod) onSnapshotPeriodUpdate;

  const CurrencyCardHistory({
    required this.snapshot,
    required this.onSnapshotPeriodUpdate,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final currentSnapshot = snapshot;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: Dimens.spacing_m),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(height: Dimens.spacing_l),
          currentSnapshot == null
              ? _CurrencyCardHistoryLoading()
              : _CurrencyCardHistoryChart(snapshot: currentSnapshot),
        ],
      ),
    );
  }
}

// TODO: Update this loading indicator.
class _CurrencyCardHistoryLoading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const LoadingProvider(
      child: LoadingBox(
        height: _chartHeight,
      ),
    );
  }
}

class _CurrencyCardHistoryChart extends StatelessWidget {
  final ExchangeRateHistorySnapshot snapshot;

  const _CurrencyCardHistoryChart({required this.snapshot});

  @override
  Widget build(BuildContext context) {
    final theme = context.theme();
    final (spots, minValue, maxValue) = _parseExchangeSnapshot(snapshot);

    final range = maxValue - minValue;
    final minStop = minValue - (range * 0.1);
    final maxStop = maxValue + (range * 0.1);
    final interval = (maxValue - minValue) / 5.0;

    return SizedBox(
      height: _chartHeight,
      child: LineChart(
        LineChartData(
          titlesData: FlTitlesData(
            leftTitles: _getSideTitles(theme.textTheme, interval),
            bottomTitles: _getBaseTitles(theme.textTheme, snapshot.period),
            topTitles: const AxisTitles(),
            rightTitles: _getSideTitles(theme.textTheme, interval),
          ),
          lineBarsData: [
            LineChartBarData(
              color: theme.colorScheme.tertiary,
              isStrokeCapRound: true,
              dotData: const FlDotData(show: false),
              barWidth: Dimens.size_1,
              belowBarData: BarAreaData(
                show: true,
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    theme.colorScheme.secondary.withOpacity(_chartFillOpacityTop),
                    theme.colorScheme.secondary.withOpacity(_chartFillOpacityBottom),
                  ],
                ),
              ),
              spots: spots,
            ),
          ],
          lineTouchData: LineTouchData(
            touchTooltipData: LineTouchTooltipData(
              getTooltipColor: (_) => theme.colorScheme.surface,
              tooltipBorder: BorderSide(
                color: theme.colorScheme.tertiary,
                width: Dimens.size_2,
              ),
            ),
            getTouchedSpotIndicator: (data, indicators) => _defaultTouchedIndicators(
              theme.colorScheme,
              data,
              indicators,
            ),
          ),
          gridData: FlGridData(
            getDrawingHorizontalLine: (_) => FlLine(
              color: theme.colorScheme.onSurface.withOpacity(_chartGridOpacity),
              strokeWidth: Dimens.size_1,
            ),
            drawVerticalLine: false,
          ),
          borderData: FlBorderData(show: false),
          minY: minStop,
          maxY: maxStop,
        ),
      ),
    );
  }
}

(List<FlSpot>, double, double) _parseExchangeSnapshot(ExchangeRateHistorySnapshot snapshot) {
  final spots = <FlSpot>[];
  var minValue = double.infinity;
  var maxValue = double.negativeInfinity;

  if (snapshot.exchangeRates.isEmpty) {
    return ([], 0.0, 0.0);
  }

  for (final value in snapshot.exchangeRates.values) {
    spots.add(FlSpot(spots.length.toDouble(), value));

    if (value < minValue) {
      minValue = value;
    }

    if (value > maxValue) {
      maxValue = value;
    }
  }

  return (spots, minValue, maxValue);
}

AxisTitles _getSideTitles(
  TextTheme fonts,
  double interval,
) {
  return AxisTitles(
    sideTitles: SideTitles(
      showTitles: true,
      reservedSize: Dimens.size_32,
      interval: interval,
      maxIncluded: false,
      minIncluded: false,
      getTitlesWidget: (value, meta) => SideTitleWidget(
        axisSide: meta.axisSide,
        child: Text(
          meta.formattedValue,
          style: fonts.labelSmall,
        ),
      ),
    ),
  );
}

AxisTitles _getBaseTitles(
  TextTheme fonts,
  HistorySnapshotPeriod period,
) {
  final interval = switch (period) {
    HistorySnapshotPeriod.oneWeek => 1.0,
    HistorySnapshotPeriod.oneMonth => 5.0,
    HistorySnapshotPeriod.threeMonths => 15.0,
    HistorySnapshotPeriod.sixMonths => 30.0,
    HistorySnapshotPeriod.oneYear => 61.0,
  };

  return AxisTitles(
    sideTitles: SideTitles(
      showTitles: true,
      reservedSize: Dimens.size_32,
      interval: interval,
      getTitlesWidget: (value, meta) => SideTitleWidget(
        axisSide: meta.axisSide,
        angle: 3 * pi / 2,
        child: Text(
          meta.formattedValue,
          style: fonts.labelSmall,
        ),
      ),
    ),
  );
}

List<TouchedSpotIndicatorData> _defaultTouchedIndicators(
  ColorScheme colors,
  LineChartBarData barData,
  List<int> indicators,
) {
  return indicators.map((int index) {
    final flLine = FlLine(color: colors.tertiary);
    final dotData = FlDotData(
      getDotPainter: (spot, percent, bar, index) => FlDotCirclePainter(
        radius: Dimens.size_4,
        color: colors.tertiary,
      ),
    );

    return TouchedSpotIndicatorData(flLine, dotData);
  }).toList();
}
