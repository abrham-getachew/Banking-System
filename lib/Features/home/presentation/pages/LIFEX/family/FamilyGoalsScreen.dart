import 'package:flutter/material.dart';

import '../../nav_page.dart';


// --- The main screen widget (Stateful to handle BottomNavigationBar and Button States) ---
class FamilyGoalsScreen extends StatefulWidget {
  const FamilyGoalsScreen({super.key});

  @override
  State<FamilyGoalsScreen> createState() => _FamilyGoalsScreenState();
}

class _FamilyGoalsScreenState extends State<FamilyGoalsScreen> {
  // State for the bottom navigation bar
  int _selectedIndex = 3; // 'LifeX' tab is the 4th item (index 3)

  // State to track if a goal is actively being tracked (simulated)
  final Map<String, bool> _goalTrackingStatus = {
    'Home Purchase': true,
    'Dream Trip': true,
    'Joint Investments': true,
  };

  // Custom colors derived from the image
  static const Color _primaryTextColor = Color(0xFF333333);
  static const Color _secondaryTextColor = Color(0xFF6A6A6A);
  static const Color _accentColor = Color(0xFF26B0AB);
  static const Color _darkHeaderColor = Color(0xFF1E3A40); // Dark teal/blue
  static const Color _scaffoldBackgroundColor = Colors.white;
  static const Color _lightCardColor = Color(0xFFF7F7F7);

  // Data structure for the Goals
  final List<Map<String, String>> _goals = [
    {
      'name': 'Home Purchase',
      'target': '500,000',
      'image_color': '0xFFF1EDE8', // Light beige
    },
    {
      'name': 'Dream Trip',
      'target': '10,000',
      'image_color': '0xFFF0F0F0', // Light gray
    },
    {
      'name': 'Joint Investments',
      'target': '20,000',
      'image_color': '0xFFE9E4DC', // Slightly darker beige
    },
  ];

  // Data structure for the Progress Timeline
  final List<Map<String, String>> _timelineEvents = [
    {'time': '2 weeks ago', 'detail': 'Sarah completed her savings goal'},
    {'time': '1 month ago', 'detail': 'Mark contributed to the investment fund'},
    {'time': '3 months ago', 'detail': 'Family vacation booked!'},
  ];

  // --- Widget for the dark header section ---
  Widget _buildHeader(BuildContext context) {
    return Container(
      height: 300,
      decoration: const BoxDecoration(
        color: _darkHeaderColor,
        // Optional: Add a subtle gradient or pattern here to enhance the background
      ),
      child: Stack(
        children: [
          // Illustration Placeholder (Family climbing stairs)
          const Positioned.fill(
            child: Center(
              child: Text(
                'Family Goals Illustration',
                style: TextStyle(color: Colors.white54, fontSize: 16),
              ),
            ),
          ),
          // Content positioned at the bottom-left
          Positioned(
            bottom: 40,
            left: 20,
            right: 20,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Achieve\nTogether',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    height: 1.1,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  'Track your family\'s shared goals and celebrate\nmilestones along the way.',
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.85),
                    fontSize: 14,
                    height: 1.4,
                  ),
                ),
                const SizedBox(height: 20),
                SizedBox(
                  width: 200, // Fixed width button
                  child: ElevatedButton(
                    onPressed: () {
                      print('Celebrate Progress pressed');
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: _accentColor,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      elevation: 5,
                    ),
                    child: const Text(
                      'Celebrate Progress',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // --- Widget for a single Goal Tracker Row ---
  Widget _buildGoalTrackerRow({
    required String name,
    required String target,
    required Color imageColor,
  }) {
    final isTracking = _goalTrackingStatus[name] ?? false;

    return Padding(
      padding: const EdgeInsets.only(bottom: 20.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Text Content Area
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: const TextStyle(
                    color: _primaryTextColor,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  'Target: \$$target',
                  style: const TextStyle(
                    color: _secondaryTextColor,
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 8),
                SizedBox(
                  height: 30, // Fixed height for the button
                  child: OutlinedButton(
                    onPressed: () {
                      setState(() {
                        _goalTrackingStatus[name] = !isTracking;
                      });
                      print('$name tracking status changed to ${!isTracking}');
                    },
                    style: OutlinedButton.styleFrom(
                      backgroundColor: isTracking ? _accentColor.withOpacity(0.1) : Colors.grey.shade100,
                      foregroundColor: isTracking ? _accentColor : _secondaryTextColor,
                      side: BorderSide(
                        color: isTracking ? _accentColor.withOpacity(0.5) : Colors.grey.shade300,
                        width: 1.0,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                    ),
                    child: Text(
                      isTracking ? 'Tracking' : 'Start Tracking',
                      style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 16),
          // Image/Illustration Placeholder
          Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              color: imageColor,
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Center(
              child: Text(
                'Goal Image',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white60,
                  fontSize: 12,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // --- Widget for the Progress Timeline Section ---
  Widget _buildTimelineEvent({
    required String time,
    required String detail,
    required IconData icon,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Icon/Marker
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: Icon(
              icon,
              color: _accentColor,
              size: 20,
            ),
          ),
          // Detail and Time
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  detail,
                  style: const TextStyle(
                    color: _primaryTextColor,
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  time,
                  style: const TextStyle(
                    color: _secondaryTextColor,
                    fontSize: 13,
                  ),
                ),
              ],
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
        backgroundColor: Colors.transparent, // AppBar should overlay the header
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          color: Colors.white, // White icon over the dark header
          onPressed: () {
            // Handle back button press
          },
        ),
        title: const Text(
          'Family Goals & Milestones',
          style: TextStyle(
            color: Colors.white, // White title over the dark header
            fontWeight: FontWeight.w600,
            fontSize: 18,
          ),
        ),
        centerTitle: true,
      ),
      extendBodyBehindAppBar: true, // Allow body to go behind AppBar
      body: Column(
        children: [
          // 1. The Header with Text and Button
          _buildHeader(context),

          // 2. The scrollable content below the header
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 30.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  // --- Shared Goal Tracker Section ---
                  const Text(
                    'Shared Goal Tracker',
                    style: TextStyle(
                      color: _primaryTextColor,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 16),
                  ..._goals.map((goal) {
                    return _buildGoalTrackerRow(
                      name: goal['name']!,
                      target: goal['target']!,
                      imageColor: Color(int.parse(goal['image_color']!)),
                    );
                  }).toList(),

                  const SizedBox(height: 30),

                  // --- Progress Timeline Section ---
                  const Text(
                    'Progress Timeline',
                    style: TextStyle(
                      color: _primaryTextColor,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 16),
                  ..._timelineEvents.map((event) {
                    return _buildTimelineEvent(
                      time: event['time']!,
                      detail: event['detail']!,
                      // Use different icons to simulate variety
                      icon: event['time'] == '2 weeks ago'
                          ? Icons.check_circle_outline
                          : event['time'] == '1 month ago'
                          ? Icons.arrow_upward_sharp
                          : Icons.luggage_outlined,
                    );
                  }).toList(),

                  const SizedBox(height: 30),

                  // --- AI Coach Section ---
                  const Text(
                    'AI Coach',
                    style: TextStyle(
                      color: _primaryTextColor,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 16),
                  // AI Coach Illustration Placeholder (Family on beach)
                  Container(
                    height: 200,
                    decoration: BoxDecoration(
                      color: _darkHeaderColor.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Center(
                      child: Text(
                        'AI Coach Illustration',
                        style: TextStyle(color: _secondaryTextColor),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10), // Padding before BottomNavBar
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: MainScreen(selectedIndex: 3), );
  }
}