import 'package:flutter/material.dart';

import '../../nav_page.dart';


// --- The main screen widget (Stateful to handle TabBar, BottomNavigationBar, and Search) ---
class SpiritualStoreScreen extends StatefulWidget {
  const SpiritualStoreScreen({super.key});

  @override
  State<SpiritualStoreScreen> createState() => _SpiritualStoreScreenState();
}

class _SpiritualStoreScreenState extends State<SpiritualStoreScreen>
    with SingleTickerProviderStateMixin {
  // State for the bottom navigation bar
  int _bottomNavIndex = 3; // 'LifeX' tab is the 4th item (index 3)

  // State for the category TabBar
  late TabController _tabController;
  final List<String> _categories = [
    'Jewelry',
    'Books',
    'Clothing',
    'Candles',
    'Artifacts',
  ];

  // Custom colors derived from the image
  static const Color _primaryTextColor = Color(0xFF333333);
  static const Color _secondaryTextColor = Color(0xFF6A6A6A);
  static const Color _blueAccentColor = Color(0xFF007AFF); // Blue from the app suite
  static const Color _scaffoldBackgroundColor = Colors.white;
  static const Color _searchFieldColor = Color(0xFFF0F0F0); // Light gray for search

  // Data structure for Featured Products
  final List<Map<String, dynamic>> _products = [
    {
      'tag': 'New',
      'name': 'Amethyst Healing Bracelet',
      'price': 29.99,
      'rating': 4.8,
      'reviews': 120,
      'image_color': const Color(0xFFE9E0E4), // Purple/Pink tone
    },
    {
      'tag': 'Best Seller',
      'name': 'Mindfulness Meditation Guide',
      'price': 14.99,
      'rating': 4.9,
      'reviews': 250,
      'image_color': const Color(0xFFE9F5F8), // Light blue tone
    },
    {
      'tag': 'Limited Edition',
      'name': 'Organic Soy Wax Candles',
      'price': 19.99,
      'rating': 4.7,
      'reviews': 85,
      'image_color': const Color(0xFFF1EDE8), // Light beige tone
    },
    {
      'tag': 'Featured',
      'name': 'Handcrafted Incense Holder',
      'price': 9.99,
      'rating': 4.6,
      'reviews': 150,
      'image_color': const Color(0xFFDCDCDC), // Gray/Wood tone
    },
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: _categories.length, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  // --- Reusable Widget for a single Product Row ---
  Widget _buildProductRow({
    required String tag,
    required String name,
    required double price,
    required double rating,
    required int reviews,
    required Color imageColor,
  }) {
    return InkWell(
      onTap: () {
        print('Product "$name" selected.');
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Text Content Area
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    tag,
                    style: TextStyle(
                      color: tag == 'New' ? _blueAccentColor : _secondaryTextColor,
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    name,
                    style: const TextStyle(
                      color: _primaryTextColor,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    '\$${price.toStringAsFixed(2)} · $rating (${reviews} reviews)',
                    style: const TextStyle(
                      color: _secondaryTextColor,
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 16),
            // Image/Illustration Placeholder
            Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                color: imageColor,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Center(
                child: Text(
                  tag,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.grey.shade700,
                    fontSize: 12,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // --- Widget for the fixed bottom navigation bar ---


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: _scaffoldBackgroundColor,
        elevation: 0,
        centerTitle: true,
        title: const Text(
          'Shop',
          style: TextStyle(
            color: _primaryTextColor,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.search, color: _primaryTextColor),
            onPressed: () {
              // Handle search button press
              print('Search icon pressed');
            },
          ),
        ],
      ),
      body: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            // --- Category TabBar ---
            SliverAppBar(
              pinned: true,
              backgroundColor: _scaffoldBackgroundColor,
              automaticallyImplyLeading: false,
              elevation: 0,
              toolbarHeight: 0,
              bottom: PreferredSize(
                preferredSize: const Size.fromHeight(50.0),
                child: Padding(
                  padding: const EdgeInsets.only(left: 20.0), // Padding to shift tabs left
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: TabBar(
                      controller: _tabController,
                      isScrollable: true,
                      indicatorColor: _blueAccentColor,
                      labelColor: _blueAccentColor,
                      unselectedLabelColor: _secondaryTextColor,
                      labelStyle: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                      unselectedLabelStyle: const TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
                      tabs: _categories.map((name) => Tab(text: name)).toList(),
                    ),
                  ),
                ),
              ),
            ),
            // --- Search Field ---
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20.0, 16.0, 20.0, 16.0),
                child: Container(
                  height: 48,
                  decoration: BoxDecoration(
                    color: _searchFieldColor,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const TextField(
                    decoration: InputDecoration(
                      hintText: 'Search',
                      hintStyle: TextStyle(color: _secondaryTextColor),
                      prefixIcon: Icon(Icons.search, color: _secondaryTextColor),
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.symmetric(vertical: 14),
                    ),
                  ),
                ),
              ),
            ),
          ];
        },
        body: TabBarView(
          controller: _tabController,
          children: _categories.map((String category) {
            // Placeholder: Only show products for the first category (Jewelry) for simplicity,
            // or show all for a standard scrolling list view, matching the image.
            // We'll show all products, as the image implies a long scrolling feed below the search bar.
            return SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Placeholder for the "For items" or filtering options below the search bar
                  const Padding(
                    padding: EdgeInsets.only(bottom: 10.0),
                    child: Text(
                      'Featured items',
                      style: TextStyle(color: _secondaryTextColor, fontSize: 14),
                    ),
                  ),
                  const SizedBox(height: 5),
                  ..._products.map((product) {
                    return _buildProductRow(
                      tag: product['tag'],
                      name: product['name'],
                      price: product['price'],
                      rating: product['rating'],
                      reviews: product['reviews'],
                      imageColor: product['image_color'],
                    );
                  }).toList(),
                  const SizedBox(height: 20),
                ],
              ),
            );
          }).toList(),
        ),
      ),
      bottomNavigationBar: MainScreen(selectedIndex: 3),
    );
  }
}