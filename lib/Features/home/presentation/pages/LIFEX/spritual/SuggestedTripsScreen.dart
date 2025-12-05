import 'package:flutter/material.dart';

import '../../nav_page.dart';


// --- The main screen widget (Stateful to handle BottomNavigationBar and selection) ---
class SuggestedTripsScreen extends StatefulWidget {
  const SuggestedTripsScreen({super.key});

  @override
  State<SuggestedTripsScreen> createState() => _SuggestedTripsScreenState();
}

class _SuggestedTripsScreenState extends State<SuggestedTripsScreen> {
  // State for the bottom navigation bar
  int _selectedIndex = 3; // 'LifeX' tab is the 4th item (index 3)

  // Custom colors derived from the image (using the blue accent from the original app suite)
  static const Color _primaryTextColor = Color(0xFF333333);
  static const Color _secondaryTextColor = Color(0xFF6A6A6A);
  static const Color _blueAccentColor = Color(0xFF007AFF); // Blue from the form screen
  static const Color _scaffoldBackgroundColor = Colors.white;
  static const Color _buttonBackgroundColor = Color(0xFFF0F0F0);

  // Data structure for the Suggested Trips
  // UPDATED: Replaced 'image_color' with 'image_path'
  final List<Map<String, dynamic>> _trips = [
    {
      'type': 'Guided Retreat',
      'name': 'Serenity in Sedona',
      'duration': '3 days',
      'price': 499,
      'image_path': 'assets/images/spritual image15.png', // <-- Image path added
    },
    {
      'type': 'Spiritual Journey',
      'name': 'Bali Bliss',
      'duration': '7 days',
      'price': 1299,
      'image_path': 'assets/images/spritual image14.png', // <-- Image path added
    },
    {
      'type': 'Mindfulness Retreat',
      'name': 'Zen in Kyoto',
      'duration': '5 days',
      'price': 899,
      'image_path': 'assets/images/spritual image13.png', // <-- Image path added
    },
  ];

  // --- Reusable Widget for a single Trip Card ---
  // UPDATED: Now accepts 'imagePath' instead of 'imageColor'
  Widget _buildTripCard({
    required String type,
    required String name,
    required String duration,
    required int price,
    required String imagePath,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 30.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Text Content Area
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  type,
                  style: const TextStyle(
                    color: _secondaryTextColor,
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  name,
                  style: const TextStyle(
                    color: _primaryTextColor,
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  '$duration | \$$price',
                  style: const TextStyle(
                    color: _secondaryTextColor,
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 12),
                SizedBox(
                  height: 38,
                  child: ElevatedButton(
                    onPressed: () {
                      print('Book Now pressed for $name');
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: _buttonBackgroundColor,
                      foregroundColor: _primaryTextColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
                      elevation: 0,
                    ),
                    child: const Text(
                      'Book Now',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 16),
          // Image/Illustration Placeholder
          // UPDATED: Container now uses DecorationImage with an AssetImage
          Container(
            width: 120,
            height: 120,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              image: DecorationImage(
                image: AssetImage(imagePath),
                fit: BoxFit.cover,
              ),
            ),
          ),
        ],
      ),
    );
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: _scaffoldBackgroundColor,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          color: _primaryTextColor,
          onPressed: () {
            // Handle back button press
            Navigator.pop(context);
          },
        ),
        title: const Text(
          'Suggested Trips',
          style: TextStyle(
            color: _primaryTextColor,
            fontWeight: FontWeight.w600,
            fontSize: 18,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          // UPDATED: Pass 'image_path' to the builder
          children: _trips.map((trip) {
            return _buildTripCard(
              type: trip['type'],
              name: trip['name'],
              duration: trip['duration'],
              price: trip['price'],
              imagePath: trip['image_path'],
            );
          }).toList(),
        ),
      ),
      bottomNavigationBar: MainScreen(selectedIndex: 3),
    );
  }
}