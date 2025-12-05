import 'package:flutter/material.dart';

import '../../nav_page.dart';
import 'JointPlanningScreen.dart';
import 'RelationshipCoachScreen.dart';

// --- Theme Colors and Constants ---
const Color _kPrimaryColor = Color(0xFF13A08D); // A guess for the main accent color
const Color _kSubtitleColor = Color(0xFF666666);
const Color _kFeatureIconColor = Color(0xFF333333);
const Color _kAITipBackgroundColor = Color(0xFFB8860B); // Dark yellow/gold for the AI Tip
const Color _kIllustrationBackgroundColor = Color(0xFFEEDDCC); // Light peach/pink background

class CouplesDashboardScreen extends StatefulWidget {
  const CouplesDashboardScreen({super.key});

  @override
  State<CouplesDashboardScreen> createState() => _CouplesDashboardScreenState();
}

class _CouplesDashboardScreenState extends State<CouplesDashboardScreen> {
  // --- State Variables (Example for a Stateful Widget) ---
  int _selectedIndex = 0; // For the bottom navigation bar
  bool _isJointAccountActive = true; // Example of managing feature state
  String _currentAiTip = 'save 15% on your monthly expense by optimizing your shared budget';

  // --- Helper Methods ---
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    // In a real app, this would handle navigation to different tabs
  }

  // --- Main Build Method ---
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      // 1. App Bar
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: const BackButton(color: Colors.black),
        title: const Text(
          'Couples Dashboard',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.w500),
        ),
        centerTitle: false,
      ),
      // 2. Body Content
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            // Illustration and Shared Finances Header
            _buildHeaderSection(context),
            const SizedBox(height: 30),
            // Key Features Section
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Key Features',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF333333),
                    ),
                  ),
                  const SizedBox(height: 15),
                  // --- UPDATED: Passing destination pages to each feature item ---
                  _buildFeatureItem(
                    icon: Icons.attach_money,
                    title: 'Joint Savings & Budgeting',
                    subtitle: 'Track shared expenses and manage your joint budget effectively.',
                    destinationPage: const JointPlanningScreen(),
                  ),
                  _buildFeatureItem(
                    icon: Icons.flag_outlined,
                    title: 'Shared Goals',
                    subtitle: 'Set and achieve common financial goals, like travel or a big purchase.',
                    destinationPage: const RelationshipCoachScreen(),
                  ),
                  _buildFeatureItem(
                    icon: Icons.auto_fix_high,
                    title: 'AI-Powered Suggestions',
                    subtitle: 'Get personalized financial suggestions to improve your relationship\'s financial health.',
                    destinationPage: const AiSuggestionsScreen(),
                  ),
                  const SizedBox(height: 30),
                  // AI Tip Section
                  const Text(
                    'AI Tip',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF333333),
                    ),
                  ),
                  const SizedBox(height: 15),
                  _buildAiTipCard(),
                  const SizedBox(height: 20), // Extra space for scrolling
                ],
              ),
            ),
          ],
        ),
      ),
      // 3. Bottom Navigation Bar
      bottomNavigationBar: MainScreen(selectedIndex: 3), );
  }

  // --- Component Builders ---

  Widget _buildHeaderSection(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Container(
              width: MediaQuery.of(context).size.width * 0.75, // Adjust width for the centered card
              height: 250, // Height of the illustration card
              decoration: BoxDecoration(
                color: _kIllustrationBackgroundColor,
                borderRadius: BorderRadius.circular(15),
                // Simple box shadow to match the slightly lifted look
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.3),
                    spreadRadius: 2,
                    blurRadius: 7,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              // --- UPDATED: Replaced placeholder text with an Image asset ---
              child: ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: Image.asset(
                  'assets/images/social image9.png', // <-- Make sure this path is correct
                  fit: BoxFit.cover, // Use BoxFit.cover to fill the container
                ),
              ),
            ),
          ),
          const SizedBox(height: 20),
          // Shared Finances Text
          const Text(
            'Shared Finances',
            style: TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.w900,
              color: Color(0xFF333333),
            ),
          ),
          const SizedBox(height: 8),
          // Subtitle Description
          const Text(
            'Manage your joint finances with ease. Track shared expenses, set goals, and get AI-powered insights to strengthen your financial bond.',
            style: TextStyle(
              color: _kSubtitleColor,
              fontSize: 16,
              height: 1.4,
            ),
          ),
          const SizedBox(height: 15),
          // Accent line (similar to the image)
          Container(
            height: 4,
            width: 80,
            decoration: BoxDecoration(
              color: _kPrimaryColor,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
        ],
      ),
    );
  }
  // --- UPDATED: Added destinationPage parameter and InkWell for navigation ---
  Widget _buildFeatureItem({
    required IconData icon,
    required String title,
    required String subtitle,
    required Widget destinationPage,
  }) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => destinationPage),
        );
      },
      borderRadius: BorderRadius.circular(8), // For a nice ripple effect
      child: Padding(
        padding: const EdgeInsets.only(bottom: 20.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Icon
            Container(
              padding: const EdgeInsets.all(5),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey.shade300),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(icon, color: _kFeatureIconColor, size: 24),
            ),
            const SizedBox(width: 15),
            // Text Content
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      color: Color(0xFF333333),
                      fontWeight: FontWeight.w600,
                      fontSize: 17,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    subtitle,
                    style: const TextStyle(
                      color: _kSubtitleColor,
                      fontSize: 14,
                      height: 1.3,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAiTipCard() {
    return Container(
      height: 180,
      width: double.infinity,
      decoration: BoxDecoration(
        color: _kAITipBackgroundColor,
        borderRadius: BorderRadius.circular(15),
        // Use a gradient to mimic the golden/brown color with shading
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            _kAITipBackgroundColor.withOpacity(0.8),
            _kAITipBackgroundColor,
            _kAITipBackgroundColor.withOpacity(0.9),
          ],
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              // Using the state variable here
              _currentAiTip,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 22,
                fontWeight: FontWeight.w700,
                height: 1.3,
                shadows: [
                  Shadow(
                    blurRadius: 2.0,
                    color: Colors.black38,
                    offset: Offset(0, 1),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// --- PLACEHOLDER SCREENS ---
// In a real application, you would move each of these to its own file.




class AiSuggestionsScreen extends StatelessWidget {
  const AiSuggestionsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('AI-Powered Suggestions')),
      body: const Center(child: Text('AI-Powered Suggestions Page')),
    );
  }
}