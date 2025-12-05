import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';

class PortfolioTabWidget extends StatelessWidget {
  final List<Map<String, dynamic>> cryptoData;
  final Function(String) onTrade;

  const PortfolioTabWidget({
    Key? key,
    required this.cryptoData,
    required this.onTrade,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ownedCryptos =
        cryptoData.where((crypto) => (crypto["owned"] as double) > 0).toList();

    return SingleChildScrollView(
      padding: EdgeInsets.all(4.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildAllocationChart(ownedCryptos),
          SizedBox(height: 3.h),
          _buildHoldingsList(ownedCryptos),
        ],
      ),
    );
  }

  Widget _buildAllocationChart(List<Map<String, dynamic>> ownedCryptos) {
    return Container(
      padding: EdgeInsets.all(4.w),
      decoration: BoxDecoration(
        color: AppTheme.secondaryDark,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppTheme.borderGray.withValues(alpha: 0.3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Portfolio Allocation',
            style: AppTheme.darkTheme.textTheme.titleMedium?.copyWith(
              color: AppTheme.textPrimary,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: 3.h),
          Container(
            height: 25.h,
            child: Row(
              children: [
                Expanded(
                  flex: 2,
                  child: PieChart(
                    PieChartData(
                      sections: _buildPieChartSections(ownedCryptos),
                      centerSpaceRadius: 8.w,
                      sectionsSpace: 2,
                      startDegreeOffset: -90,
                    ),
                  ),
                ),
                SizedBox(width: 4.w),
                Expanded(
                  flex: 1,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: ownedCryptos
                        .map((crypto) => _buildLegendItem(crypto))
                        .toList(),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  List<PieChartSectionData> _buildPieChartSections(
      List<Map<String, dynamic>> ownedCryptos) {
    final colors = [
      AppTheme.accentGold,
      AppTheme.successGreen,
      Color(0xFF8B5CF6),
      Color(0xFFEF4444),
      Color(0xFF06B6D4),
    ];

    return ownedCryptos.asMap().entries.map((entry) {
      final index = entry.key;
      final crypto = entry.value;
      final allocation = crypto["allocation"] as double;

      return PieChartSectionData(
        color: colors[index % colors.length],
        value: allocation,
        title: '${allocation.toStringAsFixed(1)}%',
        radius: 12.w,
        titleStyle: AppTheme.darkTheme.textTheme.labelSmall?.copyWith(
          color: AppTheme.textPrimary,
          fontWeight: FontWeight.w600,
        ),
      );
    }).toList();
  }

  Widget _buildLegendItem(Map<String, dynamic> crypto) {
    final colors = [
      AppTheme.accentGold,
      AppTheme.successGreen,
      Color(0xFF8B5CF6),
      Color(0xFFEF4444),
      Color(0xFF06B6D4),
    ];

    final index = cryptoData.indexOf(crypto);
    final color = colors[index % colors.length];

    return Padding(
      padding: EdgeInsets.only(bottom: 1.h),
      child: Row(
        children: [
          Container(
            width: 3.w,
            height: 3.w,
            decoration: BoxDecoration(
              color: color,
              shape: BoxShape.circle,
            ),
          ),
          SizedBox(width: 2.w),
          Expanded(
            child: Text(
              crypto["symbol"] as String,
              style: AppTheme.darkTheme.textTheme.bodySmall?.copyWith(
                color: AppTheme.textSecondary,
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHoldingsList(List<Map<String, dynamic>> ownedCryptos) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Your Holdings',
          style: AppTheme.darkTheme.textTheme.titleMedium?.copyWith(
            color: AppTheme.textPrimary,
            fontWeight: FontWeight.w600,
          ),
        ),
        SizedBox(height: 2.h),
        ListView.separated(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemCount: ownedCryptos.length,
          separatorBuilder: (context, index) => SizedBox(height: 2.h),
          itemBuilder: (context, index) {
            final crypto = ownedCryptos[index];
            return _buildHoldingCard(crypto);
          },
        ),
      ],
    );
  }

  Widget _buildHoldingCard(Map<String, dynamic> crypto) {
    final isPositive = (crypto["priceChangePercent24h"] as double) >= 0;
    final changeColor = isPositive ? AppTheme.successGreen : AppTheme.errorRed;
    final owned = crypto["owned"] as double;
    final ownedValue = crypto["ownedValue"] as double;
    final currentPrice = crypto["currentPrice"] as double;

    return Container(
      padding: EdgeInsets.all(4.w),
      decoration: BoxDecoration(
        color: AppTheme.secondaryDark,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppTheme.borderGray.withValues(alpha: 0.3)),
      ),
      child: Column(
        children: [
          Row(
            children: [
              CustomImageWidget(
                imageUrl: crypto["logo"] as String,
                width: 40,
                height: 40,
                fit: BoxFit.cover,
              ),
              SizedBox(width: 3.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      crypto["name"] as String,
                      style: AppTheme.darkTheme.textTheme.titleSmall?.copyWith(
                        color: AppTheme.textPrimary,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      '${owned.toStringAsFixed(6)} ${crypto["symbol"]}',
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
                    '\$${ownedValue.toStringAsFixed(2)}',
                    style: AppTheme.getMonospaceStyle(
                      isLight: false,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      CustomIconWidget(
                        iconName: isPositive ? 'trending_up' : 'trending_down',
                        color: changeColor,
                        size: 14,
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
                ],
              ),
            ],
          ),
          SizedBox(height: 2.h),
          Row(
            children: [
              Expanded(
                child: OutlinedButton(
                  onPressed: () => onTrade(crypto["id"] as String),
                  style: OutlinedButton.styleFrom(
                    foregroundColor: AppTheme.successGreen,
                    side: BorderSide(color: AppTheme.successGreen),
                    padding: EdgeInsets.symmetric(vertical: 1.5.h),
                  ),
                  child: Text('Buy More'),
                ),
              ),
              SizedBox(width: 3.w),
              Expanded(
                child: OutlinedButton(
                  onPressed: () => onTrade(crypto["id"] as String),
                  style: OutlinedButton.styleFrom(
                    foregroundColor: AppTheme.errorRed,
                    side: BorderSide(color: AppTheme.errorRed),
                    padding: EdgeInsets.symmetric(vertical: 1.5.h),
                  ),
                  child: Text('Sell'),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
