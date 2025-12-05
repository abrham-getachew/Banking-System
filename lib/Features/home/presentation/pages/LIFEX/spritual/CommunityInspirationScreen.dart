import 'package:flutter/material.dart';

import '../../nav_page.dart';



// --- CommunityInspirationScreen Widget (Stateful) ---
class CommunityInspirationScreen extends StatefulWidget {
  const CommunityInspirationScreen({super.key});

  @override
  State<CommunityInspirationScreen> createState() => _CommunityInspirationScreenState();
}

class _CommunityInspirationScreenState extends State<CommunityInspirationScreen> {
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
  static const Color lightGreyButton = Color(0xFFE0E0E0); // Light grey for the button

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
          'Community & Inspiration',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),

      // --- Body (Scrollable Content) ---
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            // **1. Header Image**
            ClipRRect(
              // No significant rounding is visible, so keep it minimal
              borderRadius: BorderRadius.circular(0),
              child: Container(
                width: double.infinity,
                height: 200, // Fixed height for the header image
                // Placeholder for the custom sunset/mountain image
                child: Image.network(
                  'https://i.imgur.com/gK6tN4B.png', // Placeholder URL for the sunset illustration
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(height: 32),

            // **2. Verse of the Day**
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(
                    width: double.infinity, // Ensures the Column stretches for center alignment
                    child: Text(
                      'Verse of the Day',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: darkTextColor,
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    'May your spirit be renewed and your path illuminated with divine guidance.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey[700],
                      height: 1.4,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 40),

            // **3. Community Forum Section**
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Community Forum',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: darkTextColor,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    'Share your reflections, insights, and experiences with the community. Engage in meaningful discussions and support each other on your spiritual journeys.',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey[700],
                      height: 1.4,
                    ),
                  ),
                  const SizedBox(height: 32),

                  // **Post a Prayer Request Button**
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        // Handle Post a Prayer Request button press
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: lightGreyButton, // Light grey background
                        padding: const EdgeInsets.symmetric(vertical: 16.0),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        elevation: 0,
                      ),
                      child: const Text(
                        'Post a Prayer Request',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: darkTextColor,
                        ),
                      ),
                    ),
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
}