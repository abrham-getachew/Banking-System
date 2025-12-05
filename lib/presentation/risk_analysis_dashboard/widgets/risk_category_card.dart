import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../../core/app_export.dart';

class RiskCategoryCard extends StatelessWidget {
  final String title;
  final String currentValue;
  final String targetRange;
  final double progressValue;
  final String iconName;
  final Color statusColor;
  final String improvementDirection;
  final VoidCallback onTap;

  const RiskCategoryCard({
    Key? key,
    required this.title,
    required this.currentValue,
    required this.targetRange,
    required this.progressValue,
    required this.iconName,
    required this.statusColor,
    required this.improvementDirection,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 70.w,
        margin: EdgeInsets.only(right: 4.w),
        padding: EdgeInsets.all(4.w),
        decoration: BoxDecoration(
          color: AppTheme.darkTheme.colorScheme.surface,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: statusColor.withValues(alpha: 0.3),
            width: 1.5,
          ),
          boxShadow: [
            BoxShadow(
              color: AppTheme.darkTheme.colorScheme.shadow,
              blurRadius: 8.0,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header with icon and improvement arrow
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: EdgeInsets.all(2.w),
                  decoration: BoxDecoration(
                    color: statusColor.withValues(alpha: 0.2),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: CustomIconWidget(
                    iconName: iconName,
                    color: statusColor,
                    size: 6.w,
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 2.w, vertical: 1.w),
                  decoration: BoxDecoration(
                    color: _getImprovementColor().withValues(alpha: 0.2),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      CustomIconWidget(
                        iconName: _getImprovementIcon(),
                        color: _getImprovementColor(),
                        size: 3.w,
                      ),
                      SizedBox(width: 1.w),
                      Text(
                        improvementDirection,
                        style: AppTheme.darkTheme.textTheme.bodySmall?.copyWith(
                          color: _getImprovementColor(),
                          fontSize: 9.sp,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 3.h),
            // Title
            Text(
              title,
              style: AppTheme.darkTheme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(height: 1.h),
            // Current value
            Text(
              currentValue,
              style: AppTheme.darkTheme.textTheme.headlineSmall?.copyWith(
                color: statusColor,
                fontWeight: FontWeight.w700,
              ),
            ),
            SizedBox(height: 1.h),
            // Target range
            Text(
              'Target: $targetRange',
              style: AppTheme.darkTheme.textTheme.bodySmall?.copyWith(
                color: AppTheme.textSecondary,
              ),
            ),
            SizedBox(height: 2.h),
            // Progress bar
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Progress',
                      style: AppTheme.darkTheme.textTheme.bodySmall?.copyWith(
                        color: AppTheme.textTertiary,
                      ),
                    ),
                    Text(
                      '${(progressValue * 100).toInt()}%',
                      style: AppTheme.darkTheme.textTheme.bodySmall?.copyWith(
                        color: statusColor,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 1.h),
                Container(
                  height: 1.h,
                  decoration: BoxDecoration(
                    color: AppTheme.dividerSubtle,
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: FractionallySizedBox(
                    alignment: Alignment.centerLeft,
                    widthFactor: progressValue,
                    child: Container(
                      decoration: BoxDecoration(
                        color: statusColor,
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 2.h),
            // Swipe up indicator
            Center(
              child: Container(
                width: 10.w,
                height: 1.w,
                decoration: BoxDecoration(
                  color: AppTheme.textTertiary.withValues(alpha: 0.5),
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Color _getImprovementColor() {
    switch (improvementDirection.toLowerCase()) {
      case 'good':
        return AppTheme.successGreen;
      case 'needs attention':
        return AppTheme.warningAmber;
      case 'critical':
        return AppTheme.errorRed;
      default:
        return AppTheme.textSecondary;
    }
  }

  String _getImprovementIcon() {
    switch (improvementDirection.toLowerCase()) {
      case 'good':
        return 'trending_up';
      case 'needs attention':
        return 'trending_flat';
      case 'critical':
        return 'trending_down';
      default:
        return 'help_outline';
    }
  }
}
