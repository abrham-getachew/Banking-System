import 'package:flutter/material.dart';

import '../../nav_page.dart';


// --- The main screen widget (Stateful to handle BottomNavigationBar and interactions) ---
class CourseDetailsScreen extends StatefulWidget {
  const CourseDetailsScreen({super.key});

  @override
  State<CourseDetailsScreen> createState() => _CourseDetailsScreenState();
}

class _CourseDetailsScreenState extends State<CourseDetailsScreen> {
  // State for the bottom navigation bar
  int _selectedIndex = 3; // 'LifeX' tab is the 4th item (index 3)

  // Custom colors derived from the image and app suite
  static const Color _primaryTextColor = Color(0xFF333333);
  static const Color _secondaryTextColor = Color(0xFF6A6A6A);
  static const Color _blueAccentColor = Color(0xFF007AFF); // Blue for main actions
  static const Color _scaffoldBackgroundColor = Colors.white;
  static const Color _instructorTitleColor = Color(0xFF1E88E5); // Slightly different blue for "Meditation Expert"

  // Data structure for Syllabus items
  final List<String> _syllabusItems = [
    'Introduction to Mindfulness',
    'Breathing Techniques',
    'Body Scan Meditation',
    'Mindful Movement',
    'Daily Practice Tips',
  ];

  // --- Reusable Widget for a Syllabus Item Tile ---
  Widget _buildSyllabusTile(String title) {
    return ListTile(
      title: Text(
        title,
        style: const TextStyle(
          color: _primaryTextColor,
          fontSize: 16,
          fontWeight: FontWeight.w500,
        ),
      ),
      trailing: const Icon(Icons.arrow_forward_ios, color: Colors.grey, size: 16),
      contentPadding: const EdgeInsets.symmetric(horizontal: 0, vertical: 5),
      onTap: () {
        print('Syllabus item "$title" tapped.');
      },
    );
  }

  // --- Widget for the fixed bottom navigation bar ---


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          color: _primaryTextColor,
          onPressed: () {
            // Handle back button press
          },
        ),
        title: const Text(
          'Course Details',
          style: TextStyle(
            color: _primaryTextColor,
            fontWeight: FontWeight.w600,
            fontSize: 18,
          ),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          // 1. Scrollable Content Area
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  // --- Image Header ---
                  Container(
                    height: 200,
                    width: double.infinity,
                    color: Colors.grey.shade200, // Placeholder background
                    child: Center(
                      // Placeholder for the abstract meditation illustration
                      child: Container(
                        height: 150,
                        width: 150,
                        decoration: BoxDecoration(
                          color: const Color(0xFFC8D7DB), // Blue-green tone
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Center(
                          child: Container(
                            height: 50,
                            width: 50,
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 20),

                        // --- Course Title ---
                        const Text(
                          'Mindfulness Meditation for\nBeginners',
                          style: TextStyle(
                            color: _primaryTextColor,
                            fontSize: 26,
                            fontWeight: FontWeight.bold,
                            height: 1.1,
                          ),
                        ),
                        const SizedBox(height: 10),

                        // --- Course Description ---
                        const Text(
                          'Learn the basics of mindfulness meditation to reduce stress and improve focus. This course is perfect for beginners looking to start their meditation journey.',
                          style: TextStyle(
                            color: _primaryTextColor,
                            fontSize: 16,
                            height: 1.5,
                          ),
                        ),
                        const SizedBox(height: 25),

                        // --- Instructor Section ---
                        const Text(
                          'Instructor',
                          style: TextStyle(
                            color: _primaryTextColor,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 15),
                        Row(
                          children: [
                            // Instructor Profile Picture Placeholder
                            Container(
                              width: 50,
                              height: 50,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: const Color(0xFFFCCB9D), // Skin tone placeholder
                                border: Border.all(color: Colors.grey.shade200, width: 2),
                              ),
                            ),
                            const SizedBox(width: 15),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'Dr. Anya Sharma',
                                  style: TextStyle(
                                    color: _primaryTextColor,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                Text(
                                  'Meditation Expert',
                                  style: TextStyle(
                                    color: _instructorTitleColor,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        const SizedBox(height: 30),

                        // --- Syllabus Section ---
                        const Text(
                          'Syllabus',
                          style: TextStyle(
                            color: _primaryTextColor,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 10),
                        // Syllabus List
                        Column(
                          children: _syllabusItems.map((item) {
                            return _buildSyllabusTile(item);
                          }).toList(),
                        ),
                        const SizedBox(height: 20),

                        // --- Details & Price ---
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              'Course Length',
                              style: TextStyle(color: _secondaryTextColor, fontSize: 16),
                            ),
                            const Text(
                              '4 weeks',
                              style: TextStyle(color: _primaryTextColor, fontSize: 16, fontWeight: FontWeight.w600),
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              'Price',
                              style: TextStyle(color: _secondaryTextColor, fontSize: 16),
                            ),
                            const Text(
                              '\$49',
                              style: TextStyle(color: _primaryTextColor, fontSize: 16, fontWeight: FontWeight.w600),
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          // 2. "Enroll Now" Button (Fixed at Bottom, above Nav Bar)
          Padding(
            padding: const EdgeInsets.fromLTRB(20.0, 10, 20.0, 10.0),
            child: SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: () {
                  print('Enroll Now pressed');
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: _blueAccentColor,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  elevation: 5,
                ),
                child: const Text(
                  'Enroll Now',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ),
        ],
      ),
        bottomNavigationBar: MainScreen(selectedIndex: 3),
    );
  }
}