import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../../core/app_export.dart';

class ContinueButtonWidget extends StatelessWidget {
  final bool isEnabled;
  final VoidCallback onPressed;

  const ContinueButtonWidget({
    super.key,
    required this.isEnabled,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 2.h),
      child: AnimatedContainer(
        duration: AppTheme.standardAnimation,
        child: ElevatedButton(
          onPressed: isEnabled ? onPressed : null,
          style: ElevatedButton.styleFrom(
            backgroundColor:
                isEnabled ? AppTheme.chronosGold : AppTheme.dividerSubtle,
            foregroundColor:
                isEnabled ? AppTheme.primaryCharcoal : AppTheme.textTertiary,
            padding: EdgeInsets.symmetric(vertical: 2.h),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16.0),
            ),
            elevation: isEnabled ? 4.0 : 0.0,
            shadowColor: isEnabled
                ? AppTheme.chronosGold.withValues(alpha: 0.3)
                : Colors.transparent,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Continue',
                style: AppTheme.darkTheme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                  color: isEnabled
                      ? AppTheme.primaryCharcoal
                      : AppTheme.textTertiary,
                ),
              ),
              SizedBox(width: 2.w),
              CustomIconWidget(
                iconName: 'arrow_forward',
                color: isEnabled
                    ? AppTheme.primaryCharcoal
                    : AppTheme.textTertiary,
                size: 5.w,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
