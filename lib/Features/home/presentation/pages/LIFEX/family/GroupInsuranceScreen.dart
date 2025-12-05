import 'package:flutter/material.dart';

import '../../nav_page.dart';


// --- GroupInsuranceScreen Widget (Stateful) ---
class GroupInsuranceScreen extends StatefulWidget {
  const GroupInsuranceScreen({super.key});

  @override
  State<GroupInsuranceScreen> createState() => _GroupInsuranceScreenState();
}

class _GroupInsuranceScreenState extends State<GroupInsuranceScreen> {
  // State for Bottom Navigation Bar
  // Assuming 'LifeX' is the selected tab initially (index 3)
  int _selectedIndex = 3;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  // Define custom colors based on the screenshot
  static const Color backgroundColor = Color(0xFFFBF1EC); // Light beige/pink for the header
  static const Color tealColor = Color(0xFF00BFA5); // Primary accent color (used for button and some text)
  static const Color darkTextColor = Color(0xFF333333); // Dark text color

  // Helper widget for the visual card components in "Plan Types"
  Widget _buildPlanCard(String title, String subtitle, String imagePath) {
    return Card(
      elevation: 0, // No shadow needed for this clean look
      color: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Image Placeholder (The images are square cards)
          Container(
            height: 120, // Square image area
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
              color: Colors.grey[100], // Light grey background for the image
            ),
            // Placeholder image for the card
            child: ClipRRect(
              borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
              child: Image.asset(
                imagePath, // Use an asset path
                fit: BoxFit.cover,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: darkTextColor,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  subtitle,
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey[700],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Helper widget for the rows in "Comparison Table"
  Widget _buildComparisonRow(String groupTitle, String groupValue,
      String individualTitle, String individualValue) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Group Column (Left)
          Expanded(
            flex: 2,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  groupTitle,
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey[600],
                  ),
                ),
                Text(
                  groupValue,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: darkTextColor,
                  ),
                ),
              ],
            ),
          ),
          // Individual Column (Right)
          Expanded(
            flex: 2,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  individualTitle,
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey[600],
                  ),
                ),
                Text(
                  individualValue,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.grey[400], // Faded color for less emphasis
                  ),
                ),
              ],
            ),
          ),
        ],
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
          'Group Insurance Plans',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),

      // --- Body (Scrollable Content) ---
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            // **1. Header/Hero Section**
            Container(
              width: double.infinity,
              padding: const EdgeInsets.fromLTRB(24, 16, 24, 40),
              // Use the beige/pink color from the top section
              color: backgroundColor,
              child: Stack(
                children: [
                  // Placeholder for the Shield/Family image (slightly transparent/faded)
                  Align(
                    alignment: Alignment.topCenter,
                    child: Opacity(
                      opacity: 0.4,
                      // UPDATED: Replaced Image.network with Image.asset
                      child: Image.asset(
                        'assets/images/family image11.png', // Placeholder path for shield/family
                        height: 180,
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 100), // Space for the graphic above text
                      const Text(
                        'Protecting Your\nFamily\'s Future',
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          color: darkTextColor,
                          height: 1.2,
                        ),
                      ),
                      const SizedBox(height: 12),
                      Text(
                        'Explore comprehensive group insurance plans tailored for families, offering better coverage and savings compared to individual policies.',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey[700],
                          height: 1.4,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 32),

            // **2. Plan Types Section**
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Plan Types',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: darkTextColor,
                    ),
                  ),
                  const SizedBox(height: 16),
                  // Grid View for 4 cards (2x2 layout)
                  GridView.count(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    crossAxisCount: 2,
                    crossAxisSpacing: 16.0,
                    mainAxisSpacing: 16.0,
                    childAspectRatio: 0.7, // Adjust to make cards tall enough
                    children: <Widget>[
                      // UPDATED: Replaced URLs with asset paths
                      _buildPlanCard(
                        'Health Insurance',
                        'Comprehensive medical coverage for your entire family.',
                        'assets/images/family image12.png',
                      ),
                      _buildPlanCard(
                        'Life Insurance',
                        'Financial security for your loved ones in unforeseen circumstances.',
                        'assets/images/family image13.png',
                      ),
                      _buildPlanCard(
                        'Property Insurance',
                        'Protect your home and belongings from damage or loss.',
                        'assets/images/family image15.png',
                      ),
                      _buildPlanCard(
                        'Education Insurance',
                        'Secure your child\'s future with dedicated education funds.',
                        'assets/images/family image14.png',
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 40),

            // **3. Comparison Table Section**
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Comparison Table',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: darkTextColor,
                    ),
                  ),
                  const SizedBox(height: 16),
                  // Rows for comparison
                  _buildComparisonRow(
                    'Family Premium',
                    '\$600/month',
                    'Individual Cost',
                    '\$700/month',
                  ),
                  const Divider(color: Colors.grey, height: 1),
                  _buildComparisonRow(
                    'Coverage',
                    'All family members',
                    'Benefits',
                    'Extended benefits',
                  ),
                  const Divider(color: Colors.grey, height: 1),
                  _buildComparisonRow(
                    'Flexibility',
                    'Moderate',
                    'Customization',
                    'Limited',
                  ),
                  const Divider(color: Colors.grey, height: 1),
                ],
              ),
            ),
            const SizedBox(height: 40),

            // **4. AI Recommender Section**
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'AI Recommender',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: darkTextColor,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    'Based on your family profile, this group insurance plan can save you approximately \$200 per year compared to individual policies, while offering broader coverage and additional benefits.',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey[700],
                      height: 1.4,
                    ),
                  ),
                  const SizedBox(height: 32),
                ],
              ),
            ),

            // **5. Call to Action Button**
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: ElevatedButton(
                onPressed: () {
                  // Handle button press
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: tealColor, // The bright teal accent color
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  elevation: 0,
                ),
                child: const Text(
                  'Get Covered',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 40), // Space before bottom nav bar
          ],
        ),
      ),

      // --- Bottom Navigation Bar ---
      bottomNavigationBar: MainScreen(selectedIndex: 3), );
  }
}