import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';

class CreditLimitDisplayWidget extends StatefulWidget {
  final double creditLimit;
  final bool isVisible;

  const CreditLimitDisplayWidget({
    Key? key,
    required this.creditLimit,
    required this.isVisible,
  }) : super(key: key);

  @override
  State<CreditLimitDisplayWidget> createState() =>
      _CreditLimitDisplayWidgetState();
}

class _CreditLimitDisplayWidgetState extends State<CreditLimitDisplayWidget>
    with TickerProviderStateMixin {
  late AnimationController _countUpController;
  late AnimationController _scaleController;
  late Animation<double> _countUpAnimation;
  late Animation<double> _scaleAnimation;

  double _displayedAmount = 0.0;

  @override
  void initState() {
    super.initState();
    _initializeAnimations();
  }

  void _initializeAnimations() {
    _countUpController = AnimationController(
      duration: const Duration(milliseconds: 2000),
      vsync: this,
    );

    _scaleController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );

    _countUpAnimation = Tween<double>(
      begin: 0.0,
      end: widget.creditLimit,
    ).animate(CurvedAnimation(
      parent: _countUpController,
      curve: Curves.easeOutCubic,
    ));

    _scaleAnimation = Tween<double>(
      begin: 0.8,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _scaleController,
      curve: Curves.elasticOut,
    ));

    _countUpController.addListener(() {
      setState(() {
        _displayedAmount = _countUpAnimation.value;
      });
    });
  }

  @override
  void didUpdateWidget(CreditLimitDisplayWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.isVisible && !oldWidget.isVisible) {
      _startAnimations();
    }
  }

  void _startAnimations() {
    _scaleController.forward();
    Future.delayed(const Duration(milliseconds: 300), () {
      _countUpController.forward();
    });
  }

  @override
  void dispose() {
    _countUpController.dispose();
    _scaleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!widget.isVisible) {
      return const SizedBox.shrink();
    }

    return AnimatedBuilder(
      animation: Listenable.merge([_scaleAnimation, _countUpAnimation]),
      builder: (context, child) {
        return Transform.scale(
          scale: _scaleAnimation.value,
          child: Container(
            width: 85.w,
            padding: EdgeInsets.all(5.w),
            margin: EdgeInsets.symmetric(vertical: 2.h),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  AppTheme.primaryGold.withValues(alpha: 0.1),
                  AppTheme.primaryGold.withValues(alpha: 0.05),
                ],
              ),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                color: AppTheme.primaryGold.withValues(alpha: 0.3),
                width: 1.5,
              ),
            ),
            child: Column(
              children: [
                Text(
                  'Estimated Credit Limit',
                  style: AppTheme.darkTheme.textTheme.titleMedium?.copyWith(
                    color: AppTheme.textSecondary,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(height: 1.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '\$',
                      style:
                          AppTheme.darkTheme.textTheme.headlineMedium?.copyWith(
                        color: AppTheme.primaryGold,
                        fontWeight: FontWeight.w700,
                        height: 1.2,
                      ),
                    ),
                    Text(
                      _displayedAmount.toStringAsFixed(0),
                      style:
                          AppTheme.darkTheme.textTheme.displayMedium?.copyWith(
                        color: AppTheme.primaryGold,
                        fontWeight: FontWeight.w800,
                        height: 1.0,
                        letterSpacing: -1.0,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 1.h),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 1.h),
                  decoration: BoxDecoration(
                    color: AppTheme.successGreen.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      color: AppTheme.successGreen.withValues(alpha: 0.3),
                      width: 1,
                    ),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      CustomIconWidget(
                        iconName: 'check_circle',
                        color: AppTheme.successGreen,
                        size: 4.w,
                      ),
                      SizedBox(width: 2.w),
                      Text(
                        'Pre-Approved',
                        style:
                            AppTheme.darkTheme.textTheme.bodyMedium?.copyWith(
                          color: AppTheme.successGreen,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 2.h),
                Text(
                  'Based on your Chronos account history and credit profile',
                  textAlign: TextAlign.center,
                  style: AppTheme.darkTheme.textTheme.bodySmall?.copyWith(
                    color: AppTheme.textSecondary,
                    height: 1.4,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
