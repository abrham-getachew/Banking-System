import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../../core/app_export.dart';

class TokenHeaderWidget extends StatelessWidget {
  final Map<String, dynamic> tokenData;
  final VoidCallback onBackPressed;

  const TokenHeaderWidget({
    Key? key,
    required this.tokenData,
    required this.onBackPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final priceChange = (tokenData["priceChange"] as double? ?? 0.0);
    final isPositive = priceChange >= 0;

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 2.h),
      decoration: AppTheme.glassmorphicDecoration(
        borderRadius: 0,
        opacity: 0.05,
      ),
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                GestureDetector(
                  onTap: onBackPressed,
                  child: Container(
                    padding: EdgeInsets.all(2.w),
                    decoration: AppTheme.glassmorphicDecoration(
                      borderRadius: 8,
                      opacity: 0.1,
                    ),
                    child: CustomIconWidget(
                      iconName: 'arrow_back',
                      color: AppTheme.textPrimary,
                      size: 6.w,
                    ),
                  ),
                ),
                SizedBox(width: 4.w),
                Expanded(
                  child: Row(
                    children: [
                      Hero(
                        tag: 'token_${tokenData["id"]}',
                        child: Container(
                          width: 12.w,
                          height: 12.w,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(6.w),
                            boxShadow: AppTheme.elevationShadow(2),
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(6.w),
                            child: CustomImageWidget(
                              imageUrl: tokenData["icon"] as String? ?? "",
                              width: 12.w,
                              height: 12.w,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 3.w),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              tokenData["name"] as String? ?? "",
                              style: AppTheme.darkTheme.textTheme.titleLarge
                                  ?.copyWith(
                                fontSize: 18.sp,
                                fontWeight: FontWeight.w700,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                            Text(
                              tokenData["symbol"] as String? ?? "",
                              style: AppTheme.darkTheme.textTheme.bodyMedium
                                  ?.copyWith(
                                color: AppTheme.textSecondary,
                                fontSize: 12.sp,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(2.w),
                  decoration: AppTheme.glassmorphicDecoration(
                    borderRadius: 8,
                    opacity: 0.1,
                  ),
                  child: CustomIconWidget(
                    iconName: 'more_vert',
                    color: AppTheme.textPrimary,
                    size: 6.w,
                  ),
                ),
              ],
            ),
            SizedBox(height: 3.h),
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "\$${(tokenData["currentPrice"] as double? ?? 0.0).toStringAsFixed(2)}",
                        style: AppTheme.darkTheme.textTheme.headlineMedium
                            ?.copyWith(
                          fontSize: 28.sp,
                          fontWeight: FontWeight.w800,
                          color: AppTheme.textPrimary,
                        ),
                      ),
                      SizedBox(height: 0.5.h),
                      Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: 2.w, vertical: 0.5.h),
                        decoration: BoxDecoration(
                          color: isPositive
                              ? AppTheme.successGreen.withValues(alpha: 0.2)
                              : AppTheme.errorRed.withValues(alpha: 0.2),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            CustomIconWidget(
                              iconName:
                                  isPositive ? 'trending_up' : 'trending_down',
                              color: isPositive
                                  ? AppTheme.successGreen
                                  : AppTheme.errorRed,
                              size: 4.w,
                            ),
                            SizedBox(width: 1.w),
                            Text(
                              "${isPositive ? '+' : ''}${priceChange.toStringAsFixed(2)}%",
                              style: AppTheme.darkTheme.textTheme.labelMedium
                                  ?.copyWith(
                                color: isPositive
                                    ? AppTheme.successGreen
                                    : AppTheme.errorRed,
                                fontWeight: FontWeight.w600,
                                fontSize: 11.sp,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 1.h),
                  decoration: AppTheme.glassmorphicDecoration(
                    borderRadius: 8,
                    opacity: 0.1,
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      CustomIconWidget(
                        iconName: 'notifications_none',
                        color: AppTheme.primaryGold,
                        size: 5.w,
                      ),
                      SizedBox(width: 2.w),
                      Text(
                        "Alert",
                        style:
                            AppTheme.darkTheme.textTheme.labelMedium?.copyWith(
                          color: AppTheme.primaryGold,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
