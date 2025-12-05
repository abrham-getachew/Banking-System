import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';

class LifeXIntegrationWidget extends StatelessWidget {
  final Map<String, dynamic> selectedPlan;

  const LifeXIntegrationWidget({
    super.key,
    required this.selectedPlan,
  });

  @override
  Widget build(BuildContext context) {
    final monthlyPayment = selectedPlan['monthlyPayment'] as double;
    final impactData = _calculateBudgetImpact(monthlyPayment);

    return Container(
      margin: EdgeInsets.symmetric(horizontal: 4.w),
      padding: EdgeInsets.all(4.w),
      decoration: BoxDecoration(
        color: AppTheme.darkTheme.cardColor,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: AppTheme.accentBlue.withValues(alpha: 0.3),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header with LifeX branding
          Row(
            children: [
              Container(
                padding: EdgeInsets.all(2.w),
                decoration: BoxDecoration(
                  color: AppTheme.accentBlue.withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: CustomIconWidget(
                  iconName: 'trending_up',
                  color: AppTheme.accentBlue,
                  size: 20,
                ),
              ),
              SizedBox(width: 3.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'LifeX Budget Impact',
                      style: AppTheme.darkTheme.textTheme.titleMedium?.copyWith(
                        color: AppTheme.textPrimary,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      'How this affects your savings goals',
                      style: AppTheme.darkTheme.textTheme.bodySmall?.copyWith(
                        color: AppTheme.textSecondary,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),

          SizedBox(height: 3.h),

          // Budget impact visualization
          Container(
            padding: EdgeInsets.all(3.w),
            decoration: BoxDecoration(
              color: AppTheme.backgroundDark.withValues(alpha: 0.3),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              children: [
                // Monthly budget breakdown
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Monthly Budget',
                      style: AppTheme.darkTheme.textTheme.bodyMedium?.copyWith(
                        color: AppTheme.textSecondary,
                      ),
                    ),
                    Text(
                      '\$${impactData['totalBudget'].toStringAsFixed(0)}',
                      style: AppTheme.darkTheme.textTheme.bodyMedium?.copyWith(
                        color: AppTheme.textPrimary,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),

                SizedBox(height: 2.h),

                // Budget allocation bars
                _buildBudgetBar('Essentials',
                    impactData['essentials'] as double, AppTheme.warningOrange),
                SizedBox(height: 1.h),
                _buildBudgetBar(
                    'TickPay Payment', monthlyPayment, AppTheme.primaryGold),
                SizedBox(height: 1.h),
                _buildBudgetBar('Savings Goals',
                    impactData['savings'] as double, AppTheme.successGreen),
                SizedBox(height: 1.h),
                _buildBudgetBar('Discretionary',
                    impactData['discretionary'] as double, AppTheme.accentBlue),
              ],
            ),
          ),

          SizedBox(height: 2.h),

          // Savings goals impact
          Container(
            padding: EdgeInsets.all(3.w),
            decoration: BoxDecoration(
              color: AppTheme.successGreen.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: AppTheme.successGreen.withValues(alpha: 0.3),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    CustomIconWidget(
                      iconName: 'savings',
                      color: AppTheme.successGreen,
                      size: 16,
                    ),
                    SizedBox(width: 2.w),
                    Text(
                      'Savings Goals Impact',
                      style: AppTheme.darkTheme.textTheme.titleSmall?.copyWith(
                        color: AppTheme.successGreen,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 2.h),
                _buildGoalImpactRow('Emergency Fund', 'Delayed by 2 months',
                    AppTheme.warningOrange),
                SizedBox(height: 1.h),
                _buildGoalImpactRow(
                    'Vacation Fund', 'On track', AppTheme.successGreen),
                SizedBox(height: 1.h),
                _buildGoalImpactRow('Investment Goal', 'Reduced by 15%',
                    AppTheme.warningOrange),
              ],
            ),
          ),

          SizedBox(height: 2.h),

          // Recommendations
          Container(
            padding: EdgeInsets.all(3.w),
            decoration: BoxDecoration(
              color: AppTheme.accentBlue.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: AppTheme.accentBlue.withValues(alpha: 0.3),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    CustomIconWidget(
                      iconName: 'auto_awesome',
                      color: AppTheme.accentBlue,
                      size: 16,
                    ),
                    SizedBox(width: 2.w),
                    Text(
                      'LifeX Recommendations',
                      style: AppTheme.darkTheme.textTheme.titleSmall?.copyWith(
                        color: AppTheme.accentBlue,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 1.h),
                Text(
                  '• Consider reducing discretionary spending by \$50/month\n• Pause vacation fund contributions temporarily\n• Set up automatic payments to avoid late fees\n• Review budget in 3 months for adjustments',
                  style: AppTheme.darkTheme.textTheme.bodySmall?.copyWith(
                    color: AppTheme.textPrimary,
                    height: 1.5,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBudgetBar(String label, double amount, Color color) {
    final totalBudget = 3500.0; // Mock total budget
    final percentage = (amount / totalBudget).clamp(0.0, 1.0);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              label,
              style: AppTheme.darkTheme.textTheme.bodySmall?.copyWith(
                color: AppTheme.textSecondary,
              ),
            ),
            Text(
              '\$${amount.toStringAsFixed(0)}',
              style: AppTheme.darkTheme.textTheme.bodySmall?.copyWith(
                color: AppTheme.textPrimary,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
        SizedBox(height: 0.5.h),
        Container(
          height: 6,
          decoration: BoxDecoration(
            color: AppTheme.backgroundDark.withValues(alpha: 0.3),
            borderRadius: BorderRadius.circular(3),
          ),
          child: FractionallySizedBox(
            alignment: Alignment.centerLeft,
            widthFactor: percentage,
            child: Container(
              decoration: BoxDecoration(
                color: color,
                borderRadius: BorderRadius.circular(3),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildGoalImpactRow(String goal, String impact, Color statusColor) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          goal,
          style: AppTheme.darkTheme.textTheme.bodySmall?.copyWith(
            color: AppTheme.textPrimary,
          ),
        ),
        Text(
          impact,
          style: AppTheme.darkTheme.textTheme.bodySmall?.copyWith(
            color: statusColor,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }

  Map<String, dynamic> _calculateBudgetImpact(double monthlyPayment) {
    return {
      'totalBudget': 3500.0,
      'essentials': 1800.0,
      'savings': 600.0,
      'discretionary': 1100.0 - monthlyPayment,
    };
  }
}
