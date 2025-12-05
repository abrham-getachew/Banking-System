import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../core/app_export.dart';
import './widgets/market_metrics_widget.dart';
import './widgets/price_chart_widget.dart';
import './widgets/token_header_widget.dart';
import './widgets/trading_bottom_sheet_widget.dart';

class TokenDetailView extends StatefulWidget {
  const TokenDetailView({Key? key}) : super(key: key);

  @override
  State<TokenDetailView> createState() => _TokenDetailViewState();
}

class _TokenDetailViewState extends State<TokenDetailView> {
  String _selectedTimeframe = "24H";
  bool _showTradingSheet = false;

  // Mock token data
  final Map<String, dynamic> _tokenData = {
    "id": 1,
    "name": "Bitcoin",
    "symbol": "BTC",
    "currentPrice": 43250.75,
    "priceChange": 2.45,
    "icon": "https://cryptologos.cc/logos/bitcoin-btc-logo.png",
    "marketCap": 847000000000.0,
    "volume24h": 28500000000.0,
    "circulatingSupply": 19600000.0,
    "rsi": 65.2,
    "macd": 0.125,
    "bollingerBands": "Upper Band",
  };

  // Mock chart data
  final Map<String, List<Map<String, dynamic>>> _chartDataMap = {
    "1H": [
      {"price": 43200.0, "time": "12:00"},
      {"price": 43180.0, "time": "12:15"},
      {"price": 43220.0, "time": "12:30"},
      {"price": 43250.0, "time": "12:45"},
      {"price": 43251.0, "time": "13:00"},
    ],
    "24H": [
      {"price": 42800.0, "time": "00:00"},
      {"price": 42950.0, "time": "04:00"},
      {"price": 43100.0, "time": "08:00"},
      {"price": 43200.0, "time": "12:00"},
      {"price": 43250.0, "time": "16:00"},
      {"price": 43251.0, "time": "20:00"},
    ],
    "7D": [
      {"price": 41500.0, "time": "Mon"},
      {"price": 42200.0, "time": "Tue"},
      {"price": 42800.0, "time": "Wed"},
      {"price": 43100.0, "time": "Thu"},
      {"price": 43000.0, "time": "Fri"},
      {"price": 43200.0, "time": "Sat"},
      {"price": 43251.0, "time": "Sun"},
    ],
    "1M": [
      {"price": 38000.0, "time": "Week 1"},
      {"price": 40500.0, "time": "Week 2"},
      {"price": 42000.0, "time": "Week 3"},
      {"price": 43251.0, "time": "Week 4"},
    ],
    "1Y": [
      {"price": 16000.0, "time": "Jan"},
      {"price": 25000.0, "time": "Mar"},
      {"price": 35000.0, "time": "Jun"},
      {"price": 42000.0, "time": "Sep"},
      {"price": 43251.0, "time": "Dec"},
    ],
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.trueDarkBackground,
      body: Stack(
        children: [
          _buildMainContent(),
          if (_showTradingSheet) _buildTradingOverlay(),
        ],
      ),
      floatingActionButton: _buildTradingFAB(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  Widget _buildMainContent() {
    return CustomScrollView(
      slivers: [
        SliverToBoxAdapter(
          child: TokenHeaderWidget(
            tokenData: _tokenData,
            onBackPressed: () => Navigator.pop(context),
          ),
        ),
        SliverToBoxAdapter(
          child: SizedBox(height: 2.h),
        ),
        SliverToBoxAdapter(
          child: PriceChartWidget(
            chartData: _chartDataMap[_selectedTimeframe] ?? [],
            selectedTimeframe: _selectedTimeframe,
            onTimeframeChanged: (timeframe) {
              setState(() {
                _selectedTimeframe = timeframe;
              });
            },
          ),
        ),
        SliverToBoxAdapter(
          child: MarketMetricsWidget(
            marketData: _tokenData,
          ),
        ),
        SliverToBoxAdapter(
          child: _buildQuickActions(),
        ),
        SliverToBoxAdapter(
          child: SizedBox(height: 10.h), // Space for FAB
        ),
      ],
    );
  }

  Widget _buildQuickActions() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 4.w, vertical: 2.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Quick Actions",
            style: AppTheme.darkTheme.textTheme.titleLarge?.copyWith(
              fontSize: 18.sp,
              fontWeight: FontWeight.w700,
              color: AppTheme.textPrimary,
            ),
          ),
          SizedBox(height: 2.h),
          Row(
            children: [
              Expanded(
                child: _buildActionButton(
                  "Buy",
                  Icons.trending_up,
                  AppTheme.successGreen,
                  () => _showTradingBottomSheet(),
                ),
              ),
              SizedBox(width: 3.w),
              Expanded(
                child: _buildActionButton(
                  "Sell",
                  Icons.trending_down,
                  AppTheme.errorRed,
                  () => _showTradingBottomSheet(),
                ),
              ),
            ],
          ),
          SizedBox(height: 2.h),
          Row(
            children: [
              Expanded(
                child: _buildActionButton(
                  "Exchange",
                  Icons.swap_horiz,
                  AppTheme.primaryGold,
                  () => Navigator.pushNamed(context, '/token-exchange'),
                ),
              ),
              SizedBox(width: 3.w),
              Expanded(
                child: _buildActionButton(
                  "History",
                  Icons.history,
                  AppTheme.infoBlue,
                  () => Navigator.pushNamed(
                      context, '/crypto-transaction-history'),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildActionButton(
    String title,
    IconData icon,
    Color color,
    VoidCallback onTap,
  ) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 2.h, horizontal: 3.w),
        decoration: AppTheme.glassmorphicDecoration(
          borderRadius: 12,
          opacity: 0.05,
        ),
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.all(3.w),
              decoration: BoxDecoration(
                color: color.withValues(alpha: 0.2),
                borderRadius: BorderRadius.circular(12),
              ),
              child: CustomIconWidget(
                iconName: _getIconName(icon),
                color: color,
                size: 6.w,
              ),
            ),
            SizedBox(height: 1.h),
            Text(
              title,
              style: AppTheme.darkTheme.textTheme.labelMedium?.copyWith(
                color: AppTheme.textPrimary,
                fontWeight: FontWeight.w600,
                fontSize: 12.sp,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTradingFAB() {
    return Container(
      width: 90.w,
      child: FloatingActionButton.extended(
        onPressed: _showTradingBottomSheet,
        backgroundColor: AppTheme.primaryGold,
        foregroundColor: AppTheme.trueDarkBackground,
        elevation: 8,
        label: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            CustomIconWidget(
              iconName: 'trending_up',
              color: AppTheme.trueDarkBackground,
              size: 5.w,
            ),
            SizedBox(width: 2.w),
            Text(
              "Trade ${_tokenData["symbol"]}",
              style: AppTheme.darkTheme.textTheme.titleMedium?.copyWith(
                color: AppTheme.trueDarkBackground,
                fontWeight: FontWeight.w700,
                fontSize: 16.sp,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTradingOverlay() {
    return GestureDetector(
      onTap: () => setState(() => _showTradingSheet = false),
      child: Container(
        color: Colors.black.withValues(alpha: 0.5),
        child: Align(
          alignment: Alignment.bottomCenter,
          child: GestureDetector(
            onTap: () {}, // Prevent dismissal when tapping the sheet
            child: TradingBottomSheetWidget(
              tokenData: _tokenData,
              onTradeExecuted: (type, amount) {
                setState(() => _showTradingSheet = false);
                _handleTradeExecution(type, amount);
              },
            ),
          ),
        ),
      ),
    );
  }

  void _showTradingBottomSheet() {
    setState(() => _showTradingSheet = true);
  }

  void _handleTradeExecution(String type, double amount) {
    // Handle trade execution logic here
    print("Trade executed: $type \$${amount.toStringAsFixed(2)}");
  }

  String _getIconName(IconData icon) {
    switch (icon) {
      case Icons.trending_up:
        return 'trending_up';
      case Icons.trending_down:
        return 'trending_down';
      case Icons.swap_horiz:
        return 'swap_horiz';
      case Icons.history:
        return 'history';
      default:
        return 'info';
    }
  }
}
