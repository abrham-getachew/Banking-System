import 'package:flutter/material.dart';

import '../../nav_page.dart';


// --- CommunityProgramsScreen Widget (Stateful) ---
class CommunityProgramsScreen extends StatefulWidget {
  const CommunityProgramsScreen({super.key});

  @override
  State<CommunityProgramsScreen> createState() => _CommunityProgramsScreenState();
}

class _CommunityProgramsScreenState extends State<CommunityProgramsScreen> {
  // State for the selected tab (Nearby, Global, Online)
  int _selectedTabIndex = 0; // 0=Nearby, 1=Global, 2=Online

  // State for Bottom Navigation Bar
  // Assuming 'LifeX' is the selected tab initially (index 3)
  int _selectedIndex = 3;

  void _onBottomNavItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  // Define custom colors
  static const Color darkTextColor = Color(0xFF333333);
  static const Color accentBlue = Color(0xFF1976D2); // Standard blue for button/accent
  static const Color lightBlueAccent = Color(0xFF00BFA5); // Teal-ish accent for subtitle

  // Helper widget for the main content cards
  Widget _buildProgramCard({
    required String countdown,
    required String title,
    required String subtitle,
    required String imageUrl,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Text and Button Column
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  countdown,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Colors.grey[700],
                  ),
                ),
                const SizedBox(height: 8),
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
                    color: lightBlueAccent, // Using the accent color for the description
                    height: 1.4,
                  ),
                ),
                const SizedBox(height: 16),
                // Join Now Button
                OutlinedButton(
                  onPressed: () {
                    // Handle join action
                  },
                  style: OutlinedButton.styleFrom(
                    side: BorderSide(color: Colors.grey[400]!, width: 1),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: Text(
                    'Join Now',
                    style: TextStyle(
                      color: Colors.grey[700],
                      fontWeight: FontWeight.w600,
                    ),
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
              height: 140, // Fixed height for the image
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
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            // Handle back button press
          },
        ),
        title: const Text(
          'Community Programs',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          // The small tree/leaf icon is approximated by an emoji or a specialized icon
          const Padding(
            padding: EdgeInsets.only(right: 8.0),
            child: Text(
              '🌿', // Approximated with an emoji
              style: TextStyle(fontSize: 20),
            ),
          ),
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              // Handle search button press
            },
          ),
        ],
      ),

      // --- Body (Scrollable Content) ---
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            // **1. Subtitle Text**
            const Padding(
              padding: EdgeInsets.only(left: 24.0, right: 24.0, top: 8.0),
              child: Text(
                'Attend faith events, seminars, and retreats.',
                style: TextStyle(
                  fontSize: 16,
                  color: darkTextColor,
                ),
              ),
            ),
            const SizedBox(height: 24),

            // **2. Tab/Filter Bar**
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Row(
                children: [
                  _buildTabButton(0, 'Nearby'),
                  const SizedBox(width: 24),
                  _buildTabButton(1, 'Global'),
                  const SizedBox(width: 24),
                  _buildTabButton(2, 'Online'),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // **3. Program List (Content)**
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Column(
                children: [
                  _buildProgramCard(
                    countdown: 'Live in 2d 14h 30m',
                    title: 'Faith & Wellness Retreat',
                    subtitle: 'Join us for a transformative retreat focused on spiritual growth and holistic wellness.',
                    imageUrl: 'https://i.imgur.com/8QG4F9A.png', // Placeholder 1: Mountain painting
                  ),
                  const Divider(height: 1, color: Colors.grey),
                  _buildProgramCard(
                    countdown: 'Live in 1d 8h 15m',
                    title: 'Mindfulness & Meditation Workshop',
                    subtitle: 'Learn mindfulness techniques and meditation practices to enhance your inner peace.',
                    imageUrl: 'https://i.imgur.com/n6tYV3f.png', // Placeholder 2: Meditation
                  ),
                  const Divider(height: 1, color: Colors.grey),
                  _buildProgramCard(
                    countdown: 'Live in 3d 20h 45m',
                    title: 'Spiritual Growth Seminar',
                    subtitle: 'Explore the depths of your faith and discover new perspectives on spiritual growth.',
                    imageUrl: 'https://i.imgur.com/y1v5qG3.png', // Placeholder 3: Group discussion
                  ),
                ],
              ),
            ),
            const SizedBox(height: 40), // Space before bottom nav bar
          ],
        ),
      ),

      // --- Bottom Navigation Bar ---
      bottomNavigationBar: MainScreen(selectedIndex: 3),
    );
  }

  // --- Custom Tab Button Widget ---
  Widget _buildTabButton(int index, String label) {
    final isSelected = index == _selectedTabIndex;
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedTabIndex = index;
        });
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: 16,
              fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
              color: isSelected ? darkTextColor : Colors.grey[600],
            ),
          ),
          const SizedBox(height: 4),
          // Underline indicator
          Container(
            height: 3,
            width: label.length * 9.0, // Dynamic width based on text length
            decoration: BoxDecoration(
              color: isSelected ? darkTextColor : Colors.transparent,
              borderRadius: BorderRadius.circular(1.5),
            ),
          ),
        ],
      ),
    );
  }
}