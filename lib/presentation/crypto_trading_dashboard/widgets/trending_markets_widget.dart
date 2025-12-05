import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';

class TrendingMarketsWidget extends StatelessWidget {
  final List<Map<String, dynamic>> trendingTokens;
  final Function(Map<String, dynamic>) onTokenTap;

  const TrendingMarketsWidget({
    Key? key,
    required this.trendingTokens,
    required this.onTokenTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 2.h),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Trending Markets',
                style: AppTheme.darkTheme.textTheme.headlineSmall?.copyWith(
                  color: AppTheme.textPrimary,
                  fontWeight: FontWeight.w700,
                ),
              ),
              GestureDetector(
                onTap: () {
                  // Refresh trending markets
                },
                child: Container(
                  padding: EdgeInsets.all(2.w),
                  decoration: BoxDecoration(
                    color: AppTheme.primaryGold.withValues(alpha: 0.2),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: CustomIconWidget(
                    iconName: 'refresh',
                    color: AppTheme.primaryGold,
                    size: 20,
                  ),
                ),
              ),
            ],
          ),
        ),
        Container(
          height: 25.h,
          child: PageView.builder(
            controller: PageController(viewportFraction: 0.85),
            itemCount: (trendingTokens.length / 3).ceil(),
            itemBuilder: (context, pageIndex) {
              final startIndex = pageIndex * 3;
              final endIndex = (startIndex + 3).clamp(0, trendingTokens.length);
              final pageTokens = trendingTokens.sublist(startIndex, endIndex);

              return Container(
                margin: EdgeInsets.symmetric(horizontal: 2.w),
                padding: EdgeInsets.all(4.w),
                decoration: BoxDecoration(
                  color: AppTheme.elevatedSurface.withValues(alpha: 0.8),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: AppTheme.primaryGold.withValues(alpha: 0.3),
                    width: 1,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: AppTheme.shadowDark,
                      blurRadius: 12,
                      offset: const Offset(0, 6),
                    ),
                  ],
                ),
                child: Column(
                  children: pageTokens.map((token) {
                    final bool isPositive =
                        (token['changePercent'] as double) > 0;
                    final Color changeColor =
                        isPositive ? AppTheme.successGreen : AppTheme.errorRed;
                    final String changeSign = isPositive ? '+' : '';

                    return Expanded(
                      child: GestureDetector(
                        onTap: () => onTokenTap(token),
                        child: Container(
                          margin: EdgeInsets.symmetric(vertical: 1.h),
                          child: Row(
                            children: [
                              Container(
                                width: 12.w,
                                height: 12.w,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12.w),
                                  color: AppTheme.primaryGold
                                      .withValues(alpha: 0.2),
                                ),
                                child: Center(
                                  child: Text(
                                    token['symbol'] as String,
                                    style: AppTheme
                                        .darkTheme.textTheme.titleSmall
                                        ?.copyWith(
                                      color: AppTheme.primaryGold,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(width: 3.w),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      token['name'] as String,
                                      style: AppTheme
                                          .darkTheme.textTheme.titleSmall
                                          ?.copyWith(
                                        color: AppTheme.textPrimary,
                                        fontWeight: FontWeight.w600,
                                      ),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    Text(
                                      token['symbol'] as String,
                                      style: AppTheme
                                          .darkTheme.textTheme.bodySmall
                                          ?.copyWith(
                                        color: AppTheme.textSecondary,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    '\$${(token['price'] as double).toStringAsFixed(2)}',
                                    style: AppTheme
                                        .darkTheme.textTheme.titleSmall
                                        ?.copyWith(
                                      color: AppTheme.textPrimary,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      CustomIconWidget(
                                        iconName: isPositive
                                            ? 'trending_up'
                                            : 'trending_down',
                                        color: changeColor,
                                        size: 14,
                                      ),
                                      SizedBox(width: 1.w),
                                      Text(
                                        '$changeSign${(token['changePercent'] as double).toStringAsFixed(2)}%',
                                        style: AppTheme
                                            .darkTheme.textTheme.bodySmall
                                            ?.copyWith(
                                          color: changeColor,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  }).toList(),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
