import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';

class ExchangeRateWidget extends StatelessWidget {
  final Map<String, dynamic> currency;
  final VoidCallback? onTap;

  const ExchangeRateWidget({
    Key? key,
    required this.currency,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final code = currency["code"] as String;
    final name = currency["name"] as String;
    final flag = currency["flag"] as String;
    final rate = currency["rate"] as double;
    final change = currency["change"] as double;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(3.w),
        decoration: BoxDecoration(
          color: AppTheme.secondaryDark,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: AppTheme.borderGray, width: 1),
        ),
        child: Row(
          children: [
            Text(
              flag,
              style: const TextStyle(fontSize: 20),
            ),
            SizedBox(width: 3.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    code,
                    style: AppTheme.darkTheme.textTheme.titleSmall?.copyWith(
                      color: AppTheme.textPrimary,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    name,
                    style: AppTheme.darkTheme.textTheme.bodySmall?.copyWith(
                      color: AppTheme.textSecondary,
                    ),
                  ),
                ],
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  rate.toStringAsFixed(4),
                  style: AppTheme.darkTheme.textTheme.titleSmall?.copyWith(
                    color: AppTheme.textPrimary,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    CustomIconWidget(
                      iconName: change > 0 ? 'trending_up' : 'trending_down',
                      color: change > 0
                          ? AppTheme.successGreen
                          : AppTheme.errorRed,
                      size: 14,
                    ),
                    SizedBox(width: 1.w),
                    Text(
                      '${change > 0 ? '+' : ''}${change.toStringAsFixed(1)}%',
                      style: AppTheme.darkTheme.textTheme.bodySmall?.copyWith(
                        color: change > 0
                            ? AppTheme.successGreen
                            : AppTheme.errorRed,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(width: 2.w),
            Container(
              padding: EdgeInsets.all(1.w),
              decoration: BoxDecoration(
                color: AppTheme.accentGold.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(
                    color: AppTheme.accentGold.withValues(alpha: 0.3)),
              ),
              child: CustomIconWidget(
                iconName: 'add',
                color: AppTheme.accentGold,
                size: 16,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
