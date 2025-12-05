import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';

class PortfolioAllocationWidget extends StatefulWidget {
  final Map<String, double> allocations;
  final List<Map<String, dynamic>> recommendations;
  final Function(String, double) onAllocationChanged;

  const PortfolioAllocationWidget({
    super.key,
    required this.allocations,
    required this.recommendations,
    required this.onAllocationChanged,
  });

  @override
  State<PortfolioAllocationWidget> createState() =>
      _PortfolioAllocationWidgetState();
}

class _PortfolioAllocationWidgetState extends State<PortfolioAllocationWidget> {
  int touchedIndex = -1;

  List<Color> get pieColors => [
        AppTheme.chronosGold,
        AppTheme.successGreen,
        AppTheme.warningAmber,
        AppTheme.textSecondary,
        Colors.purple,
      ];

  @override
  Widget build(BuildContext context) {
    if (widget.allocations.isEmpty) return const SizedBox.shrink();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            CustomIconWidget(
              iconName: 'pie_chart',
              color: AppTheme.chronosGold,
              size: 6.w,
            ),
            SizedBox(width: 3.w),
            Text(
              'Portfolio Allocation',
              style: AppTheme.darkTheme.textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
        SizedBox(height: 2.h),
        Container(
          padding: EdgeInsets.all(4.w),
          decoration: BoxDecoration(
            color: AppTheme.surfaceDark,
            borderRadius: BorderRadius.circular(16.0),
            border: Border.all(color: AppTheme.dividerSubtle),
          ),
          child: Column(
            children: [
              // Pie Chart
              SizedBox(
                height: 40.h,
                child: Stack(
                  children: [
                    PieChart(
                      PieChartData(
                        pieTouchData: PieTouchData(
                          touchCallback:
                              (FlTouchEvent event, pieTouchResponse) {
                            setState(() {
                              if (!event.isInterestedForInteractions ||
                                  pieTouchResponse == null ||
                                  pieTouchResponse.touchedSection == null) {
                                touchedIndex = -1;
                                return;
                              }
                              touchedIndex = pieTouchResponse
                                  .touchedSection!.touchedSectionIndex;
                            });
                          },
                        ),
                        borderData: FlBorderData(show: false),
                        sectionsSpace: 2,
                        centerSpaceRadius: 80,
                        sections: _buildPieChartSections(),
                      ),
                    ),
                    Positioned.fill(
                      child: Center(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              'Total',
                              style: AppTheme.darkTheme.textTheme.bodyMedium
                                  ?.copyWith(
                                color: AppTheme.textSecondary,
                              ),
                            ),
                            Text(
                              '${widget.allocations.values.fold(0.0, (sum, value) => sum + value).toStringAsFixed(0)}%',
                              style: AppTheme.darkTheme.textTheme.headlineSmall
                                  ?.copyWith(
                                fontWeight: FontWeight.w600,
                                color: AppTheme.chronosGold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              SizedBox(height: 3.h),

              // Allocation sliders
              Column(
                children: widget.allocations.entries.map((entry) {
                  final index =
                      widget.allocations.keys.toList().indexOf(entry.key);
                  final color = pieColors[index % pieColors.length];

                  return Container(
                    margin: EdgeInsets.only(bottom: 3.h),
                    padding: EdgeInsets.all(3.w),
                    decoration: BoxDecoration(
                      color: AppTheme.primaryCharcoal,
                      borderRadius: BorderRadius.circular(12.0),
                      border: touchedIndex == index
                          ? Border.all(color: color, width: 2.0)
                          : null,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Container(
                              width: 4.w,
                              height: 4.w,
                              decoration: BoxDecoration(
                                color: color,
                                shape: BoxShape.circle,
                              ),
                            ),
                            SizedBox(width: 2.w),
                            Expanded(
                              child: Text(
                                entry.key,
                                style: AppTheme.darkTheme.textTheme.titleSmall
                                    ?.copyWith(
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                            Text(
                              '${entry.value.toStringAsFixed(0)}%',
                              style: AppTheme.darkTheme.textTheme.titleSmall
                                  ?.copyWith(
                                fontWeight: FontWeight.w600,
                                color: color,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 2.h),
                        SliderTheme(
                          data: SliderTheme.of(context).copyWith(
                            activeTrackColor: color,
                            inactiveTrackColor: AppTheme.dividerSubtle,
                            thumbColor: color,
                            overlayColor: color.withValues(alpha: 0.2),
                            thumbShape: const RoundSliderThumbShape(
                                enabledThumbRadius: 8.0),
                            trackHeight: 4.0,
                          ),
                          child: Slider(
                            value: entry.value,
                            min: 0.0,
                            max: 100.0,
                            divisions: 20,
                            onChanged: (value) {
                              widget.onAllocationChanged(entry.key, value);
                            },
                          ),
                        ),
                      ],
                    ),
                  );
                }).toList(),
              ),

              // Risk distribution summary
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(3.w),
                decoration: BoxDecoration(
                  color: AppTheme.chronosGold.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(12.0),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        CustomIconWidget(
                          iconName: 'insights',
                          color: AppTheme.chronosGold,
                          size: 4.w,
                        ),
                        SizedBox(width: 2.w),
                        Text(
                          'Risk Distribution',
                          style:
                              AppTheme.darkTheme.textTheme.titleSmall?.copyWith(
                            fontWeight: FontWeight.w600,
                            color: AppTheme.chronosGold,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 1.h),
                    Text(
                      _calculateRiskSummary(),
                      style: AppTheme.darkTheme.textTheme.bodySmall?.copyWith(
                        color: AppTheme.textSecondary,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  List<PieChartSectionData> _buildPieChartSections() {
    return widget.allocations.entries.map((entry) {
      final index = widget.allocations.keys.toList().indexOf(entry.key);
      final isTouched = index == touchedIndex;
      final radius = isTouched ? 110.0 : 90.0;
      final color = pieColors[index % pieColors.length];

      return PieChartSectionData(
        color: color,
        value: entry.value,
        title: '${entry.value.toStringAsFixed(0)}%',
        radius: radius,
        titleStyle: AppTheme.darkTheme.textTheme.bodyMedium?.copyWith(
          fontWeight: FontWeight.w600,
          color: Colors.white,
        ),
        badgeWidget: isTouched
            ? Container(
                padding: EdgeInsets.all(1.w),
                decoration: BoxDecoration(
                  color: AppTheme.surfaceDark,
                  borderRadius: BorderRadius.circular(8.0),
                  border: Border.all(color: color, width: 2.0),
                ),
                child: Text(
                  entry.key.split(' ').first,
                  style: AppTheme.darkTheme.textTheme.bodySmall?.copyWith(
                    fontWeight: FontWeight.w600,
                    color: color,
                  ),
                ),
              )
            : null,
        badgePositionPercentageOffset: 0.98,
      );
    }).toList();
  }

  String _calculateRiskSummary() {
    double totalWeight = 0;
    double riskScore = 0;

    for (var entry in widget.allocations.entries) {
      final recommendation = widget.recommendations.firstWhere(
        (rec) => rec['name'] == entry.key,
        orElse: () => {'expectedReturn': 8.0},
      );

      final returnRate = recommendation['expectedReturn'] as double;
      final weight = entry.value / 100;

      totalWeight += weight;
      riskScore += returnRate * weight;
    }

    if (totalWeight == 0) return 'No allocation set';

    final avgReturn = riskScore / totalWeight;

    if (avgReturn < 5) {
      return 'Conservative portfolio with low volatility and steady growth potential';
    } else if (avgReturn < 10) {
      return 'Balanced portfolio with moderate risk and good growth potential';
    } else {
      return 'Growth-focused portfolio with higher volatility but strong return potential';
    }
  }
}
