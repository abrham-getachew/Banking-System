import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';

class FinancialHealthWidget extends StatefulWidget {
  const FinancialHealthWidget({super.key});

  @override
  State<FinancialHealthWidget> createState() => _FinancialHealthWidgetState();
}

class _FinancialHealthWidgetState extends State<FinancialHealthWidget>
    with TickerProviderStateMixin {
  late AnimationController _progressController;
  late Animation<double> _emergencyFundAnimation;
  late Animation<double> _riskExposureAnimation;

  bool _isExpanded = false;
  final double _emergencyFundRatio = 0.75; // 75%
  final double _riskExposure = 0.45; // 45%

  @override
  void initState() {
    super.initState();
    _progressController = AnimationController(
      duration: const Duration(milliseconds: 2000),
      vsync: this,
    );

    _emergencyFundAnimation = Tween<double>(
      begin: 0.0,
      end: _emergencyFundRatio,
    ).animate(CurvedAnimation(
      parent: _progressController,
      curve: const Interval(0.0, 0.6, curve: Curves.easeOutCubic),
    ));

    _riskExposureAnimation = Tween<double>(
      begin: 0.0,
      end: _riskExposure,
    ).animate(CurvedAnimation(
      parent: _progressController,
      curve: const Interval(0.4, 1.0, curve: Curves.easeOutCubic),
    ));

    _progressController.forward();
  }

  @override
  void dispose() {
    _progressController.dispose();
    super.dispose();
  }

  Color _getHealthColor(double ratio) {
    if (ratio >= 0.8) return AppTheme.successGreen;
    if (ratio >= 0.6) return AppTheme.warningAmber;
    return AppTheme.errorRed;
  }

  String _getHealthStatus(double ratio) {
    if (ratio >= 0.8) return 'Excellent';
    if (ratio >= 0.6) return 'Good';
    if (ratio >= 0.4) return 'Fair';
    return 'Needs Attention';
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _isExpanded = !_isExpanded;
        });
      },
      child: Container(
        width: double.infinity,
        margin: EdgeInsets.symmetric(horizontal: 4.w, vertical: 1.h),
        padding: EdgeInsets.all(5.w),
        decoration: BoxDecoration(
          color: AppTheme.surfaceDark,
          borderRadius: BorderRadius.circular(16.0),
          boxShadow: [
            BoxShadow(
              color: AppTheme.shadowDark,
              blurRadius: 8.0,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    CustomIconWidget(
                      iconName: 'health_and_safety',
                      color: AppTheme.chronosGold,
                      size: 6.w,
                    ),
                    SizedBox(width: 3.w),
                    Text(
                      'Financial Health',
                      style: AppTheme.darkTheme.textTheme.titleLarge?.copyWith(
                        color: AppTheme.textPrimary,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
                AnimatedRotation(
                  turns: _isExpanded ? 0.5 : 0.0,
                  duration: AppTheme.standardAnimation,
                  child: CustomIconWidget(
                    iconName: 'expand_more',
                    color: AppTheme.textSecondary,
                    size: 6.w,
                  ),
                ),
              ],
            ),
            SizedBox(height: 3.h),

            // Emergency Fund Ratio
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Emergency Fund',
                            style: AppTheme.darkTheme.textTheme.bodyMedium
                                ?.copyWith(
                              color: AppTheme.textPrimary,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          AnimatedBuilder(
                            animation: _emergencyFundAnimation,
                            builder: (context, child) {
                              return Text(
                                '${(_emergencyFundAnimation.value * 100).toInt()}%',
                                style: AppTheme.financialDataSmall.copyWith(
                                  color: _getHealthColor(
                                      _emergencyFundAnimation.value),
                                  fontWeight: FontWeight.w600,
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                      SizedBox(height: 1.h),
                      AnimatedBuilder(
                        animation: _emergencyFundAnimation,
                        builder: (context, child) {
                          return LinearProgressIndicator(
                            value: _emergencyFundAnimation.value,
                            backgroundColor: AppTheme.dividerSubtle,
                            valueColor: AlwaysStoppedAnimation<Color>(
                              _getHealthColor(_emergencyFundAnimation.value),
                            ),
                            minHeight: 1.h,
                          );
                        },
                      ),
                      SizedBox(height: 0.5.h),
                      AnimatedBuilder(
                        animation: _emergencyFundAnimation,
                        builder: (context, child) {
                          return Text(
                            _getHealthStatus(_emergencyFundAnimation.value),
                            style: AppTheme.darkTheme.textTheme.bodySmall
                                ?.copyWith(
                              color: _getHealthColor(
                                  _emergencyFundAnimation.value),
                              fontWeight: FontWeight.w500,
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),

            SizedBox(height: 3.h),

            // Risk Exposure
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Risk Exposure',
                            style: AppTheme.darkTheme.textTheme.bodyMedium
                                ?.copyWith(
                              color: AppTheme.textPrimary,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          AnimatedBuilder(
                            animation: _riskExposureAnimation,
                            builder: (context, child) {
                              return Text(
                                '${(_riskExposureAnimation.value * 100).toInt()}%',
                                style: AppTheme.financialDataSmall.copyWith(
                                  color: _riskExposureAnimation.value > 0.6
                                      ? AppTheme.errorRed
                                      : _riskExposureAnimation.value > 0.4
                                          ? AppTheme.warningAmber
                                          : AppTheme.successGreen,
                                  fontWeight: FontWeight.w600,
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                      SizedBox(height: 1.h),
                      AnimatedBuilder(
                        animation: _riskExposureAnimation,
                        builder: (context, child) {
                          return LinearProgressIndicator(
                            value: _riskExposureAnimation.value,
                            backgroundColor: AppTheme.dividerSubtle,
                            valueColor: AlwaysStoppedAnimation<Color>(
                              _riskExposureAnimation.value > 0.6
                                  ? AppTheme.errorRed
                                  : _riskExposureAnimation.value > 0.4
                                      ? AppTheme.warningAmber
                                      : AppTheme.successGreen,
                            ),
                            minHeight: 1.h,
                          );
                        },
                      ),
                      SizedBox(height: 0.5.h),
                      Text(
                        'Moderate Risk',
                        style: AppTheme.darkTheme.textTheme.bodySmall?.copyWith(
                          color: AppTheme.warningAmber,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),

            if (_isExpanded) ...[
              SizedBox(height: 3.h),
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(4.w),
                decoration: BoxDecoration(
                  color: AppTheme.primaryCharcoal,
                  borderRadius: BorderRadius.circular(12.0),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Recommendations',
                      style: AppTheme.darkTheme.textTheme.titleSmall?.copyWith(
                        color: AppTheme.chronosGold,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(height: 2.h),
                    _buildRecommendationItem(
                      'Increase emergency fund to 6 months of expenses',
                      'priority_high',
                      AppTheme.warningAmber,
                    ),
                    SizedBox(height: 1.h),
                    _buildRecommendationItem(
                      'Consider diversifying high-risk investments',
                      'trending_down',
                      AppTheme.errorRed,
                    ),
                    SizedBox(height: 1.h),
                    _buildRecommendationItem(
                      'Review insurance coverage adequacy',
                      'security',
                      AppTheme.successGreen,
                    ),
                  ],
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildRecommendationItem(String text, String iconName, Color color) {
    return Row(
      children: [
        CustomIconWidget(
          iconName: iconName,
          color: color,
          size: 4.w,
        ),
        SizedBox(width: 3.w),
        Expanded(
          child: Text(
            text,
            style: AppTheme.darkTheme.textTheme.bodySmall?.copyWith(
              color: AppTheme.textSecondary,
              height: 1.4,
            ),
          ),
        ),
      ],
    );
  }
}
