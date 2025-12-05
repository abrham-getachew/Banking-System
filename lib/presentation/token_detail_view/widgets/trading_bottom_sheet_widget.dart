import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../../core/app_export.dart';

class TradingBottomSheetWidget extends StatefulWidget {
  final Map<String, dynamic> tokenData;
  final Function(String, double) onTradeExecuted;

  const TradingBottomSheetWidget({
    Key? key,
    required this.tokenData,
    required this.onTradeExecuted,
  }) : super(key: key);

  @override
  State<TradingBottomSheetWidget> createState() =>
      _TradingBottomSheetWidgetState();
}

class _TradingBottomSheetWidgetState extends State<TradingBottomSheetWidget> {
  bool _isBuyMode = true;
  double _selectedPercentage = 0.0;
  final TextEditingController _amountController = TextEditingController();
  final double _availableBalance = 5000.0; // Mock balance
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _amountController.addListener(_onAmountChanged);
  }

  @override
  void dispose() {
    _amountController.dispose();
    super.dispose();
  }

  void _onAmountChanged() {
    final amount = double.tryParse(_amountController.text) ?? 0.0;
    final percentage = (amount / _availableBalance) * 100;
    setState(() {
      _selectedPercentage = percentage.clamp(0.0, 100.0);
    });
  }

  void _onPercentageChanged(double percentage) {
    setState(() {
      _selectedPercentage = percentage;
      final amount = (_availableBalance * percentage / 100);
      _amountController.text = amount.toStringAsFixed(2);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 45.h,
      decoration: const BoxDecoration(
        color: AppTheme.elevatedSurface,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Column(
        children: [
          _buildDragHandle(),
          _buildHeader(),
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 4.w),
              child: Column(
                children: [
                  _buildBuySellToggle(),
                  SizedBox(height: 3.h),
                  _buildBalanceInfo(),
                  SizedBox(height: 3.h),
                  _buildPercentageSlider(),
                  SizedBox(height: 3.h),
                  _buildAmountInput(),
                  SizedBox(height: 3.h),
                  _buildOrderSummary(),
                  SizedBox(height: 3.h),
                  _buildTradeButton(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDragHandle() {
    return Container(
      margin: EdgeInsets.only(top: 1.h),
      width: 12.w,
      height: 0.5.h,
      decoration: BoxDecoration(
        color: AppTheme.textSecondary.withValues(alpha: 0.3),
        borderRadius: BorderRadius.circular(2),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 2.h),
      child: Row(
        children: [
          Container(
            width: 10.w,
            height: 10.w,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5.w),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(5.w),
              child: CustomImageWidget(
                imageUrl: widget.tokenData["icon"] as String? ?? "",
                width: 10.w,
                height: 10.w,
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
                  "Trade ${widget.tokenData["symbol"] ?? ""}",
                  style: AppTheme.darkTheme.textTheme.titleLarge?.copyWith(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                Text(
                  "\$${(widget.tokenData["currentPrice"] as double? ?? 0.0).toStringAsFixed(2)}",
                  style: AppTheme.darkTheme.textTheme.bodyMedium?.copyWith(
                    color: AppTheme.textSecondary,
                    fontSize: 12.sp,
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.all(2.w),
            decoration: AppTheme.glassmorphicDecoration(
              borderRadius: 8,
              opacity: 0.1,
            ),
            child: CustomIconWidget(
              iconName: 'close',
              color: AppTheme.textSecondary,
              size: 5.w,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBuySellToggle() {
    return Container(
      padding: EdgeInsets.all(1.w),
      decoration: AppTheme.glassmorphicDecoration(
        borderRadius: 12,
        opacity: 0.1,
      ),
      child: Row(
        children: [
          Expanded(
            child: GestureDetector(
              onTap: () => setState(() => _isBuyMode = true),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                padding: EdgeInsets.symmetric(vertical: 2.h),
                decoration: BoxDecoration(
                  color: _isBuyMode
                      ? AppTheme.successGreen.withValues(alpha: 0.2)
                      : Colors.transparent,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    color:
                        _isBuyMode ? AppTheme.successGreen : Colors.transparent,
                    width: 1,
                  ),
                ),
                child: Center(
                  child: Text(
                    "Buy",
                    style: AppTheme.darkTheme.textTheme.titleMedium?.copyWith(
                      color: _isBuyMode
                          ? AppTheme.successGreen
                          : AppTheme.textSecondary,
                      fontWeight: FontWeight.w600,
                      fontSize: 14.sp,
                    ),
                  ),
                ),
              ),
            ),
          ),
          SizedBox(width: 2.w),
          Expanded(
            child: GestureDetector(
              onTap: () => setState(() => _isBuyMode = false),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                padding: EdgeInsets.symmetric(vertical: 2.h),
                decoration: BoxDecoration(
                  color: !_isBuyMode
                      ? AppTheme.errorRed.withValues(alpha: 0.2)
                      : Colors.transparent,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    color: !_isBuyMode ? AppTheme.errorRed : Colors.transparent,
                    width: 1,
                  ),
                ),
                child: Center(
                  child: Text(
                    "Sell",
                    style: AppTheme.darkTheme.textTheme.titleMedium?.copyWith(
                      color: !_isBuyMode
                          ? AppTheme.errorRed
                          : AppTheme.textSecondary,
                      fontWeight: FontWeight.w600,
                      fontSize: 14.sp,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBalanceInfo() {
    return Container(
      padding: EdgeInsets.all(3.w),
      decoration: AppTheme.glassmorphicDecoration(
        borderRadius: 12,
        opacity: 0.05,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "Available Balance",
            style: AppTheme.darkTheme.textTheme.bodyMedium?.copyWith(
              color: AppTheme.textSecondary,
              fontSize: 12.sp,
            ),
          ),
          Text(
            "\$${_availableBalance.toStringAsFixed(2)}",
            style: AppTheme.darkTheme.textTheme.titleMedium?.copyWith(
              color: AppTheme.textPrimary,
              fontWeight: FontWeight.w600,
              fontSize: 14.sp,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPercentageSlider() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Quick Select",
          style: AppTheme.darkTheme.textTheme.titleMedium?.copyWith(
            fontSize: 14.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
        SizedBox(height: 2.h),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [25, 50, 75, 100].map((percentage) {
            final isSelected = _selectedPercentage >= percentage - 5 &&
                _selectedPercentage <= percentage + 5;
            return GestureDetector(
              onTap: () => _onPercentageChanged(percentage.toDouble()),
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 1.h),
                decoration: BoxDecoration(
                  color: isSelected
                      ? AppTheme.primaryGold.withValues(alpha: 0.2)
                      : AppTheme.glassmorphicDecoration().color,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                    color:
                        isSelected ? AppTheme.primaryGold : Colors.transparent,
                    width: 1,
                  ),
                ),
                child: Text(
                  "$percentage%",
                  style: AppTheme.darkTheme.textTheme.labelMedium?.copyWith(
                    color: isSelected
                        ? AppTheme.primaryGold
                        : AppTheme.textSecondary,
                    fontWeight: FontWeight.w600,
                    fontSize: 12.sp,
                  ),
                ),
              ),
            );
          }).toList(),
        ),
        SizedBox(height: 2.h),
        SliderTheme(
          data: SliderTheme.of(context).copyWith(
            activeTrackColor: AppTheme.primaryGold,
            inactiveTrackColor: AppTheme.textSecondary.withValues(alpha: 0.3),
            thumbColor: AppTheme.primaryGold,
            overlayColor: AppTheme.primaryGold.withValues(alpha: 0.2),
            thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 8),
            trackHeight: 4,
          ),
          child: Slider(
            value: _selectedPercentage,
            min: 0,
            max: 100,
            divisions: 100,
            onChanged: _onPercentageChanged,
          ),
        ),
      ],
    );
  }

  Widget _buildAmountInput() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Amount (USD)",
          style: AppTheme.darkTheme.textTheme.titleMedium?.copyWith(
            fontSize: 14.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
        SizedBox(height: 1.h),
        TextFormField(
          controller: _amountController,
          keyboardType: TextInputType.number,
          style: AppTheme.darkTheme.textTheme.bodyLarge?.copyWith(
            fontSize: 16.sp,
            fontWeight: FontWeight.w600,
          ),
          decoration: InputDecoration(
            hintText: "0.00",
            prefixIcon: Padding(
              padding: EdgeInsets.all(3.w),
              child: Text(
                "\$",
                style: AppTheme.darkTheme.textTheme.bodyLarge?.copyWith(
                  color: AppTheme.textSecondary,
                  fontSize: 16.sp,
                ),
              ),
            ),
            suffixIcon: GestureDetector(
              onTap: () {
                _amountController.text = _availableBalance.toStringAsFixed(2);
                _onPercentageChanged(100);
              },
              child: Padding(
                padding: EdgeInsets.all(3.w),
                child: Text(
                  "MAX",
                  style: AppTheme.darkTheme.textTheme.labelMedium?.copyWith(
                    color: AppTheme.primaryGold,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildOrderSummary() {
    final amount = double.tryParse(_amountController.text) ?? 0.0;
    final tokenPrice = widget.tokenData["currentPrice"] as double? ?? 0.0;
    final tokenAmount = tokenPrice > 0 ? amount / tokenPrice : 0.0;
    final fee = amount * 0.001; // 0.1% fee

    return Container(
      padding: EdgeInsets.all(3.w),
      decoration: AppTheme.glassmorphicDecoration(
        borderRadius: 12,
        opacity: 0.05,
      ),
      child: Column(
        children: [
          _buildSummaryRow("You ${_isBuyMode ? 'pay' : 'receive'}",
              "\$${amount.toStringAsFixed(2)}"),
          SizedBox(height: 1.h),
          _buildSummaryRow("You ${_isBuyMode ? 'receive' : 'pay'}",
              "${tokenAmount.toStringAsFixed(6)} ${widget.tokenData["symbol"] ?? ""}"),
          SizedBox(height: 1.h),
          _buildSummaryRow("Trading Fee", "\$${fee.toStringAsFixed(2)}"),
        ],
      ),
    );
  }

  Widget _buildSummaryRow(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: AppTheme.darkTheme.textTheme.bodyMedium?.copyWith(
            color: AppTheme.textSecondary,
            fontSize: 12.sp,
          ),
        ),
        Text(
          value,
          style: AppTheme.darkTheme.textTheme.bodyMedium?.copyWith(
            color: AppTheme.textPrimary,
            fontWeight: FontWeight.w600,
            fontSize: 12.sp,
          ),
        ),
      ],
    );
  }

  Widget _buildTradeButton() {
    final amount = double.tryParse(_amountController.text) ?? 0.0;
    final isEnabled = amount > 0 && !_isLoading;

    return Container(
      width: double.infinity,
      margin: EdgeInsets.only(bottom: 2.h),
      child: ElevatedButton(
        onPressed: isEnabled ? _executeTrade : null,
        style: ElevatedButton.styleFrom(
          backgroundColor:
              _isBuyMode ? AppTheme.successGreen : AppTheme.errorRed,
          foregroundColor: AppTheme.textPrimary,
          padding: EdgeInsets.symmetric(vertical: 2.h),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        child: _isLoading
            ? SizedBox(
                height: 6.w,
                width: 6.w,
                child: CircularProgressIndicator(
                  color: AppTheme.textPrimary,
                  strokeWidth: 2,
                ),
              )
            : Text(
                "${_isBuyMode ? 'Buy' : 'Sell'} ${widget.tokenData["symbol"] ?? ""}",
                style: AppTheme.darkTheme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w700,
                  fontSize: 16.sp,
                ),
              ),
      ),
    );
  }

  void _executeTrade() async {
    setState(() => _isLoading = true);

    // Simulate biometric authentication and trade execution
    await Future.delayed(const Duration(seconds: 2));

    final amount = double.tryParse(_amountController.text) ?? 0.0;
    widget.onTradeExecuted(_isBuyMode ? "buy" : "sell", amount);

    setState(() => _isLoading = false);

    if (mounted) {
      Navigator.pop(context);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            "Trade executed successfully!",
            style: AppTheme.darkTheme.textTheme.bodyMedium,
          ),
          backgroundColor: AppTheme.successGreen,
          behavior: SnackBarBehavior.floating,
        ),
      );
    }
  }
}
