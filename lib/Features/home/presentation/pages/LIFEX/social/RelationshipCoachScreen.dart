import 'package:flutter/material.dart';

import '../../nav_page.dart';


// --- The main screen widget (Stateful to handle BottomNavigationBar) ---
class RelationshipCoachScreen extends StatefulWidget {
  const RelationshipCoachScreen({super.key});

  @override
  State<RelationshipCoachScreen> createState() => _RelationshipCoachScreenState();
}

class _RelationshipCoachScreenState extends State<RelationshipCoachScreen> {
  // State for the bottom navigation bar
  int _selectedIndex = 3; // 'LifeX' tab is the 4th item (index 3)

  // Custom colors derived from the image
  static const Color _primaryTextColor = Color(0xFF333333);
  static const Color _secondaryTextColor = Color(0xFF6A6A6A);
  static const Color _accentColor = Color(0xFF26B0AB);
  static const Color _lightTealColor = Color(0xFF26B0AB);
  static const Color _scaffoldBackgroundColor = Colors.white;

  // Data structure for the custom cards
  final List<Map<String, dynamic>> _activities = [
    {
      'section': 'Financial Activities',
      'title': 'AI Guidance',
      'subtitle': 'Joint Financial Planning',
      'description':
      'Get personalized advice on managing finances together, from budgeting to investments.',
      'card_color': const Color(0xFFF1EDE8), // Light beige
    },
    {
      'section': 'Financial Activities',
      'title': 'Budget-Friendly Investments',
      'subtitle': 'Shared Investment Strategies',
      'description':
      'Explore investment options tailored for couples, focusing on long-term financial goals.',
      'card_color': const Color(0xFFF0F0F0), // Light gray
    },
    {
      'section': 'Personal Activities',
      'title': 'AI Guidance',
      'subtitle': 'Relationship Goal Setting',
      'description':
      'Set and track personal and relationship goals with AI-driven insights and suggestions.',
      'card_color': const Color(0xFFF1EDE8), // Light beige
    },
    {
      'section': 'Personal Activities',
      'title': 'AI Alerts',
      'subtitle': 'Spending and Goal Alerts',
      'description':
      'Receive alerts for overspending or missed goals, helping you stay on track.',
      'card_color': const Color(0xFFF0F0F0), // Light gray
    },
  ];

  // --- Reusable Widget for a single content card (Activity) ---
  Widget _buildActivityCard({
    required String title,
    required String subtitle,
    required String description,
    required Color cardColor,
    required int index, // Use index to simulate unique images
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Text Content Area
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    color: _lightTealColor, // Teal color for the AI title
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  subtitle,
                  style: const TextStyle(
                    color: _primaryTextColor,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  description,
                  style: const TextStyle(
                    color: _secondaryTextColor,
                    fontSize: 14,
                    height: 1.4,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 16),
          // Image/Illustration Placeholder
          Container(
            width: 100,
            height: 100,
            decoration: BoxDecoration(
              color: cardColor, // Background color for the specific illustration
              borderRadius: BorderRadius.circular(12),
              // Simulate the illustration with text or an asset
            ),
            // Placeholder text to represent the illustration
            child: ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: Image.asset(
                'assets/images/social image${index + 10}.png', // <-- Make sure this path is correct
                fit: BoxFit.cover, // Use BoxFit.cover to fill the container
              ),
            ),
          ),
        ],
      ),
    );
  }

  // --- Widget for the main content list ---
  Widget _buildContentList() {
    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(20, 0, 20, 10), // Padding to avoid overlap with bottom nav
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: List.generate(_activities.length, (index) {
          final activity = _activities[index];
          List<Widget> children = [];

          // Check if a new section heading is needed (Financial or Personal)
          if (index == 0 || activity['section'] != _activities[index - 1]['section']) {
            children.add(
              Padding(
                padding: EdgeInsets.only(top: index == 0 ? 0 : 30.0, bottom: 16.0),
                child: Text(
                  activity['section'],
                  style: const TextStyle(
                    color: _primaryTextColor,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            );
          }

          // Add the activity card
          children.add(
            _buildActivityCard(
              title: activity['title'],
              subtitle: activity['subtitle'],
              description: activity['description'],
              cardColor: activity['card_color'],
              index: index,
            ),
          );

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: children,
          );
        }),
      ),
    );
  }

  // --- Widget for the fixed bottom navigation bar ---

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
          'AI Relationship Coach',
          style: TextStyle(
            color: _primaryTextColor,
            fontWeight: FontWeight.w600,
            fontSize: 18,
          ),
        ),
        centerTitle: true,
      ),
      body: _buildContentList(),
      bottomNavigationBar: MainScreen(selectedIndex: 3),);
  }
}