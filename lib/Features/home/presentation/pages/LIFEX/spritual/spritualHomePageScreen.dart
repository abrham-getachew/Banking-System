import 'package:flutter/material.dart';

import '../../nav_page.dart';
import 'CrowdfundingScreen.dart';
import 'DonationHubScreen.dart';
import 'FaithTripPlanningScreen.dart';
import 'SettingsScreen.dart';
import 'TripConfirmationScreen.dart'; // Import the SettingsScreen


// --- The main screen widget (Stateful to handle BottomNavigationBar and Dropdown) ---
class spritualHomePageScreen extends StatefulWidget {
  const spritualHomePageScreen({super.key});

  @override
  State<spritualHomePageScreen> createState() => _LifeXHomePageScreenState();
}

class _LifeXHomePageScreenState extends State<spritualHomePageScreen> {
  // State for the bottom navigation bar
  int _selectedIndex = 3; // 'LifeX' tab is the 4th item (index 3)

  // State for the progress bar/dropdown selection
  String? _selectedFocusArea = 'Spiritual Life';
  final List<String> _focusAreas = [
    'Spiritual Life',
    'Career & Networking',
    'Family & Relationships'
  ];

  // Custom colors derived from the image
  static const Color _primaryTextColor = Color(0xFF333333);
  static const Color _secondaryTextColor = Color(0xFF6A6A6A);
  static const Color _accentColor = Color(0xFF26B0AB);
  static const Color _scaffoldBackgroundColor = Colors.white;
  static const Color _lightCardColor = Color(0xFFF7F7F7); // For button background

  // Data structure for the Action Grid
  // UPDATED: Added 'destination' for navigation
  final List<Map<String, dynamic>> _actionData = [
    {'label': 'Donation', 'icon': Icons.watch_later_outlined, 'destination': const DonationHubScreen()},
    {'label': 'Trip Planning', 'icon': Icons.flight_takeoff, 'destination': const TripConfirmationScreen()},
    {'label': 'Charity Crowdfunding', 'icon': Icons.favorite_border, 'destination': const CrowdfundingScreen()},
    {'label': 'Faith Calendar', 'icon': Icons.calendar_today_outlined, 'destination': const FaithCalendarScreen()},
    {'label': 'Spiritual Goals', 'icon': Icons.track_changes, 'destination': const SpiritualGoalsScreen()},
    {'label': 'Faith Events', 'icon': Icons.fiber_manual_record, 'destination': const FaithEventsScreen()},
    {'label': 'Spiritual Store', 'icon': Icons.shopping_bag_outlined, 'destination': const SpiritualStoreScreen()},
    {'label': 'Courses', 'icon': Icons.book_outlined, 'destination': const CoursesScreen()},
    {'label': 'Add-ons', 'icon': Icons.add, 'destination': const AddonsScreen()},
  ];

  // --- Widget for the Dropdown/Progress Bar Section ---
  Widget _buildFocusSelector() {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0, bottom: 20.0),
      child: Container(
        height: 60,
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Colors.grey.shade300, width: 1),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.shade100,
              blurRadius: 5,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Row(
          children: [
            Expanded(
              child: DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                  value: _selectedFocusArea,
                  isExpanded: true,
                  icon: const Icon(Icons.keyboard_arrow_down, color: _secondaryTextColor),
                  style: const TextStyle(
                      color: _primaryTextColor,
                      fontSize: 16,
                      fontWeight: FontWeight.w600),
                  items: _focusAreas.map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  onChanged: (String? newValue) {
                    setState(() {
                      _selectedFocusArea = newValue;
                    });
                  },
                  hint: const Text('Select Focus Area'),
                ),
              ),
            ),
            const SizedBox(width: 8),
            // The green gradient progress indicator
            Container(
              width: 50,
              height: 8,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(4),
                gradient: const LinearGradient(
                  colors: [
                    Color(0xFFE0E0E0), // Grey for 0%
                    Color(0xFF86D8AB), // Light Green start
                    Color(0xFF4CAF50), // Dark Green end
                  ],
                  stops: [0.0, 0.5, 1.0], // Simulates 50% progress
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // --- Reusable Widget for a single Action Button (Tile) ---
  // UPDATED: Now accepts a destination widget
  Widget _buildActionTile({
    required String label,
    required IconData icon,
    required Widget destination,
  }) {
    // The image has a light green background for the tiles
    const Color tileColor = Color(0xFFF0F6F0);

    return Container(
      decoration: BoxDecoration(
        color: tileColor,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.teal.shade100, width: 1),
      ),
      child: InkWell(
        onTap: () {
          // UPDATED: Navigate to the specified destination screen
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => destination),
          );
        },
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(icon, size: 28, color: _accentColor),
              const SizedBox(height: 12),
              Text(
                label,
                textAlign: TextAlign.left,
                style: const TextStyle(
                  color: _primaryTextColor,
                  fontWeight: FontWeight.w600,
                  fontSize: 14,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // --- Widget for the fixed bottom navigation bar ---

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _scaffoldBackgroundColor,
      appBar: AppBar(
        title: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('LifeX'),
              SizedBox(width: 5),
            ],
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings_outlined, color: Colors.teal, size: 28),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const SettingsScreen()),
              );
            },
          ),
        ],
      ),
      body: CustomScrollView(
        slivers: <Widget>[
          // --- Custom SliverAppBar for Image Header ---
          SliverAppBar(
            backgroundColor: Colors.transparent,
            expandedHeight: 250.0,
            floating: false,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(

              centerTitle: true,
              background: Container(
                decoration: BoxDecoration(
                  color: Colors.grey.shade200, // Placeholder background
                  image: const DecorationImage(
                    image: AssetImage('assets/images/spritual image1.png'),
                    fit: BoxFit.cover,
                  ),
                ),

              ),
            //  titlePadding: const EdgeInsets.only(bottom: 16.0),
            ),
          ),
          // --- Main Content Section ---
          SliverList(
            delegate: SliverChildListDelegate(
              [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      const SizedBox(height: 10),
                      // Sub-header Text
                      const Text(
                        'Your daily guide for peace, purpose, and\nprogress.',
                        style: TextStyle(
                          color: _secondaryTextColor,
                          fontSize: 15,
                          height: 1.4,
                        ),
                      ),
                      const SizedBox(height: 20),

                      // Dropdown/Progress Bar
                      _buildFocusSelector(),

                      // Action Grid
                      GridView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 16.0,
                          mainAxisSpacing: 16.0,
                          childAspectRatio: 1.5, // Aspect ratio to match the card height
                        ),
                        itemCount: _actionData.length,
                        itemBuilder: (context, index) {
                          final action = _actionData[index];
                          // UPDATED: Pass the destination to the tile builder
                          return _buildActionTile(
                            label: action['label']!,
                            icon: action['icon']!,
                            destination: action['destination']!,
                          );
                        },
                      ),
                      const SizedBox(height: 20),
                    ],
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

// --- Placeholder Screens for Navigation ---

class _BaseScreen extends StatelessWidget {
  final String title;
  const _BaseScreen({required this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: Center(child: Text('This is the $title screen.')),
    );
  }
}






class FaithCalendarScreen extends StatelessWidget {
  const FaithCalendarScreen({super.key});
  @override
  Widget build(BuildContext context) => const _BaseScreen(title: 'Faith Calendar');
}

class SpiritualGoalsScreen extends StatelessWidget {
  const SpiritualGoalsScreen({super.key});
  @override
  Widget build(BuildContext context) => const _BaseScreen(title: 'Spiritual Goals');
}

class FaithEventsScreen extends StatelessWidget {
  const FaithEventsScreen({super.key});
  @override
  Widget build(BuildContext context) => const _BaseScreen(title: 'Faith Events');
}

class SpiritualStoreScreen extends StatelessWidget {
  const SpiritualStoreScreen({super.key});
  @override
  Widget build(BuildContext context) => const _BaseScreen(title: 'Spiritual Store');
}

class CoursesScreen extends StatelessWidget {
  const CoursesScreen({super.key});
  @override
  Widget build(BuildContext context) => const _BaseScreen(title: 'Courses');
}

class AddonsScreen extends StatelessWidget {
  const AddonsScreen({super.key});
  @override
  Widget build(BuildContext context) => const _BaseScreen(title: 'Add-ons');
}