import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';

class AmountInputWidget extends StatefulWidget {
  final double amount;
  final String currency;
  final List<Map<String, dynamic>> accounts;
  final String selectedAccount;
  final Function(double, String) onAmountChanged;
  final Function(String) onAccountChanged;

  const AmountInputWidget({
    super.key,
    required this.amount,
    required this.currency,
    required this.accounts,
    required this.selectedAccount,
    required this.onAmountChanged,
    required this.onAccountChanged,
  });

  @override
  State<AmountInputWidget> createState() => _AmountInputWidgetState();
}

class _AmountInputWidgetState extends State<AmountInputWidget> {
  final TextEditingController _amountController = TextEditingController();
  String _selectedCurrency = 'USD';
  double _exchangeRate = 1.0;

  final List<Map<String, String>> _currencies = [
    {"code": "USD", "symbol": "\$", "name": "US Dollar"},
    {"code": "EUR", "symbol": "€", "name": "Euro"},
    {"code": "GBP", "symbol": "£", "name": "British Pound"},
    {"code": "JPY", "symbol": "¥", "name": "Japanese Yen"},
    {"code": "CAD", "symbol": "C\$", "name": "Canadian Dollar"},
  ];

  final Map<String, double> _mockExchangeRates = {
    "USD": 1.0,
    "EUR": 0.85,
    "GBP": 0.73,
    "JPY": 110.0,
    "CAD": 1.25,
  };

  @override
  void initState() {
    super.initState();
    _selectedCurrency = widget.currency;
    _amountController.text = widget.amount > 0 ? widget.amount.toString() : '';
    _updateExchangeRate();
  }

  @override
  void dispose() {
    _amountController.dispose();
    super.dispose();
  }

  void _updateExchangeRate() {
    setState(() {
      _exchangeRate = _mockExchangeRates[_selectedCurrency] ?? 1.0;
    });
  }

  void _onAmountChanged(String value) {
    final amount = double.tryParse(value) ?? 0.0;
    widget.onAmountChanged(amount, _selectedCurrency);
  }

  void _onCurrencyChanged(String currency) {
    setState(() {
      _selectedCurrency = currency;
      _updateExchangeRate();
    });

    final amount = double.tryParse(_amountController.text) ?? 0.0;
    widget.onAmountChanged(amount, currency);
  }

  void _addAmount(double value) {
    final currentAmount = double.tryParse(_amountController.text) ?? 0.0;
    final newAmount = currentAmount + value;
    _amountController.text = newAmount.toString();
    _onAmountChanged(newAmount.toString());
  }

  Map<String, dynamic> get _selectedAccountData {
    return widget.accounts.firstWhere(
      (account) => account['id'] == widget.selectedAccount,
      orElse: () => widget.accounts.first,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(4.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Amount Input Section
          Container(
            padding: EdgeInsets.all(4.w),
            decoration: BoxDecoration(
              color: AppTheme.secondaryDark,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: AppTheme.borderGray,
                width: 1,
              ),
            ),
            child: Column(
              children: [
                // Currency Selector
                Row(
                  children: [
                    Text(
                      'Currency',
                      style: AppTheme.darkTheme.textTheme.bodyMedium?.copyWith(
                        color: AppTheme.textSecondary,
                      ),
                    ),
                    Spacer(),
                    DropdownButton<String>(
                      value: _selectedCurrency,
                      dropdownColor: AppTheme.surfaceModal,
                      style: AppTheme.darkTheme.textTheme.bodyMedium,
                      underline: Container(),
                      items: _currencies.map((currency) {
                        return DropdownMenuItem<String>(
                          value: currency['code'],
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                currency['symbol']!,
                                style: AppTheme.darkTheme.textTheme.bodyMedium
                                    ?.copyWith(
                                  color: AppTheme.accentGold,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              SizedBox(width: 2.w),
                              Text(currency['code']!),
                            ],
                          ),
                        );
                      }).toList(),
                      onChanged: (value) {
                        if (value != null) {
                          _onCurrencyChanged(value);
                        }
                      },
                    ),
                  ],
                ),

                SizedBox(height: 2.h),

                // Amount Input
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      _currencies.firstWhere(
                        (c) => c['code'] == _selectedCurrency,
                      )['symbol']!,
                      style:
                          AppTheme.darkTheme.textTheme.headlineMedium?.copyWith(
                        color: AppTheme.accentGold,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(width: 2.w),
                    Expanded(
                      child: TextField(
                        controller: _amountController,
                        keyboardType:
                            TextInputType.numberWithOptions(decimal: true),
                        style: AppTheme.darkTheme.textTheme.headlineMedium
                            ?.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                        decoration: InputDecoration(
                          hintText: '0.00',
                          hintStyle: AppTheme.darkTheme.textTheme.headlineMedium
                              ?.copyWith(
                            color:
                                AppTheme.textSecondary.withValues(alpha: 0.5),
                            fontWeight: FontWeight.w600,
                          ),
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.zero,
                        ),
                        inputFormatters: [
                          FilteringTextInputFormatter.allow(
                              RegExp(r'^\d*\.?\d{0,2}')),
                        ],
                        onChanged: _onAmountChanged,
                      ),
                    ),
                  ],
                ),

                // Exchange Rate Info
                if (_selectedCurrency != 'USD') ...[
                  SizedBox(height: 1.h),
                  Row(
                    children: [
                      CustomIconWidget(
                        iconName: 'info_outline',
                        color: AppTheme.textSecondary,
                        size: 4.w,
                      ),
                      SizedBox(width: 2.w),
                      Text(
                        '1 $_selectedCurrency = \$${(1 / _exchangeRate).toStringAsFixed(4)} USD',
                        style: AppTheme.darkTheme.textTheme.bodySmall?.copyWith(
                          color: AppTheme.textSecondary,
                        ),
                      ),
                    ],
                  ),
                ],
              ],
            ),
          ),

          SizedBox(height: 2.h),

          // Quick Amount Buttons
          Text(
            'Quick Amounts',
            style: AppTheme.darkTheme.textTheme.titleMedium,
          ),

          SizedBox(height: 1.h),

          Row(
            children: [
              Expanded(
                child: OutlinedButton(
                  onPressed: () => _addAmount(10),
                  child: Text('+\$10'),
                ),
              ),
              SizedBox(width: 2.w),
              Expanded(
                child: OutlinedButton(
                  onPressed: () => _addAmount(25),
                  child: Text('+\$25'),
                ),
              ),
              SizedBox(width: 2.w),
              Expanded(
                child: OutlinedButton(
                  onPressed: () => _addAmount(50),
                  child: Text('+\$50'),
                ),
              ),
              SizedBox(width: 2.w),
              Expanded(
                child: OutlinedButton(
                  onPressed: () => _addAmount(100),
                  child: Text('+\$100'),
                ),
              ),
            ],
          ),

          SizedBox(height: 3.h),

          // Source Account Selection
          Text(
            'From Account',
            style: AppTheme.darkTheme.textTheme.titleMedium,
          ),

          SizedBox(height: 1.h),

          Expanded(
            child: ListView.builder(
              itemCount: widget.accounts.length,
              itemBuilder: (context, index) {
                final account = widget.accounts[index];
                final isSelected = account['id'] == widget.selectedAccount;

                return Container(
                  margin: EdgeInsets.only(bottom: 2.h),
                  decoration: BoxDecoration(
                    color: isSelected
                        ? AppTheme.accentGold.withValues(alpha: 0.1)
                        : AppTheme.secondaryDark,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: isSelected
                          ? AppTheme.accentGold
                          : AppTheme.borderGray,
                      width: isSelected ? 2 : 1,
                    ),
                  ),
                  child: ListTile(
                    contentPadding: EdgeInsets.all(3.w),
                    leading: Container(
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
                    title: Text(
                      account['name'] as String,
                      style: AppTheme.darkTheme.textTheme.titleMedium,
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 0.5.h),
                        Text(
                          account['accountNumber'] as String,
                          style:
                              AppTheme.darkTheme.textTheme.bodySmall?.copyWith(
                            color: AppTheme.textSecondary,
                          ),
                        ),
                        Text(
                          'Available: \$${(account['balance'] as double).toStringAsFixed(2)}',
                          style:
                              AppTheme.darkTheme.textTheme.bodySmall?.copyWith(
                            color: AppTheme.successGreen,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                    trailing: Radio<String>(
                      value: account['id'] as String,
                      groupValue: widget.selectedAccount,
                      onChanged: (value) {
                        if (value != null) {
                          widget.onAccountChanged(value);
                        }
                      },
                      activeColor: AppTheme.accentGold,
                    ),
                    onTap: () {
                      widget.onAccountChanged(account['id'] as String);
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
