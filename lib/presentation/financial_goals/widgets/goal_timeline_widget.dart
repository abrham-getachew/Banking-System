import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';

class GoalTimelineWidget extends StatelessWidget {
  final List<Map<String, dynamic>> milestones;

  const GoalTimelineWidget({
    Key? key,
    required this.milestones,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 4.w),
      child: Card(
        elevation: AppTheme.elevationResting,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.0),
        ),
        child: Container(
          padding: EdgeInsets.all(4.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  CustomIconWidget(
                    iconName: 'timeline',
                    color: AppTheme.chronosGold,
                    size: 24,
                  ),
                  SizedBox(width: 3.w),
                  Text(
                    "Goal Timeline",
                    style: AppTheme.darkTheme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 3.h),
              _buildTimelineList(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTimelineList() {
    return ListView.separated(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: milestones.length,
      separatorBuilder: (context, index) => SizedBox(height: 2.h),
      itemBuilder: (context, index) {
        final milestone = milestones[index];
        final isCompleted = milestone["isCompleted"] as bool;
        final isCurrent = milestone["isCurrent"] as bool;

        return _buildTimelineItem(milestone, isCompleted, isCurrent, index);
      },
    );
  }

  Widget _buildTimelineItem(
    Map<String, dynamic> milestone,
    bool isCompleted,
    bool isCurrent,
    int index,
  ) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          children: [
            Container(
              width: 8.w,
              height: 8.w,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: isCompleted
                    ? AppTheme.successGreen
                    : isCurrent
                        ? AppTheme.chronosGold
                        : AppTheme.dividerSubtle,
                border: Border.all(
                  color: isCompleted
                      ? AppTheme.successGreen
                      : isCurrent
                          ? AppTheme.chronosGold
                          : AppTheme.dividerSubtle,
                  width: 2,
                ),
              ),
              child: Center(
                child: isCompleted
                    ? CustomIconWidget(
                        iconName: 'check',
                        color: AppTheme.textPrimary,
                        size: 16,
                      )
                    : isCurrent
                        ? Container(
                            width: 2.w,
                            height: 2.w,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: AppTheme.textPrimary,
                            ),
                          )
                        : Container(),
              ),
            ),
            if (index < milestones.length - 1)
              Container(
                width: 2,
                height: 6.h,
                color: isCompleted
                    ? AppTheme.successGreen.withValues(alpha: 0.3)
                    : AppTheme.dividerSubtle,
              ),
          ],
        ),
        SizedBox(width: 4.w),
        Expanded(
          child: Container(
            padding: EdgeInsets.all(3.w),
            decoration: BoxDecoration(
              color: isCurrent
                  ? AppTheme.chronosGold.withValues(alpha: 0.1)
                  : AppTheme.surfaceDark.withValues(alpha: 0.5),
              borderRadius: BorderRadius.circular(12.0),
              border: isCurrent
                  ? Border.all(
                      color: AppTheme.chronosGold.withValues(alpha: 0.3),
                      width: 1,
                    )
                  : null,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        milestone["title"] as String,
                        style:
                            AppTheme.darkTheme.textTheme.titleSmall?.copyWith(
                          fontWeight: FontWeight.w600,
                          color: isCurrent ? AppTheme.chronosGold : null,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(
                          horizontal: 2.w, vertical: 0.5.h),
                      decoration: BoxDecoration(
                        color:
                            _getProgressColor(milestone["progress"] as double)
                                .withValues(alpha: 0.2),
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      child: Text(
                        "${(milestone["progress"] as double).toStringAsFixed(0)}%",
                        style:
                            AppTheme.darkTheme.textTheme.labelSmall?.copyWith(
                          color: _getProgressColor(
                              milestone["progress"] as double),
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 1.h),
                Text(
                  milestone["description"] as String,
                  style: AppTheme.darkTheme.textTheme.bodySmall?.copyWith(
                    color: AppTheme.textSecondary,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: 1.h),
                Row(
                  children: [
                    CustomIconWidget(
                      iconName: 'schedule',
                      color: AppTheme.textTertiary,
                      size: 14,
                    ),
                    SizedBox(width: 1.w),
                    Text(
                      milestone["estimatedDate"] as String,
                      style: AppTheme.darkTheme.textTheme.bodySmall?.copyWith(
                        color: AppTheme.textTertiary,
                      ),
                    ),
                    Spacer(),
                    Text(
                      "\$${(milestone["targetAmount"] as double).toStringAsFixed(0)}",
                      style: AppTheme.financialDataSmall.copyWith(
                        color: isCompleted
                            ? AppTheme.successGreen
                            : AppTheme.chronosGold,
                      ),
                    ),
                  ],
                ),
                if (milestone["aiTip"] != null) ...[
                  SizedBox(height: 1.h),
                  Container(
                    padding: EdgeInsets.all(2.w),
                    decoration: BoxDecoration(
                      color: AppTheme.chronosGold.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(8.0),
                      border: Border.all(
                        color: AppTheme.chronosGold.withValues(alpha: 0.2),
                        width: 1,
                      ),
                    ),
                    child: Row(
                      children: [
                        CustomIconWidget(
                          iconName: 'lightbulb',
                          color: AppTheme.chronosGold,
                          size: 12,
                        ),
                        SizedBox(width: 1.w),
                        Expanded(
                          child: Text(
                            milestone["aiTip"] as String,
                            style: AppTheme.darkTheme.textTheme.bodySmall
                                ?.copyWith(
                              color: AppTheme.chronosGold,
                              fontSize: 10.sp,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ],
            ),
          ),
        ),
      ],
    );
  }

  Color _getProgressColor(double progress) {
    if (progress >= 100) return AppTheme.successGreen;
    if (progress >= 75) return AppTheme.chronosGold;
    if (progress >= 50) return AppTheme.warningAmber;
    return AppTheme.textSecondary;
  }
}
