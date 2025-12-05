import 'package:flutter/material.dart';

import '../../nav_page.dart';


// --- The main screen widget (Stateful to handle goal progress and BottomNavigationBar) ---
class SpiritualGoalsScreen extends StatefulWidget {
  const SpiritualGoalsScreen({super.key});

  @override
  State<SpiritualGoalsScreen> createState() => _SpiritualGoalsScreenState();
}

class _SpiritualGoalsScreenState extends State<SpiritualGoalsScreen> {
  // State for the bottom navigation bar
  int _selectedIndex = 3; // 'LifeX' tab is the 4th item (index 3)

  // Custom colors derived from the image and app suite
  static const Color _primaryTextColor = Color(0xFF333333);
  static const Color _secondaryTextColor = Color(0xFF6A6A6A);
  static const Color _blueAccentColor = Color(0xFF007AFF); // Blue for main actions and progress
  static const Color _scaffoldBackgroundColor = Colors.white;
  static const Color _progressBarTrackColor = Color(0xFFE0E0E0); // Light gray for the track

  // Data structure for Spiritual Goals (Simulating dynamic progress values)
  final List<Map<String, dynamic>> _goals = [
    {'name': 'Pray 5 times daily', 'progress': 0.75}, // 75%
    {'name': 'Read holy text 30 mins/day', 'progress': 0.50}, // 50%
    {'name': 'Meditate every morning', 'progress': 0.25}, // 25%
  ];

  // --- Reusable Widget for a single Goal Row with Progress Bar ---
  Widget _buildGoalRow({
    required String goalName,
    required double progress,
  }) {
    // Convert progress (0.0 to 1.0) to percentage for display
    final String percentage = (progress * 100).round().toString();

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 15.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Goal Name
          Expanded(
            flex: 2,
            child: Text(
              goalName,
              style: const TextStyle(
                color: _primaryTextColor,
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          const SizedBox(width: 15),

          // Progress Bar
          Expanded(
            flex: 2,
            child: LinearProgressIndicator(
              value: progress,
              backgroundColor: _progressBarTrackColor,
              color: _blueAccentColor,
              minHeight: 8, // Thicker bar to match the image
              borderRadius: BorderRadius.circular(4),
            ),
          ),
          const SizedBox(width: 15),

          // Percentage Text
          Text(
            percentage,
            style: const TextStyle(
              color: _primaryTextColor,
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
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
        automaticallyImplyLeading: false, // No back button shown in image
        title: const Text(
          'LifeX',
          style: TextStyle(
            color: _primaryTextColor,
            fontWeight: FontWeight.w600,
            fontSize: 18,
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.settings, color: _primaryTextColor),
            onPressed: () {
              print('Settings icon pressed');
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const SizedBox(height: 10),

            // --- Goal Header ---
            const Text(
              'Set Your Spiritual Goals',
              style: TextStyle(
                color: _primaryTextColor,
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 5),
            const Text(
              'Track your journey toward inner growth.',
              style: TextStyle(
                color: _secondaryTextColor,
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 30),

            // --- Goal List with Progress Bars ---
            ..._goals.map((goal) {
              return _buildGoalRow(
                goalName: goal['name'],
                progress: goal['progress'],
              );
            }).toList(),
            const SizedBox(height: 30),

            // --- Add New Goal Button ---
            Center(
              child: SizedBox(
                width: 200, // Fixed width to match image
                child: ElevatedButton(
                  onPressed: () {
                    print('Add New Goal pressed');
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: _blueAccentColor,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    elevation: 5,
                  ),
                  child: const Text(
                    'Add New Goal',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
      bottomNavigationBar: MainScreen(selectedIndex: 3),
    );
  }
}