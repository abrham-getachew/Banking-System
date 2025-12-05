import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../../core/app_export.dart';

class RiskBreakdownModal extends StatelessWidget {
  final int overallRiskScore;
  final Map<String, dynamic> riskBreakdown;

  const RiskBreakdownModal({
    Key? key,
    required this.overallRiskScore,
    required this.riskBreakdown,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 85.h,
      decoration: BoxDecoration(
        color: AppTheme.darkTheme.colorScheme.surface,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
      ),
      child: Column(
        children: [
          // Handle bar
          Container(
            margin: EdgeInsets.only(top: 2.h),
            width: 12.w,
            height: 1.w,
            decoration: BoxDecoration(
              color: AppTheme.textTertiary.withValues(alpha: 0.5),
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          // Header
          Padding(
            padding: EdgeInsets.all(4.w),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Risk Breakdown',
                      style:
                          AppTheme.darkTheme.textTheme.headlineSmall?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      'Detailed analysis of your risk profile',
                      style: AppTheme.darkTheme.textTheme.bodyMedium?.copyWith(
                        color: AppTheme.textSecondary,
                      ),
                    ),
                  ],
                ),
                IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: CustomIconWidget(
                    iconName: 'close',
                    color: AppTheme.textSecondary,
                    size: 6.w,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 4.w),
              child: Column(
                children: [
                  // Overall score card
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(4.w),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          _getRiskColor(overallRiskScore)
                              .withValues(alpha: 0.2),
                          _getRiskColor(overallRiskScore)
                              .withValues(alpha: 0.1),
                        ],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(
                        color: _getRiskColor(overallRiskScore)
                            .withValues(alpha: 0.3),
                      ),
                    ),
                    child: Column(
                      children: [
                        Text(
                          'Overall Risk Score',
                          style: AppTheme.darkTheme.textTheme.titleMedium
                              ?.copyWith(
                            color: AppTheme.textSecondary,
                          ),
                        ),
                        SizedBox(height: 1.h),
                        Text(
                          '$overallRiskScore',
                          style: AppTheme.darkTheme.textTheme.displayMedium
                              ?.copyWith(
                            color: _getRiskColor(overallRiskScore),
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        SizedBox(height: 1.h),
                        Text(
                          _getRiskLabel(overallRiskScore),
                          style:
                              AppTheme.darkTheme.textTheme.titleLarge?.copyWith(
                            color: _getRiskColor(overallRiskScore),
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 3.h),
                  // Risk components
                  ..._buildRiskComponents(),
                  SizedBox(height: 3.h),
                  // Risk explanation
                  _buildRiskExplanation(),
                  SizedBox(height: 2.h),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  List<Widget> _buildRiskComponents() {
    final components =
        riskBreakdown['components'] as List<Map<String, dynamic>>;

    return components.map((component) {
      return Container(
        margin: EdgeInsets.only(bottom: 2.h),
        padding: EdgeInsets.all(4.w),
        decoration: BoxDecoration(
          color: AppTheme.darkTheme.scaffoldBackgroundColor,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: AppTheme.dividerSubtle,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Container(
                      padding: EdgeInsets.all(2.w),
                      decoration: BoxDecoration(
                        color:
                            _getComponentColor(component['category'] as String)
                                .withValues(alpha: 0.2),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: CustomIconWidget(
                        iconName: component['icon'] as String,
                        color:
                            _getComponentColor(component['category'] as String),
                        size: 5.w,
                      ),
                    ),
                    SizedBox(width: 3.w),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          component['name'] as String,
                          style: AppTheme.darkTheme.textTheme.titleMedium
                              ?.copyWith(
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Text(
                          component['category'] as String,
                          style:
                              AppTheme.darkTheme.textTheme.bodySmall?.copyWith(
                            color: AppTheme.textSecondary,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      '${component['score']}',
                      style:
                          AppTheme.darkTheme.textTheme.headlineSmall?.copyWith(
                        color:
                            _getComponentColor(component['category'] as String),
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    Text(
                      '${component['weight']}% weight',
                      style: AppTheme.darkTheme.textTheme.bodySmall?.copyWith(
                        color: AppTheme.textTertiary,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: 2.h),
            Text(
              component['description'] as String,
              style: AppTheme.darkTheme.textTheme.bodyMedium?.copyWith(
                color: AppTheme.textSecondary,
                height: 1.4,
              ),
            ),
            SizedBox(height: 2.h),
            // Progress bar
            Row(
              children: [
                Expanded(
                  child: Container(
                    height: 1.h,
                    decoration: BoxDecoration(
                      color: AppTheme.dividerSubtle,
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: FractionallySizedBox(
                      alignment: Alignment.centerLeft,
                      widthFactor: (component['score'] as int) / 100.0,
                      child: Container(
                        decoration: BoxDecoration(
                          color: _getComponentColor(
                              component['category'] as String),
                          borderRadius: BorderRadius.circular(4),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 2.w),
                Text(
                  '${component['score']}/100',
                  style: AppTheme.darkTheme.textTheme.bodySmall?.copyWith(
                    color: _getComponentColor(component['category'] as String),
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ],
        ),
      );
    }).toList();
  }

  Widget _buildRiskExplanation() {
    return Container(
      padding: EdgeInsets.all(4.w),
      decoration: BoxDecoration(
        color: AppTheme.chronosGold.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: AppTheme.chronosGold.withValues(alpha: 0.2),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CustomIconWidget(
                iconName: 'info_outline',
                color: AppTheme.chronosGold,
                size: 5.w,
              ),
              SizedBox(width: 2.w),
              Text(
                'How Risk Score is Calculated',
                style: AppTheme.darkTheme.textTheme.titleMedium?.copyWith(
                  color: AppTheme.chronosGold,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          SizedBox(height: 2.h),
          Text(
            'Your risk score is calculated using a weighted average of multiple factors including portfolio diversification, emergency fund ratio, credit exposure, and market volatility impact. Each component is scored from 0-100 and weighted based on its importance to your overall financial risk profile.',
            style: AppTheme.darkTheme.textTheme.bodyMedium?.copyWith(
              color: AppTheme.textSecondary,
              height: 1.4,
            ),
          ),
          SizedBox(height: 2.h),
          Row(
            children: [
              _buildRiskRange('0-30', 'Conservative', AppTheme.successGreen),
              SizedBox(width: 2.w),
              _buildRiskRange('31-70', 'Moderate', AppTheme.warningAmber),
              SizedBox(width: 2.w),
              _buildRiskRange('71-100', 'Aggressive', AppTheme.errorRed),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildRiskRange(String range, String label, Color color) {
    return Expanded(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 2.w, vertical: 1.5.w),
        decoration: BoxDecoration(
          color: color.withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: color.withValues(alpha: 0.3),
          ),
        ),
        child: Column(
          children: [
            Text(
              range,
              style: AppTheme.darkTheme.textTheme.bodySmall?.copyWith(
                color: color,
                fontWeight: FontWeight.w700,
              ),
            ),
            Text(
              label,
              style: AppTheme.darkTheme.textTheme.bodySmall?.copyWith(
                color: color,
                fontSize: 8.sp,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Color _getRiskColor(int score) {
    if (score <= 30) return AppTheme.successGreen;
    if (score <= 70) return AppTheme.warningAmber;
    return AppTheme.errorRed;
  }

  String _getRiskLabel(int score) {
    if (score <= 30) return 'Conservative';
    if (score <= 70) return 'Moderate';
    return 'Aggressive';
  }

  Color _getComponentColor(String category) {
    switch (category.toLowerCase()) {
      case 'diversification':
        return AppTheme.successGreen;
      case 'emergency fund':
        return AppTheme.warningAmber;
      case 'credit exposure':
        return AppTheme.errorRed;
      case 'market volatility':
        return AppTheme.chronosGold;
      default:
        return AppTheme.textSecondary;
    }
  }
}
