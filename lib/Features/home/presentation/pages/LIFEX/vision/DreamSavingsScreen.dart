import 'package:flutter/material.dart';

import '../../nav_page.dart';

// --- Colors and Styles (Approximating the design) ---
const Color kPrimaryColor = Color(0xFF133F53); // Deep Teal/Blue
const Color kBackgroundColor = Color(0xFFFFFFFF);
const Color kAccentColor = Color(0xFF007BFF); // Bright Blue for the button
const Color kProgressColor = Color(0xFF4ECDC4); // Light Teal for the progress bar
const Color kDarkText = Color(0xFF333333);
const Color kLightText = Color(0xFF777777);

class DreamSavingsScreen extends StatefulWidget {
  const DreamSavingsScreen({super.key});

  @override
  State<DreamSavingsScreen> createState() => _DreamSavingsScreenState();
}

class _DreamSavingsScreenState extends State<DreamSavingsScreen> {
  // --- Mock State for Demonstration ---
  bool _isAutoSaveEnabled = true; // State for the toggle switch
  double _dreamProgress = 0.6; // State for the goal progress (60% funded)

  // --- Widget Builders ---

  // Build the main header image, text, and button section
  Widget _buildHeader() {
    return Container(
      height: 350,
      color: Colors.black, // Background color for the image area
      child: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          // Placeholder for the main image (Jar of coins)
          Opacity(
            opacity: 0.8,
            child: Image.asset(
              'assets/images/vision image14.png', // **REPLACE with your actual asset path**
              fit: BoxFit.cover,
              width: double.infinity,
              height: double.infinity,
            ),
          ),
          // Dark Gradient Overlay for text contrast
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Colors.transparent, Colors.black87],
                stops: [0.3, 1.0],
              ),
            ),
          ),
          // Text and Button Content
          Positioned(
            bottom: 60,
            child: Column(
              children: [
                const Text(
                  'Vision Life',
                  style: TextStyle(
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 5),
                const Text(
                  'Dream Savings Accounts',
                  style: TextStyle(fontSize: 16, color: Colors.white70),
                ),
                const SizedBox(height: 20),
                // "Boost Savings" Button
                ElevatedButton(
                  onPressed: () {
                    // Action: Open savings boost flow
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: kAccentColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 40, vertical: 15),
                    elevation: 5,
                  ),
                  child: const Text(
                    'Boost Savings',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // --- UPDATED: Custom widget for Dream Categories to remove all extra space ---
  Widget _buildDreamCategoryCard({
    required String title,
    required String assetPath,
  }) {
    // The Card widget has been removed. We now use a Container with decoration
    // to have full control over spacing and appearance, eliminating default margins.
    return Container(
      decoration: BoxDecoration(
        color: kBackgroundColor,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      // ClipRRect ensures the image inside respects the container's rounded corners.
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: Image.asset(
                assetPath,
                fit: BoxFit.cover,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10.0),
              child: Text(
                title,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: kDarkText,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }


  // Build the Dynamic Goal Tracker section
  Widget _buildGoalTracker() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Dynamic Goal Tracker',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: kDarkText,
            ),
          ),
          const SizedBox(height: 15),
          // Goal Progress Bar
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Dream House',
                style: TextStyle(fontSize: 16, color: kDarkText),
              ),
              Text(
                '${(_dreamProgress * 100).toInt()}%', // Display percentage
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: kDarkText,
                ),
              ),
            ],
          ),
          const SizedBox(height: 5),
          // Mock progress bar (actual bar needs to be wide)
          LinearProgressIndicator(
            value: _dreamProgress,
            backgroundColor: const Color(0xFFE0E0E0),
            valueColor: const AlwaysStoppedAnimation<Color>(kProgressColor),
            minHeight: 8,
            borderRadius: BorderRadius.circular(4),
          ),
          const SizedBox(height: 5),
          const Align(
            alignment: Alignment.centerRight,
            child: Text(
              '6000', // Mock remaining amount
              style: TextStyle(fontSize: 14, color: kLightText),
            ),
          ),
          const SizedBox(height: 20),

          // Auto-save Toggle
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text(
                    'Auto-save',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: kDarkText,
                    ),
                  ),
                  Text(
                    'Round-up from spending',
                    style: TextStyle(fontSize: 14, color: kLightText),
                  ),
                ],
              ),
              Switch(
                value: _isAutoSaveEnabled,
                onChanged: (value) {
                  setState(() {
                    _isAutoSaveEnabled = value;
                  });
                },
                activeColor: kProgressColor,
                inactiveThumbColor: const Color(0xFFCCCCCC),
                inactiveTrackColor: const Color(0xFFEEEEEE),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // Build the AI Projection section (Now as a Card)
  Widget _buildAIProjection() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      // Wrap the content in a Card for better visual separation
      child: Card(
        elevation: 2,
        color: const Color(0xFFF0F5F7), // A light, cool grey background
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
          side: BorderSide(color: Colors.grey.shade300), // Subtle border
        ),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Add an icon for visual interest
              const Icon(Icons.lightbulb_outline, color: kPrimaryColor, size: 32),
              const SizedBox(width: 15),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'AI Projection',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: kPrimaryColor,
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      'At this rate, you\'ll achieve your dream house in 3 years.',
                      style: TextStyle(
                        fontSize: 16,
                        color: kDarkText,
                        height: 1.4, // Improve line spacing for readability
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundColor,
      // App Bar
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: const Icon(Icons.arrow_back, color: Colors.white),
        title: const Text(
          'Dream Savings Accounts',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.normal),
        ),
        centerTitle: true,
      ),
      // Extend body behind the app bar for the large header image
      extendBodyBehindAppBar: true,

      // Bottom Navigation Bar
      bottomNavigationBar: MainScreen(selectedIndex: 3),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            // 1. Header Image/Text/Button
            _buildHeader(),

            // --- Dream Categories Section ---
            const Padding(
              // This padding now correctly controls the space above the grid.
              padding: EdgeInsets.fromLTRB(16.0, 25.0, 16.0, 15.0),
              child: Text(
                'Dream Categories',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: kDarkText,
                ),
              ),
            ),

            // 2. Categories Grid
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: GridView.count(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                crossAxisCount: 2,
                crossAxisSpacing: 15.0,
                mainAxisSpacing: 15.0, // This now correctly adds space between rows if they wrap
                childAspectRatio: 0.9, // Match the card shape
                children: [
                  _buildDreamCategoryCard(
                      title: 'House', assetPath: 'assets/images/vision image15.png'),
                  _buildDreamCategoryCard(
                      title: 'Car', assetPath: 'assets/images/vision image16.png'),
                  _buildDreamCategoryCard(
                      title: 'Travel', assetPath: 'assets/images/vision image17.png'),
                  _buildDreamCategoryCard(
                      title: 'Business Startup', assetPath: 'assets/images/vision image18.png'),
                ],
              ),
            ),

            const SizedBox(height: 30),

            // 3. Dynamic Goal Tracker
            _buildGoalTracker(),

            const SizedBox(height: 30),

            // 4. AI Projection
            _buildAIProjection(),

            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}