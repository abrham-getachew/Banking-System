import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../core/app_export.dart';
import './widgets/portfolio_balance_widget.dart';
import './widgets/quick_action_buttons_widget.dart';
import './widgets/search_bar_widget.dart';
import './widgets/token_card_widget.dart';
import './widgets/token_explorer_widget.dart';
import './widgets/trending_markets_widget.dart';

class CryptoTradingDashboard extends StatefulWidget {
  const CryptoTradingDashboard({Key? key}) : super(key: key);

  @override
  State<CryptoTradingDashboard> createState() => _CryptoTradingDashboardState();
}

class _CryptoTradingDashboardState extends State<CryptoTradingDashboard> {
  final TextEditingController _searchController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  bool _isBalanceVisible = true;
  bool _isRefreshing = false;
  String _searchQuery = '';

  // Mock data for cryptocurrencies
  final List<Map<String, dynamic>> _allTokens = [
    {
      "id": "bitcoin",
      "name": "Bitcoin",
      "symbol": "BTC",
      "price": 43250.75,
      "changePercent": 2.45,
      "marketCap": 847500000000.0,
      "volume24h": 28500000000.0,
      "circulatingSupply": 19600000.0,
      "rank": 1,
      "sparklineData": [
        42800.0,
        43100.0,
        42950.0,
        43200.0,
        43400.0,
        43250.0,
        43350.0
      ],
    },
    {
      "id": "ethereum",
      "name": "Ethereum",
      "symbol": "ETH",
      "price": 2650.30,
      "changePercent": 1.85,
      "marketCap": 318500000000.0,
      "volume24h": 15200000000.0,
      "circulatingSupply": 120200000.0,
      "rank": 2,
      "sparklineData": [2620.0, 2640.0, 2630.0, 2660.0, 2670.0, 2650.0, 2655.0],
    },
    {
      "id": "binancecoin",
      "name": "BNB",
      "symbol": "BNB",
      "price": 315.45,
      "changePercent": -0.75,
      "marketCap": 47200000000.0,
      "volume24h": 1800000000.0,
      "circulatingSupply": 149500000.0,
      "rank": 3,
      "sparklineData": [318.0, 316.0, 317.0, 314.0, 313.0, 315.0, 316.0],
    },
    {
      "id": "solana",
      "name": "Solana",
      "symbol": "SOL",
      "price": 98.75,
      "changePercent": 4.25,
      "marketCap": 42800000000.0,
      "volume24h": 2100000000.0,
      "circulatingSupply": 433500000.0,
      "rank": 4,
      "sparklineData": [94.0, 96.0, 95.0, 97.0, 99.0, 98.0, 99.0],
    },
    {
      "id": "cardano",
      "name": "Cardano",
      "symbol": "ADA",
      "price": 0.485,
      "changePercent": -1.25,
      "marketCap": 17200000000.0,
      "volume24h": 850000000.0,
      "circulatingSupply": 35400000000.0,
      "rank": 5,
      "sparklineData": [0.49, 0.48, 0.485, 0.47, 0.475, 0.485, 0.48],
    },
    {
      "id": "dogecoin",
      "name": "Dogecoin",
      "symbol": "DOGE",
      "price": 0.085,
      "changePercent": 3.15,
      "marketCap": 12100000000.0,
      "volume24h": 650000000.0,
      "circulatingSupply": 142300000000.0,
      "rank": 6,
      "sparklineData": [0.082, 0.083, 0.084, 0.086, 0.087, 0.085, 0.086],
    },
    {
      "id": "polygon",
      "name": "Polygon",
      "symbol": "MATIC",
      "price": 0.925,
      "changePercent": 2.85,
      "marketCap": 8600000000.0,
      "volume24h": 420000000.0,
      "circulatingSupply": 9300000000.0,
      "rank": 7,
      "sparklineData": [0.90, 0.91, 0.92, 0.93, 0.94, 0.925, 0.93],
    },
    {
      "id": "avalanche",
      "name": "Avalanche",
      "symbol": "AVAX",
      "price": 36.25,
      "changePercent": -2.15,
      "marketCap": 13500000000.0,
      "volume24h": 580000000.0,
      "circulatingSupply": 372500000.0,
      "rank": 8,
      "sparklineData": [37.0, 36.5, 36.8, 36.0, 35.8, 36.25, 36.1],
    },
  ];

  List<Map<String, dynamic>> get _filteredTokens {
    if (_searchQuery.isEmpty) return _allTokens;
    return _allTokens.where((token) {
      final name = (token['name'] as String).toLowerCase();
      final symbol = (token['symbol'] as String).toLowerCase();
      final query = _searchQuery.toLowerCase();
      return name.contains(query) || symbol.contains(query);
    }).toList();
  }

  List<Map<String, dynamic>> get _topTokens {
    return _filteredTokens.take(6).toList();
  }

  List<Map<String, dynamic>> get _trendingTokens {
    return _filteredTokens
        .where((token) => (token['changePercent'] as double) > 0)
        .take(9)
        .toList();
  }

  @override
  void initState() {
    super.initState();
    _searchController.addListener(() {
      setState(() {
        _searchQuery = _searchController.text;
      });
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  Future<void> _handleRefresh() async {
    setState(() {
      _isRefreshing = true;
    });

    // Simulate API call delay
    await Future.delayed(const Duration(seconds: 2));

    setState(() {
      _isRefreshing = false;
    });
  }

  void _handleTokenTap(Map<String, dynamic> token) {
    Navigator.pushNamed(context, '/token-detail-view');
  }

  void _clearSearch() {
    _searchController.clear();
    setState(() {
      _searchQuery = '';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.trueDarkBackground,
      body: Stack(
        children: [
          // Background gradient
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  AppTheme.trueDarkBackground,
                  AppTheme.deepCharcoal.withValues(alpha: 0.8),
                  AppTheme.trueDarkBackground,
                ],
              ),
            ),
          ),

          // Main content
          RefreshIndicator(
            onRefresh: _handleRefresh,
            color: AppTheme.primaryGold,
            backgroundColor: AppTheme.elevatedSurface,
            child: CustomScrollView(
              controller: _scrollController,
              slivers: [
                // Sticky header
                SliverAppBar(
                  expandedHeight: 20.h,
                  floating: false,
                  pinned: true,
                  backgroundColor:
                      AppTheme.trueDarkBackground.withValues(alpha: 0.95),
                  leading: GestureDetector(
                    onTap: () =>
                        Navigator.pushNamed(context, '/blockchain-module-home'),
                    child: Container(
                      margin: EdgeInsets.all(2.w),
                      decoration: BoxDecoration(
                        color: AppTheme.elevatedSurface.withValues(alpha: 0.8),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: CustomIconWidget(
                        iconName: 'arrow_back',
                        color: AppTheme.textPrimary,
                        size: 24,
                      ),
                    ),
                  ),
                  title: Text(
                    'Crypto Trading',
                    style: AppTheme.darkTheme.textTheme.headlineSmall?.copyWith(
                      color: AppTheme.textPrimary,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  actions: [
                    GestureDetector(
                      onTap: () => Navigator.pushNamed(
                          context, '/crypto-transaction-history'),
                      child: Container(
                        margin: EdgeInsets.all(2.w),
                        padding: EdgeInsets.all(2.w),
                        decoration: BoxDecoration(
                          color:
                              AppTheme.elevatedSurface.withValues(alpha: 0.8),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: CustomIconWidget(
                          iconName: 'history',
                          color: AppTheme.primaryGold,
                          size: 24,
                        ),
                      ),
                    ),
                  ],
                  flexibleSpace: FlexibleSpaceBar(
                    background: Container(
                      padding: EdgeInsets.fromLTRB(4.w, 12.h, 4.w, 2.h),
                      child: Column(
                        children: [
                          // Portfolio balance
                          PortfolioBalanceWidget(
                            isBalanceVisible: _isBalanceVisible,
                            onToggleVisibility: () {
                              setState(() {
                                _isBalanceVisible = !_isBalanceVisible;
                              });
                            },
                          ),
                          SizedBox(height: 2.h),

                          // Search bar
                          SearchBarWidget(
                            controller: _searchController,
                            onChanged: (value) {
                              setState(() {
                                _searchQuery = value;
                              });
                            },
                            onClear: _clearSearch,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),

                // Top cryptocurrencies horizontal scroll
                SliverToBoxAdapter(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: 4.w, vertical: 2.h),
                        child: Text(
                          'Top Cryptocurrencies',
                          style: AppTheme.darkTheme.textTheme.headlineSmall
                              ?.copyWith(
                            color: AppTheme.textPrimary,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                      Container(
                        height: 20.h,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          padding: EdgeInsets.symmetric(horizontal: 4.w),
                          itemCount: _topTokens.length,
                          itemBuilder: (context, index) {
                            return TokenCardWidget(
                              tokenData: _topTokens[index],
                              onTap: () => _handleTokenTap(_topTokens[index]),
                            );
                          },
                        ),
                      ),
                      SizedBox(height: 3.h),
                    ],
                  ),
                ),

                // Trending markets carousel
                SliverToBoxAdapter(
                  child: TrendingMarketsWidget(
                    trendingTokens: _trendingTokens,
                    onTokenTap: _handleTokenTap,
                  ),
                ),

                SliverToBoxAdapter(child: SizedBox(height: 3.h)),

                // Token explorer
                SliverToBoxAdapter(
                  child: TokenExplorerWidget(
                    tokens: _filteredTokens,
                    onTokenTap: _handleTokenTap,
                  ),
                ),

                SliverToBoxAdapter(child: SizedBox(height: 10.h)),
              ],
            ),
          ),

          // Quick action buttons
          const QuickActionButtonsWidget(),

          // Loading overlay
          if (_isRefreshing)
            Container(
              color: AppTheme.trueDarkBackground.withValues(alpha: 0.8),
              child: Center(
                child: Container(
                  padding: EdgeInsets.all(6.w),
                  decoration: BoxDecoration(
                    color: AppTheme.elevatedSurface,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      CircularProgressIndicator(
                        color: AppTheme.primaryGold,
                      ),
                      SizedBox(height: 2.h),
                      Text(
                        'Updating market data...',
                        style:
                            AppTheme.darkTheme.textTheme.bodyMedium?.copyWith(
                          color: AppTheme.textPrimary,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
