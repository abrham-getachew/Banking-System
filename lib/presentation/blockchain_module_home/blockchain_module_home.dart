import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../core/app_export.dart';
import './widgets/bottom_navigation_bar.dart';
import './widgets/crypto_nft_toggle.dart';
import './widgets/discovery_zone.dart';
import './widgets/portfolio_summary_card.dart';
import './widgets/recent_transactions_feed.dart';
import './widgets/search_header.dart';
import './widgets/trending_markets_carousel.dart';

class BlockchainModuleHome extends StatefulWidget {
  const BlockchainModuleHome({super.key});

  @override
  State<BlockchainModuleHome> createState() => _BlockchainModuleHomeState();
}

class _BlockchainModuleHomeState extends State<BlockchainModuleHome> {
  final ScrollController _scrollController = ScrollController();
  int _currentTabIndex = 0; // 0 for Crypto, 1 for NFT
  int _bottomNavIndex = 2; // Blockchain tab is active
  bool _isRefreshing = false;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    // Handle scroll events for additional functionality if needed
  }

  Future<void> _onRefresh() async {
    setState(() {
      _isRefreshing = true;
    });

    // Simulate refresh delay
    await Future.delayed(const Duration(seconds: 2));

    setState(() {
      _isRefreshing = false;
    });
  }

  void _onTabChanged(int index) {
    setState(() {
      _currentTabIndex = index;
    });
  }

  void _onBottomNavTapped(int index) {
    setState(() {
      _bottomNavIndex = index;
    });

    // Navigate to different sections based on index
    switch (index) {
      case 0:
        // Navigate to Banking
        break;
      case 1:
        // Navigate to Payments
        break;
      case 2:
        // Stay on Blockchain (current)
        break;
      case 3:
        // Navigate to Investments
        break;
      case 4:
        // Navigate to Profile
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.trueDarkBackground,
      body: Column(
        children: [
          const SearchHeader(),
          CryptoNftToggle(
            onTabChanged: _onTabChanged,
            initialIndex: _currentTabIndex,
          ),
          Expanded(
            child: RefreshIndicator(
              onRefresh: _onRefresh,
              color: AppTheme.primaryGold,
              backgroundColor: AppTheme.elevatedSurface,
              child: _currentTabIndex == 0
                  ? _buildCryptoContent()
                  : _buildNFTContent(),
            ),
          ),
        ],
      ),
      bottomNavigationBar: CustomBottomNavigationBar(
        currentIndex: _bottomNavIndex,
        onTap: _onBottomNavTapped,
      ),
    );
  }

  Widget _buildCryptoContent() {
    return SingleChildScrollView(
      controller: _scrollController,
      physics: const AlwaysScrollableScrollPhysics(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 2.h),
          const TrendingMarketsCarousel(),
          SizedBox(height: 4.h),
          const PortfolioSummaryCard(),
          SizedBox(height: 4.h),
          const DiscoveryZone(),
          SizedBox(height: 4.h),
          const RecentTransactionsFeed(),
          SizedBox(height: 4.h),
        ],
      ),
    );
  }

  Widget _buildNFTContent() {
    return SingleChildScrollView(
      controller: _scrollController,
      physics: const AlwaysScrollableScrollPhysics(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 2.h),
          _buildNFTPlaceholder(),
          SizedBox(height: 4.h),
        ],
      ),
    );
  }

  Widget _buildNFTPlaceholder() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 4.w),
      padding: EdgeInsets.all(8.w),
      decoration: BoxDecoration(
        color: AppTheme.elevatedSurface.withValues(alpha: 0.8),
        borderRadius: BorderRadius.circular(5.w),
        border: Border.all(
          color: AppTheme.textPrimary.withValues(alpha: 0.1),
          width: 1,
        ),
      ),
      child: Column(
        children: [
          CustomIconWidget(
            iconName: 'image',
            color: AppTheme.primaryGold,
            size: 15.w,
          ),
          SizedBox(height: 3.h),
          Text(
            'NFT Marketplace',
            style: AppTheme.darkTheme.textTheme.headlineSmall?.copyWith(
              color: AppTheme.textPrimary,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: 2.h),
          Text(
            'Discover, collect, and trade unique digital assets. The NFT marketplace is coming soon with featured drops, trending collections, and creator profiles.',
            style: AppTheme.darkTheme.textTheme.bodyMedium?.copyWith(
              color: AppTheme.textSecondary,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 4.h),
          ElevatedButton(
            onPressed: () {
              // Navigate to NFT marketplace when available
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppTheme.primaryGold,
              foregroundColor: AppTheme.trueDarkBackground,
              padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 2.h),
            ),
            child: Text(
              'Coming Soon',
              style: AppTheme.darkTheme.textTheme.titleSmall?.copyWith(
                color: AppTheme.trueDarkBackground,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
