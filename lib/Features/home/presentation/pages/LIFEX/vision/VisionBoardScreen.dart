import 'package:flutter/material.dart';

import '../../nav_page.dart';

// --- Colors and Styles (Approximating the design) ---
const Color kPrimaryColor = Color(0xFF133F53); // Deep Teal/Blue
const Color kBackgroundColor = Color(0xFFFFFFFF);
const Color kAccentColor = Color(0xFF5563FF); // Bright Blue for the "Add Dream" button
const Color kDarkGrey = Color(0xFF5A5A5A);

class VisionBoardScreen extends StatefulWidget {
  const VisionBoardScreen({super.key});

  @override
  State<VisionBoardScreen> createState() => _VisionBoardScreenState();
}

class _VisionBoardScreenState extends State<VisionBoardScreen> {
  // --- Mock State for Demonstration ---
  String _dreamStatus = 'Not Started'; // Tracks the status of the main goal

  // --- Widget Builders ---

  // Build the main header image, text, and button section
  Widget _buildHeader() {
    return Container(
      height: 400,
      color: Colors.black, // Background color for the image area
      child: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          // Placeholder for the main image (Vision board on the wall)
          Opacity(
            opacity: 0.8,
            child: Image.asset(
              'assets/images/vision image8.png', // **REPLACE with your actual asset path**
              fit: BoxFit.cover,
              width: double.infinity,
              height: double.infinity,
            ),
          ),
          // Gradient Overlay to create a slight dark fade towards the top/bottom
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Colors.transparent, Colors.black45, Colors.transparent],
                stops: [0.0, 0.4, 0.8],
              ),
            ),
          ),
          // Text and Button Content
          Positioned(
            bottom: 60,
            child: Column(
              children: [
                const Text(
                  'Life Goals',
                  style: TextStyle(
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    shadows: [
                      Shadow(blurRadius: 10, color: Colors.black54),
                    ],
                  ),
                ),
                const SizedBox(height: 5),
                const Text(
                  'Visualize your dreams and track your progress towards',
                  style: TextStyle(fontSize: 14, color: Colors.white70),
                ),
                const Text(
                  'achieving them.',
                  style: TextStyle(fontSize: 14, color: Colors.white70),
                ),
                const SizedBox(height: 20),
                // "Add Dream" Button
                ElevatedButton(
                  onPressed: () {
                    // Action: Add a new dream
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: kAccentColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 40, vertical: 15),
                    elevation: 5,
                  ),
                  child: const Text(
                    'Add Dream',
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

  // Custom widget for the Interactive Vision Board cards
  Widget _buildVisionBoardItem({
    required String title,
    required String assetPath,
  }) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: Container(
        decoration: BoxDecoration(
          color: kBackgroundColor,
          borderRadius: BorderRadius.circular(15),
        ),
        child: Column(
          children: [
            Expanded(
              child: ClipRRect(
                borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(15)),
                child: Image.asset(
                  assetPath, // **REPLACE with your actual asset path**
                  fit: BoxFit.cover,
                  width: double.infinity,
                  // The images in the design have a specific aesthetic (faded, framed look)
                  // We'll use a placeholder for structure.
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10.0),
              child: Text(
                title,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: kDarkGrey,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Build the Progress Tracker section
  Widget _buildProgressTracker() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Progress Tracker',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Color(0xFF1E1E1E),
            ),
          ),
          const SizedBox(height: 15),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Dream Status',
                style: TextStyle(fontSize: 16, color: kDarkGrey),
              ),
              // State-dependent status text
              Text(
                _dreamStatus,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.redAccent, // Red for 'Not Started'
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // Build the AI Suggestion section
  // Build the AI Suggestion section (Now as a Card)
  Widget _buildAISuggestion() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
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
                      'AI Suggestion',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: kPrimaryColor,
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      'Based on your goals, you should save \$200 monthly to achieve your "Travel" dream in 2 years.',
                      style: TextStyle(
                        fontSize: 16,
                        color: kDarkGrey,
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

  // Build the bottom navigation bar (reused from previous examples)



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundColor,
      // App Bar
      appBar: AppBar(
        backgroundColor: Colors.transparent, // Transparent to show header background
        elevation: 0,
        leading: const Icon(Icons.arrow_back, color: Colors.white),
        title: const Text(
          'Vision Board',
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

            // --- Interactive Vision Board Section ---
            const Padding(
              // UPDATED: Reduced bottom padding from 15.0 to 10.0
              padding: EdgeInsets.fromLTRB(16.0, 25.0, 16.0, 10.0),
              child: Text(
                'Interactive Vision Board',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF1E1E1E),
                ),
              ),
            ),

            // 2. Vision Board Grid
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: GridView.count(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                crossAxisCount: 2,
                crossAxisSpacing: 15.0,
                mainAxisSpacing: 15.0,
                childAspectRatio: 0.9, // Adjust aspect ratio to fit the vertical cards
                children: [
                  _buildVisionBoardItem(
                      title: 'Travel', assetPath: 'assets/images/vision image9.png'),
                  _buildVisionBoardItem(
                      title: 'Career', assetPath: 'assets/images/vision image10.png'),
                  _buildVisionBoardItem(
                      title: 'Home', assetPath: 'assets/images/vision image12.png'),
                  _buildVisionBoardItem(
                      title: 'education', assetPath: 'assets/images/vision image11.png'),
                  _buildVisionBoardItem(
                      title: 'Family', assetPath: 'assets/images/vision image13.png'),
                  // Add an empty space/placeholder for the odd number of cards
                  const SizedBox(),
                ],
              ),
            ),

            const SizedBox(height: 30),

            // 3. Progress Tracker
            _buildProgressTracker(),

            const SizedBox(height: 30),

            // 4. AI Suggestion
            _buildAISuggestion(),

            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}

// Custom widget for Bottom Navigation Bar Items (Reused)
class BottomNavItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool isSelected;

  const BottomNavItem({
    required this.icon,
    required this.label,
    this.isSelected = false,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    // Reusing the standard nav item look from previous examples
    const Color kInactiveColor = Color(0xFF888888);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            color: isSelected ? kPrimaryColor : kInactiveColor,
            size: 24,
          ),
          Text(
            label,
            style: TextStyle(
              fontSize: 10,
              color: isSelected ? kPrimaryColor : kInactiveColor,
              fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
            ),
          ),
        ],
      ),
    );
  }
}

// --- MAIN FUNCTION TO RUN THE APP (optional, for testing) ---
/*
void main() {
  // Remember to add placeholder assets if using Image.asset
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: VisionBoardScreen(),
    );
  }
}
*/