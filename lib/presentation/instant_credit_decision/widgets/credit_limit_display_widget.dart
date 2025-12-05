import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';

class CreditLimitDisplayWidget extends StatefulWidget {
  final double creditLimit;
  final bool isApproved;

  const CreditLimitDisplayWidget({
    Key? key,
    required this.creditLimit,
    required this.isApproved,
  }) : super(key: key);

  @override
  State<CreditLimitDisplayWidget> createState() =>
      _CreditLimitDisplayWidgetState();
}

class _CreditLimitDisplayWidgetState extends State<CreditLimitDisplayWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _countUpController;
  late Animation<double> _countUpAnimation;

  @override
  void initState() {
    super.initState();
    _initializeAnimation();
  }

  void _initializeAnimation() {
    _countUpController = AnimationController(
      duration: const Duration(milliseconds: 2000),
      vsync: this,
    );

    _countUpAnimation = Tween<double>(
      begin: 0.0,
      end: widget.creditLimit,
    ).animate(CurvedAnimation(
      parent: _countUpController,
      curve: Curves.easeOutCubic,
    ));

    // Start animation after a delay
    Future.delayed(const Duration(milliseconds: 1500), () {
      if (mounted && widget.isApproved) {
        _countUpController.forward();
      }
    });
  }

  @override
  void dispose() {
    _countUpController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 4.h),
      child: Column(
        children: [
          Text(
            widget.isApproved ? 'Credit Approved!' : 'Application Status',
            style: AppTheme.lightTheme.textTheme.headlineSmall?.copyWith(
              color:
                  widget.isApproved ? AppTheme.successGreen : AppTheme.errorRed,
              fontWeight: FontWeight.w700,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 2.h),
          if (widget.isApproved) ...[
            Text(
              'Your Credit Limit',
              style: AppTheme.lightTheme.textTheme.bodyLarge?.copyWith(
                color: AppTheme.textSecondary,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 1.h),
            AnimatedBuilder(
              animation: _countUpAnimation,
              builder: (context, child) {
                return Text(
                  '\$${_countUpAnimation.value.toStringAsFixed(0)}',
                  style: AppTheme.lightTheme.textTheme.displayMedium?.copyWith(
                    color: AppTheme.primaryGold,
                    fontWeight: FontWeight.w800,
                    letterSpacing: -1.0,
                  ),
                  textAlign: TextAlign.center,
                );
              },
            ),
            SizedBox(height: 1.h),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 1.h),
              decoration: BoxDecoration(
                color: AppTheme.successGreen.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(
                  color: AppTheme.successGreen.withValues(alpha: 0.3),
                ),
              ),
              child: Text(
                'Available for immediate use',
                style: AppTheme.lightTheme.textTheme.bodyMedium?.copyWith(
                  color: AppTheme.successGreen,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ] else ...[
            Container(
              padding: EdgeInsets.all(4.w),
              decoration: BoxDecoration(
                color: AppTheme.errorRed.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: AppTheme.errorRed.withValues(alpha: 0.3),
                ),
              ),
              child: Column(
                children: [
                  CustomIconWidget(
                    iconName: 'info_outline',
                    color: AppTheme.errorRed,
                    size: 6.w,
                  ),
                  SizedBox(height: 2.h),
                  Text(
                    'Application Under Review',
                    style: AppTheme.lightTheme.textTheme.titleMedium?.copyWith(
                      color: AppTheme.errorRed,
                      fontWeight: FontWeight.w600,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 1.h),
                  Text(
                    'We need additional information to process your application. Our team will contact you within 24 hours.',
                    style: AppTheme.lightTheme.textTheme.bodyMedium?.copyWith(
                      color: AppTheme.textSecondary,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }
}
