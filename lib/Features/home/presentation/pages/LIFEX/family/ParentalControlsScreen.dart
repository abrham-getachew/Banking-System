import 'package:flutter/material.dart';

import '../../nav_page.dart';


// --- ParentalControlsScreen Widget (Stateful) ---
class ParentalControlsScreen extends StatefulWidget {
  const ParentalControlsScreen({super.key});

  @override
  State<ParentalControlsScreen> createState() => _ParentalControlsScreenState();
}

class _ParentalControlsScreenState extends State<ParentalControlsScreen> {
  // State for Bottom Navigation Bar
  // Assuming 'LifeX' is the selected tab initially (index 3)
  int _selectedIndex = 3;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  // Define the custom subtitle color used throughout the screen (a shade of teal/green)
  static const Color tealColor = Color(0xFF00BFA5);
  static const Color darkTextColor = Color(0xFF333333);

  // --- UPDATED: Helper method to create the feature list tiles ---
  Widget _buildFeatureTile(
      IconData icon, String title, String subtitle) {
    return InkWell(
      onTap: () {
        // Placeholder action for when the tile is tapped
        print('$title tapped');
      },
      borderRadius: BorderRadius.circular(12),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // UPDATED: Icon Container with grey background
            Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                color: Colors.grey[200], // Light grey background
                borderRadius: BorderRadius.circular(12), // Rounded corners
              ),
              child: Icon(
                icon,
                color: darkTextColor,
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
                      color: darkTextColor,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    subtitle,
                    style: const TextStyle(
                      fontSize: 14,
                      // The light green/teal color for the descriptive text
                      color: tealColor,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
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
            Navigator.of(context).pop();
          },
        ),
        title: const Text(
          'Parental Controls',
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
            // **1. Hero Image and Text Section**
            Container(
              width: double.infinity,
              height: 350, // Height to accommodate the image and text
              child: Stack(
                alignment: Alignment.center,
                children: [
                  // Image Placeholder (Illustration of teens)
                  Positioned.fill(
                    // UPDATED: Changed from Image.network to Image.asset
                    child: Image.asset(
                      'assets/images/family image27.png', // <-- Make sure this path is correct
                      fit: BoxFit.cover,
                    ),
                  ),

                  // Black gradient for text contrast
                  Positioned.fill(
                    child: Container(
                      decoration: const BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Colors.transparent,
                            Colors.black54, // Starts dark at bottom
                            Colors.black87, // Darkest area behind text
                          ],
                          stops: [0.0, 0.4, 1.0],
                        ),
                      ),
                    ),
                  ),

                  // Text Content
                  Positioned(
                    bottom: 40,
                    left: 24,
                    right: 24,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Text(
                          'Empower Your Teen\'s\nFinancial Journey',
                          style: TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            height: 1.2,
                          ),
                        ),
                        SizedBox(height: 12),
                        Text(
                          'Link accounts, set spending limits, and approve requests. Foster financial literacy with fun learning modules and reward responsible spending.',
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.white70,
                            height: 1.4,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 32),

            // **2. Key Features Section**
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Key Features',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: darkTextColor,
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Feature Tiles
                  _buildFeatureTile(
                    Icons.link,
                    'Linked Accounts',
                    'Link your account with your teen\'s for easy management.',
                  ),
                  _buildFeatureTile(
                    Icons.attach_money,
                    'Spending Limits',
                    'Set daily, weekly, or monthly spending limits.',
                  ),
                  _buildFeatureTile(
                    Icons.check_circle_outline, // Checkmark for approval
                    'Approval Requests',
                    'Approve or deny spending requests in real-time.',
                  ),
                  _buildFeatureTile(
                    Icons.menu_book, // Open book for literacy/learning
                    'Financial Literacy',
                    'Engaging modules to teach teens about money.',
                  ),
                  _buildFeatureTile(
                    Icons.emoji_events_outlined, // Trophy/badge for rewards
                    'Gamified Rewards',
                    'Reward badges for responsible spending habits.',
                  ),
                ],
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