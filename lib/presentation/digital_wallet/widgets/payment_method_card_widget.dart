import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';

class PaymentMethodCardWidget extends StatelessWidget {
  final Map<String, dynamic> paymentMethod;
  final VoidCallback? onTap;

  const PaymentMethodCardWidget({
    Key? key,
    required this.paymentMethod,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final type = paymentMethod["type"] as String;
    final provider = paymentMethod["provider"] as String;
    final lastFour = paymentMethod["lastFour"] as String;
    final isDefault = paymentMethod["isDefault"] as bool;
    final logo = paymentMethod["logo"] as String;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(4.w),
        decoration: BoxDecoration(
          color: AppTheme.secondaryDark,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: AppTheme.borderGray, width: 1),
        ),
        child: Row(
          children: [
            Container(
              width: 12.w,
              height: 8.h,
              decoration: BoxDecoration(
                color: AppTheme.primaryDark,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: AppTheme.borderGray, width: 1),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: CustomImageWidget(
                  imageUrl: logo,
                  width: 12.w,
                  height: 8.h,
                  fit: BoxFit.contain,
                ),
              ),
            ),
            SizedBox(width: 4.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        provider,
                        style:
                            AppTheme.darkTheme.textTheme.titleMedium?.copyWith(
                          color: AppTheme.textPrimary,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      if (isDefault) ...[
                        SizedBox(width: 2.w),
                        Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: 2.w, vertical: 0.5.h),
                          decoration: BoxDecoration(
                            color: AppTheme.accentGold.withValues(alpha: 0.2),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(
                            'Default',
                            style: AppTheme.darkTheme.textTheme.bodySmall
                                ?.copyWith(
                              color: AppTheme.accentGold,
                              fontSize: 9.sp,
                            ),
                          ),
                        ),
                      ],
                    ],
                  ),
                  SizedBox(height: 0.5.h),
                  Text(
                    type == 'card'
                        ? '•••• •••• •••• $lastFour'
                        : '${paymentMethod["accountType"]} •••• $lastFour',
                    style: AppTheme.darkTheme.textTheme.bodyMedium?.copyWith(
                      color: AppTheme.textSecondary,
                    ),
                  ),
                  if (type == 'card') ...[
                    SizedBox(height: 0.5.h),
                    Text(
                      'Expires ${paymentMethod["expiryMonth"]}/${paymentMethod["expiryYear"]}',
                      style: AppTheme.darkTheme.textTheme.bodySmall?.copyWith(
                        color: AppTheme.textSecondary,
                      ),
                    ),
                  ],
                ],
              ),
            ),
            CustomIconWidget(
              iconName: 'chevron_right',
              color: AppTheme.textSecondary,
              size: 20,
            ),
          ],
        ),
      ),
    );
  }
}
