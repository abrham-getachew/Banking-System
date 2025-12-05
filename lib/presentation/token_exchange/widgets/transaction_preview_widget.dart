import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';

class TransactionPreviewWidget extends StatelessWidget {
  final String inputAmount;
  final String outputAmount;
  final String minimumReceived;
  final String priceImpact;
  final String totalFees;
  final bool isPriceImpactHigh;

  const TransactionPreviewWidget({
    Key? key,
    required this.inputAmount,
    required this.outputAmount,
    required this.minimumReceived,
    required this.priceImpact,
    required this.totalFees,
    this.isPriceImpactHigh = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(4.w),
      decoration: BoxDecoration(
        color: AppTheme.elevatedSurface.withValues(alpha: 0.6),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: AppTheme.primaryGold.withValues(alpha: 0.3),
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Transaction Preview',
            style: AppTheme.darkTheme.textTheme.titleMedium?.copyWith(
              color: AppTheme.textPrimary,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: 3.h),
          _buildPreviewRow('Input Amount', inputAmount, AppTheme.textPrimary),
          SizedBox(height: 2.h),
          _buildPreviewRow('Output Amount', outputAmount, AppTheme.textPrimary),
          SizedBox(height: 2.h),
          _buildPreviewRow(
              'Minimum Received', minimumReceived, AppTheme.textSecondary),
          SizedBox(height: 2.h),
          _buildPreviewRow(
            'Price Impact',
            priceImpact,
            isPriceImpactHigh ? AppTheme.errorRed : AppTheme.successGreen,
          ),
          SizedBox(height: 2.h),
          _buildPreviewRow('Total Fees', totalFees, AppTheme.textSecondary),
          if (isPriceImpactHigh) ...[
            SizedBox(height: 3.h),
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(3.w),
              decoration: BoxDecoration(
                color: AppTheme.errorRed.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(
                  color: AppTheme.errorRed.withValues(alpha: 0.3),
                  width: 1,
                ),
              ),
              child: Row(
                children: [
                  CustomIconWidget(
                    iconName: 'warning',
                    color: AppTheme.errorRed,
                    size: 5.w,
                  ),
                  SizedBox(width: 2.w),
                  Expanded(
                    child: Text(
                      'High price impact detected. Consider reducing swap amount.',
                      style: AppTheme.darkTheme.textTheme.bodySmall?.copyWith(
                        color: AppTheme.errorRed,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildPreviewRow(String label, String value, Color valueColor) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: AppTheme.darkTheme.textTheme.bodyMedium?.copyWith(
            color: AppTheme.textSecondary,
          ),
        ),
        Text(
          value,
          style: AppTheme.darkTheme.textTheme.bodyMedium?.copyWith(
            color: valueColor,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
}
