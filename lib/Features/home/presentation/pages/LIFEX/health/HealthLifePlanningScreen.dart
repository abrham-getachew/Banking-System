import 'package:flutter/material.dart';

// --- Colors and Styles (Approximating the design) ---
const Color kPrimaryColor = Color(0xFF133F53); // Deep Teal/Blue from previous screen for consistency
const Color kBackgroundColor = Color(0xFFFFFFFF);
const Color kGoalProgressColor1 = Color(0xFF4ECDC4); // Light Teal/Aqua
const Color kGoalProgressColor2 = Color(0xFF6BCE98); // Light Green
const Color kGoalProgressColor3 = Color(0xFF98A6EE); // Light Purple/Blue

class HealthLifePlanningScreen extends StatefulWidget {
  const HealthLifePlanningScreen({super.key});

  @override
  State<HealthLifePlanningScreen> createState() =>
      _HealthLifePlanningScreenState();
}

class _HealthLifePlanningScreenState extends State<HealthLifePlanningScreen> {
  // --- Mock State for Goal Progress (Demonstrating Stateful capabilities) ---
  double _fitnessProgress = 0.75;
  double _weightProgress = 0.50;
  double _wellnessProgress = 0.25;

  // --- Widget Builders ---

  // Custom widget for the Vision Board goals
  Widget _buildVisionBoardCard({
    required String goal,
    required Color backgroundColor,
    required String assetPath, // Placeholder for image asset
  }) {
    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      color: backgroundColor,
      child: Container(
        width: MediaQuery.of(context).size.width / 2 - 28, // Approx. half screen minus padding
        height: 150,
        padding: const EdgeInsets.all(12),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Placeholder for the main image illustration
            Expanded(
              child: Center(
                // Use a placeholder icon if an asset isn't available
                child: Image.asset(
                  assetPath, // **REPLACE with your actual asset path**
                  fit: BoxFit.contain,
                  height: 80,
                  width: 80,
                  // The original images are illustrations; using a Container/Icon is an alternative.
                ),
              ),
            ),
            const SizedBox(height: 8),
            Text(
              goal,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Color(0xFF1E1E1E),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Custom widget for Goal Progress bars
  Widget _buildGoalProgress({
    required String title,
    required double progress,
    required Color color,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 16,
                  color: Color(0xFF4A4A4A),
                ),
              ),
              Text(
                '${(progress * 100).toInt()}%',
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF4A4A4A),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          LinearProgressIndicator(
            value: progress,
            backgroundColor: const Color(0xFFE0E0E0),
            valueColor: AlwaysStoppedAnimation<Color>(color),
            minHeight: 6,
            borderRadius: BorderRadius.circular(3),
          ),
        ],
      ),
    );
  }

  // Custom widget for Milestones list item
  Widget _buildMilestoneItem({
    required String description,
    required IconData icon,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            icon,
            color: kPrimaryColor,
            size: 24,
          ),
          const SizedBox(width: 15),
          Expanded(
            child: Text(
              description,
              style: const TextStyle(
                fontSize: 16,
                color: Color(0xFF4A4A4A),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Build the bottom navigation bar (reused from the previous example)
  Widget _buildBottomNavBar() {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(top: BorderSide(color: Color(0xFFE0E0E0), width: 1)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: const [
          BottomNavItem(icon: Icons.home, label: 'Home'),
          BottomNavItem(icon: Icons.smart_toy, label: 'AI', isSelected: true),
          BottomNavItem(icon: Icons.qr_code_2_sharp, label: 'BlockHub'), // Approximating the icon
          BottomNavItem(icon: Icons.favorite_border, label: 'LifeX'),
          BottomNavItem(icon: Icons.more_horiz, label: 'More'),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // A small function to simulate incrementing progress (for statefulness demo)
    // You can call this from a button press if needed.
    void updateProgress() {
      setState(() {
        _fitnessProgress = (_fitnessProgress + 0.05).clamp(0.0, 1.0);
        _weightProgress = (_weightProgress + 0.05).clamp(0.0, 1.0);
        _wellnessProgress = (_wellnessProgress + 0.05).clamp(0.0, 1.0);
      });
    }

    return Scaffold(
      backgroundColor: kBackgroundColor,
      // App Bar
      appBar: AppBar(
        backgroundColor: kBackgroundColor,
        elevation: 0,
        leading: const Icon(Icons.arrow_back, color: Colors.black),
        title: const Text(
          'Health Life Planning',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.normal),
        ),
        centerTitle: true,
      ),
      // Bottom Navigation Bar
      bottomNavigationBar: _buildBottomNavBar(),

      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(16.0, 0, 16.0, 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            // --- Vision Board Section ---
            const Text(
              'Vision Board',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Color(0xFF1E1E1E),
              ),
            ),
            const SizedBox(height: 15),

            // Vision Board Cards
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildVisionBoardCard(
                  goal: 'Run a marathon',
                  backgroundColor: const Color(0xFFFFEBCC), // Light Orange/Yellow
                  assetPath: 'assets/running_man.png', // Placeholder
                ),
                _buildVisionBoardCard(
                  goal: 'Lose 10 lbs',
                  backgroundColor: const Color(0xFFE8F6F4), // Very Light Teal
                  assetPath: 'assets/scale.png', // Placeholder
                ),
              ],
            ),
            const SizedBox(height: 15),

            // Third Card (single item in a row)
            _buildVisionBoardCard(
              goal: 'Sleep 8 hours a night',
              backgroundColor: const Color(0xFFF0F0FF), // Very Light Purple
              assetPath: 'assets/sleeping_person.png', // Placeholder
            ),

            const SizedBox(height: 30),

            // --- Goal Progress Section ---
            const Text(
              'Goal Progress',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Color(0xFF1E1E1E),
              ),
            ),
            const SizedBox(height: 15),

            _buildGoalProgress(
              title: 'Fitness Milestone',
              progress: _fitnessProgress,
              color: kGoalProgressColor1,
            ),
            _buildGoalProgress(
              title: 'Weight Management',
              progress: _weightProgress,
              color: kGoalProgressColor2,
            ),
            _buildGoalProgress(
              title: 'Wellness Aspirations',
              progress: _wellnessProgress,
              color: kGoalProgressColor3,
            ),

            const SizedBox(height: 30),

            // --- Milestones Section ---
            const Text(
              'Milestones',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Color(0xFF1E1E1E),
              ),
            ),
            const SizedBox(height: 15),

            _buildMilestoneItem(
              description: 'Started morning walks',
              icon: Icons.fitness_center, // Placeholder for running icon
            ),
            _buildMilestoneItem(
              description: 'Joined a gym',
              icon: Icons.sports_gymnastics, // Placeholder for dumbbell icon
            ),
            _buildMilestoneItem(
              description: 'Improved sleep schedule',
              icon: Icons.mode_night_outlined, // Placeholder for moon icon
            ),

            const SizedBox(height: 30),

            // --- AI Coaching Section (Faded Text) ---
            Padding(
              padding: const EdgeInsets.only(bottom: 50.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'AI Coaching',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFFE0E0E0), // Very light/faded color
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Congratulations! Your morning walks have improved your mental health by 12% in 3 months.',
                    style: TextStyle(
                      fontSize: 14,
                      color: const Color(0xFFE0E0E0).withOpacity(0.8),
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
    // The image shows very minimal padding and small text/icons.
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            color: isSelected ? kPrimaryColor : const Color(0xFF888888),
            size: 24,
          ),
          Text(
            label,
            style: TextStyle(
              fontSize: 10,
              color: isSelected ? kPrimaryColor : const Color(0xFF888888),
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
      home: HealthLifePlanningScreen(),
    );
  }
}
*/