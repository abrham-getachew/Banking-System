import 'package:flutter/material.dart';

// --- Colors and Styles (Approximating the design) ---
const Color kPrimaryColor = Color(0xFF133F53); // Deep Teal/Blue
const Color kBackgroundColor = Color(0xFFF8F8F8); // Very light grey/off-white background
const Color kHeaderColor = Color(0xFF1C1C1C); // Dark header background
const Color kAccentColor = Color(0xFF4ECDC4); // Teal accent color
const Color kBoostColor = Color(0xFF00C853); // Green for positive progress indicators
const Color kCardColor = Color(0xFFFFFFFF);
const Color kDarkText = Color(0xFF333333);
const Color kLightText = Color(0xFF777777);
// ADDED: Teal border color for consistency
const Color tealBorderColor = Color(0xFF4DD0E1);

class VisionProgressReportScreen extends StatefulWidget {
  const VisionProgressReportScreen({super.key});

  @override
  State<VisionProgressReportScreen> createState() =>
      _VisionProgressReportScreenState();
}

class _VisionProgressReportScreenState
    extends State<VisionProgressReportScreen> {
  // --- Mock State for Demonstration (Goal data) ---
  int _goalsInProgress = 75;
  double _totalSaved = 12500.0;
  String _nextMilestone = 'Complete 25% of Dream 1';

  // --- Widget Builders ---

  // Build the dramatic header section with the animated ring
  // Build the dramatic header section with the animated ring
  Widget _buildHeader() {
    return Container(
      height: 350,
      color: kHeaderColor,
      child: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          // The SizedBox has been removed to allow the image to fill the space.
          Opacity(
            opacity: 0.6,
            child: Image.asset(
              // UPDATED ASSET
              'assets/images/vision image24.png',
              // UPDATED: Make the image cover the full width and height of the container.
              fit: BoxFit.cover,
              width: double.infinity,
              height: double.infinity,
            ),
          ),
          // Text and Button Content
          Positioned(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'Vision Progress',
                  style: TextStyle(
                    fontSize: 34,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 5),
                const Text(
                  'Track your progress towards your goals and dreams.',
                  style: TextStyle(fontSize: 14, color: Colors.white70),
                ),
                const SizedBox(height: 25),
                // "View Details" Button
                ElevatedButton(
                  onPressed: () {
                    // Action: Navigate to detail view
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
                    'View Details',
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

  // Custom widget for the statistic cards
  Widget _buildStatCard({
    required String title,
    required String value,
    required String percentageChange,
    required bool isPositive,
  }) {
    
    return Card(
      elevation: 2,
      // UPDATED: Added border to the card shape
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
        side: const BorderSide(color: tealBorderColor, width: 1.5),
      ),
      child: Container(
        width: MediaQuery.of(context).size.width / 2 - 28, // Half screen minus padding
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: const TextStyle(fontSize: 14, color: kLightText),
            ),
            const SizedBox(height: 5),
            Text(
              value,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: kDarkText,
              ),
            ),
            const SizedBox(height: 5),
            Text(
              percentageChange,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: isPositive ? kBoostColor : Colors.redAccent,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Build the "Export Progress Report" list tile
  Widget _buildExportReportTile() {
    return Card(
      elevation: 2,
      // UPDATED: Added border to the card shape
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
        side: const BorderSide(color: tealBorderColor, width: 1.5),
      ),
      child: ListTile(
        contentPadding:
        const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        leading: const Icon(Icons.drive_folder_upload_outlined,
            color: kPrimaryColor, size: 30),
        title: const Text(
          'Export Progress Report',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: kDarkText,
          ),
        ),
        trailing: const Icon(Icons.arrow_forward_ios,
            color: kLightText, size: 16),
        subtitle: const Text(
          'Share your vision progress with your mentor or \nfamily to stay motivated and accountable.',
          style: TextStyle(fontSize: 12, color: kLightText),
        ),
        onTap: () {
          // Action: Initiate export flow
        },
      ),
    );
  }

  // Build the AI Motivation section
  Widget _buildAIMotivation() {
    return Padding(
      padding: const EdgeInsets.only(top: 10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0),
            child: Text(
              'AI Motivation',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: kDarkText,
              ),
            ),
          ),
          const SizedBox(height: 15),
          // AI Motivation Image Card
          Card(
            margin: const EdgeInsets.symmetric(horizontal: 16.0),
            elevation: 2,
            // UPDATED: Added border to the card shape
            shape:
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
              side: const BorderSide(color: tealBorderColor, width: 1.5),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: AspectRatio(
                aspectRatio: 1.0, // Make the card square
                child: Image.asset(
                  // UPDATED ASSET
                  'assets/images/vision image25.png',
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Build the bottom navigation bar (reused)
  Widget _buildBottomNavBar() {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(top: BorderSide(color: Color(0xFFE0E0E0), width: 1)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: const [
          BottomNavItem(icon: Icons.home, label: 'Home', isSelected: true),
          BottomNavItem(icon: Icons.smart_toy, label: 'AI'),
          BottomNavItem(icon: Icons.qr_code_2_sharp, label: 'BlockHub'),
          BottomNavItem(icon: Icons.favorite_border, label: 'LifeX'),
          BottomNavItem(icon: Icons.more_horiz, label: 'More'),
        ],
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
          'Vision Progress Report',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.normal),
        ),
        centerTitle: true,
      ),
      // Extend body behind the app bar for the large header image
      extendBodyBehindAppBar: true,

      // Bottom Navigation Bar
      bottomNavigationBar: _buildBottomNavBar(),

      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            // 1. Header Image/Text/Button
            _buildHeader(),

            // --- Stats Cards Section ---
            Padding(
              padding: const EdgeInsets.fromLTRB(16.0, 30.0, 16.0, 20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Goals in Progress Card
                  _buildStatCard(
                    title: 'Goals in\nProgress',
                    value: '$_goalsInProgress%',
                    percentageChange: '+10%',
                    isPositive: true,
                  ),
                  // Total Saved Card
                  _buildStatCard(
                    title: 'Total Saved',
                    value: '\$${_totalSaved.toInt().toStringAsFixed(0)}',
                    percentageChange: '+5%',
                    isPositive: true,
                  ),
                ],
              ),
            ),

            // Next Milestone Card
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Card(
                elevation: 2,
                // UPDATED: Added border to the card shape
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                  side: const BorderSide(color: tealBorderColor, width: 1.5),
                ),
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Next Milestone',
                        style: TextStyle(fontSize: 14, color: kLightText),
                      ),
                      const SizedBox(height: 5),
                      Text(
                        _nextMilestone,
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: kDarkText,
                        ),
                      ),
                      const SizedBox(height: 5),
                      const Text(
                        '+15%',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: kBoostColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            const SizedBox(height: 20),

            // 2. Export Progress Report Tile
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: _buildExportReportTile(),
            ),

            const SizedBox(height: 30),

            // 3. AI Motivation Section
            _buildAIMotivation(),

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