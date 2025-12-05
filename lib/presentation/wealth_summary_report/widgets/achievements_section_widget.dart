import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';

class AchievementsSectionWidget extends StatelessWidget {
  final List<Map<String, dynamic>> achievements;

  const AchievementsSectionWidget({
    super.key,
    required this.achievements,
  });

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
          Row(
            children: [
              CustomIconWidget(
                iconName: 'emoji_events',
                color: AppTheme.chronosGold,
                size: 6.w,
              ),
              SizedBox(width: 2.w),
              Text(
                'Key Achievements',
                style: AppTheme.darkTheme.textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          SizedBox(height: 1.h),
          Text(
            'Your financial milestones and accomplishments',
            style: AppTheme.darkTheme.textTheme.bodyMedium?.copyWith(
              color: AppTheme.textSecondary,
            ),
          ),
          SizedBox(height: 3.h),
          ...achievements
              .map((achievement) => Container(
                    margin: EdgeInsets.only(bottom: 2.h),
                    padding: EdgeInsets.all(3.w),
                    decoration: BoxDecoration(
                      color: AppTheme.primaryCharcoal.withValues(alpha: 0.3),
                      borderRadius: BorderRadius.circular(12.0),
                      border: Border.all(
                        color: _getBadgeColor(achievement['badge'])
                            .withValues(alpha: 0.3),
                        width: 1.0,
                      ),
                    ),
                    child: Row(
                      children: [
                        Container(
                          width: 12.w,
                          height: 12.w,
                          decoration: BoxDecoration(
                            color: _getBadgeColor(achievement['badge'])
                                .withValues(alpha: 0.1),
                            borderRadius: BorderRadius.circular(12.0),
                          ),
                          child: CustomIconWidget(
                            iconName: _getBadgeIcon(achievement['badge']),
                            color: _getBadgeColor(achievement['badge']),
                            size: 6.w,
                          ),
                        ),
                        SizedBox(width: 3.w),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                achievement['title'],
                                style: AppTheme.darkTheme.textTheme.titleMedium
                                    ?.copyWith(
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              SizedBox(height: 0.5.h),
                              Text(
                                achievement['description'],
                                style: AppTheme.darkTheme.textTheme.bodyMedium
                                    ?.copyWith(
                                  color: AppTheme.textSecondary,
                                ),
                              ),
                              SizedBox(height: 0.5.h),
                              Text(
                                achievement['date'],
                                style: AppTheme.darkTheme.textTheme.labelSmall
                                    ?.copyWith(
                                  color: AppTheme.textTertiary,
                                ),
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

  Color _getBadgeColor(String badge) {
    switch (badge) {
      case 'milestone':
        return AppTheme.chronosGold;
      case 'achievement':
        return AppTheme.successGreen;
      case 'streak':
        return const Color(0xFF6366F1);
      default:
        return AppTheme.textSecondary;
    }
  }

  String _getBadgeIcon(String badge) {
    switch (badge) {
      case 'milestone':
        return 'flag';
      case 'achievement':
        return 'star';
      case 'streak':
        return 'whatshot';
      default:
        return 'emoji_events';
    }
  }
}
