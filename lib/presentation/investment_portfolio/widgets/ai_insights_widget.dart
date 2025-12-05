import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';

class AiInsightsWidget extends StatelessWidget {
  final List<Map<String, dynamic>> insights;

  const AiInsightsWidget({
    super.key,
    required this.insights,
  });

  IconData _getInsightIcon(String type) {
    switch (type.toLowerCase()) {
      case 'recommendation':
        return Icons.lightbulb_outline;
      case 'warning':
        return Icons.warning_amber_outlined;
      case 'opportunity':
        return Icons.trending_up;
      case 'rebalance':
        return Icons.balance;
      default:
        return Icons.info_outline;
    }
  }

  Color _getInsightColor(String type) {
    switch (type.toLowerCase()) {
      case 'recommendation':
        return AppTheme.chronosGold;
      case 'warning':
        return AppTheme.warningAmber;
      case 'opportunity':
        return AppTheme.successGreen;
      case 'rebalance':
        return AppTheme.chronosGold;
      default:
        return AppTheme.textSecondary;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 4.w, vertical: 2.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: EdgeInsets.all(2.w),
                decoration: BoxDecoration(
                  color: AppTheme.chronosGold.withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: CustomIconWidget(
                  iconName: 'psychology',
                  color: AppTheme.chronosGold,
                  size: 20,
                ),
              ),
              SizedBox(width: 3.w),
              Text(
                'AI Insights & Recommendations',
                style: AppTheme.darkTheme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          SizedBox(height: 2.h),
          ListView.separated(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: insights.length,
            separatorBuilder: (context, index) => SizedBox(height: 2.h),
            itemBuilder: (context, index) {
              final insight = insights[index];
              return Container(
                padding: EdgeInsets.all(4.w),
                decoration: BoxDecoration(
                  color: AppTheme.darkTheme.colorScheme.surface,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: _getInsightColor(insight['type'] as String)
                        .withValues(alpha: 0.3),
                    width: 1,
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        CustomIconWidget(
                          iconName: _getInsightIcon(insight['type'] as String)
                              .codePoint
                              .toString(),
                          color: _getInsightColor(insight['type'] as String),
                          size: 18,
                        ),
                        SizedBox(width: 2.w),
                        Expanded(
                          child: Text(
                            insight['title'] as String,
                            style: AppTheme.darkTheme.textTheme.titleSmall
                                ?.copyWith(
                              color:
                                  _getInsightColor(insight['type'] as String),
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        if (insight['priority'] == 'high')
                          Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 2.w, vertical: 0.5.h),
                            decoration: BoxDecoration(
                              color: AppTheme.errorRed.withValues(alpha: 0.2),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Text(
                              'High Priority',
                              style: AppTheme.darkTheme.textTheme.bodySmall
                                  ?.copyWith(
                                color: AppTheme.errorRed,
                                fontSize: 10.sp,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                      ],
                    ),
                    SizedBox(height: 1.h),
                    Text(
                      insight['description'] as String,
                      style: AppTheme.darkTheme.textTheme.bodyMedium?.copyWith(
                        color: AppTheme.textSecondary,
                        height: 1.4,
                      ),
                    ),
                    if (insight['action'] != null) ...[
                      SizedBox(height: 2.h),
                      SizedBox(
                        width: double.infinity,
                        child: OutlinedButton(
                          onPressed: () {
                            // Handle insight action
                          },
                          style: OutlinedButton.styleFrom(
                            side: BorderSide(
                              color:
                                  _getInsightColor(insight['type'] as String),
                              width: 1,
                            ),
                            foregroundColor:
                                _getInsightColor(insight['type'] as String),
                          ),
                          child: Text(insight['action'] as String),
                        ),
                      ),
                    ],
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
