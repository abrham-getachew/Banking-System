import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';

class TradingBottomSheetWidget extends StatefulWidget {
  final Map<String, dynamic> coinData;
  final Function(String, double) onTrade;

  const TradingBottomSheetWidget({
    Key? key,
    required this.coinData,
    required this.onTrade,
  }) : super(key: key);

  @override
  State<TradingBottomSheetWidget> createState() =>
      _TradingBottomSheetWidgetState();
}

class _TradingBottomSheetWidgetState extends State<TradingBottomSheetWidget> {
  bool _isBuying = true;
  String _orderType = 'market'; // market, limit
  double _amount = 0.0;
  double _usdAmount = 0.0;
  bool _isAmountInCrypto = true;
  final TextEditingController _amountController = TextEditingController();
  final TextEditingController _limitPriceController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _amountController.addListener(_onAmountChanged);
  }

  @override
  void dispose() {
    _amountController.dispose();
    _limitPriceController.dispose();
    super.dispose();
  }

  void _onAmountChanged() {
    final text = _amountController.text;
    if (text.isNotEmpty) {
      final value = double.tryParse(text) ?? 0.0;
      setState(() {
        if (_isAmountInCrypto) {
          _amount = value;
          _usdAmount = value * (widget.coinData["currentPrice"] as double);
        } else {
          _usdAmount = value;
          _amount = value / (widget.coinData["currentPrice"] as double);
        }
      });
    }
  }

  void _switchAmountType() {
    setState(() {
      _isAmountInCrypto = !_isAmountInCrypto;
      if (_isAmountInCrypto) {
        _amountController.text = _amount.toStringAsFixed(6);
      } else {
        _amountController.text = _usdAmount.toStringAsFixed(2);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 85.h,
      decoration: BoxDecoration(
        color: AppTheme.surfaceModal,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      child: Column(
        children: [
          _buildHandle(),
          _buildHeader(),
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.all(4.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildTradeToggle(),
                  SizedBox(height: 3.h),
                  _buildOrderTypeSelector(),
                  SizedBox(height: 3.h),
                  _buildAmountInput(),
                  SizedBox(height: 3.h),
                  if (_orderType == 'limit') ...[
                    _buildLimitPriceInput(),
                    SizedBox(height: 3.h),
                  ],
                  _buildOrderSummary(),
                  SizedBox(height: 3.h),
                  _buildQuickAmountButtons(),
                  SizedBox(height: 4.h),
                  _buildTradeButton(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHandle() {
    return Container(
      margin: EdgeInsets.only(top: 1.h),
      width: 10.w,
      height: 0.5.h,
      decoration: BoxDecoration(
        color: AppTheme.borderGray,
        borderRadius: BorderRadius.circular(2),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: EdgeInsets.all(4.w),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(color: AppTheme.borderGray.withValues(alpha: 0.3)),
        ),
      ),
      child: Row(
        children: [
          CustomImageWidget(
            imageUrl: widget.coinData["logo"] as String,
            width: 32,
            height: 32,
            fit: BoxFit.cover,
          ),
          SizedBox(width: 3.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.coinData["name"] as String,
                  style: AppTheme.darkTheme.textTheme.titleMedium?.copyWith(
                    color: AppTheme.textPrimary,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  widget.coinData["symbol"] as String,
                  style: AppTheme.darkTheme.textTheme.bodySmall?.copyWith(
                    color: AppTheme.textSecondary,
                  ),
                ),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                '\$${(widget.coinData["currentPrice"] as double).toStringAsFixed(2)}',
                style: AppTheme.getMonospaceStyle(
                  isLight: false,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Text(
                '${(widget.coinData["priceChangePercent24h"] as double) >= 0 ? '+' : ''}${(widget.coinData["priceChangePercent24h"] as double).toStringAsFixed(2)}%',
                style: AppTheme.darkTheme.textTheme.bodySmall?.copyWith(
                  color:
                      (widget.coinData["priceChangePercent24h"] as double) >= 0
                          ? AppTheme.successGreen
                          : AppTheme.errorRed,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTradeToggle() {
    return Container(
      padding: EdgeInsets.all(1.w),
      decoration: BoxDecoration(
        color: AppTheme.secondaryDark,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Expanded(
            child: GestureDetector(
              onTap: () => setState(() => _isBuying = true),
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 2.h),
                decoration: BoxDecoration(
                  color: _isBuying ? AppTheme.successGreen : Colors.transparent,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  'Buy',
                  textAlign: TextAlign.center,
                  style: AppTheme.darkTheme.textTheme.titleSmall?.copyWith(
                    color: _isBuying
                        ? AppTheme.primaryDark
                        : AppTheme.textSecondary,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: GestureDetector(
              onTap: () => setState(() => _isBuying = false),
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 2.h),
                decoration: BoxDecoration(
                  color: !_isBuying ? AppTheme.errorRed : Colors.transparent,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  'Sell',
                  textAlign: TextAlign.center,
                  style: AppTheme.darkTheme.textTheme.titleSmall?.copyWith(
                    color: !_isBuying
                        ? AppTheme.primaryDark
                        : AppTheme.textSecondary,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildOrderTypeSelector() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Order Type',
          style: AppTheme.darkTheme.textTheme.titleSmall?.copyWith(
            color: AppTheme.textPrimary,
            fontWeight: FontWeight.w600,
          ),
        ),
        SizedBox(height: 1.h),
        Row(
          children: [
            Expanded(
              child: RadioListTile<String>(
                title: Text('Market'),
                subtitle: Text('Execute immediately'),
                value: 'market',
                groupValue: _orderType,
                onChanged: (value) => setState(() => _orderType = value!),
                contentPadding: EdgeInsets.zero,
              ),
            ),
            Expanded(
              child: RadioListTile<String>(
                title: Text('Limit'),
                subtitle: Text('Set target price'),
                value: 'limit',
                groupValue: _orderType,
                onChanged: (value) => setState(() => _orderType = value!),
                contentPadding: EdgeInsets.zero,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildAmountInput() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Amount',
              style: AppTheme.darkTheme.textTheme.titleSmall?.copyWith(
                color: AppTheme.textPrimary,
                fontWeight: FontWeight.w600,
              ),
            ),
            TextButton(
              onPressed: _switchAmountType,
              child: Text(
                _isAmountInCrypto
                    ? 'Switch to USD'
                    : 'Switch to ${widget.coinData["symbol"]}',
                style: AppTheme.darkTheme.textTheme.bodySmall?.copyWith(
                  color: AppTheme.accentGold,
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 1.h),
        TextField(
          controller: _amountController,
          keyboardType: TextInputType.numberWithOptions(decimal: true),
          decoration: InputDecoration(
            hintText: _isAmountInCrypto
                ? '0.000000 ${widget.coinData["symbol"]}'
                : '\$0.00',
            suffixText:
                _isAmountInCrypto ? widget.coinData["symbol"] as String : 'USD',
          ),
        ),
        SizedBox(height: 1.h),
        Text(
          _isAmountInCrypto
              ? '≈ \$${_usdAmount.toStringAsFixed(2)}'
              : '≈ ${_amount.toStringAsFixed(6)} ${widget.coinData["symbol"]}',
          style: AppTheme.darkTheme.textTheme.bodySmall?.copyWith(
            color: AppTheme.textSecondary,
          ),
        ),
      ],
    );
  }

  Widget _buildLimitPriceInput() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Limit Price',
          style: AppTheme.darkTheme.textTheme.titleSmall?.copyWith(
            color: AppTheme.textPrimary,
            fontWeight: FontWeight.w600,
          ),
        ),
        SizedBox(height: 1.h),
        TextField(
          controller: _limitPriceController,
          keyboardType: TextInputType.numberWithOptions(decimal: true),
          decoration: InputDecoration(
            hintText:
                '\$${(widget.coinData["currentPrice"] as double).toStringAsFixed(2)}',
            suffixText: 'USD',
          ),
        ),
      ],
    );
  }

  Widget _buildOrderSummary() {
    return Container(
      padding: EdgeInsets.all(4.w),
      decoration: BoxDecoration(
        color: AppTheme.secondaryDark,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppTheme.borderGray.withValues(alpha: 0.3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Order Summary',
            style: AppTheme.darkTheme.textTheme.titleSmall?.copyWith(
              color: AppTheme.textPrimary,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: 2.h),
          _buildSummaryRow(
              'Type', '${_isBuying ? 'Buy' : 'Sell'} ${_orderType}'),
          _buildSummaryRow('Amount',
              '${_amount.toStringAsFixed(6)} ${widget.coinData["symbol"]}'),
          _buildSummaryRow('Price',
              '\$${(widget.coinData["currentPrice"] as double).toStringAsFixed(2)}'),
          _buildSummaryRow('Total', '\$${_usdAmount.toStringAsFixed(2)}'),
          Divider(color: AppTheme.borderGray.withValues(alpha: 0.3)),
          _buildSummaryRow(
              'Fee (0.1%)', '\$${(_usdAmount * 0.001).toStringAsFixed(2)}'),
          _buildSummaryRow(
            'Final Total',
            '\$${(_usdAmount + (_usdAmount * 0.001)).toStringAsFixed(2)}',
            isTotal: true,
          ),
        ],
      ),
    );
  }

  Widget _buildSummaryRow(String label, String value, {bool isTotal = false}) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 0.5.h),
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
            style: AppTheme.getMonospaceStyle(
              isLight: false,
              fontSize: 14,
              fontWeight: isTotal ? FontWeight.w600 : FontWeight.w400,
              color: isTotal ? AppTheme.textPrimary : AppTheme.textSecondary,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildQuickAmountButtons() {
    final percentages = [25, 50, 75, 100];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Quick Amount',
          style: AppTheme.darkTheme.textTheme.titleSmall?.copyWith(
            color: AppTheme.textPrimary,
            fontWeight: FontWeight.w600,
          ),
        ),
        SizedBox(height: 1.h),
        Row(
          children: percentages.map((percentage) {
            return Expanded(
              child: Container(
                margin: EdgeInsets.only(right: percentage != 100 ? 2.w : 0),
                child: OutlinedButton(
                  onPressed: () {
                    // Calculate amount based on percentage of available balance
                    final mockBalance = 1000.0; // Mock USD balance
                    final targetAmount = mockBalance * (percentage / 100);
                    setState(() {
                      _usdAmount = targetAmount;
                      _amount = targetAmount /
                          (widget.coinData["currentPrice"] as double);
                      _amountController.text = _isAmountInCrypto
                          ? _amount.toStringAsFixed(6)
                          : _usdAmount.toStringAsFixed(2);
                    });
                  },
                  child: Text('${percentage}%'),
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildTradeButton() {
    final isEnabled = _amount > 0;
    final buttonColor = _isBuying ? AppTheme.successGreen : AppTheme.errorRed;

    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: isEnabled
            ? () => widget.onTrade(_isBuying ? 'buy' : 'sell', _amount)
            : null,
        style: ElevatedButton.styleFrom(
          backgroundColor: buttonColor,
          foregroundColor: AppTheme.primaryDark,
          padding: EdgeInsets.symmetric(vertical: 2.h),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        child: Text(
          '${_isBuying ? 'Buy' : 'Sell'} ${widget.coinData["symbol"]}',
          style: AppTheme.darkTheme.textTheme.titleMedium?.copyWith(
            color: AppTheme.primaryDark,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}
