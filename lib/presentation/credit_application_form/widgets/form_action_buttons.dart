import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';

class FormActionButtons extends StatelessWidget {
  final VoidCallback onSaveProgress;
  final VoidCallback onSubmitApplication;
  final bool isSubmitting;
  final bool canSubmit;

  const FormActionButtons({
    super.key,
    required this.onSaveProgress,
    required this.onSubmitApplication,
    required this.isSubmitting,
    required this.canSubmit,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(4.w),
      decoration: BoxDecoration(
        color: AppTheme.surfaceDark,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
        boxShadow: [
          BoxShadow(
            color: AppTheme.shadowDark,
            blurRadius: 10,
            offset: Offset(0, -2),
          ),
        ],
      ),
      child: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: isSubmitting ? null : onSaveProgress,
                    icon: CustomIconWidget(
                      iconName: 'save',
                      color: AppTheme.primaryGold,
                      size: 20,
                    ),
                    label: Text('Save Progress'),
                    style: OutlinedButton.styleFrom(
                      padding: EdgeInsets.symmetric(vertical: 2.h),
                      side: BorderSide(
                        color: AppTheme.primaryGold.withValues(alpha: 0.8),
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 4.w),
                Expanded(
                  flex: 2,
                  child: ElevatedButton.icon(
                    onPressed:
                        canSubmit && !isSubmitting ? onSubmitApplication : null,
                    icon: isSubmitting
                        ? SizedBox(
                            width: 20,
                            height: 20,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              valueColor: AlwaysStoppedAnimation<Color>(
                                  AppTheme.backgroundDark),
                            ),
                          )
                        : CustomIconWidget(
                            iconName: 'send',
                            color: AppTheme.backgroundDark,
                            size: 20,
                          ),
                    label: Text(
                      isSubmitting ? 'Submitting...' : 'Submit Application',
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: canSubmit
                          ? AppTheme.primaryGold
                          : AppTheme.neutralGray,
                      foregroundColor: AppTheme.backgroundDark,
                      padding: EdgeInsets.symmetric(vertical: 2.h),
                    ),
                  ),
                ),
              ],
            ),
            if (!canSubmit) ...[
              SizedBox(height: 2.h),
              Container(
                padding: EdgeInsets.all(3.w),
                decoration: BoxDecoration(
                  color: AppTheme.warningOrange.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                    color: AppTheme.warningOrange.withValues(alpha: 0.3),
                  ),
                ),
                child: Row(
                  children: [
                    CustomIconWidget(
                      iconName: 'info',
                      color: AppTheme.warningOrange,
                      size: 20,
                    ),
                    SizedBox(width: 2.w),
                    Expanded(
                      child: Text(
                        'Please complete all required fields to submit your application.',
                        style: AppTheme.darkTheme.textTheme.bodySmall?.copyWith(
                          color: AppTheme.warningOrange,
                        ),
                      ),
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
}
