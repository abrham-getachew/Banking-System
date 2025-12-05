import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../core/app_export.dart';
import './widgets/crypto_watchlist_widget.dart';
import './widgets/markets_tab_widget.dart';
import './widgets/news_tab_widget.dart';
import './widgets/portfolio_tab_widget.dart';
import './widgets/trading_bottom_sheet_widget.dart';

class CryptocurrencyTrading extends StatefulWidget {
  const CryptocurrencyTrading({Key? key}) : super(key: key);

  @override
  State<CryptocurrencyTrading> createState() => _CryptocurrencyTradingState();
}

class _CryptocurrencyTradingState extends State<CryptocurrencyTrading>
    with TickerProviderStateMixin {
  late TabController _tabController;
  int _selectedBottomIndex = 3; // Crypto tab active
  String _selectedCoin = '';
  bool _showTradingSheet = false;

  // Mock cryptocurrency data
  final List<Map<String, dynamic>> _cryptoData = [
    {
      "id": "bitcoin",
      "name": "Bitcoin",
      "symbol": "BTC",
      "logo": "https://cryptologos.cc/logos/bitcoin-btc-logo.png",
      "currentPrice": 43250.75,
      "priceChange24h": 2.45,
      "priceChangePercent24h": 5.67,
      "marketCap": 847500000000,
      "volume24h": 28500000000,
      "sparklineData": [42800, 43100, 42950, 43200, 43400, 43250],
      "owned": 0.0234,
      "ownedValue": 1012.07,
      "allocation": 45.2
    },
    {
      "id": "ethereum",
      "name": "Ethereum",
      "symbol": "ETH",
      "logo": "https://cryptologos.cc/logos/ethereum-eth-logo.png",
      "currentPrice": 2650.30,
      "priceChange24h": -45.20,
      "priceChangePercent24h": -1.68,
      "marketCap": 318700000000,
      "volume24h": 15200000000,
      "sparklineData": [2695, 2680, 2670, 2655, 2645, 2650],
      "owned": 0.567,
      "ownedValue": 1502.72,
      "allocation": 32.8
    },
    {
      "id": "cardano",
      "name": "Cardano",
      "symbol": "ADA",
      "logo": "https://cryptologos.cc/logos/cardano-ada-logo.png",
      "currentPrice": 0.485,
      "priceChange24h": 0.023,
      "priceChangePercent24h": 4.98,
      "marketCap": 17200000000,
      "volume24h": 890000000,
      "sparklineData": [0.462, 0.470, 0.475, 0.480, 0.488, 0.485],
      "owned": 1250.0,
      "ownedValue": 606.25,
      "allocation": 13.2
    },
    {
      "id": "solana",
      "name": "Solana",
      "symbol": "SOL",
      "logo": "https://cryptologos.cc/logos/solana-sol-logo.png",
      "currentPrice": 98.75,
      "priceChange24h": 3.45,
      "priceChangePercent24h": 3.62,
      "marketCap": 42800000000,
      "volume24h": 2100000000,
      "sparklineData": [95.30, 96.80, 97.20, 98.10, 99.20, 98.75],
      "owned": 4.2,
      "ownedValue": 414.75,
      "allocation": 8.8
    }
  ];

  final List<Map<String, dynamic>> _newsData = [
    {
      "id": 1,
      "title": "Bitcoin Reaches New All-Time High Amid Institutional Adoption",
      "summary":
          "Major corporations continue to add Bitcoin to their treasury reserves, driving unprecedented demand.",
      "imageUrl":
          "https://images.unsplash.com/photo-1621761191319-c6fb62004040?w=400",
      "source": "CryptoNews",
      "publishedAt": DateTime.now().subtract(Duration(hours: 2)),
      "url": "https://example.com/bitcoin-ath"
    },
    {
      "id": 2,
      "title":
          "Ethereum 2.0 Staking Rewards Surge as Network Upgrades Complete",
      "summary":
          "The latest network improvements have increased staking yields and reduced transaction fees significantly.",
      "imageUrl":
          "https://images.unsplash.com/photo-1639762681485-074b7f938ba0?w=400",
      "source": "BlockchainDaily",
      "publishedAt": DateTime.now().subtract(Duration(hours: 5)),
      "url": "https://example.com/ethereum-staking"
    },
    {
      "id": 3,
      "title": "Regulatory Clarity Boosts Altcoin Market Performance",
      "summary":
          "Clear guidelines from financial authorities have sparked renewed interest in alternative cryptocurrencies.",
      "imageUrl":
          "https://images.unsplash.com/photo-1642104704074-907c0698cbd9?w=400",
      "source": "CryptoRegulatory",
      "publishedAt": DateTime.now().subtract(Duration(hours: 8)),
      "url": "https://example.com/altcoin-regulation"
    }
  ];

  double get _totalPortfolioValue {
    return _cryptoData.fold(
        0.0, (sum, crypto) => sum + (crypto["ownedValue"] as double));
  }

  double get _portfolioChange24h {
    return _cryptoData.fold(0.0, (sum, crypto) {
      final owned = crypto["ownedValue"] as double;
      final changePercent = crypto["priceChangePercent24h"] as double;
      return sum + (owned * changePercent / 100);
    });
  }

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  void _showTradingBottomSheet(String coinId) {
    final coin = _cryptoData.firstWhere((crypto) => crypto["id"] == coinId);
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => TradingBottomSheetWidget(
        coinData: coin,
        onTrade: (String type, double amount) {
          Navigator.pop(context);
          _showTradeConfirmation(type, amount, coin);
        },
      ),
    );
  }

  void _showTradeConfirmation(
      String type, double amount, Map<String, dynamic> coin) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('${type.toUpperCase()} Order Confirmed'),
        content: Text(
          'Successfully placed ${type} order for ${amount.toStringAsFixed(6)} ${coin["symbol"]} at \$${coin["currentPrice"].toStringAsFixed(2)}',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('OK'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.primaryDark,
      body: SafeArea(
        child: Column(
          children: [
            _buildHeader(),
            _buildPortfolioSummary(),
            CryptoWatchlistWidget(
              cryptoData: _cryptoData,
              onCoinTap: _showTradingBottomSheet,
            ),
            _buildTabBar(),
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: [
                  PortfolioTabWidget(
                    cryptoData: _cryptoData,
                    onTrade: _showTradingBottomSheet,
                  ),
                  MarketsTabWidget(
                    cryptoData: _cryptoData,
                    onCoinTap: _showTradingBottomSheet,
                  ),
                  NewsTabWidget(newsData: _newsData),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: _buildBottomNavigationBar(),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 2.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Crypto Trading',
            style: AppTheme.darkTheme.textTheme.headlineSmall?.copyWith(
              color: AppTheme.textPrimary,
              fontWeight: FontWeight.w600,
            ),
          ),
          Row(
            children: [
              IconButton(
                onPressed: () {
                  // Search functionality
                },
                icon: CustomIconWidget(
                  iconName: 'search',
                  color: AppTheme.textSecondary,
                  size: 24,
                ),
              ),
              IconButton(
                onPressed: () {
                  // Notifications
                },
                icon: CustomIconWidget(
                  iconName: 'notifications_outlined',
                  color: AppTheme.textSecondary,
                  size: 24,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildPortfolioSummary() {
    final isPositive = _portfolioChange24h >= 0;
    final changeColor = isPositive ? AppTheme.successGreen : AppTheme.errorRed;
    final changeIcon = isPositive ? 'trending_up' : 'trending_down';

    return Container(
      margin: EdgeInsets.symmetric(horizontal: 4.w, vertical: 1.h),
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
            'Total Portfolio Value',
            style: AppTheme.darkTheme.textTheme.bodyMedium?.copyWith(
              color: AppTheme.textSecondary,
            ),
          ),
          SizedBox(height: 1.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '\$${_totalPortfolioValue.toStringAsFixed(2)}',
                style: AppTheme.getMonospaceStyle(
                  isLight: false,
                  fontSize: 28,
                  fontWeight: FontWeight.w700,
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 0.5.h),
                decoration: BoxDecoration(
                  color: changeColor.withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    CustomIconWidget(
                      iconName: changeIcon,
                      color: changeColor,
                      size: 16,
                    ),
                    SizedBox(width: 1.w),
                    Text(
                      '${isPositive ? '+' : ''}\$${_portfolioChange24h.toStringAsFixed(2)}',
                      style: AppTheme.getMonospaceStyle(
                        isLight: false,
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: changeColor,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTabBar() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 4.w, vertical: 2.h),
      child: TabBar(
        controller: _tabController,
        tabs: [
          Tab(text: 'Portfolio'),
          Tab(text: 'Markets'),
          Tab(text: 'News'),
        ],
      ),
    );
  }

  Widget _buildBottomNavigationBar() {
    return BottomNavigationBar(
      currentIndex: _selectedBottomIndex,
      type: BottomNavigationBarType.fixed,
      backgroundColor: AppTheme.secondaryDark,
      selectedItemColor: AppTheme.accentGold,
      unselectedItemColor: AppTheme.textSecondary,
      onTap: (index) {
        setState(() {
          _selectedBottomIndex = index;
        });

        switch (index) {
          case 0:
            Navigator.pushNamed(context, '/digital-wallet');
            break;
          case 1:
            Navigator.pushNamed(context, '/money-transfer');
            break;
          case 2:
            Navigator.pushNamed(context, '/transaction-history');
            break;
          case 3:
            // Current screen - Crypto Trading
            break;
          case 4:
            Navigator.pushNamed(context, '/nft-marketplace');
            break;
          case 5:
            Navigator.pushNamed(context, '/life-x-ecosystem');
            break;
        }
      },
      items: [
        BottomNavigationBarItem(
          icon: CustomIconWidget(
            iconName: 'account_balance_wallet',
            color: _selectedBottomIndex == 0
                ? AppTheme.accentGold
                : AppTheme.textSecondary,
            size: 24,
          ),
          label: 'Wallet',
        ),
        BottomNavigationBarItem(
          icon: CustomIconWidget(
            iconName: 'send',
            color: _selectedBottomIndex == 1
                ? AppTheme.accentGold
                : AppTheme.textSecondary,
            size: 24,
          ),
          label: 'Transfer',
        ),
        BottomNavigationBarItem(
          icon: CustomIconWidget(
            iconName: 'history',
            color: _selectedBottomIndex == 2
                ? AppTheme.accentGold
                : AppTheme.textSecondary,
            size: 24,
          ),
          label: 'History',
        ),
        BottomNavigationBarItem(
          icon: CustomIconWidget(
            iconName: 'currency_bitcoin',
            color: _selectedBottomIndex == 3
                ? AppTheme.accentGold
                : AppTheme.textSecondary,
            size: 24,
          ),
          label: 'Crypto',
        ),
        BottomNavigationBarItem(
          icon: CustomIconWidget(
            iconName: 'palette',
            color: _selectedBottomIndex == 4
                ? AppTheme.accentGold
                : AppTheme.textSecondary,
            size: 24,
          ),
          label: 'NFT',
        ),
        BottomNavigationBarItem(
          icon: CustomIconWidget(
            iconName: 'explore',
            color: _selectedBottomIndex == 5
                ? AppTheme.accentGold
                : AppTheme.textSecondary,
            size: 24,
          ),
          label: 'LifeX',
        ),
      ],
    );
  }
}
