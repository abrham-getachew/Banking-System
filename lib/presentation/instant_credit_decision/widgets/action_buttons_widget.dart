import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';

class ActionButtonsWidget extends StatelessWidget {
  final bool isApproved;
  final VoidCallback? onCreateVirtualCard;
  final VoidCallback? onOrderPhysicalCard;
  final VoidCallback? onViewTerms;
  final VoidCallback? onShareAchievement;
  final VoidCallback? onContactSupport;

  const ActionButtonsWidget({
    Key? key,
    required this.isApproved,
    this.onCreateVirtualCard,
    this.onOrderPhysicalCard,
    this.onViewTerms,
    this.onShareAchievement,
    this.onContactSupport,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 3.h),
      child: Column(
        children: [
          if (isApproved) ...[
            // Primary action buttons
            Row(
              children: [
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: onCreateVirtualCard,
                    icon: CustomIconWidget(
                      iconName: 'credit_card',
                      color: AppTheme.backgroundDark,
                      size: 5.w,
                    ),
                    label: Text('Create Virtual Card'),
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.symmetric(vertical: 2.h),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 3.w),
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: onOrderPhysicalCard,
                    icon: CustomIconWidget(
                      iconName: 'local_shipping',
                      color: AppTheme.primaryGold,
                      size: 5.w,
                    ),
                    label: Text('Order Physical Card'),
                    style: OutlinedButton.styleFrom(
                      padding: EdgeInsets.symmetric(vertical: 2.h),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                ),
              ],
            ),

            SizedBox(height: 2.h),

            // Secondary action buttons
            Row(
              children: [
                Expanded(
                  child: TextButton.icon(
                    onPressed: onViewTerms,
                    icon: CustomIconWidget(
                      iconName: 'description',
                      color: AppTheme.textSecondary,
                      size: 4.w,
                    ),
                    label: Text(
                      'View Full Terms',
                      style: TextStyle(color: AppTheme.textSecondary),
                    ),
                  ),
                ),
                Expanded(
                  child: TextButton.icon(
                    onPressed: onShareAchievement,
                    icon: CustomIconWidget(
                      iconName: 'share',
                      color: AppTheme.textSecondary,
                      size: 4.w,
                    ),
                    label: Text(
                      'Share Achievement',
                      style: TextStyle(color: AppTheme.textSecondary),
                    ),
                  ),
                ),
              ],
            ),
          ] else ...[
            // Support and retry options for declined/pending applications
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: onContactSupport,
                icon: CustomIconWidget(
                  iconName: 'support_agent',
                  color: AppTheme.backgroundDark,
                  size: 5.w,
                ),
                label: Text('Contact Support'),
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(vertical: 2.h),
                  backgroundColor: AppTheme.accentBlue,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
            ),

            SizedBox(height: 2.h),

            SizedBox(
              width: double.infinity,
              child: OutlinedButton.icon(
                onPressed: () =>
                    Navigator.pushNamed(context, '/credit-application-form'),
                icon: CustomIconWidget(
                  iconName: 'refresh',
                  color: AppTheme.primaryGold,
                  size: 5.w,
                ),
                label: Text('Try Again Later'),
                style: OutlinedButton.styleFrom(
                  padding: EdgeInsets.symmetric(vertical: 2.h),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
            ),
          ],

          SizedBox(height: 3.h),

          // Additional information
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(3.w),
            decoration: BoxDecoration(
              color: AppTheme.primaryGold.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: AppTheme.primaryGold.withValues(alpha: 0.3),
              ),
            ),
            child: Row(
              children: [
                CustomIconWidget(
                  iconName: 'info_outline',
                  color: AppTheme.primaryGold,
                  size: 5.w,
                ),
                SizedBox(width: 3.w),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        isApproved ? 'Next Steps' : 'What\'s Next?',
                        style:
                            AppTheme.lightTheme.textTheme.titleSmall?.copyWith(
                          color: AppTheme.primaryGold,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(height: 0.5.h),
                      Text(
                        isApproved
                            ? 'Your virtual card will be ready instantly. Physical card delivery takes 3-5 business days.'
                            : 'We\'ll review your application and get back to you within 24 hours with next steps.',
                        style:
                            AppTheme.lightTheme.textTheme.bodySmall?.copyWith(
                          color: AppTheme.textSecondary,
                        ),
                      ),
                    ],
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
