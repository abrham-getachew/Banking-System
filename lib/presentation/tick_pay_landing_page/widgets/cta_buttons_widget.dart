import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sizer/sizer.dart';

import '../../../../core/app_export.dart';

class CtaButtonsWidget extends StatelessWidget {
  const CtaButtonsWidget({super.key});

  void _handleGetStarted(BuildContext context) {
    HapticFeedback.mediumImpact();
    Navigator.pushNamed(context, '/credit-eligibility-preview');
  }

  void _handleHowItWorks(BuildContext context) {
    HapticFeedback.lightImpact();
    Navigator.pushNamed(context, '/how-it-works-tutorial');
  }

  void _handleCheckEligibility(BuildContext context) {
    HapticFeedback.lightImpact();
    Navigator.pushNamed(context, '/credit-eligibility-preview');
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 6.w),
      child: Column(
        children: [
          // Primary CTA - Get Started
          SizedBox(
            width: double.infinity,
            height: 7.h,
            child: ElevatedButton(
              onPressed: () => _handleGetStarted(context),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppTheme.primaryGold,
                foregroundColor: AppTheme.backgroundDark,
                elevation: 4,
                shadowColor: AppTheme.primaryGold.withValues(alpha: 0.3),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Get Started',
                    style: AppTheme.darkTheme.textTheme.titleMedium?.copyWith(
                      color: AppTheme.backgroundDark,
                      fontWeight: FontWeight.w600,
                      fontSize: 16.sp,
                    ),
                  ),
                  SizedBox(width: 2.w),
                  CustomIconWidget(
                    iconName: 'arrow_forward',
                    color: AppTheme.backgroundDark,
                    size: 5.w,
                  ),
                ],
              ),
            ),
          ),

          SizedBox(height: 3.h),

          // Secondary actions row
          Row(
            children: [
              Expanded(
                child: SizedBox(
                  height: 6.h,
                  child: OutlinedButton(
                    onPressed: () => _handleHowItWorks(context),
                    style: OutlinedButton.styleFrom(
                      foregroundColor: AppTheme.primaryGold,
                      side: BorderSide(
                        color: AppTheme.primaryGold.withValues(alpha: 0.6),
                        width: 1.5,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CustomIconWidget(
                          iconName: 'play_circle_outline',
                          color: AppTheme.primaryGold,
                          size: 4.w,
                        ),
                        SizedBox(width: 2.w),
                        Text(
                          'How It Works',
                          style:
                              AppTheme.darkTheme.textTheme.bodyMedium?.copyWith(
                            color: AppTheme.primaryGold,
                            fontWeight: FontWeight.w500,
                            fontSize: 14.sp,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(width: 3.w),
              Expanded(
                child: SizedBox(
                  height: 6.h,
                  child: TextButton(
                    onPressed: () => _handleCheckEligibility(context),
                    style: TextButton.styleFrom(
                      foregroundColor: AppTheme.textSecondary,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CustomIconWidget(
                          iconName: 'verified_user',
                          color: AppTheme.textSecondary,
                          size: 4.w,
                        ),
                        SizedBox(width: 2.w),
                        Text(
                          'Check Eligibility',
                          style:
                              AppTheme.darkTheme.textTheme.bodyMedium?.copyWith(
                            color: AppTheme.textSecondary,
                            fontWeight: FontWeight.w500,
                            fontSize: 14.sp,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
