import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';
import '../../../theme/app_theme.dart';

class AmountInputWidget extends StatefulWidget {
  final TextEditingController controller;
  final Function(String) onChanged;
  final double minAmount;
  final double maxAmount;

  const AmountInputWidget({
    super.key,
    required this.controller,
    required this.onChanged,
    required this.minAmount,
    required this.maxAmount,
  });

  @override
  State<AmountInputWidget> createState() => _AmountInputWidgetState();
}

class _AmountInputWidgetState extends State<AmountInputWidget> {
  final FocusNode _focusNode = FocusNode();

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  String? _getErrorText() {
    if (widget.controller.text.isEmpty) return null;

    final amount = double.tryParse(widget.controller.text.replaceAll(',', ''));
    if (amount == null) return 'Please enter a valid amount';
    if (amount < widget.minAmount)
      return 'Minimum investment: \$${widget.minAmount.toInt()}';
    if (amount > widget.maxAmount)
      return 'Maximum investment: \$${(widget.maxAmount / 1000).toInt()}K';

    return null;
  }

  void _formatAmount(String value) {
    if (value.isEmpty) return;

    final cleanValue = value.replaceAll(',', '');
    final amount = double.tryParse(cleanValue);

    if (amount != null) {
      final formatted = amount.toInt().toString().replaceAllMapped(
            RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
            (Match m) => '${m[1]},',
          );

      widget.controller.value = TextEditingValue(
        text: formatted,
        selection: TextSelection.collapsed(offset: formatted.length),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Investment Amount',
          style: AppTheme.darkTheme.textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
        SizedBox(height: 1.h),
        Text(
          'How much would you like to invest?',
          style: AppTheme.darkTheme.textTheme.bodyMedium?.copyWith(
            color: AppTheme.textSecondary,
          ),
        ),
        SizedBox(height: 2.h),
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16.0),
            color: AppTheme.surfaceDark,
            border: Border.all(
              color: _focusNode.hasFocus
                  ? AppTheme.chronosGold
                  : (_getErrorText() != null
                      ? AppTheme.errorRed
                      : AppTheme.dividerSubtle),
              width: _focusNode.hasFocus ? 2.0 : 1.0,
            ),
          ),
          child: TextFormField(
            controller: widget.controller,
            focusNode: _focusNode,
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
            inputFormatters: [
              FilteringTextInputFormatter.allow(RegExp(r'[\d,.]')),
              LengthLimitingTextInputFormatter(15),
            ],
            style: AppTheme.darkTheme.textTheme.headlineSmall?.copyWith(
              fontWeight: FontWeight.w600,
              color: AppTheme.textPrimary,
            ),
            decoration: InputDecoration(
              prefixIcon: Padding(
                padding: EdgeInsets.all(4.w),
                child: Text(
                  '\$',
                  style: AppTheme.darkTheme.textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.w600,
                    color: AppTheme.chronosGold,
                  ),
                ),
              ),
              hintText: '1,000',
              hintStyle: AppTheme.darkTheme.textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.w400,
                color: AppTheme.textTertiary,
              ),
              border: InputBorder.none,
              errorBorder: InputBorder.none,
              enabledBorder: InputBorder.none,
              focusedBorder: InputBorder.none,
              contentPadding:
                  EdgeInsets.symmetric(horizontal: 4.w, vertical: 3.h),
            ),
            onChanged: (value) {
              _formatAmount(value);
              widget.onChanged(value);
              setState(() {});
            },
          ),
        ),
        if (_getErrorText() != null) ...[
          SizedBox(height: 1.h),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 2.w),
            child: Text(
              _getErrorText()!,
              style: AppTheme.darkTheme.textTheme.bodySmall?.copyWith(
                color: AppTheme.errorRed,
              ),
            ),
          ),
        ],
        SizedBox(height: 2.h),
        Row(
          children: [
            _QuickAmountButton(
              amount: 500,
              controller: widget.controller,
              onChanged: widget.onChanged,
            ),
            SizedBox(width: 2.w),
            _QuickAmountButton(
              amount: 1000,
              controller: widget.controller,
              onChanged: widget.onChanged,
            ),
            SizedBox(width: 2.w),
            _QuickAmountButton(
              amount: 5000,
              controller: widget.controller,
              onChanged: widget.onChanged,
            ),
          ],
        ),
      ],
    );
  }
}

class _QuickAmountButton extends StatelessWidget {
  final int amount;
  final TextEditingController controller;
  final Function(String) onChanged;

  const _QuickAmountButton({
    required this.amount,
    required this.controller,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: OutlinedButton(
        onPressed: () {
          final formatted = amount.toString().replaceAllMapped(
                RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
                (Match m) => '${m[1]},',
              );
          controller.text = formatted;
          onChanged(formatted);
        },
        style: OutlinedButton.styleFrom(
          side: BorderSide(
            color: AppTheme.dividerSubtle,
            width: 1.0,
          ),
          padding: EdgeInsets.symmetric(vertical: 1.h),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
        ),
        child: Text(
          '\$${amount >= 1000 ? '${(amount / 1000).toInt()}K' : amount.toString()}',
          style: AppTheme.darkTheme.textTheme.bodyMedium?.copyWith(
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}
