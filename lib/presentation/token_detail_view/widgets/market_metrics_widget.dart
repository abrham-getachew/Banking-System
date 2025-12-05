import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../../core/app_export.dart';

class MarketMetricsWidget extends StatefulWidget {
  final Map<String, dynamic> marketData;

  const MarketMetricsWidget({
    Key? key,
    required this.marketData,
  }) : super(key: key);

  @override
  State<MarketMetricsWidget> createState() => _MarketMetricsWidgetState();
}

class _MarketMetricsWidgetState extends State<MarketMetricsWidget> {
  String _expandedCard = "";

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 4.w, vertical: 2.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Market Metrics",
            style: AppTheme.darkTheme.textTheme.titleLarge?.copyWith(
              fontSize: 18.sp,
              fontWeight: FontWeight.w700,
              color: AppTheme.textPrimary,
            ),
          ),
          SizedBox(height: 2.h),
          _buildMetricCard(
            "Market Cap",
            "\$${_formatNumber(widget.marketData["marketCap"] as double? ?? 0.0)}",
            "market_cap",
            "Total value of all tokens in circulation",
            Icons.pie_chart,
          ),
          SizedBox(height: 2.h),
          _buildMetricCard(
            "24h Volume",
            "\$${_formatNumber(widget.marketData["volume24h"] as double? ?? 0.0)}",
            "volume",
            "Total trading volume in the last 24 hours",
            Icons.bar_chart,
          ),
          SizedBox(height: 2.h),
          _buildMetricCard(
            "Circulating Supply",
            "${_formatNumber(widget.marketData["circulatingSupply"] as double? ?? 0.0)} ${widget.marketData["symbol"] ?? ""}",
            "supply",
            "Number of tokens currently in circulation",
            Icons.donut_small,
          ),
          SizedBox(height: 2.h),
          _buildMetricCard(
            "Technical Indicators",
            "RSI: ${(widget.marketData["rsi"] as double? ?? 0.0).toStringAsFixed(1)}",
            "technical",
            "Relative Strength Index and other technical metrics",
            Icons.trending_up,
          ),
        ],
      ),
    );
  }

  Widget _buildMetricCard(
    String title,
    String value,
    String cardId,
    String description,
    IconData icon,
  ) {
    final isExpanded = _expandedCard == cardId;

    return GestureDetector(
      onTap: () {
        setState(() {
          _expandedCard = isExpanded ? "" : cardId;
        });
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        padding: EdgeInsets.all(4.w),
        decoration: AppTheme.glassmorphicDecoration(
          borderRadius: 12,
          opacity: isExpanded ? 0.1 : 0.05,
        ),
        child: Column(
          children: [
            Row(
              children: [
                Container(
                  padding: EdgeInsets.all(2.w),
                  decoration: BoxDecoration(
                    color: AppTheme.primaryGold.withValues(alpha: 0.2),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: CustomIconWidget(
                    iconName: _getIconName(icon),
                    color: AppTheme.primaryGold,
                    size: 5.w,
                  ),
                ),
                SizedBox(width: 3.w),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style:
                            AppTheme.darkTheme.textTheme.titleMedium?.copyWith(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w600,
                          color: AppTheme.textPrimary,
                        ),
                      ),
                      SizedBox(height: 0.5.h),
                      Text(
                        value,
                        style: AppTheme.darkTheme.textTheme.bodyLarge?.copyWith(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w700,
                          color: AppTheme.primaryGold,
                        ),
                      ),
                    ],
                  ),
                ),
                AnimatedRotation(
                  turns: isExpanded ? 0.5 : 0,
                  duration: const Duration(milliseconds: 300),
                  child: CustomIconWidget(
                    iconName: 'keyboard_arrow_down',
                    color: AppTheme.textSecondary,
                    size: 6.w,
                  ),
                ),
              ],
            ),
            AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              height: isExpanded ? null : 0,
              child: isExpanded
                  ? Column(
                      children: [
                        SizedBox(height: 2.h),
                        Container(
                          width: double.infinity,
                          height: 1,
                          color: AppTheme.textSecondary.withValues(alpha: 0.1),
                        ),
                        SizedBox(height: 2.h),
                        Text(
                          description,
                          style:
                              AppTheme.darkTheme.textTheme.bodyMedium?.copyWith(
                            color: AppTheme.textSecondary,
                            fontSize: 12.sp,
                          ),
                        ),
                        if (cardId == "technical") ...[
                          SizedBox(height: 2.h),
                          _buildTechnicalIndicators(),
                        ],
                      ],
                    )
                  : const SizedBox.shrink(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTechnicalIndicators() {
    final rsi = widget.marketData["rsi"] as double? ?? 50.0;
    final macd = widget.marketData["macd"] as double? ?? 0.0;
    final bollinger =
        widget.marketData["bollingerBands"] as String? ?? "Neutral";

    return Column(
      children: [
        _buildIndicatorRow("RSI", rsi.toStringAsFixed(1), _getRSIColor(rsi)),
        SizedBox(height: 1.h),
        _buildIndicatorRow(
            "MACD", macd.toStringAsFixed(3), _getMACDColor(macd)),
        SizedBox(height: 1.h),
        _buildIndicatorRow("Bollinger", bollinger, AppTheme.infoBlue),
      ],
    );
  }

  Widget _buildIndicatorRow(String name, String value, Color color) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          name,
          style: AppTheme.darkTheme.textTheme.bodySmall?.copyWith(
            color: AppTheme.textSecondary,
            fontSize: 11.sp,
          ),
        ),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 2.w, vertical: 0.5.h),
          decoration: BoxDecoration(
            color: color.withValues(alpha: 0.2),
            borderRadius: BorderRadius.circular(4),
          ),
          child: Text(
            value,
            style: AppTheme.darkTheme.textTheme.labelSmall?.copyWith(
              color: color,
              fontWeight: FontWeight.w600,
              fontSize: 10.sp,
            ),
          ),
        ),
      ],
    );
  }

  String _formatNumber(double number) {
    if (number >= 1e12) {
      return "${(number / 1e12).toStringAsFixed(2)}T";
    } else if (number >= 1e9) {
      return "${(number / 1e9).toStringAsFixed(2)}B";
    } else if (number >= 1e6) {
      return "${(number / 1e6).toStringAsFixed(2)}M";
    } else if (number >= 1e3) {
      return "${(number / 1e3).toStringAsFixed(2)}K";
    } else {
      return number.toStringAsFixed(2);
    }
  }

  String _getIconName(IconData icon) {
    switch (icon) {
      case Icons.pie_chart:
        return 'pie_chart';
      case Icons.bar_chart:
        return 'bar_chart';
      case Icons.donut_small:
        return 'donut_small';
      case Icons.trending_up:
        return 'trending_up';
      default:
        return 'info';
    }
  }

  Color _getRSIColor(double rsi) {
    if (rsi > 70) return AppTheme.errorRed;
    if (rsi < 30) return AppTheme.successGreen;
    return AppTheme.warningAmber;
  }

  Color _getMACDColor(double macd) {
    return macd > 0 ? AppTheme.successGreen : AppTheme.errorRed;
  }
}
