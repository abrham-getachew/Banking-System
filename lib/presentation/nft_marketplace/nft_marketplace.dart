import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../core/app_export.dart';
import './widgets/category_tab_widget.dart';
import './widgets/featured_collection_widget.dart';
import './widgets/filter_modal_widget.dart';
import './widgets/nft_card_widget.dart';
import './widgets/nft_detail_modal_widget.dart';

class NftMarketplace extends StatefulWidget {
  const NftMarketplace({Key? key}) : super(key: key);

  @override
  State<NftMarketplace> createState() => _NftMarketplaceState();
}

class _NftMarketplaceState extends State<NftMarketplace>
    with TickerProviderStateMixin {
  late TabController _tabController;
  final TextEditingController _searchController = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  String _selectedCategory = 'All';
  List<String> _selectedNfts = [];
  bool _isSelectionMode = false;
  bool _isLoading = false;
  String _searchQuery = '';

  final List<String> _categories = [
    'All',
    'Art',
    'Music',
    'Gaming',
    'Collectibles'
  ];

  // Mock NFT data
  final List<Map<String, dynamic>> _featuredCollections = [
    {
      "id": "1",
      "name": "CryptoPunks",
      "image":
          "https://images.unsplash.com/photo-1618005182384-a83a8bd57fbe?w=400&h=400&fit=crop",
      "floorPrice": "45.2",
      "volume": "1,234.5",
      "change": "+12.5%",
      "isPositive": true,
    },
    {
      "id": "2",
      "name": "Bored Ape Yacht Club",
      "image":
          "https://images.unsplash.com/photo-1634973357973-f2ed2657db3c?w=400&h=400&fit=crop",
      "floorPrice": "28.7",
      "volume": "987.3",
      "change": "-3.2%",
      "isPositive": false,
    },
    {
      "id": "3",
      "name": "Art Blocks Curated",
      "image":
          "https://images.unsplash.com/photo-1541961017774-22349e4a1262?w=400&h=400&fit=crop",
      "floorPrice": "12.8",
      "volume": "456.7",
      "change": "+8.9%",
      "isPositive": true,
    },
  ];

  final List<Map<String, dynamic>> _nftItems = [
    {
      "id": "1",
      "name": "Cosmic Dreams #1234",
      "collection": "Cosmic Collection",
      "image":
          "https://images.unsplash.com/photo-1634973357973-f2ed2657db3c?w=300&h=300&fit=crop",
      "price": "2.5",
      "usdPrice": "4,250.00",
      "category": "Art",
      "rarity": "Rare",
      "isFavorite": false,
      "traits": ["Blue Background", "Laser Eyes", "Gold Chain"],
    },
    {
      "id": "2",
      "name": "Digital Harmony #567",
      "collection": "Music Waves",
      "image":
          "https://images.unsplash.com/photo-1541961017774-22349e4a1262?w=300&h=300&fit=crop",
      "price": "1.8",
      "usdPrice": "3,060.00",
      "category": "Music",
      "rarity": "Common",
      "isFavorite": true,
      "traits": ["Purple Waves", "Sound Bars", "Neon Glow"],
    },
    {
      "id": "3",
      "name": "Pixel Warrior #890",
      "collection": "Game Heroes",
      "image":
          "https://images.unsplash.com/photo-1618005182384-a83a8bd57fbe?w=300&h=300&fit=crop",
      "price": "0.9",
      "usdPrice": "1,530.00",
      "category": "Gaming",
      "rarity": "Epic",
      "isFavorite": false,
      "traits": ["Sword", "Armor", "Fire Element"],
    },
    {
      "id": "4",
      "name": "Abstract Vision #345",
      "collection": "Modern Art",
      "image":
          "https://images.unsplash.com/photo-1634973357973-f2ed2657db3c?w=300&h=300&fit=crop",
      "price": "3.2",
      "usdPrice": "5,440.00",
      "category": "Art",
      "rarity": "Legendary",
      "isFavorite": true,
      "traits": ["Geometric", "Vibrant Colors", "3D Effect"],
    },
    {
      "id": "5",
      "name": "Trading Card #123",
      "collection": "Sports Cards",
      "image":
          "https://images.unsplash.com/photo-1541961017774-22349e4a1262?w=300&h=300&fit=crop",
      "price": "0.5",
      "usdPrice": "850.00",
      "category": "Collectibles",
      "rarity": "Common",
      "isFavorite": false,
      "traits": ["Rookie Card", "Holographic", "Limited Edition"],
    },
    {
      "id": "6",
      "name": "Cyber Punk #678",
      "collection": "Future City",
      "image":
          "https://images.unsplash.com/photo-1618005182384-a83a8bd57fbe?w=300&h=300&fit=crop",
      "price": "4.1",
      "usdPrice": "6,970.00",
      "category": "Art",
      "rarity": "Rare",
      "isFavorite": false,
      "traits": ["Neon City", "Cybernetic", "Night Scene"],
    },
  ];

  List<Map<String, dynamic>> _filteredNfts = [];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: _categories.length, vsync: this);
    _filteredNfts = List.from(_nftItems);
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _tabController.dispose();
    _searchController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent) {
      _loadMoreNfts();
    }
  }

  void _loadMoreNfts() {
    if (!_isLoading) {
      setState(() {
        _isLoading = true;
      });

      // Simulate loading delay
      Future.delayed(const Duration(seconds: 1), () {
        setState(() {
          _isLoading = false;
        });
      });
    }
  }

  void _filterNfts() {
    setState(() {
      _filteredNfts = _nftItems.where((nft) {
        final matchesSearch = _searchQuery.isEmpty ||
            (nft["name"] as String)
                .toLowerCase()
                .contains(_searchQuery.toLowerCase()) ||
            (nft["collection"] as String)
                .toLowerCase()
                .contains(_searchQuery.toLowerCase());

        final matchesCategory =
            _selectedCategory == 'All' || nft["category"] == _selectedCategory;

        return matchesSearch && matchesCategory;
      }).toList();
    });
  }

  void _onCategoryChanged(String category) {
    setState(() {
      _selectedCategory = category;
    });
    _filterNfts();
  }

  void _onSearchChanged(String query) {
    setState(() {
      _searchQuery = query;
    });
    _filterNfts();
  }

  void _toggleFavorite(String nftId) {
    setState(() {
      final index = _nftItems.indexWhere((nft) => nft["id"] == nftId);
      if (index != -1) {
        _nftItems[index]["isFavorite"] =
            !(_nftItems[index]["isFavorite"] as bool);
      }
    });
    _filterNfts();
  }

  void _toggleSelection(String nftId) {
    setState(() {
      if (_selectedNfts.contains(nftId)) {
        _selectedNfts.remove(nftId);
      } else {
        _selectedNfts.add(nftId);
      }

      if (_selectedNfts.isEmpty) {
        _isSelectionMode = false;
      }
    });
  }

  void _startSelectionMode(String nftId) {
    setState(() {
      _isSelectionMode = true;
      _selectedNfts.add(nftId);
    });
  }

  void _clearSelection() {
    setState(() {
      _isSelectionMode = false;
      _selectedNfts.clear();
    });
  }

  void _showFilterModal() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => FilterModalWidget(
        onApplyFilters: (filters) {
          // Apply filters logic here
          Navigator.pop(context);
        },
      ),
    );
  }

  void _showNftDetail(Map<String, dynamic> nft) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => NftDetailModalWidget(
        nft: nft,
        onBuy: () {
          Navigator.pop(context);
          _showBuyModal(nft);
        },
        onFavorite: () => _toggleFavorite(nft["id"] as String),
      ),
    );
  }

  void _showBuyModal(Map<String, dynamic> nft) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: AppTheme.surfaceModal,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: Text(
          'Purchase NFT',
          style: AppTheme.darkTheme.textTheme.titleLarge,
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              nft["name"] as String,
              style: AppTheme.darkTheme.textTheme.titleMedium,
            ),
            SizedBox(height: 2.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Price:',
                  style: AppTheme.darkTheme.textTheme.bodyMedium,
                ),
                Text(
                  '${nft["price"]} ETH (\$${nft["usdPrice"]})',
                  style: AppTheme.darkTheme.textTheme.titleMedium?.copyWith(
                    color: AppTheme.accentGold,
                  ),
                ),
              ],
            ),
            SizedBox(height: 2.h),
            Text(
              'Connect your wallet to complete the purchase',
              style: AppTheme.darkTheme.textTheme.bodySmall,
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              // Simulate wallet connection
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Wallet connection required'),
                  backgroundColor: AppTheme.warningAmber,
                ),
              );
            },
            child: Text('Connect Wallet'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.primaryDark,
      appBar: AppBar(
        backgroundColor: AppTheme.primaryDark,
        elevation: 0,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: CustomIconWidget(
            iconName: 'arrow_back',
            color: AppTheme.textPrimary,
            size: 24,
          ),
        ),
        title: Text(
          'NFT Marketplace',
          style: AppTheme.darkTheme.textTheme.titleLarge,
        ),
        actions: [
          if (_isSelectionMode) ...[
            IconButton(
              onPressed: _clearSelection,
              icon: CustomIconWidget(
                iconName: 'close',
                color: AppTheme.textPrimary,
                size: 24,
              ),
            ),
            Container(
              margin: EdgeInsets.only(right: 4.w),
              child: Center(
                child: Text(
                  '${_selectedNfts.length}',
                  style: AppTheme.darkTheme.textTheme.titleMedium?.copyWith(
                    color: AppTheme.accentGold,
                  ),
                ),
              ),
            ),
          ] else ...[
            IconButton(
              onPressed: _showFilterModal,
              icon: CustomIconWidget(
                iconName: 'tune',
                color: AppTheme.textPrimary,
                size: 24,
              ),
            ),
            IconButton(
              onPressed: () => Navigator.pushNamed(context, '/digital-wallet'),
              icon: CustomIconWidget(
                iconName: 'account_balance_wallet',
                color: AppTheme.accentGold,
                size: 24,
              ),
            ),
          ],
        ],
      ),
      body: Column(
        children: [
          // Search Bar
          Container(
            margin: EdgeInsets.symmetric(horizontal: 4.w, vertical: 2.h),
            child: TextField(
              controller: _searchController,
              onChanged: _onSearchChanged,
              style: AppTheme.darkTheme.textTheme.bodyMedium,
              decoration: InputDecoration(
                hintText: 'Search NFTs, collections, artists...',
                prefixIcon: CustomIconWidget(
                  iconName: 'search',
                  color: AppTheme.textSecondary,
                  size: 20,
                ),
                suffixIcon: _searchQuery.isNotEmpty
                    ? IconButton(
                        onPressed: () {
                          _searchController.clear();
                          _onSearchChanged('');
                        },
                        icon: CustomIconWidget(
                          iconName: 'clear',
                          color: AppTheme.textSecondary,
                          size: 20,
                        ),
                      )
                    : null,
                filled: true,
                fillColor: AppTheme.secondaryDark,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
                contentPadding:
                    EdgeInsets.symmetric(horizontal: 4.w, vertical: 1.5.h),
              ),
            ),
          ),

          // Featured Collections
          if (_searchQuery.isEmpty) ...[
            Container(
              margin: EdgeInsets.only(left: 4.w, bottom: 2.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Featured Collections',
                    style: AppTheme.darkTheme.textTheme.titleLarge,
                  ),
                  SizedBox(height: 2.h),
                  SizedBox(
                    height: 20.h,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: _featuredCollections.length,
                      itemBuilder: (context, index) {
                        final collection = _featuredCollections[index];
                        return FeaturedCollectionWidget(
                          collection: collection,
                          onTap: () {
                            // Navigate to collection detail
                          },
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],

          // Category Tabs
          Container(
            margin: EdgeInsets.symmetric(horizontal: 4.w),
            child: CategoryTabWidget(
              categories: _categories,
              selectedCategory: _selectedCategory,
              onCategoryChanged: _onCategoryChanged,
            ),
          ),

          SizedBox(height: 2.h),

          // NFT Grid
          Expanded(
            child: _filteredNfts.isEmpty
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CustomIconWidget(
                          iconName: 'search_off',
                          color: AppTheme.textSecondary,
                          size: 64,
                        ),
                        SizedBox(height: 2.h),
                        Text(
                          'No NFTs found',
                          style: AppTheme.darkTheme.textTheme.titleMedium
                              ?.copyWith(
                            color: AppTheme.textSecondary,
                          ),
                        ),
                        SizedBox(height: 1.h),
                        Text(
                          'Try adjusting your search or filters',
                          style: AppTheme.darkTheme.textTheme.bodySmall,
                        ),
                      ],
                    ),
                  )
                : GridView.builder(
                    controller: _scrollController,
                    padding: EdgeInsets.symmetric(horizontal: 4.w),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 3.w,
                      mainAxisSpacing: 2.h,
                      childAspectRatio: 0.75,
                    ),
                    itemCount: _filteredNfts.length + (_isLoading ? 2 : 0),
                    itemBuilder: (context, index) {
                      if (index >= _filteredNfts.length) {
                        return Container(
                          decoration: BoxDecoration(
                            color: AppTheme.secondaryDark,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Center(
                            child: CircularProgressIndicator(
                              color: AppTheme.accentGold,
                              strokeWidth: 2,
                            ),
                          ),
                        );
                      }

                      final nft = _filteredNfts[index];
                      final isSelected = _selectedNfts.contains(nft["id"]);

                      return NftCardWidget(
                        nft: nft,
                        isSelected: isSelected,
                        isSelectionMode: _isSelectionMode,
                        onTap: () {
                          if (_isSelectionMode) {
                            _toggleSelection(nft["id"] as String);
                          } else {
                            _showNftDetail(nft);
                          }
                        },
                        onLongPress: () {
                          if (!_isSelectionMode) {
                            _startSelectionMode(nft["id"] as String);
                          }
                        },
                        onFavorite: () => _toggleFavorite(nft["id"] as String),
                      );
                    },
                  ),
          ),
        ],
      ),
      bottomNavigationBar: _isSelectionMode
          ? Container(
              padding: EdgeInsets.all(4.w),
              decoration: BoxDecoration(
                color: AppTheme.secondaryDark,
                border: Border(
                  top: BorderSide(color: AppTheme.borderGray, width: 1),
                ),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () {
                        // Add to collection logic
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                                'Added ${_selectedNfts.length} NFTs to collection'),
                          ),
                        );
                        _clearSelection();
                      },
                      child: Text('Add to Collection'),
                    ),
                  ),
                  SizedBox(width: 4.w),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        // Bulk action logic
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                                'Bulk action on ${_selectedNfts.length} NFTs'),
                          ),
                        );
                        _clearSelection();
                      },
                      child: Text('Bulk Action'),
                    ),
                  ),
                ],
              ),
            )
          : null,
    );
  }
}
