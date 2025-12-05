import 'package:flutter/material.dart';

import '../../nav_page.dart';
import 'CareerInsightsScreen.dart';
import 'SocialConnectionsScreen.dart';

// --- Theme Colors and Constants ---
const Color _kPrimaryGreen = Color(0xFF00C7B3); // Used for the BlockHub name and some accents
const Color _kBackgroundTeal = Color(0xFF008080); // Main background for the top section
const Color _kActionCardColor = Color(0xFFF0F0F0); // Light gray for the quick action cards
const Color _kTextColor = Color(0xFF333333);
const Color _kTealBorderColor = Color(0xFFB2DFDB); // This is Material's Teal 100

class SingleDashboard extends StatefulWidget {
  const SingleDashboard({super.key});

  @override
  State<SingleDashboard> createState() => _BlockHubDashboardState();
}

class _BlockHubDashboardState extends State<SingleDashboard> {
  // --- State Variables (Example for a Stateful Widget) ---
  int _selectedIndex = 0; // For the bottom navigation bar
  bool _isPremiumUser = true; // Example of a state variable that could change UI

  // --- Helper Methods ---
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    // Add navigation logic here (e.g., if (index == 1) Navigator.push(...))
  }

  // --- Main Build Method ---
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      // 1. Top Section - Custom AppBar and User Info
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            _buildHeaderSection(),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'AI Tip',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: _kTextColor,
                    ),
                  ),
                  const SizedBox(height: 10),
                  // 2. AI Tip Card
                  _buildAiTipCard(),
                  const SizedBox(height: 30),
                  // 3. Quick Actions
                  const Text(
                    'Quick Actions',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: _kTextColor,
                    ),
                  ),
                  const SizedBox(height: 15),
                  _buildQuickActionsGrid(),
                ],
              ),
            ),
          ],
        ),
      ),
      // 4. Bottom Navigation Bar
      bottomNavigationBar: MainScreen(selectedIndex: 3), );
  }

  // --- Component Builders ---

  Widget _buildHeaderSection() {
    return Container(
      padding: const EdgeInsets.only(top: 50, bottom: 0),
      // The background color for the user portrait section
      decoration: const BoxDecoration(
        color: _kBackgroundTeal,
      ),
      child: Column(
        children: [
          // BlockHub App Bar
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'BlockHub',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.settings, color: Colors.white),
                  onPressed: () {
                    // Handle settings button press
                  },
                ),
              ],
            ),
          ),
          // Your Financial Hub Text and Portrait
          SizedBox(
            height: 350, // Height to encompass the image and text
            width: double.infinity,
            child: Stack(
              children: [
                // Placeholder for the main illustration

                // Text Overlay
                const Positioned(
                  bottom: 40,
                  left: 20,
                  right: 20,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Your Financial Hub',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 32,
                          fontWeight: FontWeight.w900,
                          shadows: [
                            Shadow(
                              blurRadius: 5.0,
                              color: Colors.black54,
                              offset: Offset(0, 1),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 8),
                      Text(
                        'Manage your savings, budget, and social wallet with ease. Get personalized AI insights for financial and personal growth.',
                        style: TextStyle(
                          color: Colors.white70,
                          fontSize: 16,
                          height: 1.4,
                        ),
                      ),
                    ],
                  ),
                ),
                // Small accent line at the bottom
                Positioned(
                  bottom: 0,
                  left: 20,
                  child: Container(
                    height: 5,
                    width: 60,
                    decoration: BoxDecoration(
                      color: _kPrimaryGreen,
                      borderRadius: BorderRadius.circular(5),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAiTipCard() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Investment Insight',
                style: TextStyle(
                  color: _kPrimaryGreen,
                  fontWeight: FontWeight.w500,
                  fontSize: 14,
                ),
              ),
              const SizedBox(height: 5),
              const Text(
                'Diversify Your Portfolio',
                style: TextStyle(
                  color: _kTextColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                'Consider adding tech stocks to your portfolio for long-term growth. Analyze market trends and consult with a financial advisor.',
                style: TextStyle(
                  color: _kTextColor.withOpacity(0.7),
                  fontSize: 14,
                  height: 1.4,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(width: 15),
        // Placeholder for the AI Tip image
        Container(
          width: 100,
          height: 100,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.2),
                spreadRadius: 2,
                blurRadius: 5,
                offset: const Offset(0, 3),
              ),
            ],
            // A simple placeholder for the image
            image: const DecorationImage(
              image: AssetImage('assets/images/social image3.png'),
              fit: BoxFit.cover,
            ),
          ),
        ),
      ],
    );
  }

  // --- UPDATED: Pass the destination page to each card ---
  Widget _buildQuickActionsGrid() {
    return GridView.count(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(), // To allow main scroll view to handle scrolling
      crossAxisCount: 2,
      childAspectRatio: 2.5, // Adjust for card size (width/height)
      mainAxisSpacing: 15.0,
      crossAxisSpacing: 15.0,
      children: <Widget>[
        _buildActionCard(
          icon: Icons.track_changes,
          title: 'Personal Goals',
          destinationPage: const CareerInsightsScreen(),
        ),
        _buildActionCard(
          icon: Icons.people_alt,
          title: 'Social Wallet',
          destinationPage:  SocialConnectionsScreen(),
        ),
        _buildActionCard(
          icon: Icons.psychology_outlined,
          title: 'AI Recommendations',
          destinationPage: const AiRecommendationsScreen(),
        ),
        // This card can navigate to a "More" screen or do nothing
        _buildActionCard(
          icon: Icons.more_horiz,
          title: 'More',
          destinationPage: null, // Or a MoreScreen()
        ),
      ],
    );
  }

  // --- UPDATED: Accept a destination page and handle navigation ---
  Widget _buildActionCard({
    required IconData icon,
    required String title,
    required Widget? destinationPage,
  }) {
    return Card(
      color: _kActionCardColor,
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
        // This adds the teal border to the card
        side: const BorderSide(color: _kTealBorderColor, width: 1.5),
      ),
      child: InkWell(
        onTap: () {
          // If a destination page is provided, navigate to it.
          if (destinationPage != null) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => destinationPage),
            );
          } else {
            // Otherwise, you can show a snackbar or do nothing.
            print('$title tapped (no destination)');
          }
        },
        borderRadius: BorderRadius.circular(15.0),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Row(
            children: [
              Icon(icon, color: _kTextColor.withOpacity(0.7), size: 24),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  title,
                  style: const TextStyle(
                    color: _kTextColor,
                    fontWeight: FontWeight.w600,
                    fontSize: 15,
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


}

// --- PLACEHOLDER SCREENS ---
// You should move each of these into its own file in a real application.

class PersonalGoalsScreen extends StatelessWidget {
  const PersonalGoalsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Personal Goals')),
      body: const Center(child: Text('Personal Goals Page')),
    );
  }
}


class AiRecommendationsScreen extends StatelessWidget {
  const AiRecommendationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('AI Recommendations')),
      body: const Center(child: Text('AI Recommendations Page')),
    );
  }
}