import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';

class ConfirmationButtonWidget extends StatefulWidget {
  final bool isEnabled;
  final bool isLoading;
  final double amount;
  final VoidCallback onPressed;

  const ConfirmationButtonWidget({
    super.key,
    required this.isEnabled,
    required this.isLoading,
    required this.amount,
    required this.onPressed,
  });

  @override
  State<ConfirmationButtonWidget> createState() =>
      _ConfirmationButtonWidgetState();
}

class _ConfirmationButtonWidgetState extends State<ConfirmationButtonWidget>
    with TickerProviderStateMixin {
  late AnimationController _pulseController;
  late Animation<double> _pulseAnimation;

  @override
  void initState() {
    super.initState();
    _pulseController =
        AnimationController(duration: const Duration(seconds: 2), vsync: this)
          ..repeat();

    _pulseAnimation = Tween<double>(begin: 1.0, end: 1.1).animate(
        CurvedAnimation(parent: _pulseController, curve: Curves.easeInOut));
  }

  @override
  void dispose() {
    _pulseController.dispose();
    super.dispose();
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
    return Container(
        padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 2.h),
        child: Column(children: [
          if (widget.isEnabled && !widget.isLoading) ...[
            Container(
                width: double.infinity,
                padding: EdgeInsets.all(4.w),
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          AppTheme.chronosGold.withValues(alpha: 0.2),
                          AppTheme.chronosGold.withValues(alpha: 0.1),
                        ]),
                    borderRadius: BorderRadius.circular(16.0),
                    border: Border.all(
                        color: AppTheme.chronosGold.withValues(alpha: 0.5),
                        width: 1.0)),
                child: Column(children: [
                  Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                    CustomIconWidget(
                        iconName: 'verified',
                        color: AppTheme.chronosGold,
                        size: 6.w),
                    SizedBox(width: 2.w),
                    Text('Ready to Invest',
                        style: AppTheme.darkTheme.textTheme.titleMedium
                            ?.copyWith(
                                fontWeight: FontWeight.w600,
                                color: AppTheme.chronosGold)),
                  ]),
                  SizedBox(height: 1.h),
                  Text(
                      'Your investment of ${_formatAmount(widget.amount)} will be allocated according to the AI recommendations.',
                      style: AppTheme.darkTheme.textTheme.bodyMedium
                          ?.copyWith(color: AppTheme.textSecondary)),
                ])),
            SizedBox(height: 2.h),
          ],
          AnimatedBuilder(
              animation: _pulseAnimation,
              builder: (context, child) {
                return Transform.scale(
                    scale: widget.isEnabled && !widget.isLoading
                        ? _pulseAnimation.value
                        : 1.0,
                    child: Container(
                        width: double.infinity,
                        height: 6.h,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16.0),
                            boxShadow: widget.isEnabled && !widget.isLoading
                                ? [
                                    BoxShadow(
                                        color: AppTheme.chronosGold
                                            .withValues(alpha: 0.4),
                                        blurRadius: 20.0,
                                        offset: const Offset(0, 8)),
                                  ]
                                : null),
                        child: ElevatedButton(
                            onPressed: widget.isEnabled && !widget.isLoading
                                ? widget.onPressed
                                : null,
                            style: ElevatedButton.styleFrom(
                                backgroundColor: widget.isEnabled
                                    ? AppTheme.chronosGold
                                    : AppTheme.dividerSubtle,
                                foregroundColor: widget.isEnabled
                                    ? AppTheme.primaryCharcoal
                                    : AppTheme.textTertiary,
                                elevation: widget.isEnabled ? 8.0 : 0.0,
                                shadowColor: widget.isEnabled
                                    ? AppTheme.chronosGold
                                        .withValues(alpha: 0.5)
                                    : Colors.transparent,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(16.0))),
                            child: widget.isLoading
                                ? Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                        SizedBox(
                                            width: 5.w,
                                            height: 5.w,
                                            child: CircularProgressIndicator(
                                                strokeWidth: 2.0,
                                                valueColor:
                                                    AlwaysStoppedAnimation<
                                                            Color>(
                                                        AppTheme
                                                            .primaryCharcoal))),
                                        SizedBox(width: 3.w),
                                        Text('Processing Investment...',
                                            style: AppTheme
                                                .darkTheme.textTheme.titleMedium
                                                ?.copyWith(
                                                    fontWeight: FontWeight.w600,
                                                    color: AppTheme
                                                        .primaryCharcoal)),
                                      ])
                                : Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                        CustomIconWidget(
                                            iconName: widget.isEnabled
                                                ? 'check_circle'
                                                : 'block',
                                            color: widget.isEnabled
                                                ? AppTheme.primaryCharcoal
                                                : AppTheme.textTertiary,
                                            size: 5.w),
                                        SizedBox(width: 2.w),
                                        Text(
                                            widget.isEnabled
                                                ? 'Confirm Investment'
                                                : 'Complete Setup First',
                                            style: AppTheme
                                                .darkTheme.textTheme.titleMedium
                                                ?.copyWith(
                                                    fontWeight: FontWeight.w600,
                                                    color: widget.isEnabled
                                                        ? AppTheme
                                                            .primaryCharcoal
                                                        : AppTheme
                                                            .textTertiary)),
                                      ]))));
              }),
          if (!widget.isEnabled) ...[
            SizedBox(height: 1.h),
            Text('Please wait for AI recommendations to load',
                style: AppTheme.darkTheme.textTheme.bodySmall
                    ?.copyWith(color: AppTheme.textTertiary)),
          ],
        ]));
  }
}
