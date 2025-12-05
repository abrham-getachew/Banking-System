import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../../core/app_export.dart';
import '../../../theme/app_theme.dart';

class PriceChartWidget extends StatefulWidget {
  final List<Map<String, dynamic>> chartData;
  final String selectedTimeframe;
  final Function(String) onTimeframeChanged;

  const PriceChartWidget({
    Key? key,
    required this.chartData,
    required this.selectedTimeframe,
    required this.onTimeframeChanged,
  }) : super(key: key);

  @override
  State<PriceChartWidget> createState() => _PriceChartWidgetState();
}

class _PriceChartWidgetState extends State<PriceChartWidget> {
  bool _showCrosshair = false;
  double _crosshairX = 0;
  double _crosshairY = 0;
  String _crosshairPrice = "";
  String _crosshairTime = "";

  final List<String> timeframes = ['1H', '24H', '7D', '1M', '1Y'];

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50.h,
      margin: EdgeInsets.symmetric(horizontal: 4.w),
      decoration: AppTheme.glassmorphicDecoration(
        borderRadius: 16,
        opacity: 0.05,
      ),
      child: Column(
        children: [
          _buildTimeframeSelector(),
          Expanded(
            child: _buildChart(),
          ),
        ],
      ),
    );
  }

  Widget _buildTimeframeSelector() {
    return Container(
      padding: EdgeInsets.all(3.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: timeframes.map((timeframe) {
          final isSelected = widget.selectedTimeframe == timeframe;
          return GestureDetector(
            onTap: () => widget.onTimeframeChanged(timeframe),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 1.h),
              decoration: BoxDecoration(
                color: isSelected
                    ? AppTheme.primaryGold.withValues(alpha: 0.2)
                    : Colors.transparent,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(
                  color: isSelected ? AppTheme.primaryGold : Colors.transparent,
                  width: 1,
                ),
              ),
              child: Text(
                timeframe,
                style: AppTheme.darkTheme.textTheme.labelMedium?.copyWith(
                  color: isSelected
                      ? AppTheme.primaryGold
                      : AppTheme.textSecondary,
                  fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
                  fontSize: 12.sp,
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildChart() {
    if (widget.chartData.isEmpty) {
      return Center(
        child: Text(
          "No chart data available",
          style: AppTheme.darkTheme.textTheme.bodyMedium?.copyWith(
            color: AppTheme.textSecondary,
          ),
        ),
      );
    }

    final spots = widget.chartData.asMap().entries.map((entry) {
      final index = entry.key;
      final data = entry.value;
      return FlSpot(
        index.toDouble(),
        (data["price"] as double? ?? 0.0),
      );
    }).toList();

    final minY = spots.map((spot) => spot.y).reduce((a, b) => a < b ? a : b);
    final maxY = spots.map((spot) => spot.y).reduce((a, b) => a > b ? a : b);
    final padding = (maxY - minY) * 0.1;

    return Container(
      padding: EdgeInsets.all(3.w),
      child: Stack(
        children: [
          LineChart(
            LineChartData(
              gridData: FlGridData(
                show: true,
                drawVerticalLine: false,
                horizontalInterval: (maxY - minY) / 4,
                getDrawingHorizontalLine: (value) {
                  return FlLine(
                    color: AppTheme.textSecondary.withValues(alpha: 0.1),
                    strokeWidth: 1,
                  );
                },
              ),
              titlesData: FlTitlesData(
                show: true,
                rightTitles: AxisTitles(
                  sideTitles: SideTitles(showTitles: false),
                ),
                topTitles: AxisTitles(
                  sideTitles: SideTitles(showTitles: false),
                ),
                bottomTitles: AxisTitles(
                  sideTitles: SideTitles(
                    showTitles: true,
                    reservedSize: 30,
                    interval: spots.length > 10 ? spots.length / 5 : 1,
                    getTitlesWidget: (value, meta) {
                      final index = value.toInt();
                      if (index >= 0 && index < widget.chartData.length) {
                        final time =
                            widget.chartData[index]["time"] as String? ?? "";
                        return Padding(
                          padding: EdgeInsets.only(top: 1.h),
                          child: Text(
                            time,
                            style: AppTheme.darkTheme.textTheme.labelSmall
                                ?.copyWith(
                              color: AppTheme.textSecondary,
                              fontSize: 9.sp,
                            ),
                          ),
                        );
                      }
                      return const SizedBox.shrink();
                    },
                  ),
                ),
                leftTitles: AxisTitles(
                  sideTitles: SideTitles(
                    showTitles: true,
                    reservedSize: 60,
                    interval: (maxY - minY) / 4,
                    getTitlesWidget: (value, meta) {
                      return Text(
                        "\$${value.toStringAsFixed(0)}",
                        style:
                            AppTheme.darkTheme.textTheme.labelSmall?.copyWith(
                          color: AppTheme.textSecondary,
                          fontSize: 9.sp,
                        ),
                      );
                    },
                  ),
                ),
              ),
              borderData: FlBorderData(show: false),
              minX: 0,
              maxX: (spots.length - 1).toDouble(),
              minY: minY - padding,
              maxY: maxY + padding,
              lineBarsData: [
                LineChartBarData(
                  spots: spots,
                  isCurved: true,
                  gradient: LinearGradient(
                    colors: [
                      AppTheme.primaryGold,
                      AppTheme.primaryGold.withValues(alpha: 0.8),
                    ],
                  ),
                  barWidth: 3,
                  isStrokeCapRound: true,
                  dotData: FlDotData(show: false),
                  belowBarData: BarAreaData(
                    show: true,
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        AppTheme.primaryGold.withValues(alpha: 0.3),
                        AppTheme.primaryGold.withValues(alpha: 0.05),
                      ],
                    ),
                  ),
                ),
              ],
              lineTouchData: LineTouchData(
                enabled: true,
                touchCallback:
                    (FlTouchEvent event, LineTouchResponse? touchResponse) {
                  if (event is FlPanUpdateEvent || event is FlLongPressStart) {
                    if (touchResponse?.lineBarSpots?.isNotEmpty == true) {
                      final spot = touchResponse!.lineBarSpots!.first;
                      final index = spot.x.toInt();

                      if (index >= 0 && index < widget.chartData.length) {
                        setState(() {
                          _showCrosshair = true;
                          _crosshairX = spot.x;
                          _crosshairY = spot.y;
                          _crosshairPrice = "\$${spot.y.toStringAsFixed(2)}";
                          _crosshairTime =
                              widget.chartData[index]["time"] as String? ?? "";
                        });
                      }
                    }
                  } else if (event is FlTapUpEvent || event is FlLongPressEnd) {
                    setState(() {
                      _showCrosshair = false;
                    });
                  }
                },
                touchTooltipData: LineTouchTooltipData(
                  tooltipBgColor:
                      AppTheme.elevatedSurface.withValues(alpha: 0.9),
                  tooltipRoundedRadius: 8,
                  tooltipPadding: EdgeInsets.all(2.w),
                  getTooltipItems: (List<LineBarSpot> touchedBarSpots) {
                    return touchedBarSpots.map((barSpot) {
                      return LineTooltipItem(
                        "\$${barSpot.y.toStringAsFixed(2)}",
                        AppTheme.darkTheme.textTheme.labelMedium?.copyWith(
                              color: AppTheme.textPrimary,
                              fontWeight: FontWeight.w600,
                            ) ??
                            const TextStyle(),
                      );
                    }).toList();
                  },
                ),
              ),
            ),
          ),
          if (_showCrosshair)
            Positioned(
              top: 10.h,
              left: 4.w,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 1.h),
                decoration: AppTheme.glassmorphicDecoration(
                  borderRadius: 8,
                  opacity: 0.9,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      _crosshairPrice,
                      style: AppTheme.darkTheme.textTheme.titleMedium?.copyWith(
                        color: AppTheme.primaryGold,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    Text(
                      _crosshairTime,
                      style: AppTheme.darkTheme.textTheme.labelSmall?.copyWith(
                        color: AppTheme.textSecondary,
                      ),
                    ),
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }
}
