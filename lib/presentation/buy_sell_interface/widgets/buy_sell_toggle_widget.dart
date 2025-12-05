import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';

class BuySellToggleWidget extends StatelessWidget {
  final bool isBuyMode;
  final Function(bool) onToggle;

  const BuySellToggleWidget({
    Key? key,
    required this.isBuyMode,
    required this.onToggle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(1.w),
      decoration: BoxDecoration(
        color: AppTheme.elevatedSurface.withValues(alpha: 0.5),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: AppTheme.textPrimary.withValues(alpha: 0.1),
          width: 1,
        ),
      ),
      child: Row(
        children: [
          Expanded(
            child: GestureDetector(
              onTap: () => onToggle(true),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                padding: EdgeInsets.symmetric(vertical: 2.h),
                decoration: BoxDecoration(
                  color: isBuyMode
                      ? AppTheme.successGreen.withValues(alpha: 0.2)
                      : Colors.transparent,
                  borderRadius: BorderRadius.circular(10),
                  border: isBuyMode
                      ? Border.all(
                          color: AppTheme.successGreen.withValues(alpha: 0.3),
                          width: 1,
                        )
                      : null,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CustomIconWidget(
                      iconName: 'trending_up',
                      color: isBuyMode
                          ? AppTheme.successGreen
                          : AppTheme.textSecondary,
                      size: 20,
                    ),
                    SizedBox(width: 2.w),
                    Text(
                      'Buy',
                      style: AppTheme.darkTheme.textTheme.titleMedium?.copyWith(
                        color: isBuyMode
                            ? AppTheme.successGreen
                            : AppTheme.textSecondary,
                        fontWeight:
                            isBuyMode ? FontWeight.w700 : FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Expanded(
            child: GestureDetector(
              onTap: () => onToggle(false),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                padding: EdgeInsets.symmetric(vertical: 2.h),
                decoration: BoxDecoration(
                  color: !isBuyMode
                      ? AppTheme.errorRed.withValues(alpha: 0.2)
                      : Colors.transparent,
                  borderRadius: BorderRadius.circular(10),
                  border: !isBuyMode
                      ? Border.all(
                          color: AppTheme.errorRed.withValues(alpha: 0.3),
                          width: 1,
                        )
                      : null,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CustomIconWidget(
                      iconName: 'trending_down',
                      color: !isBuyMode
                          ? AppTheme.errorRed
                          : AppTheme.textSecondary,
                      size: 20,
                    ),
                    SizedBox(width: 2.w),
                    Text(
                      'Sell',
                      style: AppTheme.darkTheme.textTheme.titleMedium?.copyWith(
                        color: !isBuyMode
                            ? AppTheme.errorRed
                            : AppTheme.textSecondary,
                        fontWeight:
                            !isBuyMode ? FontWeight.w700 : FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
