import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../../core/app_export.dart';

class EmptyStateWidget extends StatelessWidget {
  final VoidCallback? onStartTrading;

  const EmptyStateWidget({
    super.key,
    this.onStartTrading,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 8.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildIllustration(),
            SizedBox(height: 4.h),
            _buildTitle(),
            SizedBox(height: 2.h),
            _buildDescription(),
            SizedBox(height: 4.h),
            _buildStartTradingButton(),
          ],
        ),
      ),
    );
  }

  Widget _buildIllustration() {
    return Container(
      width: 40.w,
      height: 40.w,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: RadialGradient(
          colors: [
            AppTheme.primaryGold.withValues(alpha: 0.3),
            AppTheme.primaryGold.withValues(alpha: 0.1),
            Colors.transparent,
          ],
        ),
      ),
      child: Center(
        child: Container(
          width: 25.w,
          height: 25.w,
          decoration: BoxDecoration(
            color: AppTheme.primaryGold.withValues(alpha: 0.2),
            shape: BoxShape.circle,
          ),
          child: Center(
            child: CustomIconWidget(
              iconName: 'account_balance_wallet',
              color: AppTheme.primaryGold,
              size: 48,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTitle() {
    return Text(
      'No Transactions Yet',
      style: AppTheme.darkTheme.textTheme.headlineSmall?.copyWith(
        color: AppTheme.darkTheme.colorScheme.onSurface,
        fontWeight: FontWeight.w600,
      ),
      textAlign: TextAlign.center,
    );
  }

  Widget _buildDescription() {
    return Text(
      'Your transaction history will appear here once you start trading cryptocurrencies. Begin your blockchain journey today!',
      style: AppTheme.darkTheme.textTheme.bodyMedium?.copyWith(
        color: AppTheme.darkTheme.colorScheme.onSurface.withValues(alpha: 0.7),
        height: 1.5,
      ),
      textAlign: TextAlign.center,
    );
  }

  Widget _buildStartTradingButton() {
    return Container(
      width: double.infinity,
      constraints: BoxConstraints(maxWidth: 60.w),
      child: ElevatedButton.icon(
        onPressed: onStartTrading,
        icon: CustomIconWidget(
          iconName: 'trending_up',
          color: AppTheme.darkTheme.colorScheme.onPrimary,
          size: 20,
        ),
        label: const Text('Start Trading'),
        style: ElevatedButton.styleFrom(
          padding: EdgeInsets.symmetric(vertical: 2.h),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),
    );
  }
}
