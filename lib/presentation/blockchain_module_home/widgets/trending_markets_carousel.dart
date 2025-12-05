import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../../core/app_export.dart';

class TrendingMarketsCarousel extends StatefulWidget {
  const TrendingMarketsCarousel({super.key});

  @override
  State<TrendingMarketsCarousel> createState() =>
      _TrendingMarketsCarouselState();
}

class _TrendingMarketsCarouselState extends State<TrendingMarketsCarousel> {
  final PageController _pageController = PageController();
  int _currentIndex = 0;

  final List<Map<String, dynamic>> trendingMarkets = [
    {
      "id": 1,
      "symbol": "BTC",
      "name": "Bitcoin",
      "price": "\$67,234.50",
      "change": "+2.45%",
      "changeValue": "+1,612.30",
      "isPositive": true,
      "icon": "https://cryptologos.cc/logos/bitcoin-btc-logo.png",
      "chartData": [
        45000,
        47000,
        46500,
        48000,
        49500,
        51000,
        52500,
        54000,
        56000,
        58000,
        60000,
        62000,
        64000,
        66000,
        67234
      ],
    },
    {
      "id": 2,
      "symbol": "ETH",
      "name": "Ethereum",
      "price": "\$3,456.78",
      "change": "-1.23%",
      "changeValue": "-43.21",
      "isPositive": false,
      "icon": "https://cryptologos.cc/logos/ethereum-eth-logo.png",
      "chartData": [
        3200,
        3300,
        3250,
        3400,
        3500,
        3450,
        3600,
        3550,
        3650,
        3700,
        3600,
        3500,
        3450,
        3400,
        3456
      ],
    },
    {
      "id": 3,
      "symbol": "BNB",
      "name": "Binance Coin",
      "price": "\$542.89",
      "change": "+5.67%",
      "changeValue": "+29.12",
      "isPositive": true,
      "icon": "https://cryptologos.cc/logos/bnb-bnb-logo.png",
      "chartData": [
        480,
        490,
        500,
        510,
        520,
        515,
        525,
        530,
        535,
        540,
        545,
        542,
        541,
        540,
        542
      ],
    },
  ];

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 4.w),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Trending Markets',
                style: AppTheme.darkTheme.textTheme.titleLarge?.copyWith(
                  color: AppTheme.textPrimary,
                  fontWeight: FontWeight.w600,
                ),
              ),
              TextButton(
                onPressed: () =>
                    Navigator.pushNamed(context, '/crypto-trading-dashboard'),
                child: Text(
                  'View All',
                  style: AppTheme.darkTheme.textTheme.bodyMedium?.copyWith(
                    color: AppTheme.primaryGold,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 2.h),
        SizedBox(
          height: 20.h,
          child: PageView.builder(
            controller: _pageController,
            onPageChanged: (index) {
              setState(() {
                _currentIndex = index;
              });
            },
            itemCount: trendingMarkets.length,
            itemBuilder: (context, index) {
              final market = trendingMarkets[index];
              return Container(
                margin: EdgeInsets.symmetric(horizontal: 2.w),
                child: _buildMarketCard(market),
              );
            },
          ),
        ),
        SizedBox(height: 2.h),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(
            trendingMarkets.length,
            (index) => Container(
              margin: EdgeInsets.symmetric(horizontal: 1.w),
              width: _currentIndex == index ? 6.w : 2.w,
              height: 1.h,
              decoration: BoxDecoration(
                color: _currentIndex == index
                    ? AppTheme.primaryGold
                    : AppTheme.textSecondary.withValues(alpha: 0.3),
                borderRadius: BorderRadius.circular(1.h),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildMarketCard(Map<String, dynamic> market) {
    return GestureDetector(
      onTap: () => Navigator.pushNamed(context, '/token-detail-view'),
      child: Container(
        padding: EdgeInsets.all(4.w),
        decoration: BoxDecoration(
          color: AppTheme.elevatedSurface.withValues(alpha: 0.8),
          borderRadius: BorderRadius.circular(4.w),
          border: Border.all(
            color: AppTheme.textPrimary.withValues(alpha: 0.1),
            width: 1,
          ),
          boxShadow: [
            BoxShadow(
              color: AppTheme.shadowDark,
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          children: [
            Expanded(
              flex: 2,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
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
                            market["symbol"] as String,
                            style: AppTheme.darkTheme.textTheme.labelSmall
                                ?.copyWith(
                              color: AppTheme.primaryGold,
                              fontWeight: FontWeight.w600,
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
                              market["symbol"] as String,
                              style: AppTheme.darkTheme.textTheme.titleMedium
                                  ?.copyWith(
                                color: AppTheme.textPrimary,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Text(
                              market["name"] as String,
                              style: AppTheme.darkTheme.textTheme.bodySmall
                                  ?.copyWith(
                                color: AppTheme.textSecondary,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        market["price"] as String,
                        style:
                            AppTheme.darkTheme.textTheme.titleLarge?.copyWith(
                          color: AppTheme.textPrimary,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      Row(
                        children: [
                          CustomIconWidget(
                            iconName: (market["isPositive"] as bool)
                                ? 'trending_up'
                                : 'trending_down',
                            color: (market["isPositive"] as bool)
                                ? AppTheme.successGreen
                                : AppTheme.errorRed,
                            size: 4.w,
                          ),
                          SizedBox(width: 1.w),
                          Text(
                            market["change"] as String,
                            style: AppTheme.darkTheme.textTheme.bodyMedium
                                ?.copyWith(
                              color: (market["isPositive"] as bool)
                                  ? AppTheme.successGreen
                                  : AppTheme.errorRed,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 1,
              child: Container(
                height: 12.h,
                child: CustomPaint(
                  painter: MiniChartPainter(
                    data: (market["chartData"] as List).cast<double>(),
                    color: (market["isPositive"] as bool)
                        ? AppTheme.successGreen
                        : AppTheme.errorRed,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class MiniChartPainter extends CustomPainter {
  final List<double> data;
  final Color color;

  MiniChartPainter({required this.data, required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    if (data.isEmpty) return;

    final paint = Paint()
      ..color = color
      ..strokeWidth = 2.0
      ..style = PaintingStyle.stroke;

    final path = Path();
    final double maxValue = data.reduce((a, b) => a > b ? a : b);
    final double minValue = data.reduce((a, b) => a < b ? a : b);
    final double range = maxValue - minValue;

    if (range == 0) return;

    for (int i = 0; i < data.length; i++) {
      final double x = (i / (data.length - 1)) * size.width;
      final double y =
          size.height - ((data[i] - minValue) / range) * size.height;

      if (i == 0) {
        path.moveTo(x, y);
      } else {
        path.lineTo(x, y);
      }
    }

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
