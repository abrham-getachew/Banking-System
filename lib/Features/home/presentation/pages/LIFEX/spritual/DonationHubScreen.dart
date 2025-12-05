import 'package:flutter/material.dart';

import '../../nav_page.dart';
import 'DonationDetailsScreen.dart';

// --- Theme Colors and Constants ---
const Color _kDarkTextColor = Color(0xFF333333);
const Color _kLightTextColor = Color(0xFF666666);
const Color _kPrimaryAccent = Color(0xFF13A08D); // The LifeX heart is black, but we'll use a subtle green for consistency/accents
const Color _kFilterBackgroundColor = Color(0xFFF5F5F5); // Light background for the filter bar
const Color _kCardBorderColor = Color(0xFFEAEAEA); // Lighter border for the filter dropdowns
const Color _kCardBackgroundColor = Colors.white; // Background for the cause cards

class DonationHubScreen extends StatefulWidget {
  const DonationHubScreen({super.key});

  @override
  State<DonationHubScreen> createState() => _DonationHubScreenState();
}

class _DonationHubScreenState extends State<DonationHubScreen> {
  // --- State Variables ---
  int _selectedIndex = 3; // Initial selection for 'LifeX' tab (index 3)
  String? _selectedReligion;
  String? _selectedCauseType;
  String? _selectedLocation;

  // Dummy data to simulate the list of causes
  final List<Map<String, String>> _causes = [
    {'tag': 'Faith in Action', 'title': 'Support Orphan Homes', 'subtitle': 'Help provide shelter, education, and care for orphaned children.', 'image': 'assets/images/spritual image2.png'},
    {'tag': 'Sacred Spaces', 'title': 'Build a Mosque', 'subtitle': 'Contribute to the construction of a new mosque, fostering community and worship.', 'image': 'assets/images/spritual image3.png'},
    {'tag': 'Faith in Action', 'title': 'Support Orphan Homes', 'subtitle': 'Help provide shelter, education, and care for orphaned children.', 'image': 'assets/images/spritual image4.png'},
    {'tag': 'Sacred Spaces', 'title': 'Build a Church', 'subtitle': 'Contribute to the construction of a new church, fostering community and worship.', 'image': 'assets/images/spritual image6.png'},
    {'tag': 'Faith in Action', 'title': 'Support Orphan Homes', 'subtitle': 'Help provide shelter, education, and care for orphaned children.', 'image': 'assets/images/spritual image7.png'},
    {'tag': 'Sacred Spaces', 'title': 'Build a Temple', 'subtitle': 'Contribute to the construction of a new temple, fostering community and worship.', 'image': 'assets/images/spritual image8.png'},
  ];

  // --- Helper Methods ---
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    // Implement navigation logic here
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
            child: Icon(Icons.settings, color: _kDarkTextColor),
          ),
        ],
      ),
      // 2. Body Content
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const Padding(
            padding: EdgeInsets.only(left: 20.0, top: 10, right: 20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Make a Difference',
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.w900,
                    color: _kDarkTextColor,
                  ),
                ),
                SizedBox(height: 5),
                Text(
                  'Give to causes that align with your faith.',
                  style: TextStyle(
                    fontSize: 16,
                    color: _kLightTextColor,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          // Filter Bar
          _buildFilterBar(),
          const SizedBox(height: 10),
          // Donation Causes List
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
              itemCount: _causes.length,
              itemBuilder: (context, index) {
                return _buildCauseItem(_causes[index]);
              },
            ),
          ),
        ],
      ),
      // 3. Bottom Navigation Bar
      bottomNavigationBar: MainScreen(selectedIndex: 3),
    );
  }

  // --- Component Builders ---

  Widget _buildFilterBar() {
    // UPDATED: Wrapped in a SingleChildScrollView for horizontal scrolling
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      padding: const EdgeInsets.symmetric(horizontal: 20.0), // Padding for the scroll area
      child: Row(
        children: [
          _buildFilterDropdown(
            label: 'Religion',
            value: _selectedReligion,
            items: ['Christianity', 'Islam', 'Hinduism', 'Buddhism'],
            onChanged: (newValue) => setState(() => _selectedReligion = newValue),
          ),
          const SizedBox(width: 10), // Add spacing between dropdowns
          _buildFilterDropdown(
            label: 'Cause Type',
            value: _selectedCauseType,
            items: ['Education', 'Shelter', 'Health', 'Construction'],
            onChanged: (newValue) => setState(() => _selectedCauseType = newValue),
          ),
          const SizedBox(width: 10), // Add spacing between dropdowns
          _buildFilterDropdown(
            label: 'Location',
            value: _selectedLocation,
            items: ['Global', 'Local', 'India', 'Europe'],
            onChanged: (newValue) => setState(() => _selectedLocation = newValue),
          ),
        ],
      ),
    );
  }

  Widget _buildFilterDropdown({
    required String label,
    required String? value,
    required List<String> items,
    required ValueChanged<String?> onChanged,
  }) {
    return Container(
      // UPDATED: Reduced vertical padding to decrease height
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        // UPDATED: Added a light grey background color
        color: _kFilterBackgroundColor,
        borderRadius: BorderRadius.circular(10),
        // UPDATED: Using a lighter border color
        border: Border.all(color: _kCardBorderColor),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: null, // Always display the label/hint
          isDense: true, // Reduces the dropdown's intrinsic height
          hint: Row(
            children: [
              Text(
                label,
                style: const TextStyle(
                  color: _kDarkTextColor,
                  fontWeight: FontWeight.w500,
                  fontSize: 14,
                ),
              ),
              const SizedBox(width: 5), // Space between text and icon
              const Icon(Icons.keyboard_arrow_down, size: 18, color: _kLightTextColor),
            ],
          ),
          iconSize: 0, // Hide default dropdown icon
          items: items.map((String item) {
            return DropdownMenuItem<String>(
              value: item,
              child: Text(item),
            );
          }).toList(),
          onChanged: (newValue) {
            onChanged(newValue);
            // In a real app, this would trigger a data filter/fetch
          },
          style: const TextStyle(color: _kDarkTextColor, fontSize: 14),
        ),
      ),
    );
  }

  // UPDATED: This widget is now back to a row-based layout but within a single Card.
  Widget _buildCauseItem(Map<String, String> cause) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20.0),
      child: Card(
        elevation: 2,
        shadowColor: Colors.black.withOpacity(0.1),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        clipBehavior: Clip.antiAlias,
        child: InkWell(
          onTap: () {
            // UPDATED: Navigate to a detail screen, passing the cause data
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => DonationDetailsScreen(cause: cause),
              ),
            );
          },
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Text Content on the left
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        cause['tag']!,
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: _kLightTextColor.withOpacity(0.8),
                        ),
                      ),
                      const SizedBox(height: 5),
                      Text(
                        cause['title']!,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: _kDarkTextColor,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        cause['subtitle']!,
                        style: const TextStyle(
                          fontSize: 14,
                          height: 1.4,
                          color: _kLightTextColor,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 15),
                // Image on the right
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.asset(
                    cause['image']!,
                    width: 100,
                    height: 100,
                    fit: BoxFit.cover,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
