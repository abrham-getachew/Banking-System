import 'package:flutter/material.dart';

import '../../nav_page.dart';

// --- Theme Colors and Constants ---
const Color _kDarkTextColor = Color(0xFF333333);
const Color _kLightTextColor = Color(0xFF666666);
const Color _kPrimaryButtonColor = Color(0xFF3366FF); // Bright blue "Mark as Completed" button
const Color _kIconColor = Color(0xFF333333);
const Color _kLifeXSelectedColor = Color(0xFF333333); // Black/Dark color for the selected LifeX tab

class MindfulnessLessonScreen extends StatefulWidget {
  const MindfulnessLessonScreen({super.key});

  @override
  State<MindfulnessLessonScreen> createState() => _MindfulnessLessonScreenState();
}

class _MindfulnessLessonScreenState extends State<MindfulnessLessonScreen> {
  // --- State Variables ---
  int _selectedIndex = 3; // Assuming this lesson is part of a LifeX program (index 3)
  bool _isCompleted = false; // State to track if the lesson is completed

  // --- Helper Methods ---
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    // Implement navigation logic here
  }

  void _markAsCompleted() {
    setState(() {
      _isCompleted = true;
    });
    // Simulate an action completion
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Lesson marked as completed!')),
    );
    print('Lesson marked as completed!');
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
        leading: const BackButton(color: _kDarkTextColor),
        title: const Text(
          'Lesson 1: Introduction to Mindfulness',
          style: TextStyle(color: _kDarkTextColor, fontWeight: FontWeight.w500),
        ),
        centerTitle: false,
      ),
      // 2. Body Content
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            // Video Player Placeholder
            _buildVideoPlayerPlaceholder(context),
            const SizedBox(height: 20),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Lesson Notes Title
                  _buildLessonNotesTitle(),
                  const SizedBox(height: 10),

                  // Lesson Notes Content
                  _buildLessonContent(),
                  const SizedBox(height: 40),

                  // Action Button
                  _buildActionButton(),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ],
        ),
      ),
      // 3. Bottom Navigation Bar
      bottomNavigationBar: MainScreen(selectedIndex: 3),
    );
  }

  // --- Component Builders ---

  Widget _buildVideoPlayerPlaceholder(BuildContext context) {
    // Aspect ratio of 16:9 is common for video players.
    double height = MediaQuery.of(context).size.width / (16 / 9);

    return Container(
      width: double.infinity,
      height: height,
      decoration: BoxDecoration(
        color: Colors.black, // Dark background for video
        borderRadius: BorderRadius.circular(0), // No corner radius for full width video in this design
        image: const DecorationImage(
          image: AssetImage('assets/mindfulness_video_bg.png'), // Replace with your image
          fit: BoxFit.cover,
          colorFilter: ColorFilter.mode(
            Colors.black38, // Slightly darken the image for the play button
            BlendMode.darken,
          ),
        ),
      ),
      child: Center(
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.3),
                blurRadius: 10,
              ),
            ],
          ),
          child: const Padding(
            padding: EdgeInsets.all(5.0),
            child: Icon(
              Icons.play_arrow,
              size: 48,
              color: Colors.black,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildLessonNotesTitle() {
    return const Text(
      'Lesson Notes',
      style: TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.bold,
        color: _kDarkTextColor,
      ),
    );
  }

  Widget _buildLessonContent() {
    return const Text(
      'Mindfulness is the practice of paying attention to the present moment without judgment. It involves focusing on your breath, body sensations, thoughts, and emotions as they arise, without getting carried away by them. This practice can help reduce stress, improve focus, and enhance overall well-being.',
      style: TextStyle(
        fontSize: 16,
        height: 1.5,
        color: _kDarkTextColor,
      ),
    );
  }

  Widget _buildActionButton() {
    return SizedBox(
      width: double.infinity,
      height: 55,
      child: ElevatedButton(
        onPressed: _isCompleted ? null : _markAsCompleted, // Disable button if completed
        style: ElevatedButton.styleFrom(
          backgroundColor: _isCompleted ? Colors.grey : _kPrimaryButtonColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          elevation: 0,
        ),
        child: Text(
          _isCompleted ? 'Completed' : 'Mark as Completed',
          style: const TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }


}