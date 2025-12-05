import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';

class AiRecommendationsWidget extends StatelessWidget {
  final bool isApproved;
  final double creditLimit;

  const AiRecommendationsWidget({
    Key? key,
    required this.isApproved,
    required this.creditLimit,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> recommendations = isApproved
        ? _getApprovedRecommendations()
        : _getDeclinedRecommendations();

    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 3.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: EdgeInsets.all(2.w),
                decoration: BoxDecoration(
                  color: AppTheme.accentBlue.withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: CustomIconWidget(
                  iconName: 'psychology',
                  color: AppTheme.accentBlue,
                  size: 5.w,
                ),
              ),
              SizedBox(width: 3.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'AI Insights',
                      style:
                          AppTheme.lightTheme.textTheme.titleMedium?.copyWith(
                        color: AppTheme.textPrimary,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      isApproved
                          ? 'Personalized recommendations for your credit'
                          : 'Tips to improve your approval chances',
                      style: AppTheme.lightTheme.textTheme.bodySmall?.copyWith(
                        color: AppTheme.textSecondary,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 3.h),
          ...recommendations
              .map((recommendation) => _buildRecommendationCard(recommendation))
              .toList(),
        ],
      ),
    );
  }

  List<Map<String, dynamic>> _getApprovedRecommendations() {
    return [
      {
        'icon': 'trending_up',
        'title': 'Optimal Usage',
        'description':
            'Keep your utilization below 30% (\$${(creditLimit * 0.3).toStringAsFixed(0)}) to maintain excellent credit health.',
        'color': AppTheme.successGreen,
      },
      {
        'icon': 'schedule',
        'title': 'Payment Strategy',
        'description':
            'Set up autopay for the minimum amount and pay extra when possible to save on interest.',
        'color': AppTheme.primaryGold,
      },
      {
        'icon': 'savings',
        'title': 'LifeX Integration',
        'description':
            'Link with LifeX to automatically save 10% of your credit limit for emergency fund building.',
        'color': AppTheme.accentBlue,
      },
    ];
  }

  List<Map<String, dynamic>> _getDeclinedRecommendations() {
    return [
      {
        'icon': 'account_balance',
        'title': 'Build Credit History',
        'description':
            'Consider a secured credit card or becoming an authorized user to establish credit history.',
        'color': AppTheme.primaryGold,
      },
      {
        'icon': 'trending_down',
        'title': 'Reduce Debt-to-Income',
        'description':
            'Pay down existing debts or increase income to improve your debt-to-income ratio.',
        'color': AppTheme.warningOrange,
      },
      {
        'icon': 'schedule',
        'title': 'Reapply Timeline',
        'description':
            'Wait 3-6 months before reapplying to allow credit improvements to reflect in your score.',
        'color': AppTheme.accentBlue,
      },
    ];
  }

  Widget _buildRecommendationCard(Map<String, dynamic> recommendation) {
    final String icon = recommendation['icon'] as String;
    final String title = recommendation['title'] as String;
    final String description = recommendation['description'] as String;
    final Color color = recommendation['color'] as Color;

    return Container(
      width: double.infinity,
      margin: EdgeInsets.only(bottom: 2.h),
      padding: EdgeInsets.all(4.w),
      decoration: BoxDecoration(
        color: AppTheme.surfaceDark,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: color.withValues(alpha: 0.3),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.all(2.w),
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.2),
              borderRadius: BorderRadius.circular(8),
            ),
            child: CustomIconWidget(
              iconName: icon,
              color: color,
              size: 5.w,
            ),
          ),
          SizedBox(width: 3.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: AppTheme.lightTheme.textTheme.titleSmall?.copyWith(
                    color: AppTheme.textPrimary,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: 1.h),
                Text(
                  description,
                  style: AppTheme.lightTheme.textTheme.bodyMedium?.copyWith(
                    color: AppTheme.textSecondary,
                    height: 1.4,
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
