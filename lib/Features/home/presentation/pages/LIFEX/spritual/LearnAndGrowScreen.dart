import 'package:flutter/material.dart';

import '../../nav_page.dart';


// --- LearnAndGrowScreen Widget (Stateful) ---
class LearnAndGrowScreen extends StatefulWidget {
  const LearnAndGrowScreen({super.key});

  @override
  State<LearnAndGrowScreen> createState() => _LearnAndGrowScreenState();
}

class _LearnAndGrowScreenState extends State<LearnAndGrowScreen> {
  // State for the main segmented tab view
  int _selectedCategoryIndex = 1; // 1 = Religious Studies (selected in screenshot)

  // State for Bottom Navigation Bar
  // Assuming 'AI' is the selected tab initially (index 1)
  int _selectedIndex = 1;

  void _onBottomNavItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  // Define custom colors
  static const Color darkTextColor = Color(0xFF333333);
  static const Color accentBlue = Color(0xFF1976D2);
  static const Color subtitleColor = Color(0xFF00BFA5); // Teal-ish accent for the description

  // List of main categories
  final List<String> categories = ['Meditation', 'Religious Studies', 'Philosophy', 'Ancient Wisdom'];

  // Helper widget for the main course cards
  Widget _buildCourseCard({
    required String category,
    required String title,
    required String subtitle,
    required String imageUrl,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Text Content
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  category,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Colors.grey[700],
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: darkTextColor,
                    height: 1.2,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  subtitle,
                  style: const TextStyle(
                    fontSize: 14,
                    color: subtitleColor,
                    height: 1.4,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 16),
          // Image Placeholder
          ClipRRect(
            borderRadius: BorderRadius.circular(8.0),
            child: Image.network(
              imageUrl,
              width: 100, // Fixed width for the image
              height: 120, // Fixed height for the image
              fit: BoxFit.cover,
            ),
          ),
        ],
      ),
    );
  }

  // --- Widget Build Method ---
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // --- AppBar (Top Section) ---
      appBar: AppBar(
        title: const Text(
          'Learn & Grow',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: const [
          // Tree/leaf icon approximated by an emoji
          Padding(
            padding: EdgeInsets.only(right: 8.0),
            child: Text(
              '🌿', // Approximated with an emoji
              style: TextStyle(fontSize: 20),
            ),
          ),
          // Search icon
          Padding(
            padding: EdgeInsets.only(right: 16.0),
            child: Icon(Icons.search),
          ),
        ],
      ),

      // --- Body (Scrollable Content) ---
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          // **1. Category Tabs**
          _buildCategoryTabs(),

          // **2. Filter Buttons**
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
            child: Row(
              children: [
                _buildFilterButton('Faith', Icons.keyboard_arrow_down),
                const SizedBox(width: 12),
                _buildFilterButton('Difficulty', Icons.keyboard_arrow_down),
              ],
            ),
          ),

          // **3. Course List (Content)**
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Column(
                children: [
                  _buildCourseCard(
                    category: 'Meditation',
                    title: 'Intro to Mindfulness',
                    subtitle: 'Learn the basics of mindfulness meditation and its benefits for mental well-being.',
                    imageUrl: 'https://i.imgur.com/8QG4F9A.png', // Placeholder 1: Meditation woman
                  ),
                  const Divider(height: 1, color: Colors.grey),
                  _buildCourseCard(
                    category: 'Religious Studies',
                    title: 'The Teachings of Rumi',
                    subtitle: 'Explore the profound spiritual poetry and philosophy of the 13th-century Sufi mystic, Rumi.',
                    imageUrl: 'https://i.imgur.com/n6tYV3f.png', // Placeholder 2: Rumi portrait
                  ),
                  const Divider(height: 1, color: Colors.grey),
                  _buildCourseCard(
                    category: 'Philosophy',
                    title: 'Stoicism for Modern Life',
                    subtitle: 'Discover how ancient Stoic principles can help you navigate modern challenges and live a more fulfilling life.',
                    imageUrl: 'https://i.imgur.com/y1v5qG3.png', // Placeholder 3: Stoic man portrait
                  ),
                  const Divider(height: 1, color: Colors.grey),
                  _buildCourseCard(
                    category: 'Ancient Wisdom',
                    title: 'The Power of Ayurveda',
                    subtitle: 'Learn about the ancient Indian system of medicine and its holistic approach to health and wellness.',
                    imageUrl: 'https://i.imgur.com/X2W6P4S.png', // Placeholder 4: Ayurveda woman
                  ),
                  const SizedBox(height: 40), // Space before bottom nav bar
                ],
              ),
            ),
          ),
        ],
      ),

      // --- Bottom Navigation Bar ---
      bottomNavigationBar: MainScreen(selectedIndex: 3),
    );
  }

  // --- Custom Category Tabs Widget ---
  Widget _buildCategoryTabs() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      padding: const EdgeInsets.symmetric(horizontal: 24.0),
      child: Row(
        children: categories.asMap().entries.map((entry) {
          int index = entry.key;
          String label = entry.value;
          final isSelected = index == _selectedCategoryIndex;

          return GestureDetector(
            onTap: () {
              setState(() {
                _selectedCategoryIndex = index;
              });
            },
            child: Padding(
              padding: const EdgeInsets.only(right: 24.0, top: 8.0, bottom: 8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    label,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                      color: isSelected ? darkTextColor : Colors.grey[600],
                    ),
                  ),
                  const SizedBox(height: 4),
                  // Indicator Line
                  Container(
                    height: 3,
                    width: label.length * 9.5, // Dynamic width approximation
                    decoration: BoxDecoration(
                      color: isSelected ? accentBlue : Colors.transparent, // Solid blue line
                      borderRadius: BorderRadius.circular(1.5),
                    ),
                  ),
                ],
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  // --- Custom Filter Button Widget ---
  Widget _buildFilterButton(String label, IconData icon) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey[300]!),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: 14,
              color: darkTextColor,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(width: 4),
          Icon(
            icon,
            size: 18,
            color: darkTextColor,
          ),
        ],
      ),
    );
  }
}