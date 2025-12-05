import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';
import '../../../theme/app_theme.dart';

class PortfolioChartWidget extends StatefulWidget {
  final List<Map<String, dynamic>> chartData;
  final String selectedPeriod;

  const PortfolioChartWidget({
    super.key,
    required this.chartData,
    required this.selectedPeriod,
  });

  @override
  State<PortfolioChartWidget> createState() => _PortfolioChartWidgetState();
}

class _PortfolioChartWidgetState extends State<PortfolioChartWidget> {
  List<FlSpot> _getSpots() {
    return (widget.chartData as List).asMap().entries.map((entry) {
      final index = entry.key;
      final data = entry.value as Map<String, dynamic>;
      return FlSpot(index.toDouble(), (data['value'] as num).toDouble());
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    final spots = _getSpots();
    final minY = spots.map((spot) => spot.y).reduce((a, b) => a < b ? a : b);
    final maxY = spots.map((spot) => spot.y).reduce((a, b) => a > b ? a : b);
    final range = maxY - minY;

    return Container(
        width: double.infinity,
        height: 30.h,
        margin: EdgeInsets.symmetric(horizontal: 4.w, vertical: 2.h),
        padding: EdgeInsets.all(4.w),
        decoration: BoxDecoration(
            color: AppTheme.darkTheme.colorScheme.surface,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                  color: AppTheme.shadowDark,
                  blurRadius: 8,
                  offset: Offset(0, 2)),
            ]),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text('Performance Chart',
              style: AppTheme.darkTheme.textTheme.titleMedium
                  ?.copyWith(fontWeight: FontWeight.w600)),
          SizedBox(height: 2.h),
          Expanded(
              child: LineChart(LineChartData(
                  gridData: FlGridData(
                      show: true,
                      drawVerticalLine: false,
                      horizontalInterval: range / 4,
                      getDrawingHorizontalLine: (value) {
                        return FlLine(
                            color:
                                AppTheme.dividerSubtle.withValues(alpha: 0.3),
                            strokeWidth: 1);
                      }),
                  titlesData: FlTitlesData(
                      show: true,
                      rightTitles:
                          AxisTitles(sideTitles: SideTitles(showTitles: false)),
                      topTitles:
                          AxisTitles(sideTitles: SideTitles(showTitles: false)),
                      bottomTitles: AxisTitles(
                          sideTitles: SideTitles(
                              showTitles: true,
                              reservedSize: 30,
                              interval:
                                  spots.length > 10 ? spots.length / 5 : 1,
                              getTitlesWidget: (value, meta) {
                                final index = value.toInt();
                                if (index >= 0 &&
                                    index < widget.chartData.length) {
                                  final data = widget.chartData[index];
                                  return Padding(
                                      padding: EdgeInsets.only(top: 1.h),
                                      child: Text(data['label'] as String,
                                          style: AppTheme
                                              .darkTheme.textTheme.bodySmall
                                              ?.copyWith(fontSize: 10.sp)));
                                }
                                return SizedBox.shrink();
                              })),
                      leftTitles: AxisTitles(
                          sideTitles: SideTitles(
                              showTitles: true,
                              reservedSize: 50,
                              interval: range / 4,
                              getTitlesWidget: (value, meta) {
                                return Text(
                                    '\$${(value / 1000).toStringAsFixed(0)}K',
                                    style: AppTheme
                                        .darkTheme.textTheme.bodySmall
                                        ?.copyWith(fontSize: 10.sp));
                              }))),
                  borderData: FlBorderData(show: false),
                  minX: 0,
                  maxX: (spots.length - 1).toDouble(),
                  minY: minY - (range * 0.1),
                  maxY: maxY + (range * 0.1),
                  lineBarsData: [
                    LineChartBarData(
                        spots: spots,
                        isCurved: true,
                        gradient: LinearGradient(colors: [
                          AppTheme.chronosGold,
                          AppTheme.successGreen,
                        ]),
                        barWidth: 3,
                        isStrokeCapRound: true,
                        dotData: FlDotData(show: false),
                        belowBarData: BarAreaData(
                            show: true,
                            gradient: LinearGradient(
                                colors: [
                                  AppTheme.chronosGold.withValues(alpha: 0.3),
                                  AppTheme.successGreen.withValues(alpha: 0.1),
                                ],
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter))),
                  ],
                  lineTouchData: LineTouchData(
                      enabled: true,
                      touchTooltipData: LineTouchTooltipData(
                          getTooltipItems: (List<LineBarSpot> touchedBarSpots) {
                        return touchedBarSpots.map((barSpot) {
                          final index = barSpot.x.toInt();
                          if (index >= 0 && index < widget.chartData.length) {
                            final data = widget.chartData[index];
                            return LineTooltipItem(
                                '${data['label']}\n\$${(barSpot.y).toStringAsFixed(2)}',
                                AppTheme.darkTheme.textTheme.bodySmall!
                                    .copyWith(
                                        color: AppTheme.textPrimary,
                                        fontWeight: FontWeight.w500));
                          }
                          return null;
                        }).toList();
                      }))))),
        ]));
  }
}
