import 'package:flutter/material.dart';

import '../../nav_page.dart';


// --- JointPlanningScreen Widget (Stateful) ---
class JointPlanningScreen extends StatefulWidget {
  const JointPlanningScreen({super.key});

  @override
  State<JointPlanningScreen> createState() => _JointPlanningScreenState();
}

class _JointPlanningScreenState extends State<JointPlanningScreen> {
  // State for Bottom Navigation Bar
  // Assuming 'AI' is the selected tab initially (index 1)
  int _selectedIndex = 1;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  // Define the custom subtitle color used throughout the screen (a shade of teal/green)
  static const Color tealColor = Color(0xFF00BFA5);

  // --- UPDATED: Helper method now builds a complete Card for each feature ---
  Widget _buildFeatureTile(
      IconData icon, String title, String subtitle) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: InkWell(
        onTap: () {
          // Add navigation logic here for each feature
          print('$title tapped');
        },
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // UPDATED: Icon with grey container
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: Colors.grey[200], // Light grey background
                  borderRadius: BorderRadius.circular(12),
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
          'Joint Planning Tools',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),

      // --- Body (Scrollable Content) ---
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const SizedBox(height: 24),

            // **Shared Expenses Section Title**
            const Text(
              'Shared Expenses',
              style: TextStyle(
                fontSize: 22, // Adjusted title size
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 16),

            // **1. Bill Splitting Tile**
            _buildFeatureTile(
              Icons.monetization_on_outlined, // Dollar sign look-alike
              'Bill Splitting',
              'Automatically split bills and expenses',
            ),
            const SizedBox(height: 12), // Spacing between cards

            // **2. Expense Tracking Tile**
            _buildFeatureTile(
              Icons.show_chart, // Line chart for tracking
              'Expense Tracking',
              'Track and manage shared expenses',
            ),

            const SizedBox(height: 32),

            // **Joint Planning Section Title**
            const Text(
              'Joint Planning',
              style: TextStyle(
                fontSize: 22, // Adjusted title size
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 16),

            // **3. Date Planner Tile**
            _buildFeatureTile(
              // Calendar icon with a specific date look
              Icons.calendar_today_outlined,
              'Date Planner',
              'Plan and schedule dates together',
            ),
            const SizedBox(height: 12), // Spacing between cards

            // **4. Trip Planner Tile**
            _buildFeatureTile(
              Icons.airplanemode_active_outlined, // Airplane for trips
              'Trip Planner',
              'Organize and manage trips together',
            ),
            const SizedBox(height: 12), // Spacing between cards

            // **5. Gift Planner Tile**
            _buildFeatureTile(
              Icons.card_giftcard, // Gift box icon
              'Gift Planner',
              'Coordinate and manage gifts for each other',
            ),

            const SizedBox(height: 40), // Extra space at the bottom of the body
          ],
        ),
      ),

      // --- Bottom Navigation Bar ---
      bottomNavigationBar: MainScreen(selectedIndex: 3),
    );
  }
}