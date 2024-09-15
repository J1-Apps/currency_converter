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
    final colors = context.colorScheme();

    return Padding(
      padding: const EdgeInsets.fromLTRB(
        Dimens.spacing_m,
        Dimens.spacing_l,
        Dimens.spacing_xl + 4,
        Dimens.size_0,
      ),
      child: SizedBox(
        height: _chartHeight,
        child: LineChart(
          LineChartData(
            titlesData: const FlTitlesData(
              leftTitles: AxisTitles(
                sideTitles: SideTitles(
                  showTitles: true,
                  reservedSize: Dimens.size_32,
                ),
              ),
              bottomTitles: AxisTitles(
                sideTitles: SideTitles(
                  showTitles: true,
                  reservedSize: Dimens.size_32,
                  interval: 1,
                ),
              ),
              topTitles: AxisTitles(),
              rightTitles: AxisTitles(),
            ),
            lineBarsData: [
              LineChartBarData(
                color: colors.tertiary,
                isStrokeCapRound: true,
                dotData: const FlDotData(show: false),
                belowBarData: BarAreaData(
                  show: true,
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      colors.secondary.withOpacity(_chartFillOpacityTop),
                      colors.secondary.withOpacity(_chartFillOpacityBottom),
                    ],
                  ),
                ),
                spots: const [
                  FlSpot(1, 1),
                  FlSpot(2, 2),
                  FlSpot(3, 3),
                ],
              ),
            ],
            gridData: FlGridData(
              getDrawingHorizontalLine: (_) => FlLine(
                color: colors.onSurface.withOpacity(_chartGridOpacity),
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
