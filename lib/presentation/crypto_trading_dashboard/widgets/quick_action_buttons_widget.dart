import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';

class QuickActionButtonsWidget extends StatelessWidget {
  const QuickActionButtonsWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 3.h,
      right: 4.w,
      child: Column(
        children: [
          _buildActionButton(
            context,
            icon: 'add',
            label: 'Buy',
            color: AppTheme.successGreen,
            onTap: () => Navigator.pushNamed(context, '/buy-sell-interface'),
          ),
          SizedBox(height: 2.h),
          _buildActionButton(
            context,
            icon: 'remove',
            label: 'Sell',
            color: AppTheme.errorRed,
            onTap: () => Navigator.pushNamed(context, '/buy-sell-interface'),
          ),
          SizedBox(height: 2.h),
          _buildActionButton(
            context,
            icon: 'swap_horiz',
            label: 'Exchange',
            color: AppTheme.primaryGold,
            onTap: () => Navigator.pushNamed(context, '/token-exchange'),
          ),
        ],
      ),
    );
  }

  Widget _buildActionButton(
    BuildContext context, {
    required String icon,
    required String label,
    required Color color,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 14.w,
        height: 14.w,
        decoration: BoxDecoration(
          color: color.withValues(alpha: 0.9),
          borderRadius: BorderRadius.circular(14.w),
          boxShadow: [
            BoxShadow(
              color: color.withValues(alpha: 0.3),
              blurRadius: 12,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CustomIconWidget(
              iconName: icon,
              color: AppTheme.textPrimary,
              size: 24,
            ),
          ],
        ),
      ),
    );
  }
}
