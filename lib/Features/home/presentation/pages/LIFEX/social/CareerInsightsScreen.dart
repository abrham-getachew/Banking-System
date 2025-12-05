import 'package:flutter/material.dart';

import '../../nav_page.dart';


// --- The main screen widget (Stateful to handle BottomNavigationBar) ---
class CareerInsightsScreen extends StatefulWidget {
  const CareerInsightsScreen({super.key});

  @override
  State<CareerInsightsScreen> createState() => _CareerInsightsScreenState();
}

class _CareerInsightsScreenState extends State<CareerInsightsScreen> {
  // State for the bottom navigation bar
  int _selectedIndex = 3; // 'LifeX' tab is the 4th item (index 3)

  // Custom colors derived from the image
  static const Color _primaryTextColor = Color(0xFF333333);
  static const Color _secondaryTextColor = Color(0xFF6A6A6A);
  static const Color _accentColor = Color(0xFF26B0AB);
  static const Color _scaffoldBackgroundColor = Colors.white;

  // Data structure for the custom cards
  // UPDATED: Changed 'image_text' to 'image_path'
  final List<Map<String, String>> _insights = [
    {
      'title': 'Networking',
      'subtitle': 'Connect with Industry Leaders',
      'description':
      'AI-powered suggestions for networking events and professionals in your field.',
      'image_path': 'assets/images/social image4.png', // <-- New asset path
    },
    {
      'title': 'Side Hustles',
      'subtitle': 'Explore Side Hustle Opportunities',
      'description':
      'Discover side hustles aligned with your skills and career goals, with AI-driven recommendations.',
      'image_path': 'assets/images/social image5.png', // <-- New asset path
    },
    {
      'title': 'Education',
      'subtitle': 'Save for Professional Development',
      'description':
      'Set up micro-savings plans to fund courses, workshops, and certifications.',
      'image_path': 'assets/images/social image6.png', // <-- New asset path
    },
    {
      'title': 'Equipment',
      'subtitle': 'Invest in Career Tools',
      'description':
      'Create savings goals for essential tools and equipment to enhance your professional capabilities.',
      'image_path': 'assets/images/social image7.png', // <-- New asset path
    },
  ];

  // --- Reusable Widget for a single content card ---
  // UPDATED: Accepts 'imagePath' instead of 'imageText'
  Widget _buildInsightCard({
    required String title,
    required String subtitle,
    required String description,
    required String imagePath,
    required Color cardColor,
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
                  style: const TextStyle(
                    color: _secondaryTextColor,
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
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
          // Image/Illustration Container
          Container(
            width: 100,
            height: 100,
            decoration: BoxDecoration(
              color: cardColor, // A light, neutral background for the image
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.shade200,
                  blurRadius: 5,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            // UPDATED: Replaced placeholder text with an Image asset
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.asset(
                imagePath,
                fit: BoxFit.cover, // Ensures the image fills the container
              ),
            ),
          ),
        ],
      ),
    );
  }

  // --- Widget for the main content list ---
  Widget _buildContentList() {
    // The image uses two different background colors for the illustration cards
    const Color cardColor1 = Color(0xFFEFEBE7); // Light beige/off-white
    const Color cardColor2 = Color(0xFFF0F0F0); // Very light grey

    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(20, 0, 20, 100), // Add bottom padding for the FAB
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // AI Career Mentor Section
          const Text(
            'AI Career Mentor',
            style: TextStyle(
              color: _primaryTextColor,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          // Networking Card
          _buildInsightCard(
            title: _insights[0]['title']!,
            subtitle: _insights[0]['subtitle']!,
            description: _insights[0]['description']!,
            imagePath: _insights[0]['image_path']!, // UPDATED
            cardColor: cardColor1,
          ),
          // Side Hustles Card
          _buildInsightCard(
            title: _insights[1]['title']!,
            subtitle: _insights[1]['subtitle']!,
            description: _insights[1]['description']!,
            imagePath: _insights[1]['image_path']!, // UPDATED
            cardColor: cardColor2,
          ),

          const SizedBox(height: 30),
          // Micro-Savings for Career Goals Section
          const Text(
            'Micro-Savings for Career Goals',
            style: TextStyle(
              color: _primaryTextColor,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          // Education Card
          _buildInsightCard(
            title: _insights[2]['title']!,
            subtitle: _insights[2]['subtitle']!,
            description: _insights[2]['description']!,
            imagePath: _insights[2]['image_path']!, // UPDATED
            cardColor: cardColor2,
          ),
          // Equipment Card
          _buildInsightCard(
            title: _insights[3]['title']!,
            subtitle: _insights[3]['subtitle']!,
            description: _insights[3]['description']!,
            imagePath: _insights[3]['image_path']!, // UPDATED
            cardColor: cardColor1,
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 10.0), // Lifted slightly above the NavBar
            child: SizedBox(
              width: MediaQuery.of(context).size.width * 0.9, // Nearly full width
              child: ElevatedButton(
                onPressed: () {
                  print('Optimize Career Plan pressed!');
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: _accentColor,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 18),
                  elevation: 5,
                  shadowColor: _accentColor.withOpacity(0.5),
                ),
                child: const Text(
                  'Optimize Career Plan',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          )
        ],
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
          'Career & Networking Insights',
          style: TextStyle(
            color: _primaryTextColor,
            fontWeight: FontWeight.w600,
            fontSize: 18,
          ),
        ),
        centerTitle: true,
      ),
      body: _buildContentList(),

      // --- Fixed 'Optimize Career Plan' Button (FAB-like placement) ---

      // --- Fixed Bottom Navigation Bar ---
      bottomNavigationBar: MainScreen(selectedIndex: 3), );
  }
}