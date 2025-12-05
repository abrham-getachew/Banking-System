import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../../core/app_export.dart';

class PortfolioSummaryCard extends StatelessWidget {
  const PortfolioSummaryCard({super.key});

  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic> portfolioData = {
      "totalValue": "\$45,678.90",
      "change": "+12.34%",
      "changeValue": "+\$5,012.45",
      "isPositive": true,
      "assets": [
        {"symbol": "BTC", "value": "\$25,000.00", "percentage": "54.7%"},
        {"symbol": "ETH", "value": "\$15,000.00", "percentage": "32.8%"},
        {"symbol": "BNB", "value": "\$5,678.90", "percentage": "12.5%"},
      ],
    };

    return Container(
      margin: EdgeInsets.symmetric(horizontal: 4.w),
      padding: EdgeInsets.all(5.w),
      decoration: BoxDecoration(
        color: AppTheme.elevatedSurface.withValues(alpha: 0.9),
        borderRadius: BorderRadius.circular(5.w),
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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Portfolio Value',
                style: AppTheme.darkTheme.textTheme.titleMedium?.copyWith(
                  color: AppTheme.textSecondary,
                  fontWeight: FontWeight.w500,
                ),
              ),
              CustomIconWidget(
                iconName: 'visibility',
                color: AppTheme.textSecondary,
                size: 5.w,
              ),
            ],
          ),
          SizedBox(height: 2.h),
          Text(
            portfolioData["totalValue"] as String,
            style: AppTheme.darkTheme.textTheme.headlineMedium?.copyWith(
              color: AppTheme.textPrimary,
              fontWeight: FontWeight.w700,
            ),
          ),
          SizedBox(height: 1.h),
          Row(
            children: [
              CustomIconWidget(
                iconName: (portfolioData["isPositive"] as bool)
                    ? 'trending_up'
                    : 'trending_down',
                color: (portfolioData["isPositive"] as bool)
                    ? AppTheme.successGreen
                    : AppTheme.errorRed,
                size: 4.w,
              ),
              SizedBox(width: 2.w),
              Text(
                portfolioData["change"] as String,
                style: AppTheme.darkTheme.textTheme.bodyLarge?.copyWith(
                  color: (portfolioData["isPositive"] as bool)
                      ? AppTheme.successGreen
                      : AppTheme.errorRed,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(width: 2.w),
              Text(
                portfolioData["changeValue"] as String,
                style: AppTheme.darkTheme.textTheme.bodyMedium?.copyWith(
                  color: AppTheme.textSecondary,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),
          SizedBox(height: 3.h),
          Text(
            'Top Holdings',
            style: AppTheme.darkTheme.textTheme.titleSmall?.copyWith(
              color: AppTheme.textPrimary,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: 2.h),
          Column(
            children: (portfolioData["assets"] as List).map<Widget>((asset) {
              return Container(
                margin: EdgeInsets.only(bottom: 1.5.h),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Container(
                          width: 8.w,
                          height: 8.w,
                          decoration: BoxDecoration(
                            color: AppTheme.primaryGold.withValues(alpha: 0.2),
                            borderRadius: BorderRadius.circular(2.w),
                          ),
                          child: Center(
                            child: Text(
                              asset["symbol"] as String,
                              style: AppTheme.darkTheme.textTheme.labelSmall
                                  ?.copyWith(
                                color: AppTheme.primaryGold,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: 3.w),
                        Text(
                          asset["symbol"] as String,
                          style:
                              AppTheme.darkTheme.textTheme.bodyMedium?.copyWith(
                            color: AppTheme.textPrimary,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          asset["value"] as String,
                          style:
                              AppTheme.darkTheme.textTheme.bodyMedium?.copyWith(
                            color: AppTheme.textPrimary,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Text(
                          asset["percentage"] as String,
                          style:
                              AppTheme.darkTheme.textTheme.bodySmall?.copyWith(
                            color: AppTheme.textSecondary,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              );
            }).toList(),
          ),
          SizedBox(height: 3.h),
          Row(
            children: [
              Expanded(
                child: _buildActionButton(
                  context,
                  'Buy',
                  'add',
                  AppTheme.successGreen,
                  () => Navigator.pushNamed(context, '/buy-sell-interface'),
                ),
              ),
              SizedBox(width: 3.w),
              Expanded(
                child: _buildActionButton(
                  context,
                  'Sell',
                  'remove',
                  AppTheme.errorRed,
                  () => Navigator.pushNamed(context, '/buy-sell-interface'),
                ),
              ),
            ],
          ),
          SizedBox(height: 2.h),
          Row(
            children: [
              Expanded(
                child: _buildActionButton(
                  context,
                  'Exchange',
                  'swap_horiz',
                  AppTheme.primaryGold,
                  () => Navigator.pushNamed(context, '/token-exchange'),
                ),
              ),
              SizedBox(width: 3.w),
              Expanded(
                child: _buildActionButton(
                  context,
                  'Withdraw',
                  'account_balance_wallet',
                  AppTheme.infoBlue,
                  () {},
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildActionButton(
    BuildContext context,
    String label,
    String iconName,
    Color color,
    VoidCallback onPressed,
  ) {
    return Container(
      height: 6.h,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: color.withValues(alpha: 0.2),
          foregroundColor: color,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(3.w),
            side: BorderSide(
              color: color.withValues(alpha: 0.3),
              width: 1,
            ),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CustomIconWidget(
              iconName: iconName,
              color: color,
              size: 4.w,
            ),
            SizedBox(width: 2.w),
            Text(
              label,
              style: AppTheme.darkTheme.textTheme.bodyMedium?.copyWith(
                color: color,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
