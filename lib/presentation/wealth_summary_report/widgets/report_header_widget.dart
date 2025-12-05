import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';

class ReportHeaderWidget extends StatelessWidget {
  final double totalWealth;
  final double yearOverYearChange;
  final String reportDate;

  const ReportHeaderWidget({
    super.key,
    required this.totalWealth,
    required this.yearOverYearChange,
    required this.reportDate,
  });

  @override
  Widget build(BuildContext context) {
    final isPositiveChange = yearOverYearChange >= 0;

    return Container(
      margin: EdgeInsets.symmetric(horizontal: 4.w),
      padding: EdgeInsets.all(4.w),
      decoration: BoxDecoration(
        color: AppTheme.surfaceDark,
        borderRadius: BorderRadius.circular(16.0),
        border: Border.all(
          color: AppTheme.chronosGold.withValues(alpha: 0.2),
          width: 1.0,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Report Generated',
                style: AppTheme.darkTheme.textTheme.bodyMedium?.copyWith(
                  color: AppTheme.textSecondary,
                ),
              ),
              Text(
                reportDate,
                style: AppTheme.darkTheme.textTheme.bodyMedium?.copyWith(
                  color: AppTheme.chronosGold,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
          SizedBox(height: 2.h),
          Text(
            'Total Wealth',
            style: AppTheme.darkTheme.textTheme.titleMedium?.copyWith(
              color: AppTheme.textSecondary,
            ),
          ),
          SizedBox(height: 0.5.h),
          Text(
            '\$${totalWealth.toStringAsFixed(2)}',
            style: AppTheme.financialDataLarge.copyWith(
              color: AppTheme.textPrimary,
              fontSize: 32.sp,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: 1.h),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 1.h),
            decoration: BoxDecoration(
              color:
                  (isPositiveChange ? AppTheme.successGreen : AppTheme.errorRed)
                      .withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                CustomIconWidget(
                  iconName: isPositiveChange ? 'trending_up' : 'trending_down',
                  color: isPositiveChange
                      ? AppTheme.successGreen
                      : AppTheme.errorRed,
                  size: 4.w,
                ),
                SizedBox(width: 1.w),
                Text(
                  '${yearOverYearChange > 0 ? '+' : ''}${yearOverYearChange.toStringAsFixed(1)}%',
                  style: AppTheme.darkTheme.textTheme.labelLarge?.copyWith(
                    color: isPositiveChange
                        ? AppTheme.successGreen
                        : AppTheme.errorRed,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(width: 2.w),
                Text(
                  'vs last year',
                  style: AppTheme.darkTheme.textTheme.bodySmall?.copyWith(
                    color: AppTheme.textTertiary,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
