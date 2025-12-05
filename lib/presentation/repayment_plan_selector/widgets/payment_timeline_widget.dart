import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';

class PaymentTimelineWidget extends StatelessWidget {
  final Map<String, dynamic> selectedPlan;

  const PaymentTimelineWidget({
    super.key,
    required this.selectedPlan,
  });

  @override
  Widget build(BuildContext context) {
    final months = selectedPlan['months'] as int;
    final monthlyPayment = selectedPlan['monthlyPayment'] as double;
    final startDate = DateTime.now().add(const Duration(days: 30));

    return Container(
      margin: EdgeInsets.symmetric(horizontal: 4.w),
      padding: EdgeInsets.all(4.w),
      decoration: BoxDecoration(
        color: AppTheme.darkTheme.cardColor,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: AppTheme.primaryGold.withValues(alpha: 0.2),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CustomIconWidget(
                iconName: 'schedule',
                color: AppTheme.primaryGold,
                size: 20,
              ),
              SizedBox(width: 2.w),
              Text(
                'Payment Timeline',
                style: AppTheme.darkTheme.textTheme.titleMedium?.copyWith(
                  color: AppTheme.textPrimary,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),

          SizedBox(height: 3.h),

          // Timeline visualization
          SizedBox(
            height: 15.h,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: months,
              itemBuilder: (context, index) {
                final paymentDate = DateTime(
                  startDate.year,
                  startDate.month + index,
                  startDate.day,
                );
                final isFirst = index == 0;
                final isLast = index == months - 1;

                return Container(
                  width: 20.w,
                  margin: EdgeInsets.only(right: 2.w),
                  child: Column(
                    children: [
                      // Date marker
                      Container(
                        width: 16.w,
                        height: 6.h,
                        decoration: BoxDecoration(
                          color: isFirst
                              ? AppTheme.primaryGold
                              : AppTheme.backgroundDark.withValues(alpha: 0.5),
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: isFirst
                                ? AppTheme.primaryGold
                                : AppTheme.primaryGold.withValues(alpha: 0.3),
                          ),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              '${paymentDate.month}/${paymentDate.day}',
                              style: AppTheme.darkTheme.textTheme.bodySmall
                                  ?.copyWith(
                                color: isFirst
                                    ? AppTheme.backgroundDark
                                    : AppTheme.textPrimary,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Text(
                              '${paymentDate.year}',
                              style: AppTheme.darkTheme.textTheme.labelSmall
                                  ?.copyWith(
                                color: isFirst
                                    ? AppTheme.backgroundDark
                                        .withValues(alpha: 0.8)
                                    : AppTheme.textSecondary,
                              ),
                            ),
                          ],
                        ),
                      ),

                      SizedBox(height: 1.h),

                      // Payment amount
                      Text(
                        '\$${monthlyPayment.toStringAsFixed(0)}',
                        style: AppTheme.darkTheme.textTheme.bodySmall?.copyWith(
                          color: isFirst
                              ? AppTheme.primaryGold
                              : AppTheme.textSecondary,
                          fontWeight: FontWeight.w600,
                        ),
                      ),

                      SizedBox(height: 0.5.h),

                      // Payment status
                      Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: 2.w, vertical: 0.5.h),
                        decoration: BoxDecoration(
                          color: isFirst
                              ? AppTheme.primaryGold.withValues(alpha: 0.2)
                              : AppTheme.backgroundDark.withValues(alpha: 0.3),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          isFirst ? 'Next' : 'Pending',
                          style:
                              AppTheme.darkTheme.textTheme.labelSmall?.copyWith(
                            color: isFirst
                                ? AppTheme.primaryGold
                                : AppTheme.textSecondary,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),

          SizedBox(height: 2.h),

          // Timeline summary
          Container(
            padding: EdgeInsets.all(3.w),
            decoration: BoxDecoration(
              color: AppTheme.backgroundDark.withValues(alpha: 0.3),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'First Payment',
                      style: AppTheme.darkTheme.textTheme.bodySmall?.copyWith(
                        color: AppTheme.textSecondary,
                      ),
                    ),
                    Text(
                      '${startDate.month}/${startDate.day}/${startDate.year}',
                      style: AppTheme.darkTheme.textTheme.bodyMedium?.copyWith(
                        color: AppTheme.textPrimary,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      'Final Payment',
                      style: AppTheme.darkTheme.textTheme.bodySmall?.copyWith(
                        color: AppTheme.textSecondary,
                      ),
                    ),
                    Text(
                      '${(startDate.month + months - 1) > 12 ? (startDate.month + months - 1) - 12 : startDate.month + months - 1}/${startDate.day}/${startDate.month + months - 1 > 12 ? startDate.year + 1 : startDate.year}',
                      style: AppTheme.darkTheme.textTheme.bodyMedium?.copyWith(
                        color: AppTheme.textPrimary,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
