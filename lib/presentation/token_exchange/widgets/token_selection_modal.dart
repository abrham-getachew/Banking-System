import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';

class TokenSelectionModal extends StatefulWidget {
  final Function(Map<String, dynamic>) onTokenSelected;

  const TokenSelectionModal({
    Key? key,
    required this.onTokenSelected,
  }) : super(key: key);

  @override
  State<TokenSelectionModal> createState() => _TokenSelectionModalState();
}

class _TokenSelectionModalState extends State<TokenSelectionModal> {
  final TextEditingController _searchController = TextEditingController();
  List<Map<String, dynamic>> _filteredTokens = [];

  final List<Map<String, dynamic>> _availableTokens = [
    {
      "symbol": "BTC",
      "name": "Bitcoin",
      "icon": "https://cryptologos.cc/logos/bitcoin-btc-logo.png",
      "balance": "0.00234567",
      "usdValue": "\$1,234.56",
      "isPopular": true,
    },
    {
      "symbol": "ETH",
      "name": "Ethereum",
      "icon": "https://cryptologos.cc/logos/ethereum-eth-logo.png",
      "balance": "1.23456789",
      "usdValue": "\$2,345.67",
      "isPopular": true,
    },
    {
      "symbol": "USDT",
      "name": "Tether USD",
      "icon": "https://cryptologos.cc/logos/tether-usdt-logo.png",
      "balance": "1,234.56",
      "usdValue": "\$1,234.56",
      "isPopular": true,
    },
    {
      "symbol": "BNB",
      "name": "Binance Coin",
      "icon": "https://cryptologos.cc/logos/bnb-bnb-logo.png",
      "balance": "12.3456",
      "usdValue": "\$3,456.78",
      "isPopular": true,
    },
    {
      "symbol": "ADA",
      "name": "Cardano",
      "icon": "https://cryptologos.cc/logos/cardano-ada-logo.png",
      "balance": "1,234.56",
      "usdValue": "\$567.89",
      "isPopular": false,
    },
    {
      "symbol": "DOT",
      "name": "Polkadot",
      "icon": "https://cryptologos.cc/logos/polkadot-new-dot-logo.png",
      "balance": "123.456",
      "usdValue": "\$890.12",
      "isPopular": false,
    },
    {
      "symbol": "LINK",
      "name": "Chainlink",
      "icon": "https://cryptologos.cc/logos/chainlink-link-logo.png",
      "balance": "234.567",
      "usdValue": "\$1,345.67",
      "isPopular": false,
    },
    {
      "symbol": "UNI",
      "name": "Uniswap",
      "icon": "https://cryptologos.cc/logos/uniswap-uni-logo.png",
      "balance": "45.6789",
      "usdValue": "\$234.56",
      "isPopular": false,
    },
  ];

  @override
  void initState() {
    super.initState();
    _filteredTokens = _availableTokens;
    _searchController.addListener(_filterTokens);
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _filterTokens() {
    final query = _searchController.text.toLowerCase();
    setState(() {
      _filteredTokens = _availableTokens.where((token) {
        final symbol = (token['symbol'] as String).toLowerCase();
        final name = (token['name'] as String).toLowerCase();
        return symbol.contains(query) || name.contains(query);
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80.h,
      decoration: BoxDecoration(
        color: AppTheme.elevatedSurface,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Column(
        children: [
          _buildHeader(),
          _buildSearchBar(),
          _buildPopularTokens(),
          Expanded(child: _buildTokenList()),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Padding(
      padding: EdgeInsets.all(4.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Select Token',
            style: AppTheme.darkTheme.textTheme.titleLarge?.copyWith(
              color: AppTheme.textPrimary,
              fontWeight: FontWeight.w600,
            ),
          ),
          GestureDetector(
            onTap: () => Navigator.pop(context),
            child: Container(
              padding: EdgeInsets.all(2.w),
              decoration: BoxDecoration(
                color: AppTheme.deepCharcoal,
                shape: BoxShape.circle,
              ),
              child: CustomIconWidget(
                iconName: 'close',
                color: AppTheme.textSecondary,
                size: 5.w,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchBar() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 4.w),
      child: TextField(
        controller: _searchController,
        style: AppTheme.darkTheme.textTheme.bodyMedium?.copyWith(
          color: AppTheme.textPrimary,
        ),
        decoration: InputDecoration(
          hintText: 'Search tokens...',
          hintStyle: AppTheme.darkTheme.textTheme.bodyMedium?.copyWith(
            color: AppTheme.textSecondary,
          ),
          prefixIcon: Padding(
            padding: EdgeInsets.all(3.w),
            child: CustomIconWidget(
              iconName: 'search',
              color: AppTheme.textSecondary,
              size: 5.w,
            ),
          ),
          filled: true,
          fillColor: AppTheme.deepCharcoal,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none,
          ),
          contentPadding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 3.h),
        ),
      ),
    );
  }

  Widget _buildPopularTokens() {
    final popularTokens =
        _availableTokens.where((token) => token['isPopular'] == true).toList();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.fromLTRB(4.w, 3.h, 4.w, 2.h),
          child: Text(
            'Popular Tokens',
            style: AppTheme.darkTheme.textTheme.titleMedium?.copyWith(
              color: AppTheme.textPrimary,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        SizedBox(
          height: 12.h,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            padding: EdgeInsets.symmetric(horizontal: 4.w),
            itemCount: popularTokens.length,
            itemBuilder: (context, index) {
              final token = popularTokens[index];
              return _buildPopularTokenCard(token);
            },
          ),
        ),
      ],
    );
  }

  Widget _buildPopularTokenCard(Map<String, dynamic> token) {
    return GestureDetector(
      onTap: () {
        widget.onTokenSelected(token);
        Navigator.pop(context);
      },
      child: Container(
        width: 20.w,
        margin: EdgeInsets.only(right: 3.w),
        padding: EdgeInsets.all(3.w),
        decoration: BoxDecoration(
          color: AppTheme.deepCharcoal.withValues(alpha: 0.6),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: AppTheme.primaryGold.withValues(alpha: 0.2),
            width: 1,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 8.w,
              height: 8.w,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppTheme.elevatedSurface,
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(4.w),
                child: CustomImageWidget(
                  imageUrl: token['icon'],
                  width: 8.w,
                  height: 8.w,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SizedBox(height: 1.h),
            Text(
              token['symbol'],
              style: AppTheme.darkTheme.textTheme.bodySmall?.copyWith(
                color: AppTheme.textPrimary,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTokenList() {
    return ListView.builder(
      padding: EdgeInsets.symmetric(horizontal: 4.w),
      itemCount: _filteredTokens.length,
      itemBuilder: (context, index) {
        final token = _filteredTokens[index];
        return _buildTokenListItem(token);
      },
    );
  }

  Widget _buildTokenListItem(Map<String, dynamic> token) {
    return GestureDetector(
      onTap: () {
        widget.onTokenSelected(token);
        Navigator.pop(context);
      },
      child: Container(
        padding: EdgeInsets.all(4.w),
        margin: EdgeInsets.only(bottom: 2.h),
        decoration: BoxDecoration(
          color: AppTheme.deepCharcoal.withValues(alpha: 0.4),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: AppTheme.primaryGold.withValues(alpha: 0.1),
            width: 1,
          ),
        ),
        child: Row(
          children: [
            Container(
              width: 12.w,
              height: 12.w,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppTheme.elevatedSurface,
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(6.w),
                child: CustomImageWidget(
                  imageUrl: token['icon'],
                  width: 12.w,
                  height: 12.w,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SizedBox(width: 3.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    token['symbol'],
                    style: AppTheme.darkTheme.textTheme.titleMedium?.copyWith(
                      color: AppTheme.textPrimary,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    token['name'],
                    style: AppTheme.darkTheme.textTheme.bodySmall?.copyWith(
                      color: AppTheme.textSecondary,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  token['balance'],
                  style: AppTheme.darkTheme.textTheme.bodyMedium?.copyWith(
                    color: AppTheme.textPrimary,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  token['usdValue'],
                  style: AppTheme.darkTheme.textTheme.bodySmall?.copyWith(
                    color: AppTheme.textSecondary,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
