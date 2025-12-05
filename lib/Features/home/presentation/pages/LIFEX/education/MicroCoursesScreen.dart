import 'package:flutter/material.dart';

import '../../nav_page.dart';

class MicroCoursesScreen extends StatefulWidget {
  @override
  _MicroCoursesScreenState createState() => _MicroCoursesScreenState();
}

class _MicroCoursesScreenState extends State<MicroCoursesScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        title: Text(
          'Micro-Courses',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                'Course Providers',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildProviderCircle('coursera', Colors.teal[300]!),
                _buildProviderCircle('udemy', Colors.teal[500]!),
              ],
            ),
            SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildProviderCircle('linkedin', Colors.teal[700]!, ), // Replace with actual asset path
                _buildProviderCircle('edX', Colors.teal[900]!),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                'Recommended Courses',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
            // The ListView.builder is more efficient for long lists
            ListView(
              shrinkWrap: true, // Important inside a SingleChildScrollView
              physics: NeverScrollableScrollPhysics(), // To prevent nested scrolling issues
              children: [
                _buildCourseCard(
                  'Python for Data Science',
                  'Learn Python for data analysis and visualization.',
                  'Python',
                  45,
                  false,
                ),
                _buildCourseCard(
                  'Blockchain Fundamentals',
                  'Understand the basics of blockchain technology.',
                  'Blockchain',
                  20,
                  false,
                ),
                _buildCourseCard(
                  'NFT Creation Masterclass',
                  'Master the art of creating and selling unique NFTs.',
                  'NFTs',
                  70,
                  true,
                ),
              ],
            ),
          ],
        ),
      ),
      bottomNavigationBar: MainScreen(selectedIndex: 3),
    );
  }

  Widget _buildProviderCircle(String name, Color color, [String? imagePath]) {
    return Container(
      width: 100,
      height: 100,
      decoration: BoxDecoration(
        color: color,
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            spreadRadius: 2,
            blurRadius: 5,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Center(
        child: imagePath != null
            ? ClipOval(child: Image.asset(imagePath, width: 100, height: 100, fit: BoxFit.cover))
            : Text(
          name,
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  // --- Updated and more responsive _buildCourseCard ---
  Widget _buildCourseCard(String title, String description, String courseName, int progress, bool isComplete) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      child: Card(
        elevation: 4,
        shadowColor: Colors.teal.withOpacity(0.2),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Row(
            children: [
              Container(
                width: 80, // Slightly smaller for better balance
                height: 80,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Colors.teal[600]!, Colors.teal[200]!],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(Icons.play_circle_outline, color: Colors.white, size: 40),
              ),
              SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                      maxLines: 2, // Prevents overflow on very small screens
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(height: 4),
                    Text(
                      description,
                      style: TextStyle(color: Colors.grey[600], fontSize: 12),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(height: 8),
                    Row(
                      children: [
                        Text(
                          courseName,
                          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.teal),
                        ),
                        Spacer(),
                        Text(
                          isComplete ? 'Completed' : '$progress% ',
                          style: TextStyle(color: Colors.teal[300], fontWeight: FontWeight.bold),
                        ),
                      ],
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
}