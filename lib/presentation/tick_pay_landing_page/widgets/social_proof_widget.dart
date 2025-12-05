import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../../core/app_export.dart';

class SocialProofWidget extends StatelessWidget {
  const SocialProofWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> trustSignals = [
      {
        'icon': 'security',
        'title': 'Bank-Level Security',
        'subtitle': '256-bit SSL Encryption',
      },
      {
        'icon': 'verified',
        'title': 'FDIC Insured',
        'subtitle': 'Up to \$250,000',
      },
      {
        'icon': 'shield',
        'title': 'PCI Compliant',
        'subtitle': 'Level 1 Certified',
      },
    ];

    final List<Map<String, dynamic>> userStats = [
      {
        'number': '50K+',
        'label': 'Active Users',
      },
      {
        'number': '4.8★',
        'label': 'App Rating',
      },
      {
        'number': '\$10M+',
        'label': 'Credit Approved',
      },
    ];

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 4.w),
      child: Column(
        children: [
          // User statistics
          Container(
            padding: EdgeInsets.all(5.w),
            decoration: BoxDecoration(
              color: AppTheme.surfaceDark.withValues(alpha: 0.5),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: AppTheme.primaryGold.withValues(alpha: 0.1),
                width: 1,
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: userStats.map((stat) => _buildStatItem(stat)).toList(),
            ),
          ),

          SizedBox(height: 4.h),

          // Trust signals
          Column(
            children: trustSignals
                .map((signal) => _buildTrustSignal(signal))
                .toList(),
          ),

          SizedBox(height: 3.h),

          // Compliance badges
          _buildComplianceBadges(),
        ],
      ),
    );
  }

  Widget _buildStatItem(Map<String, dynamic> stat) {
    return Column(
      children: [
        Text(
          stat['number'],
          style: AppTheme.darkTheme.textTheme.headlineSmall?.copyWith(
            color: AppTheme.primaryGold,
            fontWeight: FontWeight.w700,
            fontSize: 20.sp,
          ),
        ),
        SizedBox(height: 0.5.h),
        Text(
          stat['label'],
          style: AppTheme.darkTheme.textTheme.bodySmall?.copyWith(
            color: AppTheme.textSecondary,
            fontSize: 11.sp,
          ),
        ),
      ],
    );
  }

  Widget _buildTrustSignal(Map<String, dynamic> signal) {
    return Container(
      margin: EdgeInsets.only(bottom: 2.h),
      padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 3.h),
      decoration: BoxDecoration(
        color: AppTheme.surfaceDark.withValues(alpha: 0.3),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: AppTheme.successGreen.withValues(alpha: 0.2),
          width: 1,
        ),
      ),
      child: Row(
        children: [
          Container(
            width: 10.w,
            height: 10.w,
            decoration: BoxDecoration(
              color: AppTheme.successGreen.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Center(
              child: CustomIconWidget(
                iconName: signal['icon'],
                color: AppTheme.successGreen,
                size: 5.w,
              ),
            ),
          ),
          SizedBox(width: 3.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  signal['title'],
                  style: AppTheme.darkTheme.textTheme.titleSmall?.copyWith(
                    color: AppTheme.textPrimary,
                    fontWeight: FontWeight.w600,
                    fontSize: 14.sp,
                  ),
                ),
                SizedBox(height: 0.5.h),
                Text(
                  signal['subtitle'],
                  style: AppTheme.darkTheme.textTheme.bodySmall?.copyWith(
                    color: AppTheme.textSecondary,
                    fontSize: 12.sp,
                  ),
                ),
              ],
            ),
          ),
          CustomIconWidget(
            iconName: 'check_circle',
            color: AppTheme.successGreen,
            size: 4.w,
          ),
        ],
      ),
    );
  }

  Widget _buildComplianceBadges() {
    return Container(
      padding: EdgeInsets.all(4.w),
      decoration: BoxDecoration(
        color: AppTheme.surfaceDark.withValues(alpha: 0.2),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: AppTheme.neutralGray.withValues(alpha: 0.2),
          width: 1,
        ),
      ),
      child: Column(
        children: [
          Text(
            'Regulated & Compliant',
            style: AppTheme.darkTheme.textTheme.titleSmall?.copyWith(
              color: AppTheme.textPrimary,
              fontWeight: FontWeight.w600,
              fontSize: 14.sp,
            ),
          ),
          SizedBox(height: 2.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildBadge('SOC 2'),
              _buildBadge('ISO 27001'),
              _buildBadge('CCPA'),
              _buildBadge('GDPR'),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildBadge(String text) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 1.h),
      decoration: BoxDecoration(
        color: AppTheme.neutralGray.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: AppTheme.neutralGray.withValues(alpha: 0.3),
          width: 1,
        ),
      ),
      child: Text(
        text,
        style: AppTheme.darkTheme.textTheme.bodySmall?.copyWith(
          color: AppTheme.textSecondary,
          fontSize: 10.sp,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}
