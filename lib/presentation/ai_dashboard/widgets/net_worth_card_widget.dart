import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';

class NetWorthCardWidget extends StatefulWidget {
  const NetWorthCardWidget({super.key});

  @override
  State<NetWorthCardWidget> createState() => _NetWorthCardWidgetState();
}

class _NetWorthCardWidgetState extends State<NetWorthCardWidget>
    with TickerProviderStateMixin {
  late AnimationController _growthController;
  late Animation<double> _growthAnimation;
  late AnimationController _sparkleController;
  late Animation<double> _sparkleAnimation;

  final double _netWorth = 127500.0;
  final double _growthPercentage = 12.4;

  @override
  void initState() {
    super.initState();
    _growthController = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    );
    _growthAnimation = Tween<double>(
      begin: 0.0,
      end: _netWorth,
    ).animate(CurvedAnimation(
      parent: _growthController,
      curve: Curves.easeOutCubic,
    ));

    _sparkleController = AnimationController(
      duration: AppTheme.aiAnimation,
      vsync: this,
    )..repeat(reverse: true);
    _sparkleAnimation = Tween<double>(
      begin: 0.5,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _sparkleController,
      curve: Curves.easeInOut,
    ));

    _growthController.forward();
  }

  @override
  void dispose() {
    _growthController.dispose();
    _sparkleController.dispose();
    super.dispose();
  }

  String _formatCurrency(double amount) {
    if (amount >= 1000000) {
      return '\$${(amount / 1000000).toStringAsFixed(1)}M';
    } else if (amount >= 1000) {
      return '\$${(amount / 1000).toStringAsFixed(1)}K';
    } else {
      return '\$${amount.toStringAsFixed(0)}';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
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
              Text(
                'Total Net Worth',
                style: AppTheme.darkTheme.textTheme.titleMedium?.copyWith(
                  color: AppTheme.textSecondary,
                ),
              ),
              AnimatedBuilder(
                animation: _sparkleAnimation,
                builder: (context, child) {
                  return Container(
                    padding:
                        EdgeInsets.symmetric(horizontal: 3.w, vertical: 1.h),
                    decoration: BoxDecoration(
                      color: AppTheme.successGreen.withValues(alpha: 0.2),
                      borderRadius: BorderRadius.circular(20.0),
                      border: Border.all(
                        color: AppTheme.successGreen
                            .withValues(alpha: _sparkleAnimation.value),
                        width: 1.0,
                      ),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        CustomIconWidget(
                          iconName: 'trending_up',
                          color: AppTheme.successGreen,
                          size: 4.w,
                        ),
                        SizedBox(width: 1.w),
                        Text(
                          '+${_growthPercentage.toStringAsFixed(1)}%',
                          style: AppTheme.darkTheme.textTheme.labelMedium
                              ?.copyWith(
                            color: AppTheme.successGreen,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ],
          ),
          SizedBox(height: 2.h),
          AnimatedBuilder(
            animation: _growthAnimation,
            builder: (context, child) {
              return Text(
                _formatCurrency(_growthAnimation.value),
                style: AppTheme.financialDataLarge.copyWith(
                  fontSize: 32.sp,
                  fontWeight: FontWeight.w700,
                  color: AppTheme.textPrimary,
                ),
              );
            },
          ),
          SizedBox(height: 1.h),
          Text(
            'Year-over-year growth',
            style: AppTheme.darkTheme.textTheme.bodySmall?.copyWith(
              color: AppTheme.textTertiary,
            ),
          ),
          SizedBox(height: 2.h),
          Container(
            width: double.infinity,
            height: 0.5.h,
            decoration: BoxDecoration(
              color: AppTheme.dividerSubtle,
              borderRadius: BorderRadius.circular(2.0),
            ),
            child: FractionallySizedBox(
              alignment: Alignment.centerLeft,
              widthFactor: _growthPercentage / 100,
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      AppTheme.chronosGold,
                      AppTheme.successGreen,
                    ],
                  ),
                  borderRadius: BorderRadius.circular(2.0),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
