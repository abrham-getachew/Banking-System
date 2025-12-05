import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';
import '../../../theme/app_theme.dart';

class WealthTimelineChartWidget extends StatelessWidget {
  final List<Map<String, dynamic>> timelineData;

  const WealthTimelineChartWidget({
    super.key,
    required this.timelineData,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.symmetric(horizontal: 4.w),
        padding: EdgeInsets.all(4.w),
        decoration: BoxDecoration(
            color: AppTheme.surfaceDark,
            borderRadius: BorderRadius.circular(16.0)),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text('Wealth Progression',
              style: AppTheme.darkTheme.textTheme.titleLarge
                  ?.copyWith(fontWeight: FontWeight.w600)),
          SizedBox(height: 1.h),
          Text('Your wealth growth over the past 12 months',
              style: AppTheme.darkTheme.textTheme.bodyMedium
                  ?.copyWith(color: AppTheme.textSecondary)),
          SizedBox(height: 3.h),
          SizedBox(
              height: 30.h,
              child: LineChart(LineChartData(
                  gridData: FlGridData(
                      show: true,
                      drawVerticalLine: false,
                      horizontalInterval: 50000,
                      getDrawingHorizontalLine: (value) {
                        return FlLine(
                            color: AppTheme.dividerSubtle, strokeWidth: 1);
                      }),
                  titlesData: FlTitlesData(
                      show: true,
                      rightTitles: const AxisTitles(
                          sideTitles: SideTitles(showTitles: false)),
                      topTitles: const AxisTitles(
                          sideTitles: SideTitles(showTitles: false)),
                      bottomTitles: AxisTitles(
                          sideTitles: SideTitles(
                              showTitles: true,
                              reservedSize: 30,
                              interval: 1,
                              getTitlesWidget: (double value, TitleMeta meta) {
                                if (value >= 0 && value < timelineData.length) {
                                  final date = timelineData[value.toInt()]
                                      ['date'] as String;
                                  final month = date.split('-')[1];
                                  return SideTitleWidget(
                                      axisSide: meta.axisSide,
                                      child: Text(month,
                                          style: AppTheme
                                              .darkTheme.textTheme.bodySmall
                                              ?.copyWith(
                                                  color:
                                                      AppTheme.textTertiary)));
                                }
                                return const Text('');
                              })),
                      leftTitles: AxisTitles(
                          sideTitles: SideTitles(
                              showTitles: true,
                              interval: 50000,
                              reservedSize: 50,
                              getTitlesWidget: (double value, TitleMeta meta) {
                                return SideTitleWidget(
                                    axisSide: meta.axisSide,
                                    child: Text('\$${(value / 1000).toInt()}K',
                                        style: AppTheme
                                            .darkTheme.textTheme.bodySmall
                                            ?.copyWith(
                                                color: AppTheme.textTertiary)));
                              }))),
                  borderData: FlBorderData(show: false),
                  minX: 0,
                  maxX: timelineData.length.toDouble() - 1,
                  minY: 150000,
                  maxY: 280000,
                  lineBarsData: [
                    LineChartBarData(
                        spots: timelineData.asMap().entries.map((entry) {
                          return FlSpot(entry.key.toDouble(),
                              entry.value['value'].toDouble());
                        }).toList(),
                        isCurved: true,
                        color: AppTheme.chronosGold,
                        barWidth: 3,
                        isStrokeCapRound: true,
                        dotData: FlDotData(
                            show: true,
                            getDotPainter: (spot, percent, barData, index) =>
                                FlDotCirclePainter(
                                    radius: 4,
                                    color: AppTheme.chronosGold,
                                    strokeWidth: 2,
                                    strokeColor: AppTheme.surfaceDark)),
                        belowBarData: BarAreaData(
                            show: true,
                            color:
                                AppTheme.chronosGold.withValues(alpha: 0.1))),
                  ],
                  lineTouchData: LineTouchData(
                      enabled: true,
                      touchTooltipData: LineTouchTooltipData(
                          tooltipRoundedRadius: 8,
                          getTooltipItems: (List<LineBarSpot> touchedBarSpots) {
                            return touchedBarSpots.map((barSpot) {
                              return LineTooltipItem(
                                  '\$${barSpot.y.toStringAsFixed(0)}',
                                  AppTheme.darkTheme.textTheme.bodyMedium!
                                      .copyWith(
                                          color: AppTheme.chronosGold,
                                          fontWeight: FontWeight.w600));
                            }).toList();
                          }))))),
        ]));
  }
}
