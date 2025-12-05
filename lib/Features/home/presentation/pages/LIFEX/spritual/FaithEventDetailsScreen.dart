import 'package:flutter/material.dart';

import '../../nav_page.dart';


// --- The main screen widget (Stateful to handle BottomNavigationBar and interactions) ---
class FaithEventDetailsScreen extends StatefulWidget {
  const FaithEventDetailsScreen({super.key});

  @override
  State<FaithEventDetailsScreen> createState() =>
      _FaithEventDetailsScreenState();
}

class _FaithEventDetailsScreenState extends State<FaithEventDetailsScreen> {
  // State for the bottom navigation bar
  int _selectedIndex = 3; // 'LifeX' tab is the 4th item (index 3)

  // Custom colors derived from the image and app suite
  static const Color _primaryTextColor = Color(0xFF333333);
  static const Color _secondaryTextColor = Color(0xFF6A6A6A);
  static const Color _blueAccentColor = Color(0xFF007AFF); // Blue for main actions
  static const Color _scaffoldBackgroundColor = Colors.white;
  static const Color _lightButtonColor = Color(0xFFF0F0F0); // Light gray for secondary button

  // Data structure for Speakers
  final List<Map<String, dynamic>> _speakers = [
    {
      'name': 'Dr. Anya Sharma',
      'image_color': const Color(0xFFFCCB9D), // Skin tone placeholder
    },
    {
      'name': 'Rev. Ethan Carter',
      'image_color': const Color(0xFFC7A58E), // Skin tone placeholder
    },
    {
      'name': 'Ms. Chloe Benton',
      'image_color': const Color(0xFFFCCB9D), // Skin tone placeholder
    },
  ];

  // --- Reusable Widget for a single Speaker Profile ---
  Widget _buildSpeakerProfile({
    required String name,
    required Color imageColor,
  }) {
    return Padding(
      padding: const EdgeInsets.only(right: 15.0),
      child: Column(
        children: [
          // Circular Image Placeholder
          Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: imageColor,
              border: Border.all(color: Colors.grey.shade200, width: 2),
              // Simulated profile illustration
            ),
            child: Center(
              child: Text(
                name.split(' ').first,
                style: const TextStyle(
                  color: _primaryTextColor,
                  fontSize: 12,
                ),
              ),
            ),
          ),
          const SizedBox(height: 8),
          // Name
          SizedBox(
            width: 80, // Constrain width for wrapping
            child: Text(
              name,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: _primaryTextColor,
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
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
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          color: _primaryTextColor,
          onPressed: () {
            // Handle back button press
          },
        ),
        title: const Text(
          'Event Details',
          style: TextStyle(
            color: _primaryTextColor,
            fontWeight: FontWeight.w600,
            fontSize: 18,
          ),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          // 1. Scrollable Content Area
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  // --- Image Header ---
                  Container(
                    height: 200,
                    width: double.infinity,
                    color: Colors.grey.shade200, // Placeholder background
                    padding: const EdgeInsets.all(20),
                    child: Center(
                      // Placeholder for the serene mountain illustration
                      child: Container(
                        decoration: BoxDecoration(
                          color: const Color(0xFFC8D7DB), // Blue-green mountain tone
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: const Center(
                          child: Text(
                            'Mountain Illustration',
                            style: TextStyle(color: Colors.white, fontSize: 14),
                          ),
                        ),
                      ),
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 20),

                        // --- Event Title ---
                        const Text(
                          'Faith Event Program',
                          style: TextStyle(
                            color: _primaryTextColor,
                            fontSize: 26,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 10),

                        // --- Description ---
                        const Text(
                          'Join us for a transformative spiritual journey, featuring renowned speakers, interactive workshops, and serene meditation sessions. Discover inner peace and connect with like-minded individuals.',
                          style: TextStyle(
                            color: _primaryTextColor,
                            fontSize: 16,
                            height: 1.5,
                          ),
                        ),
                        const SizedBox(height: 25),

                        // --- Speakers Section ---
                        const Text(
                          'Speakers',
                          style: TextStyle(
                            color: _primaryTextColor,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 15),
                        // Speakers List (Horizontal Scroll)
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: _speakers.map((speaker) {
                              return _buildSpeakerProfile(
                                name: speaker['name'],
                                imageColor: speaker['image_color'],
                              );
                            }).toList(),
                          ),
                        ),
                        const SizedBox(height: 30),

                        // --- Location Section ---
                        const Text(
                          'Location',
                          style: TextStyle(
                            color: _primaryTextColor,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 15),

                        // Map Placeholder
                        Container(
                          height: 180,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: const Color(0xFFD3EBE0), // Light green map color
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(color: Colors.grey.shade300, width: 1),
                          ),
                          child: const Center(
                            child: Text(
                              '',
                              style: TextStyle(color: _secondaryTextColor),
                            ),
                          ),
                        ),
                        const SizedBox(height: 10),
                        const Text(
                          'Serenity Retreat Center, 123 Harmony Lane, Tranquil Valley',
                          style: TextStyle(
                            color: _primaryTextColor,
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(height: 20),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          // 2. Action Buttons (Fixed at Bottom, above Nav Bar)
          Padding(
            padding: const EdgeInsets.fromLTRB(20.0, 10, 20.0, 10.0),
            child: Row(
              children: [
                // Secondary Button: Add Reminder
                Expanded(
                  child: SizedBox(
                    height: 50,
                    child: OutlinedButton(
                      onPressed: () {
                        print('Add Reminder pressed');
                      },
                      style: OutlinedButton.styleFrom(
                        backgroundColor: _lightButtonColor, // Light gray background
                        foregroundColor: _primaryTextColor,
                        side: BorderSide.none, // No explicit border line
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: const Text(
                        'Add Reminder',
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                // Primary Button: Buy Ticket
                Expanded(
                  child: SizedBox(
                    height: 50,
                    child: ElevatedButton(
                      onPressed: () {
                        print('Buy Ticket pressed');
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: _blueAccentColor,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        elevation: 0,
                      ),
                      child: const Text(
                        'Buy Ticket',
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: MainScreen(selectedIndex: 3),
    );
  }
}