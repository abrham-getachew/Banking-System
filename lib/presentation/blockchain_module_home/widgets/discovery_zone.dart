import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../../core/app_export.dart';

class DiscoveryZone extends StatefulWidget {
  const DiscoveryZone({super.key});

  @override
  State<DiscoveryZone> createState() => _DiscoveryZoneState();
}

class _DiscoveryZoneState extends State<DiscoveryZone> {
  final ScrollController _scrollController = ScrollController();
  bool _isLoading = false;

  final List<Map<String, dynamic>> marketMovers = [
    {
      "id": 1,
      "symbol": "DOGE",
      "name": "Dogecoin",
      "price": "\$0.0789",
      "change": "+15.67%",
      "isPositive": true,
      "volume": "\$2.4B",
      "marketCap": "\$11.2B",
    },
    {
      "id": 2,
      "symbol": "ADA",
      "name": "Cardano",
      "price": "\$0.4521",
      "change": "+8.34%",
      "isPositive": true,
      "volume": "\$890M",
      "marketCap": "\$15.8B",
    },
    {
      "id": 3,
      "symbol": "SOL",
      "name": "Solana",
      "price": "\$98.76",
      "change": "-3.21%",
      "isPositive": false,
      "volume": "\$1.2B",
      "marketCap": "\$42.1B",
    },
    {
      "id": 4,
      "symbol": "MATIC",
      "name": "Polygon",
      "price": "\$0.8934",
      "change": "+12.45%",
      "isPositive": true,
      "volume": "\$567M",
      "marketCap": "\$8.3B",
    },
    {
      "id": 5,
      "symbol": "DOT",
      "name": "Polkadot",
      "price": "\$6.78",
      "change": "+4.56%",
      "isPositive": true,
      "volume": "\$234M",
      "marketCap": "\$7.9B",
    },
    {
      "id": 6,
      "symbol": "AVAX",
      "name": "Avalanche",
      "price": "\$34.21",
      "change": "-2.34%",
      "isPositive": false,
      "volume": "\$456M",
      "marketCap": "\$12.7B",
    },
  ];

  final List<Map<String, dynamic>> curatedTokens = [
    {
      "id": 1,
      "symbol": "UNI",
      "name": "Uniswap",
      "price": "\$7.89",
      "change": "+6.78%",
      "isPositive": true,
      "category": "DeFi",
      "description": "Leading decentralized exchange protocol",
    },
    {
      "id": 2,
      "symbol": "LINK",
      "name": "Chainlink",
      "price": "\$14.56",
      "change": "+3.45%",
      "isPositive": true,
      "category": "Oracle",
      "description": "Decentralized oracle network",
    },
    {
      "id": 3,
      "symbol": "AAVE",
      "name": "Aave",
      "price": "\$89.12",
      "change": "-1.23%",
      "isPositive": false,
      "category": "DeFi",
      "description": "Decentralized lending protocol",
    },
  ];

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
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent - 200) {
      _loadMoreData();
    }
  }

  Future<void> _loadMoreData() async {
    if (_isLoading) return;

    setState(() {
      _isLoading = true;
    });

    // Simulate loading more data
    await Future.delayed(const Duration(seconds: 1));

    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 4.w),
          child: Text(
            'Discovery Zone',
            style: AppTheme.darkTheme.textTheme.titleLarge?.copyWith(
              color: AppTheme.textPrimary,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        SizedBox(height: 3.h),
        _buildMarketMoversSection(),
        SizedBox(height: 4.h),
        _buildCuratedTokensSection(),
      ],
    );
  }

  Widget _buildMarketMoversSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 4.w),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Market Movers',
                style: AppTheme.darkTheme.textTheme.titleMedium?.copyWith(
                  color: AppTheme.textPrimary,
                  fontWeight: FontWeight.w600,
                ),
              ),
              CustomIconWidget(
                iconName: 'trending_up',
                color: AppTheme.successGreen,
                size: 5.w,
              ),
            ],
          ),
        ),
        SizedBox(height: 2.h),
        SizedBox(
          height: 25.h,
          child: GridView.builder(
            padding: EdgeInsets.symmetric(horizontal: 4.w),
            scrollDirection: Axis.horizontal,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 1.2,
              crossAxisSpacing: 2.h,
              mainAxisSpacing: 3.w,
            ),
            itemCount: marketMovers.length,
            itemBuilder: (context, index) {
              final mover = marketMovers[index];
              return _buildMoverCard(mover);
            },
          ),
        ),
      ],
    );
  }

  Widget _buildMoverCard(Map<String, dynamic> mover) {
    return GestureDetector(
      onTap: () => Navigator.pushNamed(context, '/token-detail-view'),
      child: Container(
        padding: EdgeInsets.all(3.w),
        decoration: BoxDecoration(
          color: AppTheme.elevatedSurface.withValues(alpha: 0.8),
          borderRadius: BorderRadius.circular(3.w),
          border: Border.all(
            color: AppTheme.textPrimary.withValues(alpha: 0.1),
            width: 1,
          ),
        ),
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
                      mover["symbol"] as String,
                      style: AppTheme.darkTheme.textTheme.labelSmall?.copyWith(
                        color: AppTheme.primaryGold,
                        fontWeight: FontWeight.w600,
                        fontSize: 8.sp,
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 2.w),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        mover["symbol"] as String,
                        style:
                            AppTheme.darkTheme.textTheme.bodyMedium?.copyWith(
                          color: AppTheme.textPrimary,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Text(
                        mover["name"] as String,
                        style: AppTheme.darkTheme.textTheme.bodySmall?.copyWith(
                          color: AppTheme.textSecondary,
                          fontSize: 9.sp,
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
                  mover["price"] as String,
                  style: AppTheme.darkTheme.textTheme.titleSmall?.copyWith(
                    color: AppTheme.textPrimary,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                Row(
                  children: [
                    CustomIconWidget(
                      iconName: (mover["isPositive"] as bool)
                          ? 'trending_up'
                          : 'trending_down',
                      color: (mover["isPositive"] as bool)
                          ? AppTheme.successGreen
                          : AppTheme.errorRed,
                      size: 3.w,
                    ),
                    SizedBox(width: 1.w),
                    Text(
                      mover["change"] as String,
                      style: AppTheme.darkTheme.textTheme.bodySmall?.copyWith(
                        color: (mover["isPositive"] as bool)
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
    );
  }

  Widget _buildCuratedTokensSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 4.w),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Curated Tokens',
                style: AppTheme.darkTheme.textTheme.titleMedium?.copyWith(
                  color: AppTheme.textPrimary,
                  fontWeight: FontWeight.w600,
                ),
              ),
              CustomIconWidget(
                iconName: 'star',
                color: AppTheme.primaryGold,
                size: 5.w,
              ),
            ],
          ),
        ),
        SizedBox(height: 2.h),
        ListView.builder(
          controller: _scrollController,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          padding: EdgeInsets.symmetric(horizontal: 4.w),
          itemCount: curatedTokens.length + (_isLoading ? 1 : 0),
          itemBuilder: (context, index) {
            if (index == curatedTokens.length) {
              return Container(
                padding: EdgeInsets.all(4.w),
                child: const Center(
                  child: CircularProgressIndicator(
                    color: AppTheme.primaryGold,
                  ),
                ),
              );
            }

            final token = curatedTokens[index];
            return _buildCuratedTokenCard(token);
          },
        ),
      ],
    );
  }

  Widget _buildCuratedTokenCard(Map<String, dynamic> token) {
    return GestureDetector(
      onTap: () => Navigator.pushNamed(context, '/token-detail-view'),
      child: Container(
        margin: EdgeInsets.only(bottom: 2.h),
        padding: EdgeInsets.all(4.w),
        decoration: BoxDecoration(
          color: AppTheme.elevatedSurface.withValues(alpha: 0.8),
          borderRadius: BorderRadius.circular(4.w),
          border: Border.all(
            color: AppTheme.textPrimary.withValues(alpha: 0.1),
            width: 1,
          ),
        ),
        child: Row(
          children: [
            Container(
              width: 12.w,
              height: 12.w,
              decoration: BoxDecoration(
                color: AppTheme.primaryGold.withValues(alpha: 0.2),
                borderRadius: BorderRadius.circular(3.w),
              ),
              child: Center(
                child: Text(
                  token["symbol"] as String,
                  style: AppTheme.darkTheme.textTheme.labelMedium?.copyWith(
                    color: AppTheme.primaryGold,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
            SizedBox(width: 4.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        token["symbol"] as String,
                        style:
                            AppTheme.darkTheme.textTheme.titleSmall?.copyWith(
                          color: AppTheme.textPrimary,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Text(
                        token["price"] as String,
                        style:
                            AppTheme.darkTheme.textTheme.titleSmall?.copyWith(
                          color: AppTheme.textPrimary,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 0.5.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          token["name"] as String,
                          style:
                              AppTheme.darkTheme.textTheme.bodySmall?.copyWith(
                            color: AppTheme.textSecondary,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      Row(
                        children: [
                          CustomIconWidget(
                            iconName: (token["isPositive"] as bool)
                                ? 'trending_up'
                                : 'trending_down',
                            color: (token["isPositive"] as bool)
                                ? AppTheme.successGreen
                                : AppTheme.errorRed,
                            size: 3.w,
                          ),
                          SizedBox(width: 1.w),
                          Text(
                            token["change"] as String,
                            style: AppTheme.darkTheme.textTheme.bodySmall
                                ?.copyWith(
                              color: (token["isPositive"] as bool)
                                  ? AppTheme.successGreen
                                  : AppTheme.errorRed,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: 1.h),
                  Row(
                    children: [
                      Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: 2.w, vertical: 0.5.h),
                        decoration: BoxDecoration(
                          color: AppTheme.infoBlue.withValues(alpha: 0.2),
                          borderRadius: BorderRadius.circular(1.w),
                        ),
                        child: Text(
                          token["category"] as String,
                          style:
                              AppTheme.darkTheme.textTheme.labelSmall?.copyWith(
                            color: AppTheme.infoBlue,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      SizedBox(width: 2.w),
                      Expanded(
                        child: Text(
                          token["description"] as String,
                          style:
                              AppTheme.darkTheme.textTheme.bodySmall?.copyWith(
                            color: AppTheme.textSecondary,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
