import 'package:flutter/material.dart';

import '../../nav_page.dart';


// --- CampaignDashboardScreen Widget (Stateful) ---
class CampaignDashboardScreen extends StatefulWidget {
  const CampaignDashboardScreen({super.key});

  @override
  State<CampaignDashboardScreen> createState() => _CampaignDashboardScreenState();
}

class _CampaignDashboardScreenState extends State<CampaignDashboardScreen> {
  // State for Bottom Navigation Bar
  // Assuming 'LifeX' is the selected tab initially (index 3)
  int _selectedIndex = 3;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  // Define custom colors
  static const Color primaryBlue = Color(0xFF13A08D); // The bright blue used for the button
  static const Color lightBlueBackground = Color(0xFFF7F9FC); // The very light blue/grey background
  static const Color darkTextColor = Color(0xFF333333);
  static const Color accentBlue = Color(0xFF00BFA5); // Placeholder for the light blue/teal subtitle

  // Helper widget for the individual stat items inside the main card
  Widget _buildStatItem(String title, String value) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: Colors.grey[600],
            ),
          ),
          const SizedBox(height: 8),
          Text(
            value,
            style: const TextStyle(
              fontSize: 28, // Large font size for the numbers
              fontWeight: FontWeight.bold,
              color: darkTextColor,
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
        backgroundColor: Colors.white, // Match the body background
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text(
          'Campaign Dashboard',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),

      // --- Body (Scrollable Content) ---
      body: Container(
        // Set the overall body background color to match the card background
        color: Colors.white,
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              const SizedBox(height: 40),

              // **1. Campaign Image/Logo**
              Container(
                width: 120,
                height: 120,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white, // White circle background for image
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      spreadRadius: 1,
                      blurRadius: 5,
                    ),
                  ],
                ),
                child: Center(
                  // UPDATED: Changed from Network to Asset Image
                  child: Image.asset(
                    'assets/images/spritual image24.png', // <-- Replace with your actual image path
                    height: 90,
                    width: 90,
                    fit: BoxFit.contain,
                  ),
                ),
              ),
              const SizedBox(height: 16),

              // **2. Campaign Title and Subtitle**
              const Text(
                'Chronos LifeX',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: darkTextColor,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                'Charity Crowdfunding',
                style: TextStyle(
                  fontSize: 14,
                  // Use a slightly different accent color for this subtitle
                  color: Colors.grey[600],
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 32),

              // **3. Stat Cards (Combined into one)**
              Card(
                elevation: 0,
                color: lightBlueBackground,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          _buildStatItem('Donors', '125'),
                          const SizedBox(width: 16),
                          _buildStatItem('Total Raised', '\$5,000'),
                        ],
                      ),
                      const SizedBox(height: 24),
                      Row(
                        children: [
                          _buildStatItem('Shares', '300'),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 40),

              // **4. Call to Action Button**
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    // Handle Withdraw funds button press
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: primaryBlue, // The primary blue color
                    padding: const EdgeInsets.symmetric(vertical: 16.0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    elevation: 0,
                  ),
                  child: const Text(
                    'Withdraw funds to Chronos Wallet',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 40), // Space before bottom nav bar
            ],
          ),
        ),
      ),

      // --- Bottom Navigation Bar ---
      bottomNavigationBar: MainScreen(selectedIndex: 3),
    );
  }
}
