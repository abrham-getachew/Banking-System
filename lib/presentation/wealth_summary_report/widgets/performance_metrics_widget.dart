import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';

class PerformanceMetricsWidget extends StatelessWidget {
  final double portfolioReturn;
  final double volatility;
  final double sharpeRatio;

  const PerformanceMetricsWidget({
    super.key,
    required this.portfolioReturn,
    required this.volatility,
    required this.sharpeRatio,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 4.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 4.w),
            child: Text(
              'Performance Metrics',
              style: AppTheme.darkTheme.textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          SizedBox(height: 2.h),
          Row(
            children: [
              Expanded(
                child: _buildMetricCard(
                  title: 'Portfolio Return',
                  value: '${portfolioReturn.toStringAsFixed(1)}%',
                  subtitle: 'YTD Performance',
                  color: portfolioReturn >= 0
                      ? AppTheme.successGreen
                      : AppTheme.errorRed,
                  icon: 'trending_up',
                ),
              ),
              SizedBox(width: 2.w),
              Expanded(
                child: _buildMetricCard(
                  title: 'Volatility',
                  value: '${volatility.toStringAsFixed(1)}%',
                  subtitle: 'Risk Measure',
                  color: AppTheme.warningAmber,
                  icon: 'bar_chart',
                ),
              ),
              SizedBox(width: 2.w),
              Expanded(
                child: _buildMetricCard(
                  title: 'Sharpe Ratio',
                  value: sharpeRatio.toStringAsFixed(2),
                  subtitle: 'Risk-Adj. Return',
                  color: AppTheme.chronosGold,
                  icon: 'show_chart',
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildMetricCard({
    required String title,
    required String value,
    required String subtitle,
    required Color color,
    required String icon,
  }) {
    return Container(
      padding: EdgeInsets.all(4.w),
      decoration: BoxDecoration(
        color: AppTheme.surfaceDark,
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: Column(
        children: [
          Container(
            width: 12.w,
            height: 12.w,
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: CustomIconWidget(
              iconName: icon,
              color: color,
              size: 6.w,
            ),
          ),
          SizedBox(height: 2.h),
          Text(
            value,
            style: AppTheme.financialDataMedium.copyWith(
              color: color,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: 0.5.h),
          Text(
            title,
            style: AppTheme.darkTheme.textTheme.bodySmall?.copyWith(
              fontWeight: FontWeight.w500,
            ),
            textAlign: TextAlign.center,
          ),
          Text(
            subtitle,
            style: AppTheme.darkTheme.textTheme.labelSmall?.copyWith(
              color: AppTheme.textTertiary,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
