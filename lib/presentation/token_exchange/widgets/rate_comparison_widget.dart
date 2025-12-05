import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';

class RateComparisonWidget extends StatelessWidget {
  final String exchangeRate;
  final String percentageDifference;
  final bool isPositive;
  final bool isLoading;

  const RateComparisonWidget({
    Key? key,
    required this.exchangeRate,
    required this.percentageDifference,
    required this.isPositive,
    this.isLoading = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(4.w),
      decoration: BoxDecoration(
        color: AppTheme.elevatedSurface.withValues(alpha: 0.4),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: AppTheme.primaryGold.withValues(alpha: 0.2),
          width: 1,
        ),
      ),
      child: isLoading
          ? Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: 4.w,
                  height: 4.w,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    valueColor:
                        AlwaysStoppedAnimation<Color>(AppTheme.primaryGold),
                  ),
                ),
                SizedBox(width: 3.w),
                Text(
                  'Fetching rate...',
                  style: AppTheme.darkTheme.textTheme.bodyMedium?.copyWith(
                    color: AppTheme.textSecondary,
                  ),
                ),
              ],
            )
          : Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Exchange Rate',
                      style: AppTheme.darkTheme.textTheme.bodyMedium?.copyWith(
                        color: AppTheme.textSecondary,
                      ),
                    ),
                    Text(
                      exchangeRate,
                      style: AppTheme.darkTheme.textTheme.bodyMedium?.copyWith(
                        color: AppTheme.textPrimary,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 2.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'vs Market Average',
                      style: AppTheme.darkTheme.textTheme.bodySmall?.copyWith(
                        color: AppTheme.textSecondary,
                      ),
                    ),
                    Row(
                      children: [
                        CustomIconWidget(
                          iconName:
                              isPositive ? 'trending_up' : 'trending_down',
                          color: isPositive
                              ? AppTheme.successGreen
                              : AppTheme.errorRed,
                          size: 4.w,
                        ),
                        SizedBox(width: 1.w),
                        Text(
                          percentageDifference,
                          style:
                              AppTheme.darkTheme.textTheme.bodySmall?.copyWith(
                            color: isPositive
                                ? AppTheme.successGreen
                                : AppTheme.errorRed,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
    );
  }
}
