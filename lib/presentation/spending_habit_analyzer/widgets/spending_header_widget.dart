import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';

class SpendingHeaderWidget extends StatelessWidget {
  final double monthlyTotal;
  final double monthlyChange;
  final String currentMonth;

  const SpendingHeaderWidget({
    super.key,
    required this.monthlyTotal,
    required this.monthlyChange,
    required this.currentMonth,
  });

  @override
  Widget build(BuildContext context) {
    final isDecreased = monthlyChange < 0;

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
          Text(
            currentMonth,
            style: AppTheme.darkTheme.textTheme.titleMedium?.copyWith(
              color: AppTheme.textSecondary,
            ),
          ),
          SizedBox(height: 1.h),
          Text(
            'Total Spending',
            style: AppTheme.darkTheme.textTheme.bodyMedium?.copyWith(
              color: AppTheme.textSecondary,
            ),
          ),
          SizedBox(height: 0.5.h),
          Text(
            '\$${monthlyTotal.toStringAsFixed(2)}',
            style: AppTheme.financialDataLarge.copyWith(
              color: AppTheme.textPrimary,
              fontSize: 28.sp,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: 2.h),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 1.h),
            decoration: BoxDecoration(
              color:
                  (isDecreased ? AppTheme.successGreen : AppTheme.warningAmber)
                      .withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                CustomIconWidget(
                  iconName: isDecreased ? 'trending_down' : 'trending_up',
                  color: isDecreased
                      ? AppTheme.successGreen
                      : AppTheme.warningAmber,
                  size: 4.w,
                ),
                SizedBox(width: 1.w),
                Text(
                  '${monthlyChange > 0 ? '+' : ''}${monthlyChange.toStringAsFixed(1)}%',
                  style: AppTheme.darkTheme.textTheme.labelLarge?.copyWith(
                    color: isDecreased
                        ? AppTheme.successGreen
                        : AppTheme.warningAmber,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(width: 2.w),
                Text(
                  'vs last month',
                  style: AppTheme.darkTheme.textTheme.bodySmall?.copyWith(
                    color: AppTheme.textTertiary,
                  ),
                ),
              ],
            ),
          ),
          if (isDecreased) ...[
            SizedBox(height: 1.h),
            Text(
              '🎉 Great job! You spent less than last month.',
              style: AppTheme.darkTheme.textTheme.bodySmall?.copyWith(
                color: AppTheme.successGreen,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ],
      ),
    );
  }
}
