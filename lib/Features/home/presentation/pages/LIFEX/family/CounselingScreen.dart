import 'package:flutter/material.dart';

import '../../nav_page.dart';


// --- The main screen widget (Stateful to handle BottomNavigationBar and Profile Selection) ---
class CounselingScreen extends StatefulWidget {
  const CounselingScreen({super.key});

  @override
  State<CounselingScreen> createState() => _CounselingScreenState();
}

class _CounselingScreenState extends State<CounselingScreen> {
  // State for the bottom navigation bar
  int _selectedIndex = 3; // 'LifeX' tab is the 4th item (index 3)

  // State for counselor selection (Optional but makes it stateful)
  String? _selectedCounselor;

  // Custom colors derived from the image
  static const Color _primaryTextColor = Color(0xFF333333);
  static const Color _secondaryTextColor = Color(0xFF6A6A6A);
  static const Color _accentColor = Color(0xFF26B0AB);
  static const Color _scaffoldBackgroundColor = Colors.white;
  static const Color _headerOverlayColor = Color(0xFF1F3542); // Dark overlay

  // Data structure for the Counselors
  final List<Map<String, String>> _counselors = [
    {
      'name': 'Dr. Amelia Harper',
      'title': 'Licensed Marriage and Family Therapist',
      'avatar_path': 'assets/images/family image18.png',
    },
    {
      'name': 'Dr. Ethan Bennett',
      'title': 'Certified Relationship Counselor',
      'avatar_path': 'assets/images/family image20.png',
    },
    {
      'name': 'Dr. Olivia Carter',
      'title': 'Couples Therapy Specialist',
      'avatar_path': 'assets/images/family image19.png',
    },
  ];

  // --- Widget for the dramatic header section ---
  Widget _buildHeader(BuildContext context) {
    return Container(
      height: 300,
      decoration: const BoxDecoration(
        // UPDATED: Using an asset image for the background
        image: DecorationImage(
          image: AssetImage('assets/images/family image16.png'), // <-- Header background image
          fit: BoxFit.cover,
        ),
      ),
      child: Container(
        // This container adds the dark gradient overlay on top of the image
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.black.withOpacity(0.0),
              _headerOverlayColor.withOpacity(0.9), // Dark blue/gray at the bottom
            ],
            stops: const [0.5, 1.0],
          ),
        ),
        child: Stack(
          children: [
            // Content positioned at the bottom-center
            Positioned(
              bottom: 40,
              left: 20,
              right: 20,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text(
                    'Find the Right\nCounselor for You',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      height: 1.2,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'Connect with experienced therapists specializing in\nmarriage and relationship counseling. Our AI-powered\nmatching system ensures you find the perfect fit for\nyour needs.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.85),
                      fontSize: 14,
                      height: 1.4,
                    ),
                  ),
                  const SizedBox(height: 20),
                  SizedBox(
                    width: 250, // Fixed width button
                    child: ElevatedButton(
                      onPressed: () {
                        print('Book a Session (Header) pressed');
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: _accentColor,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        elevation: 5,
                      ),
                      child: const Text(
                        'Book a Session',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
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

  // --- Reusable Widget for a Counselor/AI Profile Row ---
  Widget _buildProfileRow({
    required String name,
    required String title,
    required String actionLabel,
    required Function() onAction,
    String? avatarPath, // Optional path for asset image
    Color actionColor = _secondaryTextColor,
    Color titleColor = _secondaryTextColor,
  }) {
    final isSelected = _selectedCounselor == name && actionLabel == 'Select';

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Row(
        children: [
          // Avatar logic
          CircleAvatar(
            radius: 24,
            backgroundImage: avatarPath != null ? AssetImage(avatarPath) : null,
            backgroundColor: _secondaryTextColor.withOpacity(0.1),
            child: avatarPath == null
                ? Text(
              name.split(' ').map((e) => e.substring(0, 1)).join(),
              style: const TextStyle(
                color: _primaryTextColor,
                fontWeight: FontWeight.bold,
              ),
            )
                : null,
          ),
          const SizedBox(width: 16),
          // Text Content
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: const TextStyle(
                    color: _primaryTextColor,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  title,
                  style: TextStyle(
                    color: titleColor,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
          // Action Button
          SizedBox(
            width: 80,
            height: 40,
            child: TextButton(
              onPressed: onAction,
              style: TextButton.styleFrom(
                backgroundColor: isSelected ? _accentColor.withOpacity(0.1) : Colors.grey.shade100,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                  side: BorderSide(
                    color: isSelected ? _accentColor : Colors.transparent,
                    width: 1.0,
                  ),
                ),
              ),
              child: Text(
                actionLabel,
                style: TextStyle(
                  color: isSelected ? _accentColor : actionColor,
                  fontWeight: FontWeight.w600,
                  fontSize: 14,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // --- UPDATED: New widget for the Video Call card ---
  Widget _buildVideoCallCard() {
    return Card(
      elevation: 4,
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Container(
        height: 180,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/family image23.png'), // Background image
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
              Colors.black38,
              BlendMode.darken,
            ),
          ),
        ),
        child: Center(
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.9),
              shape: BoxShape.circle,
            ),
            child: IconButton(
              icon: const Icon(Icons.play_arrow, color: _accentColor, size: 30),
              onPressed: () {},
            ),
          ),
        ),
      ),
    );
  }

  // --- UPDATED: New widget for the final "Book a Session" card ---
  Widget _buildBookingCard() {
    return Card(
      elevation: 4,
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Container(
        height: 150,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/family image5.png'), // Background image
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
              Colors.black45,
              BlendMode.darken,
            ),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Expanded(
                child: Text(
                  'Ready to Start\nYour Session?',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    height: 1.3,
                  ),
                ),
              ),
              ElevatedButton(
                onPressed: _selectedCounselor != null ? () {
                  print('Final Book Session for $_selectedCounselor');
                } : null,
                style: ElevatedButton.styleFrom(
                  backgroundColor: _accentColor,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  textStyle: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                child: const Text('Book Now'),
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
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          color: Colors.white,
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        title: const Text(
          'Marriage & Relationship\nCounseling',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w600,
            fontSize: 18,
          ),
        ),
        centerTitle: true,
      ),
      extendBodyBehindAppBar: true,
      body: Column(
        children: [
          // 1. The Header with Text and Button
          _buildHeader(context),

          // 2. The scrollable content below the header
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // --- Booking System Section ---
                  const Text(
                    'Booking System',
                    style: TextStyle(
                      color: _primaryTextColor,
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 16),
                  ..._counselors.map((c) {
                    return _buildProfileRow(
                      name: c['name']!,
                      title: c['title']!,
                      avatarPath: c['avatar_path'],
                      actionLabel: 'Select',
                      onAction: () {
                        setState(() {
                          _selectedCounselor = c['name'];
                        });
                        print('Selected: ${c['name']}');
                      },
                    );
                  }).toList(),

                  const SizedBox(height: 30),

                  // --- Video Call Integration Section ---
                  const Text(
                    'Video Call Integration',
                    style: TextStyle(
                      color: _primaryTextColor,
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 16),
                  _buildVideoCallCard(), // Using the new video call card

                  const SizedBox(height: 30),

                  // --- AI Support Section ---
                  const Text(
                    'AI Support from Kevin.AI',
                    style: TextStyle(
                      color: _primaryTextColor,
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 16),
                  // UPDATED: AI support now uses avatars
                  _buildProfileRow(
                    name: 'Emotional Check-in',
                    title: 'Kevin.AI',
                    avatarPath: 'assets/images/family image21.png', // Kevin AI's avatar
                    actionLabel: 'Start',
                    onAction: () {
                      print('Emotional Check-in started');
                    },
                    actionColor: _accentColor,
                    titleColor: _accentColor,
                  ),
                  _buildProfileRow(
                    name: 'Resource Suggestions',
                    title: 'Kevin.AI',
                    avatarPath: 'assets/images/family image22.png', // Kevin AI's avatar
                    actionLabel: 'View',
                    onAction: () {
                      print('Resource Suggestions viewed');
                    },
                    actionColor: _accentColor,
                    titleColor: _accentColor,
                  ),

                  const SizedBox(height: 30),

                  // --- Final Call to Action Card ---
                  _buildBookingCard(), // Using the new booking card

                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: MainScreen(selectedIndex: 3),
    );
  }
}