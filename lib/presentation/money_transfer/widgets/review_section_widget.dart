import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';

class ReviewSectionWidget extends StatelessWidget {
  final Map<String, dynamic>? recipient;
  final double amount;
  final String currency;
  final Map<String, dynamic> account;
  final Map<String, dynamic> transferMethod;
  final String message;
  final DateTime? scheduledDate;

  const ReviewSectionWidget({
    super.key,
    required this.recipient,
    required this.amount,
    required this.currency,
    required this.account,
    required this.transferMethod,
    required this.message,
    this.scheduledDate,
  });

  String get _currencySymbol {
    switch (currency) {
      case 'USD':
        return '\$';
      case 'EUR':
        return '€';
      case 'GBP':
        return '£';
      case 'JPY':
        return '¥';
      case 'CAD':
        return 'C\$';
      default:
        return '\$';
    }
  }

  String get _estimatedArrival {
    if (scheduledDate != null) {
      return '${scheduledDate!.day}/${scheduledDate!.month}/${scheduledDate!.year}';
    }

    switch (transferMethod['id']) {
      case 'instant':
        return 'Within 5 minutes';
      case 'standard':
        return '1-2 business days';
      default:
        return '1-2 business days';
    }
  }

  double get _totalFee {
    return transferMethod['fee'] as double? ?? 0.0;
  }

  double get _totalAmount {
    return amount + _totalFee;
  }

  @override
  Widget build(BuildContext context) {
    if (recipient == null) {
      return Center(
        child: Text(
          'No recipient selected',
          style: AppTheme.darkTheme.textTheme.bodyMedium?.copyWith(
            color: AppTheme.textSecondary,
          ),
        ),
      );
    }

    return Padding(
      padding: EdgeInsets.all(4.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Transfer Summary Header
          Container(
            padding: EdgeInsets.all(4.w),
            decoration: BoxDecoration(
              color: AppTheme.accentGold.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: AppTheme.accentGold.withValues(alpha: 0.3),
                width: 1,
              ),
            ),
            child: Row(
              children: [
                CustomIconWidget(
                  iconName: 'send',
                  color: AppTheme.accentGold,
                  size: 8.w,
                ),
                SizedBox(width: 3.w),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Transfer Summary',
                        style:
                            AppTheme.darkTheme.textTheme.titleMedium?.copyWith(
                          color: AppTheme.accentGold,
                        ),
                      ),
                      Text(
                        'Review your transfer details',
                        style: AppTheme.darkTheme.textTheme.bodySmall?.copyWith(
                          color: AppTheme.textSecondary,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          SizedBox(height: 3.h),

          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Recipient Information
                  _buildSectionCard(
                    title: 'Recipient',
                    icon: 'person',
                    child: Row(
                      children: [
                        CircleAvatar(
                          radius: 6.w,
                          backgroundColor:
                              AppTheme.accentGold.withValues(alpha: 0.2),
                          child: ClipOval(
                            child: CustomImageWidget(
                              imageUrl: recipient!['avatar'] as String,
                              width: 12.w,
                              height: 12.w,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        SizedBox(width: 3.w),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                recipient!['name'] as String,
                                style: AppTheme.darkTheme.textTheme.titleMedium,
                              ),
                              Text(
                                recipient!['email'] as String,
                                style: AppTheme.darkTheme.textTheme.bodySmall
                                    ?.copyWith(
                                  color: AppTheme.textSecondary,
                                ),
                              ),
                              Text(
                                recipient!['phone'] as String,
                                style: AppTheme.darkTheme.textTheme.bodySmall
                                    ?.copyWith(
                                  color: AppTheme.textSecondary,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),

                  SizedBox(height: 2.h),

                  // Amount Information
                  _buildSectionCard(
                    title: 'Amount',
                    icon: 'attach_money',
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Transfer Amount',
                              style: AppTheme.darkTheme.textTheme.bodyMedium,
                            ),
                            Text(
                              '$_currencySymbol${amount.toStringAsFixed(2)}',
                              style: AppTheme.darkTheme.textTheme.titleMedium
                                  ?.copyWith(
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                        if (_totalFee > 0) ...[
                          SizedBox(height: 1.h),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Transfer Fee',
                                style: AppTheme.darkTheme.textTheme.bodyMedium,
                              ),
                              Text(
                                '\$${_totalFee.toStringAsFixed(2)}',
                                style: AppTheme.darkTheme.textTheme.bodyMedium
                                    ?.copyWith(
                                  color: AppTheme.warningAmber,
                                ),
                              ),
                            ],
                          ),
                        ],
                        SizedBox(height: 1.h),
                        Divider(color: AppTheme.borderGray),
                        SizedBox(height: 1.h),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Total Amount',
                              style: AppTheme.darkTheme.textTheme.titleMedium
                                  ?.copyWith(
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Text(
                              '\$${_totalAmount.toStringAsFixed(2)}',
                              style: AppTheme.darkTheme.textTheme.titleMedium
                                  ?.copyWith(
                                fontWeight: FontWeight.w600,
                                color: AppTheme.accentGold,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),

                  SizedBox(height: 2.h),

                  // Source Account
                  _buildSectionCard(
                    title: 'From Account',
                    icon: 'account_balance_wallet',
                    child: Row(
                      children: [
                        Container(
                          width: 12.w,
                          height: 12.w,
                          decoration: BoxDecoration(
                            color: AppTheme.accentGold.withValues(alpha: 0.2),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: CustomIconWidget(
                            iconName: account['type'] == 'checking'
                                ? 'account_balance_wallet'
                                : account['type'] == 'savings'
                                    ? 'savings'
                                    : 'trending_up',
                            color: AppTheme.accentGold,
                            size: 6.w,
                          ),
                        ),
                        SizedBox(width: 3.w),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                account['name'] as String,
                                style: AppTheme.darkTheme.textTheme.titleMedium,
                              ),
                              Text(
                                account['accountNumber'] as String,
                                style: AppTheme.darkTheme.textTheme.bodySmall
                                    ?.copyWith(
                                  color: AppTheme.textSecondary,
                                ),
                              ),
                              Text(
                                'Available: \$${(account['balance'] as double).toStringAsFixed(2)}',
                                style: AppTheme.darkTheme.textTheme.bodySmall
                                    ?.copyWith(
                                  color: AppTheme.successGreen,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),

                  SizedBox(height: 2.h),

                  // Transfer Method
                  _buildSectionCard(
                    title: 'Transfer Method',
                    icon: transferMethod['icon'] as String,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              transferMethod['name'] as String,
                              style: AppTheme.darkTheme.textTheme.titleMedium,
                            ),
                            if (_totalFee > 0)
                              Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: 2.w,
                                  vertical: 0.5.h,
                                ),
                                decoration: BoxDecoration(
                                  color: AppTheme.warningAmber
                                      .withValues(alpha: 0.2),
                                  borderRadius: BorderRadius.circular(4),
                                ),
                                child: Text(
                                  '\$${_totalFee.toStringAsFixed(2)}',
                                  style: AppTheme.darkTheme.textTheme.bodySmall
                                      ?.copyWith(
                                    color: AppTheme.warningAmber,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              )
                            else
                              Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: 2.w,
                                  vertical: 0.5.h,
                                ),
                                decoration: BoxDecoration(
                                  color: AppTheme.successGreen
                                      .withValues(alpha: 0.2),
                                  borderRadius: BorderRadius.circular(4),
                                ),
                                child: Text(
                                  'FREE',
                                  style: AppTheme.darkTheme.textTheme.bodySmall
                                      ?.copyWith(
                                    color: AppTheme.successGreen,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                          ],
                        ),
                        SizedBox(height: 1.h),
                        Text(
                          'Estimated arrival: $_estimatedArrival',
                          style:
                              AppTheme.darkTheme.textTheme.bodySmall?.copyWith(
                            color: AppTheme.textSecondary,
                          ),
                        ),
                      ],
                    ),
                  ),

                  // Message (if provided)
                  if (message.isNotEmpty) ...[
                    SizedBox(height: 2.h),
                    _buildSectionCard(
                      title: 'Message',
                      icon: 'message',
                      child: Text(
                        message,
                        style: AppTheme.darkTheme.textTheme.bodyMedium,
                      ),
                    ),
                  ],

                  SizedBox(height: 3.h),

                  // Security Notice
                  Container(
                    padding: EdgeInsets.all(3.w),
                    decoration: BoxDecoration(
                      color: AppTheme.successGreen.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(
                        color: AppTheme.successGreen.withValues(alpha: 0.3),
                        width: 1,
                      ),
                    ),
                    child: Row(
                      children: [
                        CustomIconWidget(
                          iconName: 'security',
                          color: AppTheme.successGreen,
                          size: 5.w,
                        ),
                        SizedBox(width: 2.w),
                        Expanded(
                          child: Text(
                            'Your transfer is protected by bank-grade security and encryption.',
                            style: AppTheme.darkTheme.textTheme.bodySmall
                                ?.copyWith(
                              color: AppTheme.successGreen,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionCard({
    required String title,
    required String icon,
    required Widget child,
  }) {
    return Container(
      padding: EdgeInsets.all(3.w),
      decoration: BoxDecoration(
        color: AppTheme.secondaryDark,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: AppTheme.borderGray,
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CustomIconWidget(
                iconName: icon,
                color: AppTheme.accentGold,
                size: 5.w,
              ),
              SizedBox(width: 2.w),
              Text(
                title,
                style: AppTheme.darkTheme.textTheme.titleMedium?.copyWith(
                  color: AppTheme.accentGold,
                ),
              ),
            ],
          ),
          SizedBox(height: 2.h),
          child,
        ],
      ),
    );
  }
}
