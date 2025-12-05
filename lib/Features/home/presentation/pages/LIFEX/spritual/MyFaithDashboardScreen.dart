import 'package:flutter/material.dart';

import '../../nav_page.dart';


// --- MyFaithDashboardScreen Widget (Stateful) ---
class MyFaithDashboardScreen extends StatefulWidget {
  const MyFaithDashboardScreen({super.key});

  @override
  State<MyFaithDashboardScreen> createState() => _MyFaithDashboardScreenState();
}

class _MyFaithDashboardScreenState extends State<MyFaithDashboardScreen> {
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
  static const Color accentBlue = Color(0xFF1976D2); // Primary blue for progress bars
  static const Color lightBlueBackground = Color(0xFFF7F9FC); // Light background for cards

  // Helper widget for the Donations stat cards
  Widget _buildStatCard(String title, String value) {
    return Expanded(
      child: Card(
        elevation: 0,
        // The card background is slightly off-white/light grey in the image
        color: Colors.grey[100],
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.grey[600],
                ),
              ),
              const SizedBox(height: 8),
              Text(
                value,
                style: const TextStyle(
                  fontSize: 24, // Prominent font size for the value
                  fontWeight: FontWeight.bold,
                  color: darkTextColor,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Helper widget for the Goals section with a progress bar
  Widget _buildGoalProgress(String title, double progress, String statusText) {
    return Padding(
      padding: const EdgeInsets.only(top: 16.0, bottom: 24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: darkTextColor,
            ),
          ),
          const SizedBox(height: 8),
          // Progress Bar
          LinearProgressIndicator(
            value: progress, // 0.75 for Prayer Goal, 0.50 for Meditation Goal
            minHeight: 8,
            backgroundColor: Colors.grey[300],
            valueColor: const AlwaysStoppedAnimation<Color>(accentBlue),
            borderRadius: BorderRadius.circular(4),
          ),
          const SizedBox(height: 8),
          Text(
            statusText,
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey[600],
            ),
          ),
        ],
      ),
    );
  }

  // Helper widget for the Upcoming Events list
  Widget _buildEventTile(String title, String date) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Calendar Icon Container
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: Colors.grey[100],
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Icon(
              Icons.calendar_today_outlined,
              color: darkTextColor,
              size: 20,
            ),
          ),
          const SizedBox(width: 16),
          // Event Text
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: darkTextColor,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                date,
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey[600],
                ),
              ),
            ],
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
          'My Faith',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),

      // --- Body (Scrollable Content) ---
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const SizedBox(height: 16),

            // **1. Donations Section Title**
            const Text(
              'Donations',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: darkTextColor,
              ),
            ),
            const SizedBox(height: 16),

            // **2. Donations Stat Cards**
            Row(
              children: [
                _buildStatCard('Total Donations', '\$1,250'),
                const SizedBox(width: 16),
                _buildStatCard('This Year', '\$450'),
              ],
            ),
            const SizedBox(height: 32),

            // **3. Goals Section Title**
            const Text(
              'Goals',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: darkTextColor,
              ),
            ),
            const SizedBox(height: 8),

            // **4. Goals Progress Bars**
            _buildGoalProgress('Prayer Goal', 0.75, '75% Complete'),
            _buildGoalProgress('Meditation Goal', 0.50, '50% Complete'),
            const SizedBox(height: 8),

            // **5. Upcoming Events Section Title**
            const Text(
              'Upcoming Events',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: darkTextColor,
              ),
            ),
            const SizedBox(height: 16),

            // **6. Upcoming Events List**
            _buildEventTile(
              'Community Prayer Meeting',
              'Sunday, July 21, 2024',
            ),
            _buildEventTile(
              'Meditation Workshop',
              'Wednesday, July 24, 2024',
            ),
            const SizedBox(height: 40), // Extra space at the bottom
          ],
        ),
      ),

      // --- Bottom Navigation Bar ---
      bottomNavigationBar: MainScreen(selectedIndex: 3),
    );
  }
}