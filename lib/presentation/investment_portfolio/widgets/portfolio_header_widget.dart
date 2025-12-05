import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';

class PortfolioHeaderWidget extends StatelessWidget {
  final String totalValue;
  final String percentageChange;
  final bool isPositive;
  final String selectedPeriod;
  final Function(String) onPeriodChanged;

  const PortfolioHeaderWidget({
    super.key,
    required this.totalValue,
    required this.percentageChange,
    required this.isPositive,
    required this.selectedPeriod,
    required this.onPeriodChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 2.h),
      decoration: BoxDecoration(
        color: AppTheme.darkTheme.colorScheme.surface,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(16),
          bottomRight: Radius.circular(16),
        ),
        boxShadow: [
          BoxShadow(
            color: AppTheme.shadowDark,
            blurRadius: 8,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Total Portfolio Value',
            style: AppTheme.darkTheme.textTheme.bodyMedium?.copyWith(
              color: AppTheme.textSecondary,
            ),
          ),
          SizedBox(height: 0.5.h),
          Text(
            totalValue,
            style: AppTheme.financialDataLarge.copyWith(
              fontSize: 28.sp,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: 0.5.h),
          Row(
            children: [
              CustomIconWidget(
                iconName: isPositive ? 'trending_up' : 'trending_down',
                color: isPositive ? AppTheme.successGreen : AppTheme.errorRed,
                size: 16,
              ),
              SizedBox(width: 1.w),
              Text(
                percentageChange,
                style: AppTheme.darkTheme.textTheme.bodyMedium?.copyWith(
                  color: isPositive ? AppTheme.successGreen : AppTheme.errorRed,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
          SizedBox(height: 2.h),
          Row(
            children: ['1D', '1W', '1M', '1Y'].map((period) {
              final isSelected = period == selectedPeriod;
              return Expanded(
                child: GestureDetector(
                  onTap: () => onPeriodChanged(period),
                  child: Container(
                    margin: EdgeInsets.symmetric(horizontal: 1.w),
                    padding: EdgeInsets.symmetric(vertical: 1.h),
                    decoration: BoxDecoration(
                      color: isSelected
                          ? AppTheme.chronosGold.withValues(alpha: 0.2)
                          : Colors.transparent,
                      borderRadius: BorderRadius.circular(8),
                      border: isSelected
                          ? Border.all(color: AppTheme.chronosGold, width: 1)
                          : null,
                    ),
                    child: Text(
                      period,
                      textAlign: TextAlign.center,
                      style: AppTheme.darkTheme.textTheme.bodyMedium?.copyWith(
                        color: isSelected
                            ? AppTheme.chronosGold
                            : AppTheme.textSecondary,
                        fontWeight:
                            isSelected ? FontWeight.w600 : FontWeight.w400,
                      ),
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}
