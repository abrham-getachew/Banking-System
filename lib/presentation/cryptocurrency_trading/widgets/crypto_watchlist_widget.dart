import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';

class CryptoWatchlistWidget extends StatelessWidget {
  final List<Map<String, dynamic>> cryptoData;
  final Function(String) onCoinTap;

  const CryptoWatchlistWidget({
    Key? key,
    required this.cryptoData,
    required this.onCoinTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 20.h,
      margin: EdgeInsets.symmetric(vertical: 2.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 4.w),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Watchlist',
                  style: AppTheme.darkTheme.textTheme.titleMedium?.copyWith(
                    color: AppTheme.textPrimary,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                TextButton(
                  onPressed: () {
                    // Edit watchlist
                  },
                  child: Text('Edit'),
                ),
              ],
            ),
          ),
          SizedBox(height: 1.h),
          Expanded(
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              padding: EdgeInsets.symmetric(horizontal: 4.w),
              itemCount: cryptoData.length,
              itemBuilder: (context, index) {
                final crypto = cryptoData[index];
                return _buildWatchlistCard(crypto);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildWatchlistCard(Map<String, dynamic> crypto) {
    final isPositive = (crypto["priceChangePercent24h"] as double) >= 0;
    final changeColor = isPositive ? AppTheme.successGreen : AppTheme.errorRed;
    final sparklineData = (crypto["sparklineData"] as List).cast<double>();

    return Container(
      width: 40.w,
      margin: EdgeInsets.only(right: 3.w),
      padding: EdgeInsets.all(3.w),
      decoration: BoxDecoration(
        color: AppTheme.secondaryDark,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppTheme.borderGray.withValues(alpha: 0.3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CustomImageWidget(
                imageUrl: crypto["logo"] as String,
                width: 24,
                height: 24,
                fit: BoxFit.cover,
              ),
              SizedBox(width: 2.w),
              Expanded(
                child: Text(
                  crypto["symbol"] as String,
                  style: AppTheme.darkTheme.textTheme.titleSmall?.copyWith(
                    color: AppTheme.textPrimary,
                    fontWeight: FontWeight.w600,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
          SizedBox(height: 1.h),
          Text(
            '\$${(crypto["currentPrice"] as double).toStringAsFixed(2)}',
            style: AppTheme.getMonospaceStyle(
              isLight: false,
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: 0.5.h),
          Row(
            children: [
              CustomIconWidget(
                iconName: isPositive ? 'trending_up' : 'trending_down',
                color: changeColor,
                size: 12,
              ),
              SizedBox(width: 1.w),
              Text(
                '${isPositive ? '+' : ''}${(crypto["priceChangePercent24h"] as double).toStringAsFixed(2)}%',
                style: AppTheme.darkTheme.textTheme.bodySmall?.copyWith(
                  color: changeColor,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
          SizedBox(height: 1.h),
          Expanded(
            child: Container(
              height: 6.h,
              child: LineChart(
                LineChartData(
                  gridData: FlGridData(show: false),
                  titlesData: FlTitlesData(show: false),
                  borderData: FlBorderData(show: false),
                  lineBarsData: [
                    LineChartBarData(
                      spots: sparklineData
                          .asMap()
                          .entries
                          .map((e) => FlSpot(e.key.toDouble(), e.value))
                          .toList(),
                      isCurved: true,
                      color: changeColor,
                      barWidth: 2,
                      dotData: FlDotData(show: false),
                      belowBarData: BarAreaData(
                        show: true,
                        color: changeColor.withValues(alpha: 0.1),
                      ),
                    ),
                  ],
                  minY: sparklineData.reduce((a, b) => a < b ? a : b) * 0.999,
                  maxY: sparklineData.reduce((a, b) => a > b ? a : b) * 1.001,
                ),
              ),
            ),
          ),
          SizedBox(height: 1.h),
          Row(
            children: [
              Expanded(
                child: ElevatedButton(
                  onPressed: () => onCoinTap(crypto["id"] as String),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppTheme.successGreen,
                    foregroundColor: AppTheme.primaryDark,
                    padding: EdgeInsets.symmetric(vertical: 1.h),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: Text(
                    'Buy',
                    style: AppTheme.darkTheme.textTheme.labelMedium?.copyWith(
                      color: AppTheme.primaryDark,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
              SizedBox(width: 2.w),
              Expanded(
                child: OutlinedButton(
                  onPressed: () => onCoinTap(crypto["id"] as String),
                  style: OutlinedButton.styleFrom(
                    foregroundColor: AppTheme.errorRed,
                    side: BorderSide(color: AppTheme.errorRed),
                    padding: EdgeInsets.symmetric(vertical: 1.h),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: Text(
                    'Sell',
                    style: AppTheme.darkTheme.textTheme.labelMedium?.copyWith(
                      color: AppTheme.errorRed,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
