import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';

class BudgetRulesToggleWidget extends StatelessWidget {
  final Map<String, bool> budgetRules;
  final Function(String, bool) onRuleToggled;

  const BudgetRulesToggleWidget({
    super.key,
    required this.budgetRules,
    required this.onRuleToggled,
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
                iconName: 'rule',
                color: AppTheme.chronosGold,
                size: 6.w,
              ),
              SizedBox(width: 2.w),
              Text(
                'Budget Rules',
                style: AppTheme.darkTheme.textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          SizedBox(height: 1.h),
          Text(
            'Activate automatic budget rules to stay on track',
            style: AppTheme.darkTheme.textTheme.bodyMedium?.copyWith(
              color: AppTheme.textSecondary,
            ),
          ),
          SizedBox(height: 2.h),
          ...budgetRules.entries.map((entry) {
            final ruleName = entry.key;
            final isActive = entry.value;

            return Container(
              margin: EdgeInsets.only(bottom: 2.h),
              padding: EdgeInsets.all(3.w),
              decoration: BoxDecoration(
                color: AppTheme.primaryCharcoal.withValues(alpha: 0.3),
                borderRadius: BorderRadius.circular(12.0),
                border: isActive
                    ? Border.all(
                        color: AppTheme.chronosGold.withValues(alpha: 0.3),
                        width: 1.0,
                      )
                    : null,
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          ruleName,
                          style: AppTheme.darkTheme.textTheme.titleMedium
                              ?.copyWith(
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        SizedBox(height: 0.5.h),
                        Text(
                          _getRuleDescription(ruleName),
                          style:
                              AppTheme.darkTheme.textTheme.bodySmall?.copyWith(
                            color: AppTheme.textSecondary,
                            height: 1.3,
                          ),
                        ),
                        if (isActive) ...[
                          SizedBox(height: 1.h),
                          Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 2.w, vertical: 0.5.h),
                            decoration: BoxDecoration(
                              color:
                                  AppTheme.chronosGold.withValues(alpha: 0.1),
                              borderRadius: BorderRadius.circular(6.0),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                CustomIconWidget(
                                  iconName: 'check_circle',
                                  color: AppTheme.chronosGold,
                                  size: 3.w,
                                ),
                                SizedBox(width: 1.w),
                                Text(
                                  'Active',
                                  style: AppTheme.darkTheme.textTheme.labelSmall
                                      ?.copyWith(
                                    color: AppTheme.chronosGold,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ],
                    ),
                  ),
                  Switch(
                    value: isActive,
                    onChanged: (value) => onRuleToggled(ruleName, value),
                    activeColor: AppTheme.chronosGold,
                    activeTrackColor:
                        AppTheme.chronosGold.withValues(alpha: 0.3),
                    inactiveThumbColor: AppTheme.textTertiary,
                    inactiveTrackColor: AppTheme.dividerSubtle,
                  ),
                ],
              ),
            );
          }).toList(),
        ],
      ),
    );
  }

  String _getRuleDescription(String ruleName) {
    switch (ruleName) {
      case '50/30/20 Rule':
        return '50% needs, 30% wants, 20% savings and debt repayment';
      case 'Envelope Method':
        return 'Allocate specific amounts to spending categories';
      case 'Zero-Based Budget':
        return 'Every dollar is assigned a specific purpose';
      case 'Pay Yourself First':
        return 'Prioritize savings before any other expenses';
      default:
        return 'Automatic budget rule for better financial management';
    }
  }
}
