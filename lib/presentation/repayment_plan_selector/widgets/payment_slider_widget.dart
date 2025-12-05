import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';

class PaymentSliderWidget extends StatefulWidget {
  final double currentAmount;
  final double minAmount;
  final double maxAmount;
  final Function(double) onChanged;

  const PaymentSliderWidget({
    super.key,
    required this.currentAmount,
    required this.minAmount,
    required this.maxAmount,
    required this.onChanged,
  });

  @override
  State<PaymentSliderWidget> createState() => _PaymentSliderWidgetState();
}

class _PaymentSliderWidgetState extends State<PaymentSliderWidget> {
  late double _currentValue;

  @override
  void initState() {
    super.initState();
    _currentValue = widget.currentAmount;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 4.w),
      padding: EdgeInsets.all(4.w),
      decoration: BoxDecoration(
        color: AppTheme.darkTheme.cardColor,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: AppTheme.primaryGold.withValues(alpha: 0.2),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CustomIconWidget(
                iconName: 'tune',
                color: AppTheme.primaryGold,
                size: 20,
              ),
              SizedBox(width: 2.w),
              Text(
                'Adjust Payment Amount',
                style: AppTheme.darkTheme.textTheme.titleMedium?.copyWith(
                  color: AppTheme.textPrimary,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),

          SizedBox(height: 3.h),

          // Current amount display
          Center(
            child: Column(
              children: [
                Text(
                  'Monthly Payment',
                  style: AppTheme.darkTheme.textTheme.bodySmall?.copyWith(
                    color: AppTheme.textSecondary,
                  ),
                ),
                SizedBox(height: 1.h),
                Text(
                  '\$${_currentValue.toStringAsFixed(2)}',
                  style: AppTheme.darkTheme.textTheme.headlineLarge?.copyWith(
                    color: AppTheme.primaryGold,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
          ),

          SizedBox(height: 3.h),

          // Slider
          SliderTheme(
            data: SliderTheme.of(context).copyWith(
              activeTrackColor: AppTheme.primaryGold,
              inactiveTrackColor: AppTheme.primaryGold.withValues(alpha: 0.2),
              thumbColor: AppTheme.primaryGold,
              overlayColor: AppTheme.primaryGold.withValues(alpha: 0.2),
              thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 12),
              overlayShape: const RoundSliderOverlayShape(overlayRadius: 20),
              trackHeight: 4,
              valueIndicatorColor: AppTheme.primaryGold,
              valueIndicatorTextStyle:
                  AppTheme.darkTheme.textTheme.bodySmall?.copyWith(
                color: AppTheme.backgroundDark,
                fontWeight: FontWeight.w600,
              ),
            ),
            child: Slider(
              value: _currentValue,
              min: widget.minAmount,
              max: widget.maxAmount,
              divisions: 20,
              label: '\$${_currentValue.toStringAsFixed(0)}',
              onChanged: (value) {
                setState(() {
                  _currentValue = value;
                });
                widget.onChanged(value);
              },
            ),
          ),

          // Min/Max labels
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 2.w),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '\$${widget.minAmount.toStringAsFixed(0)}',
                  style: AppTheme.darkTheme.textTheme.bodySmall?.copyWith(
                    color: AppTheme.textSecondary,
                  ),
                ),
                Text(
                  '\$${widget.maxAmount.toStringAsFixed(0)}',
                  style: AppTheme.darkTheme.textTheme.bodySmall?.copyWith(
                    color: AppTheme.textSecondary,
                  ),
                ),
              ],
            ),
          ),

          SizedBox(height: 2.h),

          // Impact on terms
          Container(
            padding: EdgeInsets.all(3.w),
            decoration: BoxDecoration(
              color: AppTheme.backgroundDark.withValues(alpha: 0.3),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              children: [
                CustomIconWidget(
                  iconName: 'info_outline',
                  color: AppTheme.primaryGold,
                  size: 16,
                ),
                SizedBox(width: 2.w),
                Expanded(
                  child: Text(
                    'Adjusting payment amount will recalculate your terms and total interest.',
                    style: AppTheme.darkTheme.textTheme.bodySmall?.copyWith(
                      color: AppTheme.textSecondary,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
