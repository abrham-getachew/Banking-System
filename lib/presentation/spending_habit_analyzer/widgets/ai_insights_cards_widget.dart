import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';

class AiInsightsCardsWidget extends StatelessWidget {
  final List<String> insights;

  const AiInsightsCardsWidget({
    super.key,
    required this.insights,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 4.w),
          child: Row(
            children: [
              CustomIconWidget(
                iconName: 'psychology',
                color: AppTheme.chronosGold,
                size: 6.w,
              ),
              SizedBox(width: 2.w),
              Text(
                'AI Insights & Recommendations',
                style: AppTheme.darkTheme.textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 2.h),
        SizedBox(
          height: 20.h,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            padding: EdgeInsets.symmetric(horizontal: 4.w),
            itemCount: insights.length,
            itemBuilder: (context, index) {
              final insight = insights[index];
              final isOverspending =
                  insight.toLowerCase().contains('overspending');
              final isSaving = insight.toLowerCase().contains('below budget') ||
                  insight.toLowerCase().contains('great job') ||
                  insight.toLowerCase().contains('dropped');

              return Container(
                width: 70.w,
                margin: EdgeInsets.only(right: 3.w),
                padding: EdgeInsets.all(4.w),
                decoration: BoxDecoration(
                  color: AppTheme.surfaceDark,
                  borderRadius: BorderRadius.circular(16.0),
                  border: Border.all(
                    color: _getInsightColor(isOverspending, isSaving)
                        .withValues(alpha: 0.3),
                    width: 1.0,
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          width: 8.w,
                          height: 8.w,
                          decoration: BoxDecoration(
                            color: _getInsightColor(isOverspending, isSaving)
                                .withValues(alpha: 0.1),
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          child: CustomIconWidget(
                            iconName: _getInsightIcon(isOverspending, isSaving),
                            color: _getInsightColor(isOverspending, isSaving),
                            size: 4.w,
                          ),
                        ),
                        SizedBox(width: 2.w),
                        Expanded(
                          child: Text(
                            _getInsightType(isOverspending, isSaving),
                            style: AppTheme.darkTheme.textTheme.labelMedium
                                ?.copyWith(
                              color: _getInsightColor(isOverspending, isSaving),
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 2.h),
                    Expanded(
                      child: Text(
                        insight,
                        style:
                            AppTheme.darkTheme.textTheme.bodyMedium?.copyWith(
                          height: 1.4,
                        ),
                      ),
                    ),
                    if (isOverspending) ...[
                      SizedBox(height: 1.h),
                      Container(
                        width: double.infinity,
                        padding: EdgeInsets.symmetric(vertical: 1.h),
                        decoration: BoxDecoration(
                          color: AppTheme.chronosGold.withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        child: Text(
                          'Tap for solutions',
                          textAlign: TextAlign.center,
                          style:
                              AppTheme.darkTheme.textTheme.labelSmall?.copyWith(
                            color: AppTheme.chronosGold,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Color _getInsightColor(bool isOverspending, bool isSaving) {
    if (isOverspending) return AppTheme.errorRed;
    if (isSaving) return AppTheme.successGreen;
    return AppTheme.chronosGold;
  }

  String _getInsightIcon(bool isOverspending, bool isSaving) {
    if (isOverspending) return 'warning';
    if (isSaving) return 'check_circle';
    return 'lightbulb';
  }

  String _getInsightType(bool isOverspending, bool isSaving) {
    if (isOverspending) return 'Overspending Alert';
    if (isSaving) return 'Great Progress';
    return 'Smart Insight';
  }
}
