import 'package:flutter/material.dart';

import '../../nav_page.dart';

// --- Theme Colors and Constants ---
const Color _kDarkTextColor = Color(0xFF333333);
const Color _kLightTextColor = Color(0xFF666666);
const Color _kPrimaryButtonColor = Color(0xFF13A08D); // Bright blue for the main button
const Color _kSecondaryButtonColor = Color(0xFFE0E0E0); // Light gray for the secondary button
const Color _kFilterChipColor = Color(0xFFEFEFEF); // Light gray background for filter chips
const Color _kIconColor = Color(0xFF333333); // For the settings icon and bottom nav unselected
const Color _kLifeXSelectedColor = Color(0xFF333333); // Black/Dark color for the selected LifeX tab

class FaithTripPlanningScreen extends StatefulWidget {
  const FaithTripPlanningScreen({super.key});

  @override
  State<FaithTripPlanningScreen> createState() => _FaithTripPlanningScreenState();
}

class _FaithTripPlanningScreenState extends State<FaithTripPlanningScreen> {
  // --- State Variables ---
  int _selectedIndex = 3; // Initial selection for 'LifeX' tab (index 3)
  String _selectedReligion = 'All';
  String _selectedRegion = 'All';

  // --- Helper Methods ---
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    // Implement navigation logic here
  }

  // Example method to simulate filtering action
  void _setReligion(String religion) {
    setState(() {
      _selectedReligion = religion;
      // In a real app, this would trigger data filtering
    });
  }

  void _setRegion(String region) {
    setState(() {
      _selectedRegion = region;
    });
  }

  // --- Main Build Method ---
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      // 1. Custom App Bar
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          'LifeX',
          style: TextStyle(color: _kDarkTextColor, fontWeight: FontWeight.w500),
        ),
        centerTitle: true,
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 15.0),
            child: Icon(Icons.settings, color: _kIconColor),
          ),
        ],
      ),
      // 2. Body Content
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            // Header Text
            const Padding(
              padding: EdgeInsets.only(left: 20.0, top: 10, right: 20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        'Plan Your Faith Journey',
                        style: TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.w900,
                          color: _kDarkTextColor,
                        ),
                      ),
                      // Small airplane emoji icon
                      SizedBox(width: 8),
                      Text('✈️', style: TextStyle(fontSize: 24)),
                    ],
                  ),
                  SizedBox(height: 5),
                  Text(
                    'Discover holy sites, pilgrimages, and retreats.',
                    style: TextStyle(
                      fontSize: 16,
                      color: _kLightTextColor,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 30),

            // Destination Carousel
            _buildDestinationCarousel(),
            const SizedBox(height: 30),

            // Action Buttons
            _buildActionButtons(),
            const SizedBox(height: 30),

            // Filter Section
            _buildFilterChips(),
            const SizedBox(height: 20),
          ],
        ),
      ),
      // 3. Bottom Navigation Bar
      bottomNavigationBar: MainScreen(selectedIndex: 3),
    );
  }

  // --- Component Builders ---

  Widget _buildDestinationCarousel() {
    // Height determined by image aspect ratio and desired fit
    return SizedBox(
      height: 250,
      child: ListView(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.only(left: 20.0), // Start padding
        children: <Widget>[
          _buildDestinationCard(
            title: 'Temple',
            imagePath: 'assets/images/spritual image10.png', // Placeholder
          ),
          const SizedBox(width: 15),
          _buildDestinationCard(
            title: 'Church',
            imagePath: 'assets/images/spritual image11.png', // Placeholder
          ),
          const SizedBox(width: 15),
          _buildDestinationCard(
            title: 'Mosque',
            imagePath: 'assets/images/spritual image10.png', // Placeholder
          ),
        ],
      ),
    );
  }

  Widget _buildDestinationCard({required String title, required String imagePath}) {
    // Card width slightly less than half the screen to ensure multiple cards show
    return SizedBox(
      width: 180,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.asset(
                imagePath,
                fit: BoxFit.cover,
                width: double.infinity,
                // Simple placeholder image for the visual structure
                errorBuilder: (context, error, stackTrace) => Container(
                  color: _kSecondaryButtonColor,
                  child: Center(child: Text(title, style: TextStyle(color: _kDarkTextColor))),
                ),
              ),
            ),
          ),
          const SizedBox(height: 10),
          Text(
            title,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: _kDarkTextColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActionButtons() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Row(
        children: [
          // Primary Button: Plan My Trip (Blue, Bold)
          Expanded(
            child: SizedBox(
              height: 50,
              child: ElevatedButton(
                onPressed: () {
                  // Handle Plan My Trip action
                  print('Plan My Trip pressed');
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: _kPrimaryButtonColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  elevation: 0,
                ),
                child: const Text(
                  'Plan My Trip',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(width: 10),

          // Secondary Button: View Popular Destinations (Gray, less emphasis)
          Expanded(
            child: SizedBox(
              height: 50,
              child: ElevatedButton(
                onPressed: () {
                  // Handle View Popular Destinations action
                  print('View Popular Destinations pressed');
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: _kSecondaryButtonColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  elevation: 0,
                ),
                child: const Text(
                  'View Popular Destinations',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: _kDarkTextColor,
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFilterChips() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Filter',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: _kDarkTextColor,
            ),
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              // Religion Filter Chip
              GestureDetector(
                onTap: () => _setReligion(_selectedReligion == 'All' ? 'Christianity' : 'All'), // Toggle example
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  decoration: BoxDecoration(
                    color: _kFilterChipColor,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Text(
                    'By Religion',
                    style: TextStyle(
                      color: _kDarkTextColor,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 10),
              // Region Filter Chip
              GestureDetector(
                onTap: () => _setRegion(_selectedRegion == 'All' ? 'Asia' : 'All'), // Toggle example
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  decoration: BoxDecoration(
                    color: _kFilterChipColor,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Text(
                    'By Region',
                    style: TextStyle(
                      color: _kDarkTextColor,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }


}