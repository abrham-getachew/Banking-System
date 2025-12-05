import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';

class InterestCalculatorWidget extends StatefulWidget {
  final double principalAmount;

  const InterestCalculatorWidget({
    super.key,
    required this.principalAmount,
  });

  @override
  State<InterestCalculatorWidget> createState() =>
      _InterestCalculatorWidgetState();
}

class _InterestCalculatorWidgetState extends State<InterestCalculatorWidget> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 4.w),
      decoration: BoxDecoration(
        color: AppTheme.darkTheme.cardColor,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: AppTheme.primaryGold.withValues(alpha: 0.2),
        ),
      ),
      child: Column(
        children: [
          // Header
          GestureDetector(
            onTap: () {
              setState(() {
                _isExpanded = !_isExpanded;
              });
            },
            child: Container(
              padding: EdgeInsets.all(4.w),
              child: Row(
                children: [
                  CustomIconWidget(
                    iconName: 'calculate',
                    color: AppTheme.primaryGold,
                    size: 20,
                  ),
                  SizedBox(width: 2.w),
                  Expanded(
                    child: Text(
                      'How Interest Works',
                      style: AppTheme.darkTheme.textTheme.titleMedium?.copyWith(
                        color: AppTheme.textPrimary,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  AnimatedRotation(
                    turns: _isExpanded ? 0.5 : 0,
                    duration: const Duration(milliseconds: 300),
                    child: CustomIconWidget(
                      iconName: 'keyboard_arrow_down',
                      color: AppTheme.primaryGold,
                      size: 24,
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Expandable content
          AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            height: _isExpanded ? null : 0,
            child: _isExpanded ? _buildExpandedContent() : null,
          ),
        ],
      ),
    );
  }

  Widget _buildExpandedContent() {
    return Padding(
      padding: EdgeInsets.fromLTRB(4.w, 0, 4.w, 4.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Interest calculation breakdown
          Container(
            padding: EdgeInsets.all(3.w),
            decoration: BoxDecoration(
              color: AppTheme.backgroundDark.withValues(alpha: 0.3),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Interest Calculation',
                  style: AppTheme.darkTheme.textTheme.titleSmall?.copyWith(
                    color: AppTheme.primaryGold,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: 2.h),
                _buildCalculationRow('Principal Amount',
                    '\$${widget.principalAmount.toStringAsFixed(2)}'),
                SizedBox(height: 1.h),
                _buildCalculationRow('3-Month Plan (8.9% APR)',
                    '\$${_calculateInterest(3, 8.9).toStringAsFixed(2)}'),
                SizedBox(height: 1.h),
                _buildCalculationRow('6-Month Plan (12.5% APR)',
                    '\$${_calculateInterest(6, 12.5).toStringAsFixed(2)}'),
                SizedBox(height: 1.h),
                _buildCalculationRow('12-Month Plan (18.9% APR)',
                    '\$${_calculateInterest(12, 18.9).toStringAsFixed(2)}'),
              ],
            ),
          ),

          SizedBox(height: 2.h),

          // Example calculation
          Container(
            padding: EdgeInsets.all(3.w),
            decoration: BoxDecoration(
              color: AppTheme.primaryGold.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: AppTheme.primaryGold.withValues(alpha: 0.3),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    CustomIconWidget(
                      iconName: 'lightbulb_outline',
                      color: AppTheme.primaryGold,
                      size: 16,
                    ),
                    SizedBox(width: 2.w),
                    Text(
                      'Example: \$1,000 Purchase',
                      style: AppTheme.darkTheme.textTheme.titleSmall?.copyWith(
                        color: AppTheme.primaryGold,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 2.h),
                _buildExampleRow(
                    '3 months', '\$347.30/month', '\$41.90 interest'),
                SizedBox(height: 1.h),
                _buildExampleRow(
                    '6 months', '\$187.50/month', '\$125.00 interest'),
                SizedBox(height: 1.h),
                _buildExampleRow(
                    '12 months', '\$105.75/month', '\$269.00 interest'),
              ],
            ),
          ),

          SizedBox(height: 2.h),

          // Early payment benefits
          Container(
            padding: EdgeInsets.all(3.w),
            decoration: BoxDecoration(
              color: AppTheme.successGreen.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: AppTheme.successGreen.withValues(alpha: 0.3),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    CustomIconWidget(
                      iconName: 'savings',
                      color: AppTheme.successGreen,
                      size: 16,
                    ),
                    SizedBox(width: 2.w),
                    Text(
                      'Early Payment Benefits',
                      style: AppTheme.darkTheme.textTheme.titleSmall?.copyWith(
                        color: AppTheme.successGreen,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 1.h),
                Text(
                  '• Pay off early to save on interest\n• No prepayment penalties\n• Flexible payment scheduling\n• Build better credit history',
                  style: AppTheme.darkTheme.textTheme.bodySmall?.copyWith(
                    color: AppTheme.textPrimary,
                    height: 1.5,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCalculationRow(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: AppTheme.darkTheme.textTheme.bodySmall?.copyWith(
            color: AppTheme.textSecondary,
          ),
        ),
        Text(
          value,
          style: AppTheme.darkTheme.textTheme.bodySmall?.copyWith(
            color: AppTheme.textPrimary,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }

  Widget _buildExampleRow(String term, String monthly, String interest) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          term,
          style: AppTheme.darkTheme.textTheme.bodySmall?.copyWith(
            color: AppTheme.textPrimary,
            fontWeight: FontWeight.w500,
          ),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              monthly,
              style: AppTheme.darkTheme.textTheme.bodySmall?.copyWith(
                color: AppTheme.textPrimary,
                fontWeight: FontWeight.w600,
              ),
            ),
            Text(
              interest,
              style: AppTheme.darkTheme.textTheme.labelSmall?.copyWith(
                color: AppTheme.textSecondary,
              ),
            ),
          ],
        ),
      ],
    );
  }

  double _calculateInterest(int months, double apr) {
    final monthlyRate = apr / 100 / 12;
    final totalAmount = widget.principalAmount * (1 + monthlyRate * months);
    return totalAmount - widget.principalAmount;
  }
}
