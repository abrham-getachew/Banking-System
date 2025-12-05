import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../../core/app_export.dart';

class BenefitsShowcaseWidget extends StatelessWidget {
  const BenefitsShowcaseWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> benefits = [
      {
        'icon': 'flash_on',
        'title': 'Instant Approval',
        'subtitle': 'up to \$2,500',
        'description':
            'Get approved in seconds with AI-powered credit assessment',
      },
      {
        'icon': 'schedule',
        'title': 'Flexible Plans',
        'subtitle': '3-12 Month Terms',
        'description':
            'Choose payment plans that fit your lifestyle and budget',
      },
      {
        'icon': 'psychology',
        'title': 'AI Credit Health',
        'subtitle': 'Smart Insights',
        'description': 'Personalized tips to improve your financial wellness',
      },
    ];

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 4.w),
      child: Column(
        children:
            benefits.map((benefit) => _buildBenefitCard(benefit)).toList(),
      ),
    );
  }

  Widget _buildBenefitCard(Map<String, dynamic> benefit) {
    return Container(
      margin: EdgeInsets.only(bottom: 3.h),
      padding: EdgeInsets.all(5.w),
      decoration: BoxDecoration(
        color: AppTheme.surfaceDark,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: AppTheme.primaryGold.withValues(alpha: 0.1),
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 12.w,
            height: 12.w,
            decoration: BoxDecoration(
              color: AppTheme.primaryGold.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Center(
              child: CustomIconWidget(
                iconName: benefit['icon'],
                color: AppTheme.primaryGold,
                size: 6.w,
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
                      benefit['title'],
                      style: AppTheme.darkTheme.textTheme.titleMedium?.copyWith(
                        color: AppTheme.textPrimary,
                        fontWeight: FontWeight.w600,
                        fontSize: 16.sp,
                      ),
                    ),
                    SizedBox(width: 2.w),
                    Text(
                      benefit['subtitle'],
                      style: AppTheme.darkTheme.textTheme.bodyMedium?.copyWith(
                        color: AppTheme.primaryGold,
                        fontWeight: FontWeight.w500,
                        fontSize: 14.sp,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 1.h),
                Text(
                  benefit['description'],
                  style: AppTheme.darkTheme.textTheme.bodyMedium?.copyWith(
                    color: AppTheme.textSecondary,
                    fontSize: 13.sp,
                    height: 1.4,
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
