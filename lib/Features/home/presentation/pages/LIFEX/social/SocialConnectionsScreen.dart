import 'package:flutter/material.dart';

import '../../nav_page.dart';


// --- SocialConnectionsScreen Widget ---
class SocialConnectionsScreen extends StatefulWidget {
  const SocialConnectionsScreen({super.key});

  @override
  State<SocialConnectionsScreen> createState() => _SocialConnectionsScreenState();
}

class _SocialConnectionsScreenState extends State<SocialConnectionsScreen> {
  // State for Bottom Navigation Bar
  int _selectedIndex = 1; // Assuming 'AI' is the selected tab initially

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  // --- UPDATED: Helper method to create the main feature tiles ---
  // This widget now represents the content *inside* a card.
  Widget _buildFeatureTile(
      IconData icon, String title, String subtitle, Color subtitleColor) {
    return Padding(
      // Padding is now inside the card, applied to the row
      padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center, // Center vertically
        children: [
          // Icon Container with grey background
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: Colors.grey[200], // Light grey background
              borderRadius: BorderRadius.circular(12), // Rounded corners
            ),
            child: Icon(
              icon,
              color: Colors.black87,
              size: 24,
            ),
          ),
          const SizedBox(width: 16),
          // Text Content (Title and Subtitle)
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600, // Semi-bold for title
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  subtitle,
                  style: TextStyle(
                    fontSize: 14,
                    // The light green/teal color for the descriptive text
                    color: subtitleColor,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // --- Widget Build Method ---
  @override
  Widget build(BuildContext context) {
    // Define the custom subtitle color used throughout the screen
    const Color tealColor = Color(0xFF00BFA5);

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
          'Social Connections & Goals',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),

      // --- Body (Scrollable Content) ---
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16.0), // Adjusted horizontal padding
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const SizedBox(height: 16),

            // --- UPDATED: "Connect with Friends" is now a title for the section ---
            const Text(
              'Connect with Friends',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 16),

            // --- UPDATED: Each feature is now in its own Card ---
            // 1. Shared Events Card
            Card(
              elevation: 2,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: _buildFeatureTile(
                Icons.people_outline,
                'Shared Events',
                'Invite friends to join events and activities',
                tealColor,
              ),
            ),
            const SizedBox(height: 12), // Spacing between cards

            // 2. Trips & Experiences Card
            Card(
              elevation: 2,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: _buildFeatureTile(
                Icons.location_on_outlined,
                'Trips & Experiences',
                'Plan trips and experiences together',
                tealColor,
              ),
            ),
            const SizedBox(height: 12), // Spacing between cards

            // 3. Shared Goals Card
            Card(
              elevation: 2,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: _buildFeatureTile(
                Icons.flag_outlined,
                'Shared Goals',
                'Track progress on shared goals',
                tealColor,
              ),
            ),

            const SizedBox(height: 32),

            // --- "AI Suggestion" section remains a Card ---
            Card(
              elevation: 2,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'AI Suggestion',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Text and Button Column
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Invite Friends to Join Activities',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black,
                                ),
                              ),
                              const SizedBox(height: 8),
                              const Text(
                                'Invite friends to join activities with cost breakdowns and shared planning.',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: tealColor,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              const SizedBox(height: 16),
                              // 'Invite' Button
                              OutlinedButton(
                                onPressed: () {
                                  // Handle Invite button press
                                },
                                style: OutlinedButton.styleFrom(
                                  side: const BorderSide(color: tealColor, width: 1.5),
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 24, vertical: 12),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                ),
                                child: const Text(
                                  'Invite',
                                  style: TextStyle(
                                    color: tealColor,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),

                        // Image Placeholder
                        const SizedBox(width: 10),
                        SizedBox(
                          width: 100,
                          height: 100,
                          child: Center(
                            child: Image.asset(
                              'assets/images/social image4.png',
                              fit: BoxFit.cover, // Ensures the image fills the container
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 40), // Extra space at the bottom of the body
          ],
        ),
      ),

      // --- Bottom Navigation Bar ---
      bottomNavigationBar: MainScreen(selectedIndex: 3), );
  }
}