import 'package:flutter/material.dart';

import '../../nav_page.dart';
import 'CampaignDashboardScreen.dart';
import 'CreateCampaignScreen.dart';


// --- The main screen widget (Stateful to handle BottomNavigationBar and campaign interaction) ---
class CrowdfundingScreen extends StatefulWidget {
  const CrowdfundingScreen({super.key});

  @override
  State<CrowdfundingScreen> createState() => _CrowdfundingScreenState();
}

class _CrowdfundingScreenState extends State<CrowdfundingScreen> {
  // State for the bottom navigation bar
  int _selectedIndex = 3; // 'LifeX' tab is the 4th item (index 3)

  // Custom colors derived from the image
  static const Color _primaryTextColor = Color(0xFF333333);
  static const Color _secondaryTextColor = Color(0xFF6A6A6A);
  static const Color _blueAccentColor = Color(0xFF13A08D); // Bright blue accent for buttons
  static const Color _scaffoldBackgroundColor = Colors.white;
  static const Color _buttonSecondaryColor = Color(0xFFF0F0F0); // Light gray for secondary button

  // Data structure for Featured Campaigns
  // UPDATED: Replaced 'image_color' with 'image_path'
  final List<Map<String, dynamic>> _campaigns = [
    {
      'author': 'Sarah',
      'title': 'Building a Community Center',
      'faith': 'Christianity',
      'raised': 12345,
      'image_path': 'assets/images/spritual image28.png', // <-- Image path added
    },
    {
      'author': 'David',
      'title': 'Supporting Local Missions',
      'faith': 'Judaism',
      'raised': 8765,
      'image_path': 'assets/images/spritual image27.png', // <-- Image path added
    },
    {
      'author': 'Fatima',
      'title': 'Providing Clean Water',
      'faith': 'Islam',
      'raised': 15987,
      'image_path': 'assets/images/spritual image26.png', // <-- Image path added
    },
  ];

  // --- Reusable Widget for a single Featured Campaign Row ---
  // UPDATED: Now accepts 'imagePath' instead of 'imageColor'
  Widget _buildCampaignRow({
    required String author,
    required String title,
    required String faith,
    required int raised,
    required String imagePath,
  }) {
    // Format the raised amount to include dollar sign and comma separator
    final String raisedAmount = '\$${raised.toString().replaceAllMapped(
      RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
          (Match m) => '${m[1]},',
    )} raised';

    return InkWell(
      onTap: () {
        print('Campaign "$title" selected.');
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 15.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Text Content Area
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'By $author',
                    style: const TextStyle(
                      color: _secondaryTextColor,
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    title,
                    style: const TextStyle(
                      color: _primaryTextColor,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Row(
                    children: [
                      Text(
                        '$faith · ',
                        style: const TextStyle(
                          color: _secondaryTextColor,
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Text(
                        raisedAmount,
                        style: TextStyle(
                          color: _blueAccentColor, // Highlight the raised amount
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(width: 16),
            // Image/Illustration Placeholder
            // UPDATED: Container now uses DecorationImage with an AssetImage
            Container(
              width: 100,
              height: 70, // Slightly landscape aspect ratio as in the image
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                image: DecorationImage(
                  image: AssetImage(imagePath),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ],
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
        backgroundColor: _scaffoldBackgroundColor,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          color: _primaryTextColor,
          onPressed: () {
            // Handle back button press
            Navigator.pop(context);
          },
        ),
        title: const Text(
          'LifeX',
          style: TextStyle(
            color: _primaryTextColor,
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const SizedBox(height: 10),
            // --- Header Text ---
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'Faith-Based',
                  style: TextStyle(
                    color: _primaryTextColor,
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'Crowdfunding',
                  style: TextStyle(
                    color: _primaryTextColor,
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(width: 5),
                const Text('💖', style: TextStyle(fontSize: 26)), // Heart emoji
              ],
            ),
            const SizedBox(height: 10),
            Center(
              child: Text(
                'Start or support causes rooted in compassion.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: _secondaryTextColor,
                  fontSize: 16,
                ),
              ),
            ),
            const SizedBox(height: 30),

            // --- Action Buttons ---
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => CreateCampaignScreen(),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: _blueAccentColor,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  elevation: 0,
                ),
                child: const Text(
                  'Start a Campaign',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            const SizedBox(height: 12),
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => CampaignDashboardScreen(),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: _buttonSecondaryColor,
                  foregroundColor: _primaryTextColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  elevation: 0,
                ),
                child: const Text(
                  'Browse Campaigns',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
            ),

            const SizedBox(height: 30),

            // --- Featured Campaigns Section ---
            const Text(
              'Featured Campaigns',
              style: TextStyle(
                color: _primaryTextColor,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),

            // Campaign List
            // UPDATED: Pass 'image_path' to the builder
            Column(
              children: _campaigns.map((campaign) {
                return _buildCampaignRow(
                  author: campaign['author'],
                  title: campaign['title'],
                  faith: campaign['faith'],
                  raised: campaign['raised'],
                  imagePath: campaign['image_path'],
                );
              }).toList(),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
      bottomNavigationBar: MainScreen(selectedIndex: 3),
    );
  }
}