import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';

class InvestmentPreviewWidget extends StatefulWidget {
  final double amount;
  final double duration;
  final String? riskLevel;
  final double projectedReturns;

  const InvestmentPreviewWidget({
    super.key,
    required this.amount,
    required this.duration,
    required this.riskLevel,
    required this.projectedReturns,
  });

  @override
  State<InvestmentPreviewWidget> createState() =>
      _InvestmentPreviewWidgetState();
}

class _InvestmentPreviewWidgetState extends State<InvestmentPreviewWidget>
    with TickerProviderStateMixin {
  late AnimationController _numberController;
  late Animation<double> _numberAnimation;

  @override
  void initState() {
    super.initState();
    _numberController = AnimationController(
      duration: AppTheme.aiAnimation,
      vsync: this,
    );
    _numberAnimation = Tween<double>(
      begin: 0.0,
      end: widget.projectedReturns,
    ).animate(CurvedAnimation(
      parent: _numberController,
      curve: Curves.easeOutCubic,
    ));
  }

  @override
  void didUpdateWidget(InvestmentPreviewWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.projectedReturns != widget.projectedReturns) {
      _numberAnimation = Tween<double>(
        begin: oldWidget.projectedReturns,
        end: widget.projectedReturns,
      ).animate(CurvedAnimation(
        parent: _numberController,
        curve: Curves.easeOutCubic,
      ));
      _numberController.reset();
      _numberController.forward();
    }
  }

  @override
  void dispose() {
    _numberController.dispose();
    super.dispose();
  }

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

  @override
  Widget build(BuildContext context) {
    if (widget.amount <= 0 || widget.riskLevel == null) {
      return const SizedBox.shrink();
    }

    _numberController.forward();

    return Container(
      padding: EdgeInsets.all(4.w),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            AppTheme.chronosGold.withValues(alpha: 0.1),
            AppTheme.chronosGold.withValues(alpha: 0.05),
          ],
        ),
        borderRadius: BorderRadius.circular(20.0),
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
              CustomIconWidget(
                iconName: 'analytics',
                color: AppTheme.chronosGold,
                size: 6.w,
              ),
              SizedBox(width: 2.w),
              Text(
                'Projected Returns',
                style: AppTheme.darkTheme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                  color: AppTheme.chronosGold,
                ),
              ),
            ],
          ),
          SizedBox(height: 3.h),
          Row(
            children: [
              Expanded(
                child: _StatCard(
                  label: 'Initial Investment',
                  value: _formatAmount(widget.amount),
                  icon: 'account_balance_wallet',
                ),
              ),
              SizedBox(width: 3.w),
              Expanded(
                child: _StatCard(
                  label: 'Duration',
                  value: _formatDuration(widget.duration),
                  icon: 'schedule',
                ),
              ),
            ],
          ),
          SizedBox(height: 2.h),
          Container(
            width: double.infinity,
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
              children: [
                Text(
                  'Estimated Profit',
                  style: AppTheme.darkTheme.textTheme.bodyMedium?.copyWith(
                    color: AppTheme.textSecondary,
                  ),
                ),
                SizedBox(height: 1.h),
                AnimatedBuilder(
                  animation: _numberAnimation,
                  builder: (context, child) {
                    return Text(
                      _formatAmount(_numberAnimation.value),
                      style:
                          AppTheme.darkTheme.textTheme.headlineLarge?.copyWith(
                        fontWeight: FontWeight.w700,
                        color: AppTheme.successGreen,
                      ),
                    );
                  },
                ),
                SizedBox(height: 1.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CustomIconWidget(
                      iconName: 'trending_up',
                      color: AppTheme.successGreen,
                      size: 4.w,
                    ),
                    SizedBox(width: 1.w),
                    Text(
                      '${((widget.projectedReturns / widget.amount) * 100).toStringAsFixed(1)}% return',
                      style: AppTheme.darkTheme.textTheme.bodyMedium?.copyWith(
                        color: AppTheme.successGreen,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ],
            ),
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
                    'This is an estimate based on historical data. Actual returns may vary.',
                    style: AppTheme.darkTheme.textTheme.bodySmall?.copyWith(
                      color: AppTheme.textSecondary,
                      fontSize: 11.sp,
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

class _StatCard extends StatelessWidget {
  final String label;
  final String value;
  final String icon;

  const _StatCard({
    required this.label,
    required this.value,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(3.w),
      decoration: BoxDecoration(
        color: AppTheme.surfaceDark,
        borderRadius: BorderRadius.circular(12.0),
        border: Border.all(
          color: AppTheme.dividerSubtle,
          width: 1.0,
        ),
      ),
      child: Column(
        children: [
          CustomIconWidget(
            iconName: icon,
            color: AppTheme.textSecondary,
            size: 5.w,
          ),
          SizedBox(height: 1.h),
          Text(
            value,
            style: AppTheme.darkTheme.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: 0.5.h),
          Text(
            label,
            style: AppTheme.darkTheme.textTheme.bodySmall?.copyWith(
              color: AppTheme.textSecondary,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
