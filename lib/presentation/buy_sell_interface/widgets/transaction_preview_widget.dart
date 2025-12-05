import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';

class TransactionPreviewWidget extends StatelessWidget {
  final String selectedToken;
  final double amount;
  final String currency;
  final double tokenPrice;
  final bool isBuyMode;
  final double networkFee;
  final double platformFee;

  const TransactionPreviewWidget({
    Key? key,
    required this.selectedToken,
    required this.amount,
    required this.currency,
    required this.tokenPrice,
    required this.isBuyMode,
    required this.networkFee,
    required this.platformFee,
  }) : super(key: key);

  double get _totalAmount {
    final baseAmount = currency == 'USD' ? amount : amount * tokenPrice;
    return isBuyMode
        ? baseAmount + networkFee + platformFee
        : baseAmount - networkFee - platformFee;
  }

  double get _tokenAmount {
    return currency == 'USD' ? amount / tokenPrice : amount;
  }

  double get _usdAmount {
    return currency == 'USD' ? amount : amount * tokenPrice;
  }

  @override
  Widget build(BuildContext context) {
    if (amount <= 0) return const SizedBox.shrink();

    return Container(
      padding: EdgeInsets.all(4.w),
      decoration: BoxDecoration(
        color: AppTheme.elevatedSurface.withValues(alpha: 0.3),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: AppTheme.textPrimary.withValues(alpha: 0.1),
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CustomIconWidget(
                iconName: 'receipt_long',
                color: AppTheme.primaryGold,
                size: 20,
              ),
              SizedBox(width: 2.w),
              Text(
                'Transaction Preview',
                style: AppTheme.darkTheme.textTheme.titleMedium?.copyWith(
                  color: AppTheme.textPrimary,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          SizedBox(height: 3.h),

          // Transaction Type
          _buildPreviewRow(
            'Transaction Type',
            isBuyMode ? 'Buy' : 'Sell',
            valueColor: isBuyMode ? AppTheme.successGreen : AppTheme.errorRed,
          ),

          // Token Amount
          _buildPreviewRow(
            'Token Amount',
            '${_tokenAmount.toStringAsFixed(6)} $selectedToken',
          ),

          // USD Amount
          _buildPreviewRow(
            'USD Amount',
            '\$${_usdAmount.toStringAsFixed(2)}',
          ),

          // Divider
          Container(
            margin: EdgeInsets.symmetric(vertical: 2.h),
            height: 1,
            color: AppTheme.textPrimary.withValues(alpha: 0.1),
          ),

          // Network Fee
          _buildPreviewRow(
            'Network Fee',
            '\$${networkFee.toStringAsFixed(2)}',
            valueColor: AppTheme.textSecondary,
          ),

          // Platform Fee
          _buildPreviewRow(
            'Platform Fee',
            '\$${platformFee.toStringAsFixed(2)}',
            valueColor: AppTheme.textSecondary,
          ),

          // Divider
          Container(
            margin: EdgeInsets.symmetric(vertical: 2.h),
            height: 1,
            color: AppTheme.textPrimary.withValues(alpha: 0.1),
          ),

          // Total Amount
          _buildPreviewRow(
            isBuyMode ? 'Total Cost' : 'You Receive',
            '\$${_totalAmount.toStringAsFixed(2)}',
            isTotal: true,
          ),

          SizedBox(height: 3.h),

          // Estimated Time
          Container(
            padding: EdgeInsets.all(3.w),
            decoration: BoxDecoration(
              color: AppTheme.infoBlue.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: AppTheme.infoBlue.withValues(alpha: 0.2),
                width: 1,
              ),
            ),
            child: Row(
              children: [
                CustomIconWidget(
                  iconName: 'schedule',
                  color: AppTheme.infoBlue,
                  size: 16,
                ),
                SizedBox(width: 2.w),
                Text(
                  'Estimated completion: 2-5 minutes',
                  style: AppTheme.darkTheme.textTheme.bodySmall?.copyWith(
                    color: AppTheme.infoBlue,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPreviewRow(
    String label,
    String value, {
    Color? valueColor,
    bool isTotal = false,
  }) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 1.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: AppTheme.darkTheme.textTheme.bodyMedium?.copyWith(
              color: isTotal ? AppTheme.textPrimary : AppTheme.textSecondary,
              fontWeight: isTotal ? FontWeight.w600 : FontWeight.w400,
            ),
          ),
          Text(
            value,
            style: AppTheme.darkTheme.textTheme.bodyMedium?.copyWith(
              color: valueColor ??
                  (isTotal ? AppTheme.primaryGold : AppTheme.textPrimary),
              fontWeight: isTotal ? FontWeight.w700 : FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
