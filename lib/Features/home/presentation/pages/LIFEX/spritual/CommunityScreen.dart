import 'package:flutter/material.dart';

import '../../nav_page.dart';

// --- Theme Colors and Constants ---
const Color _kDarkTextColor = Color(0xFF333333);
const Color _kLightTextColor = Color(0xFF666666);
const Color _kCategoryTabColor = Color(0xFF3366FF); // Bright blue for selected category
const Color _kIconColor = Color(0xFF333333);
const Color _kLifeXSelectedColor = Color(0xFF333333);

class CommunityScreen extends StatefulWidget {
  const CommunityScreen({super.key});

  @override
  State<CommunityScreen> createState() => _CommunityScreenState();
}

class _CommunityScreenState extends State<CommunityScreen> with SingleTickerProviderStateMixin {
  // --- State Variables ---
  int _selectedIndex = 3; // Initial selection for 'LifeX' tab (index 3, Community is likely linked to LifeX)
  late TabController _tabController;
  final List<String> _categories = ['Gratitude', 'Faith', 'Peace', 'Healing'];

  // Example data for community posts
  final List<Map<String, dynamic>> _posts = [
    {'title': 'Daily Gratitude Practice', 'upvotes': 12, 'comments': 3, 'category': 'Gratitude', 'avatar': 'assets/avatar_woman1.png'},
    {'title': 'Finding Joy in Small Things', 'upvotes': 25, 'comments': 8, 'category': 'Gratitude', 'avatar': 'assets/avatar_man1.png'},
    {'title': 'Gratitude for Nature\'s Beauty', 'upvotes': 18, 'comments': 5, 'category': 'Gratitude', 'avatar': 'assets/avatar_woman2.png'},
    {'title': 'Gratitude for Family and Friends', 'upvotes': 30, 'comments': 10, 'category': 'Gratitude', 'avatar': 'assets/avatar_man2.png'},
    {'title': 'The Power of Belief', 'upvotes': 45, 'comments': 15, 'category': 'Faith', 'avatar': 'assets/avatar_woman3.png'},
    {'title': 'Finding Your Inner Peace', 'upvotes': 5, 'comments': 1, 'category': 'Peace', 'avatar': 'assets/avatar_man3.png'},
    // Add more dummy data as needed
  ];

  // --- Life Cycle Methods ---
  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: _categories.length, vsync: this);
    // Listen to tab changes to potentially update the displayed list if filtering were active
    _tabController.addListener(_handleTabSelection);
  }

  @override
  void dispose() {
    _tabController.removeListener(_handleTabSelection);
    _tabController.dispose();
    super.dispose();
  }

  // --- Helper Methods ---
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    // Implement navigation logic here
  }

  void _handleTabSelection() {
    if (_tabController.indexIsChanging) {
      // Logic to filter the list based on _categories[_tabController.index]
      print('Current category selected: ${_categories[_tabController.index]}');
      setState(() {
        // Force rebuild if filtering is implemented
      });
    }
  }

  // --- Main Build Method ---
  @override
  Widget build(BuildContext context) {
    // Filter the posts based on the currently selected tab (simulated filtering)
    String currentCategory = _categories[_tabController.index];
    final filteredPosts = _posts.where((post) => post['category'] == currentCategory).toList();

    return Scaffold(
      backgroundColor: Colors.white,
      // 1. App Bar
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: const BackButton(color: _kDarkTextColor),
        title: const Text(
          'Community',
          style: TextStyle(color: _kDarkTextColor, fontWeight: FontWeight.w500),
        ),
        centerTitle: false,
        // Category Tabs integrated into the AppBar bottom
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(48.0),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Align(
              alignment: Alignment.centerLeft,
              child: TabBar(
                controller: _tabController,
                isScrollable: true,
                indicatorColor: _kCategoryTabColor,
                labelColor: _kCategoryTabColor,
                unselectedLabelColor: _kLightTextColor,
                labelStyle: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold
                ),
                unselectedLabelStyle: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.normal
                ),
                indicatorWeight: 3.0,
                indicatorSize: TabBarIndicatorSize.tab, // Indicator covers text width
                tabs: _categories.map((name) => Tab(text: name)).toList(),
              ),
            ),
          ),
        ),
      ),
      // 2. Body Content (Using TabBarView to hold the list for the current tab)
      body: TabBarView(
        controller: _tabController,
        children: _categories.map((category) {
          // This creates a dedicated list view for each category tab
          // To strictly clone the image, we only display the list in the first tab (Gratitude)
          if (category == 'Gratitude') {
            return ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
              itemCount: filteredPosts.length,
              itemBuilder: (context, index) {
                return _buildCommunityPost(filteredPosts[index]);
              },
            );
          } else {
            // Placeholder for other tabs
            return Center(
              child: Text('Content for $category will appear here.', style: TextStyle(color: _kLightTextColor)),
            );
          }
        }).toList(),
      ),

      // 3. Bottom Navigation Bar
      bottomNavigationBar: MainScreen(selectedIndex: 3),
    );
  }

  // --- Component Builders ---

  Widget _buildCommunityPost(Map<String, dynamic> post) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Avatar
          CircleAvatar(
            radius: 25,
            backgroundImage: AssetImage(post['avatar']!), // Replace with NetworkImage if necessary
          ),
          const SizedBox(width: 15),
          // Post Content
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  post['title']!,
                  style: const TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 16,
                    color: _kDarkTextColor,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  '${post['upvotes']} upvotes · ${post['comments']} comments',
                  style: TextStyle(
                    fontSize: 14,
                    color: _kLightTextColor.withOpacity(0.8),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }


}