import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';
import '../../../theme/app_theme.dart';

class SpendingDonutChartWidget extends StatefulWidget {
  final List<Map<String, dynamic>> spendingCategories;
  final Function(Map<String, dynamic>) onCategoryTap;

  const SpendingDonutChartWidget({
    super.key,
    required this.spendingCategories,
    required this.onCategoryTap,
  });

  @override
  State<SpendingDonutChartWidget> createState() =>
      _SpendingDonutChartWidgetState();
}

class _SpendingDonutChartWidgetState extends State<SpendingDonutChartWidget> {
  int selectedIndex = -1;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 4.w),
      padding: EdgeInsets.all(4.w),
      decoration: BoxDecoration(
        color: AppTheme.surfaceDark,
        borderRadius: BorderRadius.circular(16.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Spending Breakdown',
            style: AppTheme.darkTheme.textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: 1.h),
          Text(
            'Touch segments for detailed breakdown',
            style: AppTheme.darkTheme.textTheme.bodyMedium?.copyWith(
              color: AppTheme.textSecondary,
            ),
          ),
          SizedBox(height: 3.h),
          SizedBox(
            height: 35.h,
            child: PieChart(
              PieChartData(
                sectionsSpace: 2,
                centerSpaceRadius: 10.h,
                sections:
                    widget.spendingCategories.asMap().entries.map((entry) {
                  final index = entry.key;
                  final data = entry.value;
                  final isSelected = selectedIndex == index;

                  return PieChartSectionData(
                    color: data['color'],
                    value: data['percentage'].toDouble(),
                    title: isSelected ? '${data['percentage'].toInt()}%' : '',
                    radius: isSelected ? 8.h : 6.h,
                    titleStyle:
                        AppTheme.darkTheme.textTheme.labelMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                      color: AppTheme.textPrimary,
                    ),
                  );
                }).toList(),
                pieTouchData: PieTouchData(
                  enabled: true,
                  touchCallback: (FlTouchEvent event, pieTouchResponse) {
                    if (pieTouchResponse == null ||
                        pieTouchResponse.touchedSection == null) {
                      setState(() {
                        selectedIndex = -1;
                      });
                      return;
                    }

                    final touchedIndex =
                        pieTouchResponse.touchedSection!.touchedSectionIndex;
                    if (event is FlTapUpEvent) {
                      widget.onCategoryTap(
                          widget.spendingCategories[touchedIndex]);
                    }

                    setState(() {
                      selectedIndex = touchedIndex;
                    });
                  },
                ),
              ),
            ),
          ),
          SizedBox(height: 2.h),
          if (selectedIndex >= 0 &&
              selectedIndex < widget.spendingCategories.length)
            _buildSelectedCategoryInfo(widget.spendingCategories[selectedIndex])
          else
            _buildCategoriesLegend(),
        ],
      ),
    );
  }

  Widget _buildSelectedCategoryInfo(Map<String, dynamic> category) {
    final isOverBudget = category['amount'] > category['budgetLimit'];

    return Container(
      padding: EdgeInsets.all(3.w),
      decoration: BoxDecoration(
        color: category['color'].withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(12.0),
        border: Border.all(
          color: category['color'].withValues(alpha: 0.3),
          width: 1.0,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 3.w,
                height: 3.w,
                decoration: BoxDecoration(
                  color: category['color'],
                  shape: BoxShape.circle,
                ),
              ),
              SizedBox(width: 2.w),
              Text(
                category['category'],
                style: AppTheme.darkTheme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          SizedBox(height: 1.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Spent: \$${category['amount'].toStringAsFixed(2)}',
                    style: AppTheme.darkTheme.textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    'Budget: \$${category['budgetLimit'].toStringAsFixed(2)}',
                    style: AppTheme.darkTheme.textTheme.bodySmall?.copyWith(
                      color: AppTheme.textSecondary,
                    ),
                  ),
                ],
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 2.w, vertical: 0.5.h),
                decoration: BoxDecoration(
                  color: isOverBudget
                      ? AppTheme.errorRed.withValues(alpha: 0.1)
                      : AppTheme.successGreen.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(6.0),
                ),
                child: Text(
                  isOverBudget ? 'Over Budget' : 'Within Budget',
                  style: AppTheme.darkTheme.textTheme.labelSmall?.copyWith(
                    color: isOverBudget
                        ? AppTheme.errorRed
                        : AppTheme.successGreen,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildCategoriesLegend() {
    return Wrap(
      spacing: 3.w,
      runSpacing: 1.h,
      children: widget.spendingCategories.take(6).map((category) {
        return Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 2.w,
              height: 2.w,
              decoration: BoxDecoration(
                color: category['color'],
                shape: BoxShape.circle,
              ),
            ),
            SizedBox(width: 1.w),
            Text(
              category['category'],
              style: AppTheme.darkTheme.textTheme.labelSmall?.copyWith(
                color: AppTheme.textSecondary,
              ),
            ),
          ],
        );
      }).toList(),
    );
  }
}
