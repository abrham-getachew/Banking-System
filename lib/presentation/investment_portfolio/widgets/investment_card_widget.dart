import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';

class InvestmentCardWidget extends StatelessWidget {
  final Map<String, dynamic> investment;
  final VoidCallback? onTap;
  final VoidCallback? onBuyMore;
  final VoidCallback? onSell;
  final VoidCallback? onViewDetails;

  const InvestmentCardWidget({
    super.key,
    required this.investment,
    this.onTap,
    this.onBuyMore,
    this.onSell,
    this.onViewDetails,
  });

  Color _getRiskColor(String riskLevel) {
    switch (riskLevel.toLowerCase()) {
      case 'low':
        return AppTheme.successGreen;
      case 'medium':
        return AppTheme.warningAmber;
      case 'high':
        return AppTheme.errorRed;
      default:
        return AppTheme.textSecondary;
    }
  }

  @override
  Widget build(BuildContext context) {
    final roi = investment['roi'] as double;
    final isPositive = roi >= 0;

    return Container(
      width: 70.w,
      margin: EdgeInsets.only(right: 4.w),
      child: Card(
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(16),
          child: Container(
            padding: EdgeInsets.all(4.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      width: 12.w,
                      height: 12.w,
                      decoration: BoxDecoration(
                        color: AppTheme.chronosGold.withValues(alpha: 0.2),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: CustomImageWidget(
                        imageUrl: investment['icon'] as String,
                        width: 12.w,
                        height: 12.w,
                        fit: BoxFit.cover,
                      ),
                    ),
                    SizedBox(width: 3.w),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            investment['name'] as String,
                            style: AppTheme.darkTheme.textTheme.titleMedium
                                ?.copyWith(
                              fontWeight: FontWeight.w600,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          SizedBox(height: 0.5.h),
                          Text(
                            investment['type'] as String,
                            style: AppTheme.darkTheme.textTheme.bodySmall
                                ?.copyWith(
                              color: AppTheme.textSecondary,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(
                          horizontal: 2.w, vertical: 0.5.h),
                      decoration: BoxDecoration(
                        color: _getRiskColor(investment['riskLevel'] as String)
                            .withValues(alpha: 0.2),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        investment['riskLevel'] as String,
                        style: AppTheme.darkTheme.textTheme.bodySmall?.copyWith(
                          color:
                              _getRiskColor(investment['riskLevel'] as String),
                          fontWeight: FontWeight.w500,
                          fontSize: 10.sp,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 3.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Current Value',
                          style:
                              AppTheme.darkTheme.textTheme.bodySmall?.copyWith(
                            color: AppTheme.textSecondary,
                          ),
                        ),
                        SizedBox(height: 0.5.h),
                        Text(
                          investment['currentValue'] as String,
                          style: AppTheme.financialDataMedium.copyWith(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          'ROI',
                          style:
                              AppTheme.darkTheme.textTheme.bodySmall?.copyWith(
                            color: AppTheme.textSecondary,
                          ),
                        ),
                        SizedBox(height: 0.5.h),
                        Row(
                          children: [
                            CustomIconWidget(
                              iconName:
                                  isPositive ? 'trending_up' : 'trending_down',
                              color: isPositive
                                  ? AppTheme.successGreen
                                  : AppTheme.errorRed,
                              size: 14,
                            ),
                            SizedBox(width: 1.w),
                            Text(
                              '${isPositive ? '+' : ''}${roi.toStringAsFixed(2)}%',
                              style: AppTheme.darkTheme.textTheme.bodyMedium
                                  ?.copyWith(
                                color: isPositive
                                    ? AppTheme.successGreen
                                    : AppTheme.errorRed,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(height: 2.h),
                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton(
                        onPressed: onBuyMore,
                        style: OutlinedButton.styleFrom(
                          padding: EdgeInsets.symmetric(vertical: 1.h),
                          side:
                              BorderSide(color: AppTheme.chronosGold, width: 1),
                        ),
                        child: Text(
                          'Buy More',
                          style: TextStyle(fontSize: 12.sp),
                        ),
                      ),
                    ),
                    SizedBox(width: 2.w),
                    Expanded(
                      child: OutlinedButton(
                        onPressed: onSell,
                        style: OutlinedButton.styleFrom(
                          padding: EdgeInsets.symmetric(vertical: 1.h),
                          side: BorderSide(color: AppTheme.errorRed, width: 1),
                          foregroundColor: AppTheme.errorRed,
                        ),
                        child: Text(
                          'Sell',
                          style: TextStyle(fontSize: 12.sp),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
