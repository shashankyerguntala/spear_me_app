import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class BarChartWidget extends StatelessWidget {
  const BarChartWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final TextStyle textStyle = TextStyle(
      fontSize: 12,
      color: Colors.grey.shade700,
      fontWeight: FontWeight.w500,
    );

    return BarChart(
      BarChartData(
        barTouchData: BarTouchData(
          enabled: true,
          touchTooltipData: BarTouchTooltipData(
            tooltipBgColor: Colors.black87,
            getTooltipItem:
                (
                  BarChartGroupData group,
                  int groupIndex,
                  BarChartRodData rod,
                  int rodIndex,
                ) {
                  return BarTooltipItem(
                    '${rod.toY.toInt()}',
                    const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  );
                },
          ),
        ),
        titlesData: FlTitlesData(
          leftTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              interval: 2,
              getTitlesWidget: (double value, TitleMeta meta) =>
                  Text(value.toInt().toString(), style: textStyle),
            ),
          ),
          bottomTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              getTitlesWidget: (double value, TitleMeta meta) {
                const List<String> labels = <String>[
                  '2005',
                  '2006',
                  '2007',
                  '2008',
                  '2009',
                ];
                if (value.toInt() < 0 || value.toInt() > 4) {
                  return const SizedBox.shrink();
                }
                return Text(labels[value.toInt()], style: textStyle);
              },
            ),
          ),
          topTitles: AxisTitles(sideTitles: SideTitles()),
          rightTitles: AxisTitles(sideTitles: SideTitles()),
        ),
        gridData: FlGridData(show: false),
        borderData: FlBorderData(show: false),
        barGroups: <BarChartGroupData>[
          _bar(0, 5),
          _bar(1, 7),
          _bar(2, 3),
          _bar(3, 8),
          _bar(4, 6),
        ],
      ),
      swapAnimationDuration: const Duration(milliseconds: 350),
      swapAnimationCurve: Curves.easeOut,
    );
  }

  BarChartGroupData _bar(int x, double value) {
    return BarChartGroupData(
      x: x,
      barRods: <BarChartRodData>[
        BarChartRodData(
          toY: value,
          width: 26,
          borderRadius: BorderRadius.circular(6),
          color: const Color(0xFF4A90E2),
        ),
      ],
    );
  }
}
