import 'package:flutter/material.dart';

import '../../nav_page.dart';

// Import for charting libraries (replace with actual library like fl_chart)
// import 'package:fl_chart/fl_chart.dart';

// --- Theme Colors and Constants ---
const Color _kDarkTextColor = Color(0xFF333333);
const Color _kLightTextColor = Color(0xFF666666);
const Color _kChartLineColor = Color(0xFF3366FF); // Bright blue for the chart line
const Color _kChartAreaColor = Color(0xFF3366FF); // Bright blue for chart area fill
const Color _kPercentageIncreaseColor = Color(0xFF00C7B3); // Teal/green for the +10%
const Color _kIconColor = Color(0xFF333333); // For back icon and bottom nav unselected
const Color _kLifeXSelectedColor = Color(0xFF333333); // Black/Dark color for the selected LifeX tab

class GoalAnalyticsScreen extends StatefulWidget {
  const GoalAnalyticsScreen({super.key});

  @override
  State<GoalAnalyticsScreen> createState() => _GoalAnalyticsScreenState();
}

class _GoalAnalyticsScreenState extends State<GoalAnalyticsScreen> {
  // --- State Variables ---
  int _selectedIndex = 4; // Assuming this might be under the 'More' tab (index 4)
  int _completionStreak = 3; // Example state for the streak count
  double _goalConsistency = 0.75; // Example state for the percentage (75%)

  // --- Helper Methods ---
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    // Implement navigation logic here
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
          'Goal Analytics',
          style: TextStyle(color: _kDarkTextColor, fontWeight: FontWeight.w500),
        ),
        centerTitle: false,
      ),
      // 2. Body Content
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            // Weekly Summary
            _buildSectionTitle('Weekly Summary'),
            const SizedBox(height: 15),
            _buildWeeklySummary(),
            const SizedBox(height: 30),

            // Consistency Over Time
            _buildSectionTitle('Consistency Over Time'),
            const SizedBox(height: 15),
            _buildConsistencySection(),
            const SizedBox(height: 30),

            // AI Spiritual Coach
            _buildSectionTitle('AI Spiritual Coach'),
            const SizedBox(height: 15),
            _buildAiTip(),
            const SizedBox(height: 20),
          ],
        ),
      ),
      // 3. Bottom Navigation Bar
      bottomNavigationBar: MainScreen(selectedIndex: 3),
    );
  }

  // --- Component Builders ---

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.bold,
        color: _kDarkTextColor,
      ),
    );
  }

  Widget _buildWeeklySummary() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'Completion Streak',
              style: TextStyle(
                fontSize: 16,
                color: _kLightTextColor,
              ),
            ),
            Text(
              '${_completionStreak} days',
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: _kDarkTextColor,
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),
        const Text(
          'Enco... "Embrace the journey, one step at a time."',
          style: TextStyle(
            fontSize: 16,
            fontStyle: FontStyle.italic,
            color: _kLightTextColor,
          ),
        ),
      ],
    );
  }

  Widget _buildConsistencySection() {
    String consistencyPercentage = '${(_goalConsistency * 100).toInt()}%';

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Goal Consistency',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w500,
            color: _kLightTextColor,
          ),
        ),
        const SizedBox(height: 5),
        Row(
          crossAxisAlignment: CrossAxisAlignment.baseline,
          textBaseline: TextBaseline.alphabetic,
          children: [
            Text(
              consistencyPercentage,
              style: const TextStyle(
                fontSize: 48, // Large font size for emphasis
                fontWeight: FontWeight.bold,
                color: _kDarkTextColor,
              ),
            ),
            const SizedBox(width: 8),
            const Text(
              'Last 4 Weeks',
              style: TextStyle(
                fontSize: 16,
                color: _kLightTextColor,
              ),
            ),
            const SizedBox(width: 5),
            const Text(
              '+10%',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: _kPercentageIncreaseColor,
              ),
            ),
          ],
        ),
        const SizedBox(height: 20),
        // Placeholder for the Line Chart
        _buildLineChartPlaceholder(),
        const SizedBox(height: 10),
        // Week Labels
        const Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Text('W1', style: TextStyle(color: _kLightTextColor)),
            Text('W2', style: TextStyle(color: _kLightTextColor)),
            Text('W3', style: TextStyle(color: _kLightTextColor)),
            Text('W4', style: TextStyle(color: _kLightTextColor)),
          ],
        ),
      ],
    );
  }

  Widget _buildLineChartPlaceholder() {
    // This is a simple container designed to visually represent the chart area
    return Container(
      height: 150, // Height of the chart area
      width: double.infinity,
      decoration: BoxDecoration(
        // We use a linear gradient with the primary color to hint at the filled area chart style
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            _kChartAreaColor.withOpacity(0.4),
            Colors.white.withOpacity(0.0),
          ],
        ),
      ),
      // Placeholder for the actual drawn line chart
      child: CustomPaint(
        painter: ChartLinePainter(), // Custom painter to draw a wavy line
      ),
    );
  }

  Widget _buildAiTip() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: const Text(
        'Tip: Consider setting smaller, daily goals to build momentum and consistency.',
        style: TextStyle(
          fontSize: 16,
          height: 1.4,
          color: _kLightTextColor,
        ),
      ),
    );
  }


}

// --- Custom Painter for Wavy Line (Visual Approximation) ---
class ChartLinePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = _kChartLineColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3.0;

    final path = Path();

    // Starting point (W1)
    path.moveTo(size.width * 0.05, size.height * 0.7);

    // Draw an approximation of the wavy line seen in the image
    path.cubicTo(
      size.width * 0.25, size.height * 0.3, // Control point 1
      size.width * 0.4, size.height * 0.9,  // Control point 2
      size.width * 0.55, size.height * 0.5, // End point for segment 1 (W2)
    );
    path.cubicTo(
      size.width * 0.65, size.height * 0.2, // Control point 3
      size.width * 0.8, size.height * 0.9,  // Control point 4
      size.width * 0.95, size.height * 0.6, // End point (W4)
    );

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}