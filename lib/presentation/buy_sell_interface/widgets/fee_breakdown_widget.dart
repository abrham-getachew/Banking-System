import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';

class FeeBreakdownWidget extends StatefulWidget {
  final double networkFee;
  final double platformFee;
  final double gasPrice;
  final int estimatedGasUnits;

  const FeeBreakdownWidget({
    Key? key,
    required this.networkFee,
    required this.platformFee,
    required this.gasPrice,
    required this.estimatedGasUnits,
  }) : super(key: key);

  @override
  State<FeeBreakdownWidget> createState() => _FeeBreakdownWidgetState();
}

class _FeeBreakdownWidgetState extends State<FeeBreakdownWidget>
    with SingleTickerProviderStateMixin {
  bool _isExpanded = false;
  late AnimationController _animationController;
  late Animation<double> _expandAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    _expandAnimation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _toggleExpansion() {
    setState(() {
      _isExpanded = !_isExpanded;
      if (_isExpanded) {
        _animationController.forward();
      } else {
        _animationController.reverse();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final totalFees = widget.networkFee + widget.platformFee;

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
        children: [
          // Fee Summary Header
          GestureDetector(
            onTap: _toggleExpansion,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    CustomIconWidget(
                      iconName: 'account_balance_wallet',
                      color: AppTheme.warningAmber,
                      size: 20,
                    ),
                    SizedBox(width: 2.w),
                    Text(
                      'Estimated Fees',
                      style: AppTheme.darkTheme.textTheme.titleMedium?.copyWith(
                        color: AppTheme.textPrimary,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Text(
                      '\$${totalFees.toStringAsFixed(2)}',
                      style: AppTheme.darkTheme.textTheme.titleMedium?.copyWith(
                        color: AppTheme.warningAmber,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    SizedBox(width: 2.w),
                    AnimatedRotation(
                      turns: _isExpanded ? 0.5 : 0,
                      duration: const Duration(milliseconds: 300),
                      child: CustomIconWidget(
                        iconName: 'keyboard_arrow_down',
                        color: AppTheme.textSecondary,
                        size: 20,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          // Expandable Fee Details
          SizeTransition(
            sizeFactor: _expandAnimation,
            child: Column(
              children: [
                SizedBox(height: 3.h),
                Container(
                  height: 1,
                  color: AppTheme.textPrimary.withValues(alpha: 0.1),
                ),
                SizedBox(height: 2.h),

                // Network Fee Details
                _buildFeeRow(
                  'Network Fee',
                  '\$${widget.networkFee.toStringAsFixed(2)}',
                  subtitle:
                      'Gas: ${widget.estimatedGasUnits} units × ${widget.gasPrice.toStringAsFixed(2)} Gwei',
                ),

                // Platform Fee
                _buildFeeRow(
                  'Platform Fee',
                  '\$${widget.platformFee.toStringAsFixed(2)}',
                  subtitle: '0.5% of transaction amount',
                ),

                SizedBox(height: 2.h),

                // Fee Speed Options
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
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Transaction Speed',
                        style:
                            AppTheme.darkTheme.textTheme.labelMedium?.copyWith(
                          color: AppTheme.infoBlue,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(height: 1.h),
                      Row(
                        children: [
                          _buildSpeedOption('Slow', '~10 min', false),
                          SizedBox(width: 2.w),
                          _buildSpeedOption('Standard', '~5 min', true),
                          SizedBox(width: 2.w),
                          _buildSpeedOption('Fast', '~2 min', false),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFeeRow(String label, String amount, {String? subtitle}) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 1.h),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                label,
                style: AppTheme.darkTheme.textTheme.bodyMedium?.copyWith(
                  color: AppTheme.textPrimary,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Text(
                amount,
                style: AppTheme.darkTheme.textTheme.bodyMedium?.copyWith(
                  color: AppTheme.textPrimary,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          if (subtitle != null) ...[
            SizedBox(height: 0.5.h),
            Row(
              children: [
                Text(
                  subtitle,
                  style: AppTheme.darkTheme.textTheme.bodySmall?.copyWith(
                    color: AppTheme.textSecondary,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildSpeedOption(String label, String time, bool isSelected) {
    return Expanded(
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 1.h, horizontal: 2.w),
        decoration: BoxDecoration(
          color: isSelected
              ? AppTheme.primaryGold.withValues(alpha: 0.2)
              : AppTheme.elevatedSurface.withValues(alpha: 0.3),
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: isSelected
                ? AppTheme.primaryGold.withValues(alpha: 0.4)
                : AppTheme.textPrimary.withValues(alpha: 0.1),
            width: 1,
          ),
        ),
        child: Column(
          children: [
            Text(
              label,
              style: AppTheme.darkTheme.textTheme.labelSmall?.copyWith(
                color:
                    isSelected ? AppTheme.primaryGold : AppTheme.textSecondary,
                fontWeight: FontWeight.w600,
              ),
            ),
            Text(
              time,
              style: AppTheme.darkTheme.textTheme.labelSmall?.copyWith(
                color:
                    isSelected ? AppTheme.primaryGold : AppTheme.textSecondary,
                fontWeight: FontWeight.w400,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
