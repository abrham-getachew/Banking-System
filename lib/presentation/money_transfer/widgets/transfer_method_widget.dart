import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';

class TransferMethodWidget extends StatefulWidget {
  final List<Map<String, dynamic>> methods;
  final String selectedMethod;
  final DateTime? scheduledDate;
  final String message;
  final Function(String, DateTime?) onMethodChanged;
  final Function(String) onMessageChanged;

  const TransferMethodWidget({
    super.key,
    required this.methods,
    required this.selectedMethod,
    this.scheduledDate,
    required this.message,
    required this.onMethodChanged,
    required this.onMessageChanged,
  });

  @override
  State<TransferMethodWidget> createState() => _TransferMethodWidgetState();
}

class _TransferMethodWidgetState extends State<TransferMethodWidget> {
  final TextEditingController _messageController = TextEditingController();
  DateTime? _selectedDate;
  final int _maxMessageLength = 140;

  @override
  void initState() {
    super.initState();
    _messageController.text = widget.message;
    _selectedDate = widget.scheduledDate;
  }

  @override
  void dispose() {
    _messageController.dispose();
    super.dispose();
  }

  void _selectDate() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate ?? DateTime.now().add(const Duration(days: 1)),
      firstDate: DateTime.now().add(const Duration(days: 1)),
      lastDate: DateTime.now().add(const Duration(days: 365)),
      builder: (context, child) {
        return Theme(
          data: AppTheme.darkTheme.copyWith(
            datePickerTheme: DatePickerThemeData(
              backgroundColor: AppTheme.surfaceModal,
              headerBackgroundColor: AppTheme.accentGold,
              headerForegroundColor: AppTheme.primaryDark,
              dayForegroundColor: WidgetStateProperty.resolveWith((states) {
                if (states.contains(WidgetState.selected)) {
                  return AppTheme.primaryDark;
                }
                return AppTheme.textPrimary;
              }),
              dayBackgroundColor: WidgetStateProperty.resolveWith((states) {
                if (states.contains(WidgetState.selected)) {
                  return AppTheme.accentGold;
                }
                return Colors.transparent;
              }),
              todayForegroundColor:
                  WidgetStateProperty.all(AppTheme.accentGold),
              todayBackgroundColor: WidgetStateProperty.all(Colors.transparent),
              todayBorder: BorderSide(color: AppTheme.accentGold, width: 1),
            ),
          ),
          child: child!,
        );
      },
    );

    if (picked != null) {
      setState(() {
        _selectedDate = picked;
      });
      widget.onMethodChanged(widget.selectedMethod, picked);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(4.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Transfer Methods
          Text(
            'Transfer Method',
            style: AppTheme.darkTheme.textTheme.titleMedium,
          ),

          SizedBox(height: 2.h),

          Expanded(
            flex: 3,
            child: ListView.builder(
              itemCount: widget.methods.length,
              itemBuilder: (context, index) {
                final method = widget.methods[index];
                final isSelected = method['id'] == widget.selectedMethod;
                final fee = method['fee'] as double;

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
                        color: isSelected
                            ? AppTheme.accentGold.withValues(alpha: 0.2)
                            : AppTheme.borderGray.withValues(alpha: 0.2),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: CustomIconWidget(
                        iconName: method['icon'] as String,
                        color: isSelected
                            ? AppTheme.accentGold
                            : AppTheme.textSecondary,
                        size: 6.w,
                      ),
                    ),
                    title: Row(
                      children: [
                        Text(
                          method['name'] as String,
                          style: AppTheme.darkTheme.textTheme.titleMedium,
                        ),
                        Spacer(),
                        if (fee > 0)
                          Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: 2.w,
                              vertical: 0.5.h,
                            ),
                            decoration: BoxDecoration(
                              color:
                                  AppTheme.warningAmber.withValues(alpha: 0.2),
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: Text(
                              '\$${fee.toStringAsFixed(2)}',
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
                              color:
                                  AppTheme.successGreen.withValues(alpha: 0.2),
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
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 0.5.h),
                        Text(
                          method['description'] as String,
                          style:
                              AppTheme.darkTheme.textTheme.bodySmall?.copyWith(
                            color: AppTheme.textSecondary,
                          ),
                        ),
                        Text(
                          method['duration'] as String,
                          style:
                              AppTheme.darkTheme.textTheme.bodySmall?.copyWith(
                            color: AppTheme.textSecondary,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                    trailing: Radio<String>(
                      value: method['id'] as String,
                      groupValue: widget.selectedMethod,
                      onChanged: (value) {
                        if (value != null) {
                          widget.onMethodChanged(value, _selectedDate);
                        }
                      },
                      activeColor: AppTheme.accentGold,
                    ),
                    onTap: () {
                      widget.onMethodChanged(
                          method['id'] as String, _selectedDate);
                    },
                  ),
                );
              },
            ),
          ),

          // Scheduled Date Picker (if scheduled method is selected)
          if (widget.selectedMethod == 'scheduled') ...[
            SizedBox(height: 2.h),
            Container(
              padding: EdgeInsets.all(3.w),
              decoration: BoxDecoration(
                color: AppTheme.secondaryDark,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: AppTheme.borderGray,
                  width: 1,
                ),
              ),
              child: Row(
                children: [
                  CustomIconWidget(
                    iconName: 'event',
                    color: AppTheme.accentGold,
                    size: 6.w,
                  ),
                  SizedBox(width: 3.w),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Schedule Date',
                          style:
                              AppTheme.darkTheme.textTheme.bodyMedium?.copyWith(
                            color: AppTheme.textSecondary,
                          ),
                        ),
                        Text(
                          _selectedDate != null
                              ? '${_selectedDate!.day}/${_selectedDate!.month}/${_selectedDate!.year}'
                              : 'Select date',
                          style: AppTheme.darkTheme.textTheme.titleMedium,
                        ),
                      ],
                    ),
                  ),
                  TextButton(
                    onPressed: _selectDate,
                    child: Text('Change'),
                  ),
                ],
              ),
            ),
          ],

          SizedBox(height: 3.h),

          // Message Field
          Text(
            'Message (Optional)',
            style: AppTheme.darkTheme.textTheme.titleMedium,
          ),

          SizedBox(height: 1.h),

          Expanded(
            flex: 2,
            child: Container(
              decoration: BoxDecoration(
                color: AppTheme.secondaryDark,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: AppTheme.borderGray,
                  width: 1,
                ),
              ),
              child: TextField(
                controller: _messageController,
                maxLines: 4,
                maxLength: _maxMessageLength,
                style: AppTheme.darkTheme.textTheme.bodyMedium,
                decoration: InputDecoration(
                  hintText: 'Add a note for the recipient...',
                  hintStyle: AppTheme.darkTheme.textTheme.bodyMedium?.copyWith(
                    color: AppTheme.textSecondary,
                  ),
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.all(3.w),
                  counterStyle:
                      AppTheme.darkTheme.textTheme.bodySmall?.copyWith(
                    color: AppTheme.textSecondary,
                  ),
                ),
                onChanged: (value) {
                  widget.onMessageChanged(value);
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
