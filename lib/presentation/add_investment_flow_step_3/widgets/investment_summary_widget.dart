import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';

class InvestmentSummaryWidget extends StatelessWidget {
  final Map<String, dynamic>? investmentData;
  final double amount;
  final double duration;
  final String? riskLevel;

  const InvestmentSummaryWidget({
    super.key,
    required this.investmentData,
    required this.amount,
    required this.duration,
    required this.riskLevel,
  });

  String _formatDuration(double months) {
    if (months < 12) {
      return '${months.toInt()} month${months.toInt() == 1 ? '' : 's'}';
    } else if (months == 120) {
      return '10+ years';
    } else {
      final years = (months / 12);
      return '${years.toStringAsFixed(1)} years';
    }
  }

  String _formatAmount(double amount) {
    if (amount >= 1000000) {
      return '\$${(amount / 1000000).toStringAsFixed(1)}M';
    } else if (amount >= 1000) {
      return '\$${(amount / 1000).toStringAsFixed(amount >= 10000 ? 0 : 1)}K';
    } else {
      return '\$${amount.toStringAsFixed(0)}';
    }
  }

  Color _getRiskColor(String? risk) {
    switch (risk?.toLowerCase()) {
      case 'conservative':
        return AppTheme.successGreen;
      case 'moderate':
        return AppTheme.warningAmber;
      case 'aggressive':
        return AppTheme.errorRed;
      default:
        return AppTheme.textSecondary;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(4.w),
      decoration: BoxDecoration(
        color: AppTheme.surfaceDark,
        borderRadius: BorderRadius.circular(16.0),
        border: Border.all(
          color: AppTheme.chronosGold.withValues(alpha: 0.3),
          width: 1.0,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              if (investmentData != null) ...[
                Container(
                  width: 12.w,
                  height: 12.w,
                  decoration: BoxDecoration(
                    color: AppTheme.chronosGold.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  child: CustomIconWidget(
                    iconName: investmentData!['icon'] as String,
                    color: AppTheme.chronosGold,
                    size: 6.w,
                  ),
                ),
                SizedBox(width: 3.w),
              ],
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      investmentData?['title'] ?? 'Investment Summary',
                      style: AppTheme.darkTheme.textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    if (investmentData != null)
                      Text(
                        investmentData!['description'] as String,
                        style:
                            AppTheme.darkTheme.textTheme.bodyMedium?.copyWith(
                          color: AppTheme.textSecondary,
                        ),
                      ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 1.h),
                decoration: BoxDecoration(
                  color: _getRiskColor(riskLevel).withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(12.0),
                ),
                child: Text(
                  riskLevel ?? 'N/A',
                  style: AppTheme.darkTheme.textTheme.labelMedium?.copyWith(
                    color: _getRiskColor(riskLevel),
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 3.h),
          Row(
            children: [
              Expanded(
                child: _SummaryItem(
                  icon: 'account_balance_wallet',
                  label: 'Amount',
                  value: _formatAmount(amount),
                  valueColor: AppTheme.chronosGold,
                ),
              ),
              Container(
                width: 1.0,
                height: 8.h,
                color: AppTheme.dividerSubtle,
                margin: EdgeInsets.symmetric(horizontal: 4.w),
              ),
              Expanded(
                child: _SummaryItem(
                  icon: 'schedule',
                  label: 'Duration',
                  value: _formatDuration(duration),
                  valueColor: AppTheme.textPrimary,
                ),
              ),
            ],
          ),
          SizedBox(height: 2.h),
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(3.w),
            decoration: BoxDecoration(
              color: AppTheme.primaryCharcoal,
              borderRadius: BorderRadius.circular(12.0),
            ),
            child: Row(
              children: [
                CustomIconWidget(
                  iconName: 'info',
                  color: AppTheme.warningAmber,
                  size: 4.w,
                ),
                SizedBox(width: 2.w),
                Expanded(
                  child: Text(
                    'Review the AI recommendations below and adjust allocations as needed before confirming your investment.',
                    style: AppTheme.darkTheme.textTheme.bodySmall?.copyWith(
                      color: AppTheme.textSecondary,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _SummaryItem extends StatelessWidget {
  final String icon;
  final String label;
  final String value;
  final Color valueColor;

  const _SummaryItem({
    required this.icon,
    required this.label,
    required this.value,
    required this.valueColor,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomIconWidget(
          iconName: icon,
          color: AppTheme.textSecondary,
          size: 6.w,
        ),
        SizedBox(height: 1.h),
        Text(
          value,
          style: AppTheme.darkTheme.textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.w600,
            color: valueColor,
          ),
        ),
        SizedBox(height: 0.5.h),
        Text(
          label,
          style: AppTheme.darkTheme.textTheme.bodySmall?.copyWith(
            color: AppTheme.textSecondary,
          ),
        ),
      ],
    );
  }
}
