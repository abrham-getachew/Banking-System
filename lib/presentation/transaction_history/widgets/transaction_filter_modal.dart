import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';

class TransactionFilterModal extends StatefulWidget {
  final Function(List<String>) onFiltersApplied;
  final List<String> currentFilters;

  const TransactionFilterModal({
    super.key,
    required this.onFiltersApplied,
    required this.currentFilters,
  });

  @override
  State<TransactionFilterModal> createState() => _TransactionFilterModalState();
}

class _TransactionFilterModalState extends State<TransactionFilterModal> {
  DateTimeRange? _selectedDateRange;
  List<String> _selectedCategories = [];
  RangeValues _amountRange = RangeValues(0, 5000);
  String? _selectedAccount;

  final List<String> _categories = [
    'Food & Dining',
    'Income',
    'Shopping',
    'Transportation',
    'Entertainment',
    'Groceries',
    'Technology',
    'Bills & Utilities',
    'Healthcare',
    'Education',
  ];

  final List<String> _accounts = [
    'Main Checking',
    'Savings Account',
    'Credit Card',
    'Investment Account',
  ];

  @override
  void initState() {
    super.initState();
    _selectedCategories = List.from(widget.currentFilters);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 90.h,
      decoration: BoxDecoration(
        color: AppTheme.darkTheme.colorScheme.surface,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Column(
        children: [
          // Handle bar
          Container(
            width: 12.w,
            height: 0.5.h,
            margin: EdgeInsets.symmetric(vertical: 2.h),
            decoration: BoxDecoration(
              color: AppTheme.textSecondary,
              borderRadius: BorderRadius.circular(2),
            ),
          ),

          // Header
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 4.w),
            child: Row(
              children: [
                TextButton(
                  onPressed: _clearAllFilters,
                  child: Text(
                    'Clear All',
                    style: TextStyle(
                      color: AppTheme.textSecondary,
                      fontSize: 14.sp,
                    ),
                  ),
                ),
                Spacer(),
                Text(
                  'Filter Transactions',
                  style: TextStyle(
                    color: AppTheme.textPrimary,
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Spacer(),
                TextButton(
                  onPressed: _applyFilters,
                  child: Text(
                    'Apply',
                    style: TextStyle(
                      color: AppTheme.accentGold,
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          ),

          Divider(color: AppTheme.borderGray),

          // Filter options
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.all(4.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Date range
                  _buildSectionTitle('Date Range'),
                  _buildDateRangeSelector(),

                  SizedBox(height: 4.h),

                  // Categories
                  _buildSectionTitle('Categories'),
                  _buildCategorySelector(),

                  SizedBox(height: 4.h),

                  // Amount range
                  _buildSectionTitle('Amount Range'),
                  _buildAmountRangeSelector(),

                  SizedBox(height: 4.h),

                  // Account
                  _buildSectionTitle('Account'),
                  _buildAccountSelector(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: TextStyle(
        color: AppTheme.textPrimary,
        fontSize: 16.sp,
        fontWeight: FontWeight.w600,
      ),
    );
  }

  Widget _buildDateRangeSelector() {
    return Container(
      margin: EdgeInsets.only(top: 2.h),
      child: InkWell(
        onTap: _selectDateRange,
        child: Container(
          padding: EdgeInsets.all(4.w),
          decoration: BoxDecoration(
            color: AppTheme.secondaryDark,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: AppTheme.borderGray.withValues(alpha: 0.3),
              width: 1,
            ),
          ),
          child: Row(
            children: [
              CustomIconWidget(
                iconName: 'date_range',
                color: AppTheme.accentGold,
                size: 20,
              ),
              SizedBox(width: 3.w),
              Expanded(
                child: Text(
                  _selectedDateRange != null
                      ? '${_formatDate(_selectedDateRange!.start)} - ${_formatDate(_selectedDateRange!.end)}'
                      : 'Select date range',
                  style: TextStyle(
                    color: _selectedDateRange != null
                        ? AppTheme.textPrimary
                        : AppTheme.textSecondary,
                    fontSize: 14.sp,
                  ),
                ),
              ),
              CustomIconWidget(
                iconName: 'chevron_right',
                color: AppTheme.textSecondary,
                size: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCategorySelector() {
    return Container(
      margin: EdgeInsets.only(top: 2.h),
      child: Wrap(
        spacing: 2.w,
        runSpacing: 1.h,
        children: _categories.map((category) {
          final isSelected = _selectedCategories.contains(category);
          return FilterChip(
            label: Text(
              category,
              style: TextStyle(
                color: isSelected ? AppTheme.primaryDark : AppTheme.textPrimary,
                fontSize: 12.sp,
                fontWeight: FontWeight.w500,
              ),
            ),
            selected: isSelected,
            onSelected: (selected) {
              setState(() {
                if (selected) {
                  _selectedCategories.add(category);
                } else {
                  _selectedCategories.remove(category);
                }
              });
            },
            backgroundColor: AppTheme.secondaryDark,
            selectedColor: AppTheme.accentGold,
            checkmarkColor: AppTheme.primaryDark,
            side: BorderSide(
              color: isSelected
                  ? AppTheme.accentGold
                  : AppTheme.borderGray.withValues(alpha: 0.3),
              width: 1,
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildAmountRangeSelector() {
    return Container(
      margin: EdgeInsets.only(top: 2.h),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '\$${_amountRange.start.round()}',
                style: TextStyle(
                  color: AppTheme.textSecondary,
                  fontSize: 14.sp,
                ),
              ),
              Text(
                '\$${_amountRange.end.round()}',
                style: TextStyle(
                  color: AppTheme.textSecondary,
                  fontSize: 14.sp,
                ),
              ),
            ],
          ),
          RangeSlider(
            values: _amountRange,
            min: 0,
            max: 5000,
            divisions: 100,
            activeColor: AppTheme.accentGold,
            inactiveColor: AppTheme.borderGray,
            onChanged: (values) {
              setState(() {
                _amountRange = values;
              });
            },
          ),
        ],
      ),
    );
  }

  Widget _buildAccountSelector() {
    return Container(
      margin: EdgeInsets.only(top: 2.h),
      child: Column(
        children: _accounts.map((account) {
          final isSelected = _selectedAccount == account;
          return Container(
            margin: EdgeInsets.only(bottom: 1.h),
            child: InkWell(
              onTap: () {
                setState(() {
                  _selectedAccount = isSelected ? null : account;
                });
              },
              child: Container(
                padding: EdgeInsets.all(4.w),
                decoration: BoxDecoration(
                  color: isSelected
                      ? AppTheme.accentGold.withValues(alpha: 0.2)
                      : AppTheme.secondaryDark,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: isSelected
                        ? AppTheme.accentGold
                        : AppTheme.borderGray.withValues(alpha: 0.3),
                    width: 1,
                  ),
                ),
                child: Row(
                  children: [
                    CustomIconWidget(
                      iconName: 'account_balance',
                      color: isSelected
                          ? AppTheme.accentGold
                          : AppTheme.textSecondary,
                      size: 20,
                    ),
                    SizedBox(width: 3.w),
                    Expanded(
                      child: Text(
                        account,
                        style: TextStyle(
                          color: isSelected
                              ? AppTheme.accentGold
                              : AppTheme.textPrimary,
                          fontSize: 14.sp,
                          fontWeight:
                              isSelected ? FontWeight.w600 : FontWeight.w400,
                        ),
                      ),
                    ),
                    if (isSelected)
                      CustomIconWidget(
                        iconName: 'check',
                        color: AppTheme.accentGold,
                        size: 20,
                      ),
                  ],
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  void _selectDateRange() async {
    final DateTimeRange? picked = await showDateRangePicker(
      context: context,
      firstDate: DateTime.now().subtract(Duration(days: 365)),
      lastDate: DateTime.now(),
      initialDateRange: _selectedDateRange,
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.dark(
              primary: AppTheme.accentGold,
              onPrimary: AppTheme.primaryDark,
              surface: AppTheme.secondaryDark,
              onSurface: AppTheme.textPrimary,
            ),
          ),
          child: child!,
        );
      },
    );

    if (picked != null) {
      setState(() {
        _selectedDateRange = picked;
      });
    }
  }

  String _formatDate(DateTime date) {
    return '${date.day}/${date.month}/${date.year}';
  }

  void _clearAllFilters() {
    setState(() {
      _selectedDateRange = null;
      _selectedCategories.clear();
      _amountRange = RangeValues(0, 5000);
      _selectedAccount = null;
    });
  }

  void _applyFilters() {
    List<String> filters = [];

    if (_selectedDateRange != null) {
      filters.add(
          '${_formatDate(_selectedDateRange!.start)} - ${_formatDate(_selectedDateRange!.end)}');
    }

    filters.addAll(_selectedCategories);

    if (_amountRange.start > 0 || _amountRange.end < 5000) {
      filters.add(
          '\$${_amountRange.start.round()} - \$${_amountRange.end.round()}');
    }

    if (_selectedAccount != null) {
      filters.add(_selectedAccount!);
    }

    widget.onFiltersApplied(filters);
    Navigator.pop(context);
  }
}
