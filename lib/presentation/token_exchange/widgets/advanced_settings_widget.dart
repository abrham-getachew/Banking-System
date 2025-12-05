import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';

class AdvancedSettingsWidget extends StatefulWidget {
  final double slippageTolerance;
  final int transactionDeadline;
  final String gasFee;
  final Function(double) onSlippageChanged;
  final Function(int) onDeadlineChanged;
  final VoidCallback onGasFeeCustomize;

  const AdvancedSettingsWidget({
    Key? key,
    required this.slippageTolerance,
    required this.transactionDeadline,
    required this.gasFee,
    required this.onSlippageChanged,
    required this.onDeadlineChanged,
    required this.onGasFeeCustomize,
  }) : super(key: key);

  @override
  State<AdvancedSettingsWidget> createState() => _AdvancedSettingsWidgetState();
}

class _AdvancedSettingsWidgetState extends State<AdvancedSettingsWidget> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: AppTheme.elevatedSurface.withValues(alpha: 0.4),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: AppTheme.primaryGold.withValues(alpha: 0.2),
          width: 1,
        ),
      ),
      child: Column(
        children: [
          GestureDetector(
            onTap: () {
              setState(() {
                _isExpanded = !_isExpanded;
              });
            },
            child: Padding(
              padding: EdgeInsets.all(4.w),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Advanced Settings',
                    style: AppTheme.darkTheme.textTheme.titleMedium?.copyWith(
                      color: AppTheme.textPrimary,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  AnimatedRotation(
                    turns: _isExpanded ? 0.5 : 0.0,
                    duration: const Duration(milliseconds: 200),
                    child: CustomIconWidget(
                      iconName: 'keyboard_arrow_down',
                      color: AppTheme.textSecondary,
                      size: 6.w,
                    ),
                  ),
                ],
              ),
            ),
          ),
          AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            height: _isExpanded ? null : 0,
            child: _isExpanded
                ? Padding(
                    padding: EdgeInsets.fromLTRB(4.w, 0, 4.w, 4.w),
                    child: Column(
                      children: [
                        Divider(
                          color: AppTheme.primaryGold.withValues(alpha: 0.2),
                          height: 1,
                        ),
                        SizedBox(height: 3.h),
                        _buildSlippageSection(),
                        SizedBox(height: 3.h),
                        _buildDeadlineSection(),
                        SizedBox(height: 3.h),
                        _buildGasFeeSection(),
                      ],
                    ),
                  )
                : const SizedBox.shrink(),
          ),
        ],
      ),
    );
  }

  Widget _buildSlippageSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Slippage Tolerance',
              style: AppTheme.darkTheme.textTheme.bodyMedium?.copyWith(
                color: AppTheme.textPrimary,
                fontWeight: FontWeight.w500,
              ),
            ),
            Text(
              '${widget.slippageTolerance.toStringAsFixed(1)}%',
              style: AppTheme.darkTheme.textTheme.bodyMedium?.copyWith(
                color: AppTheme.primaryGold,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
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
            value: widget.slippageTolerance,
            min: 0.1,
            max: 5.0,
            divisions: 49,
            onChanged: widget.onSlippageChanged,
          ),
        ),
      ],
    );
  }

  Widget _buildDeadlineSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Transaction Deadline',
              style: AppTheme.darkTheme.textTheme.bodyMedium?.copyWith(
                color: AppTheme.textPrimary,
                fontWeight: FontWeight.w500,
              ),
            ),
            Text(
              '${widget.transactionDeadline} min',
              style: AppTheme.darkTheme.textTheme.bodyMedium?.copyWith(
                color: AppTheme.primaryGold,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
        SizedBox(height: 2.h),
        Row(
          children: [
            _buildDeadlineButton(10),
            SizedBox(width: 2.w),
            _buildDeadlineButton(20),
            SizedBox(width: 2.w),
            _buildDeadlineButton(30),
            SizedBox(width: 2.w),
            _buildDeadlineButton(60),
          ],
        ),
      ],
    );
  }

  Widget _buildDeadlineButton(int minutes) {
    final isSelected = widget.transactionDeadline == minutes;
    return Expanded(
      child: GestureDetector(
        onTap: () => widget.onDeadlineChanged(minutes),
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 2.h),
          decoration: BoxDecoration(
            color: isSelected
                ? AppTheme.primaryGold.withValues(alpha: 0.2)
                : AppTheme.deepCharcoal.withValues(alpha: 0.6),
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              color: isSelected
                  ? AppTheme.primaryGold
                  : AppTheme.textSecondary.withValues(alpha: 0.3),
              width: 1,
            ),
          ),
          child: Text(
            '${minutes}m',
            textAlign: TextAlign.center,
            style: AppTheme.darkTheme.textTheme.bodySmall?.copyWith(
              color: isSelected ? AppTheme.primaryGold : AppTheme.textSecondary,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildGasFeeSection() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Gas Fee',
              style: AppTheme.darkTheme.textTheme.bodyMedium?.copyWith(
                color: AppTheme.textPrimary,
                fontWeight: FontWeight.w500,
              ),
            ),
            Text(
              widget.gasFee,
              style: AppTheme.darkTheme.textTheme.bodySmall?.copyWith(
                color: AppTheme.textSecondary,
              ),
            ),
          ],
        ),
        TextButton(
          onPressed: widget.onGasFeeCustomize,
          child: Text(
            'Customize',
            style: AppTheme.darkTheme.textTheme.bodyMedium?.copyWith(
              color: AppTheme.primaryGold,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
    );
  }
}
