import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../../core/app_export.dart';

class AiInsightsSection extends StatelessWidget {
  final List<Map<String, dynamic>> insights;

  const AiInsightsSection({
    Key? key,
    required this.insights,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 4.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Section header
          Row(
            children: [
              Container(
                padding: EdgeInsets.all(2.w),
                decoration: BoxDecoration(
                  color: AppTheme.chronosGold.withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: CustomIconWidget(
                  iconName: 'psychology',
                  color: AppTheme.chronosGold,
                  size: 6.w,
                ),
              ),
              SizedBox(width: 3.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'AI Risk Insights',
                      style: AppTheme.darkTheme.textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      'Personalized recommendations for risk optimization',
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
          // Insights list
          ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: insights.length,
            separatorBuilder: (context, index) => SizedBox(height: 2.h),
            itemBuilder: (context, index) {
              final insight = insights[index];
              return _buildInsightCard(insight);
            },
          ),
        ],
      ),
    );
  }

  Widget _buildInsightCard(Map<String, dynamic> insight) {
    final difficulty = insight['difficulty'] as String;
    final impact = insight['impact'] as String;

    return Container(
      padding: EdgeInsets.all(4.w),
      decoration: BoxDecoration(
        color: AppTheme.darkTheme.colorScheme.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: AppTheme.chronosGold.withValues(alpha: 0.2),
        ),
        boxShadow: [
          BoxShadow(
            color: AppTheme.darkTheme.colorScheme.shadow,
            blurRadius: 8.0,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header with category and priority
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 1.w),
                decoration: BoxDecoration(
                  color: _getCategoryColor(insight['category'] as String)
                      .withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  insight['category'] as String,
                  style: AppTheme.darkTheme.textTheme.bodySmall?.copyWith(
                    color: _getCategoryColor(insight['category'] as String),
                    fontWeight: FontWeight.w500,
                    fontSize: 9.sp,
                  ),
                ),
              ),
              Row(
                children: [
                  CustomIconWidget(
                    iconName: 'priority_high',
                    color: _getPriorityColor(insight['priority'] as String),
                    size: 4.w,
                  ),
                  SizedBox(width: 1.w),
                  Text(
                    insight['priority'] as String,
                    style: AppTheme.darkTheme.textTheme.bodySmall?.copyWith(
                      color: _getPriorityColor(insight['priority'] as String),
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: 2.h),
          // Insight title
          Text(
            insight['title'] as String,
            style: AppTheme.darkTheme.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: 1.h),
          // Insight description
          Text(
            insight['description'] as String,
            style: AppTheme.darkTheme.textTheme.bodyMedium?.copyWith(
              color: AppTheme.textSecondary,
              height: 1.4,
            ),
          ),
          SizedBox(height: 2.h),
          // Metrics row
          Row(
            children: [
              Expanded(
                child: _buildMetricChip(
                  'Difficulty',
                  difficulty,
                  _getDifficultyColor(difficulty),
                  _getDifficultyIcon(difficulty),
                ),
              ),
              SizedBox(width: 2.w),
              Expanded(
                child: _buildMetricChip(
                  'Impact',
                  impact,
                  _getImpactColor(impact),
                  _getImpactIcon(impact),
                ),
              ),
            ],
          ),
          SizedBox(height: 2.h),
          // Action button
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                // Handle implementation action
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppTheme.chronosGold.withValues(alpha: 0.1),
                foregroundColor: AppTheme.chronosGold,
                elevation: 0,
                padding: EdgeInsets.symmetric(vertical: 2.h),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                  side: BorderSide(
                    color: AppTheme.chronosGold.withValues(alpha: 0.3),
                  ),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CustomIconWidget(
                    iconName: 'play_arrow',
                    color: AppTheme.chronosGold,
                    size: 5.w,
                  ),
                  SizedBox(width: 2.w),
                  Text(
                    'Implement Strategy',
                    style: AppTheme.darkTheme.textTheme.titleSmall?.copyWith(
                      color: AppTheme.chronosGold,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMetricChip(
      String label, String value, Color color, String iconName) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 1.5.w),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: color.withValues(alpha: 0.3),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CustomIconWidget(
            iconName: iconName,
            color: color,
            size: 4.w,
          ),
          SizedBox(width: 1.w),
          Column(
            children: [
              Text(
                label,
                style: AppTheme.darkTheme.textTheme.bodySmall?.copyWith(
                  color: AppTheme.textTertiary,
                  fontSize: 8.sp,
                ),
              ),
              Text(
                value,
                style: AppTheme.darkTheme.textTheme.bodySmall?.copyWith(
                  color: color,
                  fontWeight: FontWeight.w600,
                  fontSize: 9.sp,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Color _getCategoryColor(String category) {
    switch (category.toLowerCase()) {
      case 'emergency fund':
        return AppTheme.successGreen;
      case 'diversification':
        return AppTheme.warningAmber;
      case 'credit management':
        return AppTheme.errorRed;
      default:
        return AppTheme.chronosGold;
    }
  }

  Color _getPriorityColor(String priority) {
    switch (priority.toLowerCase()) {
      case 'high':
        return AppTheme.errorRed;
      case 'medium':
        return AppTheme.warningAmber;
      case 'low':
        return AppTheme.successGreen;
      default:
        return AppTheme.textSecondary;
    }
  }

  Color _getDifficultyColor(String difficulty) {
    switch (difficulty.toLowerCase()) {
      case 'easy':
        return AppTheme.successGreen;
      case 'medium':
        return AppTheme.warningAmber;
      case 'hard':
        return AppTheme.errorRed;
      default:
        return AppTheme.textSecondary;
    }
  }

  String _getDifficultyIcon(String difficulty) {
    switch (difficulty.toLowerCase()) {
      case 'easy':
        return 'sentiment_satisfied';
      case 'medium':
        return 'sentiment_neutral';
      case 'hard':
        return 'sentiment_dissatisfied';
      default:
        return 'help_outline';
    }
  }

  Color _getImpactColor(String impact) {
    switch (impact.toLowerCase()) {
      case 'high':
        return AppTheme.successGreen;
      case 'medium':
        return AppTheme.warningAmber;
      case 'low':
        return AppTheme.errorRed;
      default:
        return AppTheme.textSecondary;
    }
  }

  String _getImpactIcon(String impact) {
    switch (impact.toLowerCase()) {
      case 'high':
        return 'trending_up';
      case 'medium':
        return 'trending_flat';
      case 'low':
        return 'trending_down';
      default:
        return 'help_outline';
    }
  }
}
