import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';

class PlanCardWidget extends StatelessWidget {
  final Map<String, dynamic> planData;
  final bool isSelected;
  final bool isRecommended;
  final VoidCallback onTap;

  const PlanCardWidget({
    super.key,
    required this.planData,
    required this.isSelected,
    required this.isRecommended,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final monthlyPayment = planData['monthlyPayment'] as double;
    final totalInterest = planData['totalInterest'] as double;
    final totalAmount = planData['totalAmount'] as double;
    final months = planData['months'] as int;
    final title = planData['title'] as String;
    final description = planData['description'] as String;
    final affordabilityColor =
        _getAffordabilityColor(planData['affordability'] as String);

    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        margin: EdgeInsets.symmetric(horizontal: 4.w, vertical: 1.h),
        padding: EdgeInsets.all(4.w),
        decoration: BoxDecoration(
          color: isSelected
              ? AppTheme.primaryGold.withValues(alpha: 0.1)
              : AppTheme.darkTheme.cardColor,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isSelected
                ? AppTheme.primaryGold
                : AppTheme.primaryGold.withValues(alpha: 0.2),
            width: isSelected ? 2 : 1,
          ),
          boxShadow: isSelected
              ? [
                  BoxShadow(
                    color: AppTheme.primaryGold.withValues(alpha: 0.3),
                    blurRadius: 12,
                    offset: const Offset(0, 4),
                  ),
                ]
              : [
                  BoxShadow(
                    color: AppTheme.shadowDark,
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header with title and recommendation badge
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style:
                            AppTheme.darkTheme.textTheme.titleLarge?.copyWith(
                          color: isSelected
                              ? AppTheme.primaryGold
                              : AppTheme.textPrimary,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      SizedBox(height: 0.5.h),
                      Text(
                        description,
                        style: AppTheme.darkTheme.textTheme.bodySmall?.copyWith(
                          color: AppTheme.textSecondary,
                        ),
                      ),
                    ],
                  ),
                ),
                if (isRecommended)
                  Container(
                    padding:
                        EdgeInsets.symmetric(horizontal: 3.w, vertical: 0.5.h),
                    decoration: BoxDecoration(
                      color: AppTheme.primaryGold,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        CustomIconWidget(
                          iconName: 'auto_awesome',
                          color: AppTheme.backgroundDark,
                          size: 14,
                        ),
                        SizedBox(width: 1.w),
                        Text(
                          'AI Pick',
                          style:
                              AppTheme.darkTheme.textTheme.labelSmall?.copyWith(
                            color: AppTheme.backgroundDark,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
              ],
            ),

            SizedBox(height: 3.h),

            // Monthly payment amount
            Row(
              children: [
                CustomIconWidget(
                  iconName: 'payments',
                  color: AppTheme.primaryGold,
                  size: 20,
                ),
                SizedBox(width: 2.w),
                Text(
                  'Monthly Payment',
                  style: AppTheme.darkTheme.textTheme.bodyMedium?.copyWith(
                    color: AppTheme.textSecondary,
                  ),
                ),
              ],
            ),
            SizedBox(height: 1.h),
            Text(
              '\$${monthlyPayment.toStringAsFixed(2)}',
              style: AppTheme.darkTheme.textTheme.headlineMedium?.copyWith(
                color: AppTheme.primaryGold,
                fontWeight: FontWeight.w700,
              ),
            ),

            SizedBox(height: 2.h),

            // Financial details
            Container(
              padding: EdgeInsets.all(3.w),
              decoration: BoxDecoration(
                color: AppTheme.backgroundDark.withValues(alpha: 0.5),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: AppTheme.primaryGold.withValues(alpha: 0.1),
                ),
              ),
              child: Column(
                children: [
                  _buildDetailRow('Total Interest',
                      '\$${totalInterest.toStringAsFixed(2)}'),
                  SizedBox(height: 1.h),
                  _buildDetailRow(
                      'Total Repayable', '\$${totalAmount.toStringAsFixed(2)}'),
                  SizedBox(height: 1.h),
                  _buildDetailRow('Duration', '$months months'),
                ],
              ),
            ),

            SizedBox(height: 2.h),

            // Affordability indicator
            Row(
              children: [
                Container(
                  width: 12,
                  height: 12,
                  decoration: BoxDecoration(
                    color: affordabilityColor,
                    shape: BoxShape.circle,
                  ),
                ),
                SizedBox(width: 2.w),
                Text(
                  _getAffordabilityText(planData['affordability'] as String),
                  style: AppTheme.darkTheme.textTheme.bodySmall?.copyWith(
                    color: affordabilityColor,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: AppTheme.darkTheme.textTheme.bodySmall?.copyWith(
            color: AppTheme.textSecondary,
          ),
        ),
        Text(
          value,
          style: AppTheme.darkTheme.textTheme.bodySmall?.copyWith(
            color: AppTheme.textPrimary,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }

  Color _getAffordabilityColor(String affordability) {
    switch (affordability.toLowerCase()) {
      case 'excellent':
        return AppTheme.successGreen;
      case 'good':
        return AppTheme.primaryGold;
      case 'moderate':
        return AppTheme.warningOrange;
      default:
        return AppTheme.textSecondary;
    }
  }

  String _getAffordabilityText(String affordability) {
    switch (affordability.toLowerCase()) {
      case 'excellent':
        return 'Excellent Affordability';
      case 'good':
        return 'Good Affordability';
      case 'moderate':
        return 'Moderate Affordability';
      default:
        return 'Check Affordability';
    }
  }
}
