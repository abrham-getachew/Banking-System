import 'package:flutter/material.dart';

import '../../nav_page.dart';
import 'GymFitnessScreen.dart';
import 'HSAManagementScreen.dart';
import 'InsuranceMarketplaceScreen.dart';
import 'MentalHealthCounselingScreen.dart';
import 'NutritionDietScreen.dart';
import 'WearableIntegrationScreen.dart';

class HealthLifeHubScreen extends StatefulWidget {
  const HealthLifeHubScreen({super.key});

  @override
  State<HealthLifeHubScreen> createState() => _HealthLifeHubScreenState();
}

class _HealthLifeHubScreenState extends State<HealthLifeHubScreen> {
  // Mock data for the state
  String insuranceStatus = 'Active';
  int stepsToday = 5234;
  String nextAppointmentDate = 'July 15, 2024';
  int selectedTabIndex = 0;

  // The main accent color from the image (a light greenish-teal/cyan)
  // I'll approximate the colors based on the image provided.
  static const Color primaryCardColor = Color(0xFFF0F5F7); // A light, cool background color for cards
  static const Color accentColor = Color(0xFF00ADB5); // For icons and active states

  // Function to simulate a network call to update steps, making it stateful
  void _updateSteps() {
    setState(() {
      // Simulate a step count increase
      stepsToday += 100;
    });
    // In a real app, this would involve fetching data from a service
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        // The title bar area is mostly a custom header, so we'll make the AppBar transparent/minimal
        toolbarHeight: 0, // Hide the standard app bar
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            // --- HEADER SECTION ---
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Health Life',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      SizedBox(height: 4),
                      Text(
                        'Your health and wellness hub',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                  IconButton(
                    icon: const Icon(Icons.settings, size: 28, color: Colors.grey),
                    onPressed: () {
                      // Handle settings tap
                    },
                  ),
                ],
              ),
            ),

            // --- IMAGE / ILLUSTRATION SECTION ---
            Container(
              margin: const EdgeInsets.symmetric(vertical: 16.0),
              // This container simulates the heart illustration area
              height: 250,
              decoration: const BoxDecoration(
                color: Color(0xFFFEE4D7),
                image: DecorationImage(
                  image: AssetImage('assets/images/health image1.png'),
                  fit: BoxFit.cover,
                ),// A light peach/orange background
              ),
              child: Center(
               
                // ), <-- THIS WAS THE MISPLACED PARENTHESIS THAT WAS REMOVED
              ),
            ),

            // --- QUICK STATS HEADER ---
            const Padding(
              padding: EdgeInsets.only(left: 16.0, top: 8.0, bottom: 12.0),
              child: Text(
                'Quick Stats',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
            ),

            // --- QUICK STATS CARDS ---
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                children: [
                  // Row for Insurance Status and Steps Today
                  Row(
                    children: <Widget>[
                      // Insurance Status Card
                      Expanded(
                        child: _buildQuickStatCard(
                          title: 'Insurance Status',
                          value: insuranceStatus,
                          valueStyle: const TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                          onTap: () => setState(() => insuranceStatus = (insuranceStatus == 'Active' ? 'Inactive' : 'Active')),
                        ),
                      ),
                      const SizedBox(width: 16),
                      // Steps Today Card
                      Expanded(
                        child: _buildQuickStatCard(
                          title: 'Steps Today',
                          value: stepsToday.toString(),
                          valueStyle: const TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                          onTap: _updateSteps,
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 16),

                  // Next Doctor Appointment Card
                  _buildQuickStatCard(
                    title: 'Next Doctor Appointment',
                    value: nextAppointmentDate,
                    valueStyle: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                    onTap: () => setState(() => nextAppointmentDate = 'Dec 25, 2024'),
                    isFullWidth: true,
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),

            // --- MANAGE HEADER ---
            const Padding(
              padding: EdgeInsets.only(left: 16.0, bottom: 12.0),
              child: Text(
                'Manage',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
            ),

            // --- MANAGE GRID ---
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: GridView.count(
                shrinkWrap: true, // Important for nested ScrollView
                physics: const NeverScrollableScrollPhysics(), // Disable internal scrolling
                crossAxisCount: 2,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
                childAspectRatio: 2.2, // Adjust card height
                children: <Widget>[
                  _buildManageTile(Icons.credit_card, 'HSA'),
                  _buildManageTile(Icons.verified_user, 'Insurance'),
                  _buildManageTile(Icons.fitness_center, 'Fitness'),
                  _buildManageTile(Icons.local_florist, 'Nutrition'), // Changed icon to better match 'Nutrition'
                  _buildManageTile(Icons.self_improvement, 'Mental Health'), // Changed icon
                  _buildManageTile(Icons.watch, 'Wearables'),
                ],
              ),
            ),

            const SizedBox(height: 16), // Padding before the bottom navigation
          ], // <-- THIS IS THE CORRECT PLACEMENT FOR THE COLUMN'S CLOSING BRACKET
        ),
      ),

      // --- BOTTOM NAVIGATION BAR ---
      bottomNavigationBar: MainScreen(selectedIndex: 3),
    );
  }

  // Helper widget for Quick Stats cards
  Widget _buildQuickStatCard({
    required String title,
    required String value,
    required TextStyle valueStyle,
    required VoidCallback onTap,
    bool isFullWidth = false,
  }) {
    return Card(
      color: primaryCardColor,
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Container(
          width: isFullWidth ? double.infinity : null,
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                title,
                style: const TextStyle(
                  fontSize: 14,
                  color: Colors.black54,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                value,
                style: valueStyle,
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Helper widget for Manage grid tiles
  //... inside _HealthLifeHubScreenState

  // Helper widget for Manage grid tiles
  Widget _buildManageTile(IconData icon, String label) {
    return Card(
      color: primaryCardColor,
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: InkWell(
        onTap: () {
          // --- NAVIGATION LOGIC ADDED HERE ---
          Widget? destinationPage;
          switch (label) {
            case 'HSA':
              destinationPage = HSAManagementScreen();
              break;
            case 'Insurance':
              destinationPage = InsuranceMarketplaceScreen();
              break;
            case 'Fitness':
              destinationPage =GymFitnessScreen() ;
              break;
            case 'Nutrition':
              destinationPage = NutritionDietScreen();
              break;
            case 'Mental Health':
              destinationPage = MentalHealthCounselingScreen();
              break;
            case 'Wearables':
              destinationPage = WearableIntegrationScreen();
              break;
          }

          if (destinationPage != null) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => destinationPage!),
            );
          }
        },
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Row(
            children: <Widget>[
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: accentColor.withOpacity(0.1), // Very light background for icon
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(icon, color: accentColor, size: 20),
              ),
              const SizedBox(width: 8),
              Flexible(
                child: Text(
                  label,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // --- NEW HELPER FOR PLACEHOLDER PAGES ---
  Widget _buildPlaceholderScreen(String title) {
    return Scaffold(
      appBar: AppBar(
        title: Text('$title Screen'),
        backgroundColor: accentColor,
      ),
      body: Center(
        child: Text(
          'This is the placeholder page for $title.',
          style: TextStyle(fontSize: 18),
        ),
      ),
    );
  }
}