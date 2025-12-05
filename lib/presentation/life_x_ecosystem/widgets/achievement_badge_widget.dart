import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';

class AchievementBadgeWidget extends StatelessWidget {
  final Map<String, dynamic> achievement;
  final bool isExpanded;

  const AchievementBadgeWidget({
    Key? key,
    required this.achievement,
    this.isExpanded = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (isExpanded) {
      return _buildExpandedBadge();
    }
    return _buildCompactBadge();
  }

  Widget _buildCompactBadge() {
    return Container(
      width: 25.w,
      margin: EdgeInsets.only(right: 3.w),
      padding: EdgeInsets.all(3.w),
      decoration: BoxDecoration(
        color: achievement['earned']
            ? AppTheme.accentGold.withValues(alpha: 0.2)
            : AppTheme.secondaryDark,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color:
              achievement['earned'] ? AppTheme.accentGold : AppTheme.borderGray,
          width: 1,
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: EdgeInsets.all(2.w),
            decoration: BoxDecoration(
              color: achievement['earned']
                  ? AppTheme.accentGold
                  : AppTheme.borderGray,
              shape: BoxShape.circle,
            ),
            child: CustomIconWidget(
              iconName: achievement['icon'],
              color: achievement['earned']
                  ? AppTheme.primaryDark
                  : AppTheme.textSecondary,
              size: 20,
            ),
          ),
          SizedBox(height: 1.h),
          Text(
            achievement['title'],
            style: AppTheme.darkTheme.textTheme.bodySmall?.copyWith(
              color: achievement['earned']
                  ? AppTheme.accentGold
                  : AppTheme.textSecondary,
              fontWeight: FontWeight.w600,
            ),
            textAlign: TextAlign.center,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }

  Widget _buildExpandedBadge() {
    return Container(
      margin: EdgeInsets.only(bottom: 2.h),
      padding: EdgeInsets.all(4.w),
      decoration: BoxDecoration(
        color: achievement['earned']
            ? AppTheme.accentGold.withValues(alpha: 0.1)
            : AppTheme.secondaryDark,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color:
              achievement['earned'] ? AppTheme.accentGold : AppTheme.borderGray,
          width: 1,
        ),
      ),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(3.w),
            decoration: BoxDecoration(
              color: achievement['earned']
                  ? AppTheme.accentGold
                  : AppTheme.borderGray,
              shape: BoxShape.circle,
            ),
            child: CustomIconWidget(
              iconName: achievement['icon'],
              color: achievement['earned']
                  ? AppTheme.primaryDark
                  : AppTheme.textSecondary,
              size: 24,
            ),
          ),
          SizedBox(width: 4.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        achievement['title'],
                        style:
                            AppTheme.darkTheme.textTheme.titleMedium?.copyWith(
                          color: achievement['earned']
                              ? AppTheme.accentGold
                              : AppTheme.textSecondary,
                          fontWeight: FontWeight.w600,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    if (achievement['earned'])
                      Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: 2.w, vertical: 0.5.h),
                        decoration: BoxDecoration(
                          color: AppTheme.successGreen.withValues(alpha: 0.2),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          'Earned',
                          style:
                              AppTheme.darkTheme.textTheme.bodySmall?.copyWith(
                            color: AppTheme.successGreen,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                  ],
                ),
                SizedBox(height: 1.h),
                Text(
                  achievement['description'],
                  style: AppTheme.darkTheme.textTheme.bodyMedium?.copyWith(
                    color: AppTheme.textSecondary,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                if (achievement['earned'] && achievement['date'] != null) ...[
                  SizedBox(height: 1.h),
                  Text(
                    'Earned on ${achievement['date']}',
                    style: AppTheme.darkTheme.textTheme.bodySmall?.copyWith(
                      color: AppTheme.textSecondary,
                    ),
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }
}
