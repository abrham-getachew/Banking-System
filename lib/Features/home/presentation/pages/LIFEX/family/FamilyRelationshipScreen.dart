import 'package:flutter/material.dart';

import '../../nav_page.dart';
import 'CounselingScreen.dart';
import 'FamilyDashboardScreen.dart';
import 'GroupInsuranceScreen.dart';
import 'ParentalControlsScreen.dart';

// --- The main screen widget (Stateful to handle BottomNavigationBar) ---
class FamilyRelationshipScreen extends StatefulWidget {
  const FamilyRelationshipScreen({super.key});

  @override
  State<FamilyRelationshipScreen> createState() =>
      _FamilyRelationshipScreenState();
}

class _FamilyRelationshipScreenState extends State<FamilyRelationshipScreen> {
  // State for the bottom navigation bar
  int _selectedIndex = 3; // 'LifeX' tab is the 4th item (index 3)

  // Custom colors derived from the image
  static const Color _primaryTextColor = Color(0xFF333333);
  static const Color _secondaryTextColor = Color(0xFF6A6A6A);
  static const Color _accentColor = Color(0xFF26B0AB);
  static const Color _scaffoldBackgroundColor = Colors.white;
  static const Color _lightCardColor = Color(0xFFF7F7F7); // For button background

  // Data structure for the Quick Snapshot cards
  // UPDATED: Added 'image_path' to each map
  final List<Map<String, dynamic>> _snapshotData = [
    {
      'title': 'Family Shared Budget',
      'value': '\$12,500',
      'status': 'Balance',
      'image_color': const Color(0xFFF1EDE8), // Light beige
      'image_path': 'assets/images/family image2.png', // <-- Image path added
    },
    {
      'title': 'Child Education Savings',
      'value': '60%',
      'status': 'Progress',
      'image_color': const Color(0xFFF0F0F0), // Light gray
      'image_path': 'assets/images/family image3.png', // <-- Image path added
    },
    {
      'title': 'Group Insurance',
      'value': 'Coverage',
      'status': 'Active',
      'image_color': const Color(0xFF26B0AB), // Teal/Accent color
      'image_path': 'assets/images/family image4.png', // <-- Image path added
    },
  ];

  // Data for the action buttons
  final List<Map<String, dynamic>> _actionData = [
    {
      'label': 'Shared\nAccounts',
      'icon': Icons.people_outline,
      'color': _primaryTextColor,
      'destination': const FamilyDashboardScreen(),
    },
    {
      'label': 'Group\nInsurance',
      'icon': Icons.verified_user_outlined,
      'color': _primaryTextColor,
      'destination': const GroupInsuranceScreen(),
    },
    {
      'label': 'Relationship\nCounseling',
      'icon': Icons.favorite_border,
      'color': _primaryTextColor,
      'destination': const CounselingScreen(),
    },
    {
      'label': 'Parental\nControls',
      'icon': Icons.lock_outline,
      'color': _primaryTextColor,
      'destination': const ParentalControlsScreen(),
    },
  ];

  // --- Reusable Widget for a single Quick Snapshot Card ---
  // UPDATED: Now accepts 'imagePath'
  Widget _buildSnapshotCard({
    required String title,
    required String value,
    required String status,
    required Color imageColor,
    required String imagePath,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    color: _secondaryTextColor,
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  value,
                  style: TextStyle(
                    color: title == 'Group Insurance'
                        ? _accentColor // 'Coverage' text is teal
                        : _primaryTextColor, // Numeric values are dark gray
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  status,
                  style: TextStyle(
                    color: status == 'Active' ? _accentColor : _secondaryTextColor,
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
          // Image/Illustration Container
          Container(
            width: 100,
            height: 80,
            decoration: BoxDecoration(
              color: imageColor,
              borderRadius: BorderRadius.circular(8),
              border: imageColor == _accentColor
                  ? Border.all(color: _accentColor.withOpacity(0.5), width: 1)
                  : null,
            ),
            // UPDATED: Replaced placeholder text with an Image asset
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Padding(
                padding: const EdgeInsets.all(0), // Add padding to the image
                child: Image.asset(
                  imagePath,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // --- Reusable Widget for a single Action Button (Card) ---
  Widget _buildActionButton({
    required String label,
    required IconData icon,
    required Color color,
    required Widget destinationPage,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: _lightCardColor,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.teal.shade100, width: 1),
      ),
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => destinationPage),
          );
        },
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(icon, size: 28, color: color),
              const SizedBox(height: 12),
              Text(
                label,
                textAlign: TextAlign.left,
                style: TextStyle(
                  color: color,
                  fontWeight: FontWeight.w600,
                  fontSize: 14,
                  height: 1.2,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: _scaffoldBackgroundColor,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          color: _primaryTextColor,
          onPressed: () {
            // Handle back button press
          },
        ),
        title: const Text(
          'Family & Relationships Life',
          style: TextStyle(
            color: _primaryTextColor,
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.settings_outlined),
            color: _primaryTextColor,
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            // --- Header Description ---
            const SizedBox(height: 5),
            const Text(
              'Your central hub for family-related financial and relationship management.',
              style: TextStyle(
                color: _secondaryTextColor,
                fontSize: 15,
              ),
            ),
            const SizedBox(height: 25),

            // --- Illustration ---
            // UPDATED: Replaced placeholder with an asset image
            Container(
              height: 150,
              decoration: BoxDecoration(
                color: const Color(0xFFF1EDE8), // Light beige for illustration background
                borderRadius: BorderRadius.circular(10),
                image: const DecorationImage(
                  image: AssetImage('assets/images/family image1.png'), // <-- Header image
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(height: 30),

            // --- Quick Snapshot Section ---
            const Text(
              'Quick Snapshot',
              style: TextStyle(
                color: _primaryTextColor,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            // UPDATED: Pass the imagePath to the builder
            ..._snapshotData
                .map((data) => _buildSnapshotCard(
              title: data['title'],
              value: data['value'],
              status: data['status'],
              imageColor: data['image_color'],
              imagePath: data['image_path'], // Pass the new path
            ))
                .toList(),

            const SizedBox(height: 30),

            // --- Actions Section ---
            const Text(
              'Actions',
              style: TextStyle(
                color: _primaryTextColor,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 16.0,
                mainAxisSpacing: 16.0,
                childAspectRatio: 1.3,
              ),
              itemCount: _actionData.length,
              itemBuilder: (context, index) {
                final action = _actionData[index];
                return _buildActionButton(
                  label: action['label']!,
                  icon: action['icon']!,
                  color: action['color']!,
                  destinationPage: action['destination']!,
                );
              },
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
      bottomNavigationBar: MainScreen(selectedIndex: 3), );
  }
}