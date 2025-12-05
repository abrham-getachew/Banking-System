import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';

class CurrencyCardWidget extends StatelessWidget {
  final Map<String, dynamic> currency;
  final bool isSelected;
  final bool isBulkSelectionMode;
  final VoidCallback? onTap;
  final VoidCallback? onLongPress;

  const CurrencyCardWidget({
    Key? key,
    required this.currency,
    this.isSelected = false,
    this.isBulkSelectionMode = false,
    this.onTap,
    this.onLongPress,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final balance = currency["balance"] as double;
    final code = currency["code"] as String;
    final name = currency["name"] as String;
    final flag = currency["flag"] as String;
    final change24h = currency["change24h"] as double;
    final changePercent = currency["changePercent"] as double;
    final isPrimary = currency["isPrimary"] as bool;

    return GestureDetector(
      onTap: onTap,
      onLongPress: onLongPress,
      child: Container(
        width: 70.w,
        padding: EdgeInsets.all(4.w),
        decoration: BoxDecoration(
          color: isSelected
              ? AppTheme.accentGold.withValues(alpha: 0.1)
              : AppTheme.secondaryDark,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isSelected ? AppTheme.accentGold : AppTheme.borderGray,
            width: isSelected ? 2 : 1,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Text(
                      flag,
                      style: const TextStyle(fontSize: 24),
                    ),
                    SizedBox(width: 2.w),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          code,
                          style: AppTheme.darkTheme.textTheme.titleMedium
                              ?.copyWith(
                            color: AppTheme.textPrimary,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Text(
                          name,
                          style:
                              AppTheme.darkTheme.textTheme.bodySmall?.copyWith(
                            color: AppTheme.textSecondary,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                if (isBulkSelectionMode)
                  Container(
                    width: 6.w,
                    height: 6.w,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color:
                          isSelected ? AppTheme.accentGold : Colors.transparent,
                      border: Border.all(
                        color: isSelected
                            ? AppTheme.accentGold
                            : AppTheme.borderGray,
                        width: 2,
                      ),
                    ),
                    child: isSelected
                        ? CustomIconWidget(
                            iconName: 'check',
                            color: AppTheme.primaryDark,
                            size: 16,
                          )
                        : null,
                  )
                else if (isPrimary)
                  Container(
                    padding:
                        EdgeInsets.symmetric(horizontal: 2.w, vertical: 0.5.h),
                    decoration: BoxDecoration(
                      color: AppTheme.accentGold.withValues(alpha: 0.2),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      'Primary',
                      style: AppTheme.darkTheme.textTheme.bodySmall?.copyWith(
                        color: AppTheme.accentGold,
                        fontSize: 10.sp,
                      ),
                    ),
                  ),
              ],
            ),
            SizedBox(height: 3.h),
            Text(
              '\$${balance.toStringAsFixed(2)}',
              style: AppTheme.darkTheme.textTheme.headlineSmall?.copyWith(
                color: AppTheme.textPrimary,
                fontWeight: FontWeight.w700,
              ),
            ),
            SizedBox(height: 1.h),
            if (changePercent != 0.0)
              Row(
                children: [
                  CustomIconWidget(
                    iconName:
                        changePercent > 0 ? 'trending_up' : 'trending_down',
                    color: changePercent > 0
                        ? AppTheme.successGreen
                        : AppTheme.errorRed,
                    size: 16,
                  ),
                  SizedBox(width: 1.w),
                  Text(
                    '${changePercent > 0 ? '+' : ''}${changePercent.toStringAsFixed(2)}%',
                    style: AppTheme.darkTheme.textTheme.bodySmall?.copyWith(
                      color: changePercent > 0
                          ? AppTheme.successGreen
                          : AppTheme.errorRed,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(width: 2.w),
                  Text(
                    '${change24h > 0 ? '+' : ''}\$${change24h.toStringAsFixed(2)}',
                    style: AppTheme.darkTheme.textTheme.bodySmall?.copyWith(
                      color: AppTheme.textSecondary,
                    ),
                  ),
                ],
              ),
            SizedBox(height: 2.h),
            if (!isBulkSelectionMode)
              Row(
                children: [
                  Expanded(
                    child: _buildActionButton(
                      'Add Funds',
                      'add',
                      () {
                        // Handle add funds
                      },
                    ),
                  ),
                  SizedBox(width: 2.w),
                  Expanded(
                    child: _buildActionButton(
                      'Exchange',
                      'swap_horiz',
                      () {
                        // Handle exchange
                      },
                    ),
                  ),
                  SizedBox(width: 2.w),
                  Expanded(
                    child: _buildActionButton(
                      'Send',
                      'send',
                      () {
                        Navigator.pushNamed(context, '/money-transfer');
                      },
                    ),
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildActionButton(
      String label, String iconName, VoidCallback onPressed) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: AppTheme.accentGold.withValues(alpha: 0.1),
        foregroundColor: AppTheme.accentGold,
        elevation: 0,
        padding: EdgeInsets.symmetric(vertical: 1.h),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
          side: BorderSide(color: AppTheme.accentGold.withValues(alpha: 0.3)),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          CustomIconWidget(
            iconName: iconName,
            color: AppTheme.accentGold,
            size: 16,
          ),
          SizedBox(height: 0.5.h),
          Text(
            label,
            style: AppTheme.darkTheme.textTheme.bodySmall?.copyWith(
              color: AppTheme.accentGold,
              fontSize: 9.sp,
            ),
          ),
        ],
      ),
    );
  }
}
