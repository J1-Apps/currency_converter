import "package:fl_chart/fl_chart.dart";
import "package:flutter/material.dart";
import "package:j1_ui/j1_ui.dart";

const _chartHeight = 212.0;
const _chartFillOpacityTop = 0.5;
const _chartFillOpacityBottom = 0.1;
const _chartGridOpacity = 0.2;

class CurrencyCardHistory extends StatelessWidget {
  const CurrencyCardHistory({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = context.theme();

    return Padding(
      padding: const EdgeInsets.fromLTRB(
        Dimens.spacing_m,
        Dimens.spacing_l,
        Dimens.spacing_m,
        Dimens.size_0,
      ),
      child: SizedBox(
        height: _chartHeight,
        child: LineChart(
          LineChartData(
            titlesData: FlTitlesData(
              leftTitles: _defaultGetTitle(theme.textTheme, null),
              bottomTitles: _defaultGetTitle(theme.textTheme, 1),
              topTitles: const AxisTitles(),
              rightTitles: _defaultGetTitle(theme.textTheme, null),
            ),
            lineBarsData: [
              LineChartBarData(
                color: theme.colorScheme.tertiary,
                isStrokeCapRound: true,
                dotData: const FlDotData(show: false),
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
                spots: const [
                  FlSpot(1, 1),
                  FlSpot(2, 3),
                  FlSpot(3, 2),
                ],
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
          ),
        ),
      ),
    );
  }
}

AxisTitles _defaultGetTitle(
  TextTheme fonts,
  double? interval,
) {
  return AxisTitles(
    sideTitles: SideTitles(
      showTitles: true,
      reservedSize: Dimens.size_32,
      interval: interval,
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
