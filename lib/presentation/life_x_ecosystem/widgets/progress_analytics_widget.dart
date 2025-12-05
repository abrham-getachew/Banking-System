import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';

class ProgressAnalyticsWidget extends StatefulWidget {
  final List<Map<String, dynamic>> dimensions;

  const ProgressAnalyticsWidget({
    Key? key,
    required this.dimensions,
  }) : super(key: key);

  @override
  State<ProgressAnalyticsWidget> createState() =>
      _ProgressAnalyticsWidgetState();
}

class _ProgressAnalyticsWidgetState extends State<ProgressAnalyticsWidget> {
  String selectedPeriod = 'This Month';
  final List<String> periods = [
    'This Week',
    'This Month',
    'This Quarter',
    'This Year'
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildPeriodSelector(),
        SizedBox(height: 3.h),
        _buildProgressChart(),
        SizedBox(height: 3.h),
        _buildSpendingBreakdown(),
        SizedBox(height: 3.h),
        _buildTrendAnalysis(),
        SizedBox(height: 3.h),
        _buildRecommendations(),
      ],
    );
  }

  Widget _buildPeriodSelector() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          'Analytics Overview',
          style: AppTheme.darkTheme.textTheme.titleLarge?.copyWith(
            color: AppTheme.textPrimary,
            fontWeight: FontWeight.w600,
          ),
        ),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 1.h),
          decoration: BoxDecoration(
            color: AppTheme.secondaryDark,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: AppTheme.borderGray),
          ),
          child: DropdownButton<String>(
            value: selectedPeriod,
            onChanged: (String? newValue) {
              if (newValue != null) {
                setState(() {
                  selectedPeriod = newValue;
                });
              }
            },
            items: periods.map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(
                  value,
                  style: AppTheme.darkTheme.textTheme.bodyMedium?.copyWith(
                    color: AppTheme.textPrimary,
                  ),
                ),
              );
            }).toList(),
            underline: SizedBox.shrink(),
            dropdownColor: AppTheme.secondaryDark,
            icon: CustomIconWidget(
              iconName: 'keyboard_arrow_down',
              color: AppTheme.textSecondary,
              size: 20,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildProgressChart() {
    return Container(
      padding: EdgeInsets.all(4.w),
      decoration: BoxDecoration(
        color: AppTheme.secondaryDark,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Progress by Dimension',
            style: AppTheme.darkTheme.textTheme.titleMedium?.copyWith(
              color: AppTheme.textPrimary,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: 3.h),
          SizedBox(
            height: 30.h,
            child: BarChart(
              BarChartData(
                alignment: BarChartAlignment.spaceAround,
                maxY: 1.0,
                barTouchData: BarTouchData(enabled: false),
                titlesData: FlTitlesData(
                  show: true,
                  bottomTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      getTitlesWidget: (double value, TitleMeta meta) {
                        if (value.toInt() < widget.dimensions.length) {
                          return Padding(
                            padding: EdgeInsets.only(top: 1.h),
                            child: Text(
                              widget.dimensions[value.toInt()]['name']
                                  .toString()
                                  .substring(0, 3),
                              style: AppTheme.darkTheme.textTheme.bodySmall
                                  ?.copyWith(
                                color: AppTheme.textSecondary,
                              ),
                            ),
                          );
                        }
                        return Text('');
                      },
                    ),
                  ),
                  leftTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      reservedSize: 10.w,
                      getTitlesWidget: (double value, TitleMeta meta) {
                        return Text(
                          '${(value * 100).toInt()}%',
                          style:
                              AppTheme.darkTheme.textTheme.bodySmall?.copyWith(
                            color: AppTheme.textSecondary,
                          ),
                        );
                      },
                    ),
                  ),
                  topTitles:
                      AxisTitles(sideTitles: SideTitles(showTitles: false)),
                  rightTitles:
                      AxisTitles(sideTitles: SideTitles(showTitles: false)),
                ),
                gridData: FlGridData(
                  show: true,
                  drawVerticalLine: false,
                  horizontalInterval: 0.2,
                  getDrawingHorizontalLine: (value) {
                    return FlLine(
                      color: AppTheme.borderGray.withValues(alpha: 0.3),
                      strokeWidth: 1,
                    );
                  },
                ),
                borderData: FlBorderData(show: false),
                barGroups: widget.dimensions.asMap().entries.map((entry) {
                  int index = entry.key;
                  Map<String, dynamic> dimension = entry.value;
                  return BarChartGroupData(
                    x: index,
                    barRods: [
                      BarChartRodData(
                        toY: dimension['progress'],
                        color: dimension['color'],
                        width: 6.w,
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ],
                  );
                }).toList(),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSpendingBreakdown() {
    return Container(
      padding: EdgeInsets.all(4.w),
      decoration: BoxDecoration(
        color: AppTheme.secondaryDark,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Spending Breakdown',
            style: AppTheme.darkTheme.textTheme.titleMedium?.copyWith(
              color: AppTheme.textPrimary,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: 3.h),
          Row(
            children: [
              Expanded(
                flex: 2,
                child: SizedBox(
                  height: 25.h,
                  child: PieChart(
                    PieChartData(
                      sections: widget.dimensions.map((dimension) {
                        final spent = double.parse(dimension['spent']
                            .replaceAll('\$', '')
                            .replaceAll(',', ''));
                        final total = widget.dimensions.fold(
                            0.0,
                            (sum, d) =>
                                sum +
                                double.parse(d['spent']
                                    .replaceAll('\$', '')
                                    .replaceAll(',', '')));
                        final percentage = (spent / total) * 100;

                        return PieChartSectionData(
                          color: dimension['color'],
                          value: spent,
                          title: '${percentage.toInt()}%',
                          radius: 8.w,
                          titleStyle:
                              AppTheme.darkTheme.textTheme.bodySmall?.copyWith(
                            color: AppTheme.textPrimary,
                            fontWeight: FontWeight.w600,
                          ),
                        );
                      }).toList(),
                      centerSpaceRadius: 6.w,
                      sectionsSpace: 2,
                    ),
                  ),
                ),
              ),
              SizedBox(width: 4.w),
              Expanded(
                flex: 3,
                child: Column(
                  children: widget.dimensions.map((dimension) {
                    return Container(
                      margin: EdgeInsets.only(bottom: 1.h),
                      child: Row(
                        children: [
                          Container(
                            width: 3.w,
                            height: 3.w,
                            decoration: BoxDecoration(
                              color: dimension['color'],
                              shape: BoxShape.circle,
                            ),
                          ),
                          SizedBox(width: 2.w),
                          Expanded(
                            child: Text(
                              dimension['name'],
                              style: AppTheme.darkTheme.textTheme.bodySmall
                                  ?.copyWith(
                                color: AppTheme.textPrimary,
                              ),
                            ),
                          ),
                          Text(
                            dimension['spent'],
                            style: AppTheme.darkTheme.textTheme.bodySmall
                                ?.copyWith(
                              color: AppTheme.textSecondary,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    );
                  }).toList(),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTrendAnalysis() {
    return Container(
      padding: EdgeInsets.all(4.w),
      decoration: BoxDecoration(
        color: AppTheme.secondaryDark,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Trend Analysis',
            style: AppTheme.darkTheme.textTheme.titleMedium?.copyWith(
              color: AppTheme.textPrimary,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: 2.h),
          _buildTrendItem('Health', '+12%', true),
          _buildTrendItem('Education', '+8%', true),
          _buildTrendItem('Fitness', '-5%', false),
          _buildTrendItem('Family', '+15%', true),
        ],
      ),
    );
  }

  Widget _buildTrendItem(String dimension, String change, bool isPositive) {
    return Container(
      margin: EdgeInsets.only(bottom: 1.h),
      padding: EdgeInsets.all(3.w),
      decoration: BoxDecoration(
        color: AppTheme.primaryDark,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            dimension,
            style: AppTheme.darkTheme.textTheme.bodyMedium?.copyWith(
              color: AppTheme.textPrimary,
            ),
          ),
          Row(
            children: [
              CustomIconWidget(
                iconName: isPositive ? 'trending_up' : 'trending_down',
                color: isPositive ? AppTheme.successGreen : AppTheme.errorRed,
                size: 16,
              ),
              SizedBox(width: 1.w),
              Text(
                change,
                style: AppTheme.darkTheme.textTheme.bodyMedium?.copyWith(
                  color: isPositive ? AppTheme.successGreen : AppTheme.errorRed,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildRecommendations() {
    final recommendations = [
      {
        'title': 'Increase Fitness Budget',
        'description':
            'Your fitness spending is below target. Consider allocating more for better health outcomes.',
        'priority': 'high',
        'icon': 'fitness_center'
      },
      {
        'title': 'Optimize Education Spending',
        'description':
            'Great progress on education! Consider exploring advanced courses.',
        'priority': 'medium',
        'icon': 'school'
      },
      {
        'title': 'Family Planning Review',
        'description':
            'Review your family financial goals and adjust savings accordingly.',
        'priority': 'low',
        'icon': 'family_restroom'
      },
    ];

    return Container(
      padding: EdgeInsets.all(4.w),
      decoration: BoxDecoration(
        color: AppTheme.secondaryDark,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'AI Recommendations',
            style: AppTheme.darkTheme.textTheme.titleMedium?.copyWith(
              color: AppTheme.textPrimary,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: 2.h),
          ...recommendations
              .map((rec) => Container(
                    margin: EdgeInsets.only(bottom: 2.h),
                    padding: EdgeInsets.all(3.w),
                    decoration: BoxDecoration(
                      color: AppTheme.primaryDark,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: _getPriorityColor(rec['priority'] as String)
                            .withValues(alpha: 0.3),
                      ),
                    ),
                    child: Row(
                      children: [
                        Container(
                          padding: EdgeInsets.all(2.w),
                          decoration: BoxDecoration(
                            color: _getPriorityColor(rec['priority'] as String)
                                .withValues(alpha: 0.2),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: CustomIconWidget(
                            iconName: rec['icon'] as String,
                            color: _getPriorityColor(rec['priority'] as String),
                            size: 20,
                          ),
                        ),
                        SizedBox(width: 3.w),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                rec['title'] as String,
                                style: AppTheme.darkTheme.textTheme.bodyMedium
                                    ?.copyWith(
                                  color: AppTheme.textPrimary,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              SizedBox(height: 0.5.h),
                              Text(
                                rec['description'] as String,
                                style: AppTheme.darkTheme.textTheme.bodySmall
                                    ?.copyWith(
                                  color: AppTheme.textSecondary,
                                ),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ))
              .toList(),
        ],
      ),
    );
  }

  Color _getPriorityColor(String priority) {
    switch (priority) {
      case 'high':
        return AppTheme.errorRed;
      case 'medium':
        return AppTheme.warningAmber;
      case 'low':
        return AppTheme.successGreen;
      default:
        return AppTheme.textSecondary;
    }
  }
}
