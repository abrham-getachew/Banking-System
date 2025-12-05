import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';

class GoalCardWidget extends StatelessWidget {
  final Map<String, dynamic> goal;
  final VoidCallback? onTap;
  final VoidCallback? onAddMoney;
  final VoidCallback? onAdjustTarget;
  final VoidCallback? onShareProgress;
  final VoidCallback? onViewPlan;

  const GoalCardWidget({
    Key? key,
    required this.goal,
    this.onTap,
    this.onAddMoney,
    this.onAdjustTarget,
    this.onShareProgress,
    this.onViewPlan,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double progress =
        (goal["currentAmount"] as double) / (goal["targetAmount"] as double);
    final bool isCompleted = progress >= 1.0;

    return Container(
      margin: EdgeInsets.symmetric(horizontal: 4.w, vertical: 1.h),
      child: Card(
        elevation: AppTheme.elevationResting,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.0),
        ),
        child: InkWell(
          onTap: onTap,
          onLongPress: () => _showContextMenu(context),
          borderRadius: BorderRadius.circular(16.0),
          child: Container(
            padding: EdgeInsets.all(4.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildGoalHeader(),
                SizedBox(height: 2.h),
                _buildProgressSection(progress, isCompleted),
                SizedBox(height: 2.h),
                _buildGoalDetails(),
                if (goal["aiSuggestion"] != null) ...[
                  SizedBox(height: 2.h),
                  _buildAISuggestion(),
                ],
                SizedBox(height: 2.h),
                _buildActionButtons(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildGoalHeader() {
    return Row(
      children: [
        Container(
          width: 12.w,
          height: 12.w,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8.0),
            image: DecorationImage(
              image: NetworkImage(goal["image"] as String),
              fit: BoxFit.cover,
            ),
          ),
        ),
        SizedBox(width: 3.w),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                goal["title"] as String,
                style: AppTheme.darkTheme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              SizedBox(height: 0.5.h),
              Text(
                goal["category"] as String,
                style: AppTheme.darkTheme.textTheme.bodySmall?.copyWith(
                  color: AppTheme.textSecondary,
                ),
              ),
            ],
          ),
        ),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 2.w, vertical: 0.5.h),
          decoration: BoxDecoration(
            color: _getStatusColor().withValues(alpha: 0.2),
            borderRadius: BorderRadius.circular(12.0),
          ),
          child: Text(
            goal["status"] as String,
            style: AppTheme.darkTheme.textTheme.labelSmall?.copyWith(
              color: _getStatusColor(),
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildProgressSection(double progress, bool isCompleted) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "\$${(goal["currentAmount"] as double).toStringAsFixed(0)}",
              style: AppTheme.financialDataMedium.copyWith(
                color:
                    isCompleted ? AppTheme.successGreen : AppTheme.chronosGold,
              ),
            ),
            Text(
              "\$${(goal["targetAmount"] as double).toStringAsFixed(0)}",
              style: AppTheme.darkTheme.textTheme.bodyMedium?.copyWith(
                color: AppTheme.textSecondary,
              ),
            ),
          ],
        ),
        SizedBox(height: 1.h),
        ClipRRect(
          borderRadius: BorderRadius.circular(8.0),
          child: LinearProgressIndicator(
            value: progress > 1.0 ? 1.0 : progress,
            backgroundColor: AppTheme.dividerSubtle,
            valueColor: AlwaysStoppedAnimation<Color>(
              isCompleted ? AppTheme.successGreen : AppTheme.chronosGold,
            ),
            minHeight: 1.h,
          ),
        ),
        SizedBox(height: 1.h),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "${(progress * 100).toStringAsFixed(1)}% Complete",
              style: AppTheme.darkTheme.textTheme.bodySmall?.copyWith(
                color: isCompleted
                    ? AppTheme.successGreen
                    : AppTheme.textSecondary,
                fontWeight: FontWeight.w500,
              ),
            ),
            if (!isCompleted)
              Text(
                "Est. ${goal["estimatedCompletion"]}",
                style: AppTheme.darkTheme.textTheme.bodySmall?.copyWith(
                  color: AppTheme.textTertiary,
                ),
              ),
          ],
        ),
      ],
    );
  }

  Widget _buildGoalDetails() {
    return Container(
      padding: EdgeInsets.all(3.w),
      decoration: BoxDecoration(
        color: AppTheme.surfaceDark.withValues(alpha: 0.5),
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: Row(
        children: [
          Expanded(
            child: _buildDetailItem(
              "Monthly",
              "\$${(goal["monthlyContribution"] as double).toStringAsFixed(0)}",
              CustomIconWidget(
                iconName: 'calendar_today',
                color: AppTheme.chronosGold,
                size: 16,
              ),
            ),
          ),
          Container(
            width: 1,
            height: 4.h,
            color: AppTheme.dividerSubtle,
          ),
          Expanded(
            child: _buildDetailItem(
              "Timeline",
              "${goal["timelineMonths"]} months",
              CustomIconWidget(
                iconName: 'schedule',
                color: AppTheme.successGreen,
                size: 16,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDetailItem(String label, String value, Widget icon) {
    return Column(
      children: [
        icon,
        SizedBox(height: 0.5.h),
        Text(
          value,
          style: AppTheme.darkTheme.textTheme.titleSmall?.copyWith(
            fontWeight: FontWeight.w600,
          ),
          textAlign: TextAlign.center,
        ),
        Text(
          label,
          style: AppTheme.darkTheme.textTheme.bodySmall?.copyWith(
            color: AppTheme.textTertiary,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  Widget _buildAISuggestion() {
    return Container(
      padding: EdgeInsets.all(3.w),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            AppTheme.chronosGold.withValues(alpha: 0.1),
            AppTheme.chronosGold.withValues(alpha: 0.05),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(12.0),
        border: Border.all(
          color: AppTheme.chronosGold.withValues(alpha: 0.3),
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CustomIconWidget(
                iconName: 'auto_awesome',
                color: AppTheme.chronosGold,
                size: 16,
              ),
              SizedBox(width: 2.w),
              Text(
                "AI Suggestion",
                style: AppTheme.darkTheme.textTheme.labelMedium?.copyWith(
                  color: AppTheme.chronosGold,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          SizedBox(height: 1.h),
          Text(
            goal["aiSuggestion"] as String,
            style: AppTheme.darkTheme.textTheme.bodySmall?.copyWith(
              color: AppTheme.textSecondary,
            ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }

  Widget _buildActionButtons() {
    return Row(
      children: [
        Expanded(
          child: OutlinedButton.icon(
            onPressed: onAddMoney,
            icon: CustomIconWidget(
              iconName: 'add',
              color: AppTheme.chronosGold,
              size: 16,
            ),
            label: Text("Add Money"),
            style: OutlinedButton.styleFrom(
              padding: EdgeInsets.symmetric(vertical: 1.5.h),
            ),
          ),
        ),
        SizedBox(width: 2.w),
        if (goal["aiSuggestion"] != null)
          Expanded(
            child: ElevatedButton.icon(
              onPressed: onViewPlan,
              icon: CustomIconWidget(
                iconName: 'lightbulb',
                color: AppTheme.primaryCharcoal,
                size: 16,
              ),
              label: Text("View Plan"),
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(vertical: 1.5.h),
              ),
            ),
          ),
      ],
    );
  }

  Color _getStatusColor() {
    switch (goal["status"] as String) {
      case "On Track":
        return AppTheme.successGreen;
      case "Behind":
        return AppTheme.warningAmber;
      case "Completed":
        return AppTheme.successGreen;
      default:
        return AppTheme.textSecondary;
    }
  }

  void _showContextMenu(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: AppTheme.surfaceDark,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20.0)),
      ),
      builder: (context) => Container(
        padding: EdgeInsets.all(4.w),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 10.w,
              height: 0.5.h,
              decoration: BoxDecoration(
                color: AppTheme.dividerSubtle,
                borderRadius: BorderRadius.circular(2.0),
              ),
            ),
            SizedBox(height: 2.h),
            ListTile(
              leading: CustomIconWidget(
                iconName: 'edit',
                color: AppTheme.chronosGold,
                size: 24,
              ),
              title: Text("Edit Goal"),
              onTap: () {
                Navigator.pop(context);
                // Handle edit action
              },
            ),
            ListTile(
              leading: CustomIconWidget(
                iconName: 'tune',
                color: AppTheme.successGreen,
                size: 24,
              ),
              title: Text("Adjust Target"),
              onTap: () {
                Navigator.pop(context);
                onAdjustTarget?.call();
              },
            ),
            ListTile(
              leading: CustomIconWidget(
                iconName: 'share',
                color: AppTheme.textSecondary,
                size: 24,
              ),
              title: Text("Share Progress"),
              onTap: () {
                Navigator.pop(context);
                onShareProgress?.call();
              },
            ),
            ListTile(
              leading: CustomIconWidget(
                iconName: 'delete',
                color: AppTheme.errorRed,
                size: 24,
              ),
              title: Text("Delete Goal"),
              onTap: () {
                Navigator.pop(context);
                // Handle delete action
              },
            ),
            SizedBox(height: 2.h),
          ],
        ),
      ),
    );
  }
}
