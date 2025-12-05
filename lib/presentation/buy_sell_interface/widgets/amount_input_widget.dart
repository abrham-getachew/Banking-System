import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';

class AmountInputWidget extends StatefulWidget {
  final String selectedToken;
  final double tokenPrice;
  final bool isBuyMode;
  final Function(double) onAmountChanged;
  final Function(String) onCurrencyToggle;
  final String currentCurrency;
  final double availableBalance;

  const AmountInputWidget({
    Key? key,
    required this.selectedToken,
    required this.tokenPrice,
    required this.isBuyMode,
    required this.onAmountChanged,
    required this.onCurrencyToggle,
    required this.currentCurrency,
    required this.availableBalance,
  }) : super(key: key);

  @override
  State<AmountInputWidget> createState() => _AmountInputWidgetState();
}

class _AmountInputWidgetState extends State<AmountInputWidget> {
  final TextEditingController _amountController = TextEditingController();
  double _currentAmount = 0.0;

  @override
  void dispose() {
    _amountController.dispose();
    super.dispose();
  }

  void _updateAmount(String value) {
    final amount = double.tryParse(value) ?? 0.0;
    setState(() {
      _currentAmount = amount;
    });
    widget.onAmountChanged(amount);
  }

  void _setPercentageAmount(double percentage) {
    final maxAmount = widget.currentCurrency == 'USD'
        ? widget.availableBalance
        : widget.availableBalance / widget.tokenPrice;
    final amount = maxAmount * percentage;

    setState(() {
      _currentAmount = amount;
      _amountController.text =
          amount.toStringAsFixed(widget.currentCurrency == 'USD' ? 2 : 6);
    });
    widget.onAmountChanged(amount);
  }

  @override
  Widget build(BuildContext context) {
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
          // Currency Toggle
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Amount',
                style: AppTheme.darkTheme.textTheme.titleMedium?.copyWith(
                  color: AppTheme.textSecondary,
                ),
              ),
              GestureDetector(
                onTap: () {
                  final newCurrency = widget.currentCurrency == 'USD'
                      ? widget.selectedToken
                      : 'USD';
                  widget.onCurrencyToggle(newCurrency);
                },
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 1.h),
                  decoration: BoxDecoration(
                    color: AppTheme.primaryGold.withValues(alpha: 0.2),
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(
                      color: AppTheme.primaryGold.withValues(alpha: 0.3),
                      width: 1,
                    ),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        widget.currentCurrency,
                        style:
                            AppTheme.darkTheme.textTheme.labelMedium?.copyWith(
                          color: AppTheme.primaryGold,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(width: 1.w),
                      CustomIconWidget(
                        iconName: 'swap_horiz',
                        color: AppTheme.primaryGold,
                        size: 16,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 2.h),

          // Amount Input
          Container(
            padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 2.h),
            decoration: BoxDecoration(
              color: AppTheme.deepCharcoal.withValues(alpha: 0.5),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: AppTheme.textPrimary.withValues(alpha: 0.1),
                width: 1,
              ),
            ),
            child: Row(
              children: [
                Text(
                  widget.currentCurrency == 'USD' ? '\$' : '',
                  style: AppTheme.darkTheme.textTheme.headlineMedium?.copyWith(
                    color: AppTheme.textPrimary,
                    fontWeight: FontWeight.w300,
                  ),
                ),
                Expanded(
                  child: TextField(
                    controller: _amountController,
                    keyboardType:
                        const TextInputType.numberWithOptions(decimal: true),
                    style:
                        AppTheme.darkTheme.textTheme.headlineMedium?.copyWith(
                      color: AppTheme.textPrimary,
                      fontWeight: FontWeight.w600,
                    ),
                    decoration: InputDecoration(
                      hintText: '0.00',
                      hintStyle:
                          AppTheme.darkTheme.textTheme.headlineMedium?.copyWith(
                        color: AppTheme.textSecondary.withValues(alpha: 0.5),
                        fontWeight: FontWeight.w300,
                      ),
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.zero,
                    ),
                    onChanged: _updateAmount,
                  ),
                ),
                if (widget.currentCurrency != 'USD')
                  Text(
                    widget.selectedToken,
                    style: AppTheme.darkTheme.textTheme.titleMedium?.copyWith(
                      color: AppTheme.textSecondary,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
              ],
            ),
          ),
          SizedBox(height: 2.h),

          // Equivalent Amount Display
          if (_currentAmount > 0)
            Container(
              padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 1.h),
              decoration: BoxDecoration(
                color: AppTheme.primaryGold.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CustomIconWidget(
                    iconName: 'swap_vert',
                    color: AppTheme.primaryGold,
                    size: 16,
                  ),
                  SizedBox(width: 2.w),
                  Text(
                    widget.currentCurrency == 'USD'
                        ? '≈ ${(_currentAmount / widget.tokenPrice).toStringAsFixed(6)} ${widget.selectedToken}'
                        : '≈ \$${(_currentAmount * widget.tokenPrice).toStringAsFixed(2)}',
                    style: AppTheme.darkTheme.textTheme.bodyMedium?.copyWith(
                      color: AppTheme.primaryGold,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
          SizedBox(height: 3.h),

          // Percentage Buttons
          Row(
            children: [
              _buildPercentageButton('25%', 0.25),
              SizedBox(width: 2.w),
              _buildPercentageButton('50%', 0.50),
              SizedBox(width: 2.w),
              _buildPercentageButton('75%', 0.75),
              SizedBox(width: 2.w),
              _buildPercentageButton('Max', 1.0),
            ],
          ),
          SizedBox(height: 2.h),

          // Available Balance
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Available Balance',
                style: AppTheme.darkTheme.textTheme.bodyMedium?.copyWith(
                  color: AppTheme.textSecondary,
                ),
              ),
              Text(
                widget.currentCurrency == 'USD'
                    ? '\$${widget.availableBalance.toStringAsFixed(2)}'
                    : '${(widget.availableBalance / widget.tokenPrice).toStringAsFixed(6)} ${widget.selectedToken}',
                style: AppTheme.darkTheme.textTheme.bodyMedium?.copyWith(
                  color: AppTheme.textPrimary,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildPercentageButton(String label, double percentage) {
    return Expanded(
      child: GestureDetector(
        onTap: () => _setPercentageAmount(percentage),
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 1.5.h),
          decoration: BoxDecoration(
            color: AppTheme.elevatedSurface.withValues(alpha: 0.5),
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              color: AppTheme.textPrimary.withValues(alpha: 0.1),
              width: 1,
            ),
          ),
          child: Text(
            label,
            textAlign: TextAlign.center,
            style: AppTheme.darkTheme.textTheme.labelMedium?.copyWith(
              color: AppTheme.textPrimary,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ),
    );
  }
}
