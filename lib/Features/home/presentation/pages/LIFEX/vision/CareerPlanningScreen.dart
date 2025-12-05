import 'package:flutter/material.dart';

import '../../nav_page.dart';



class CareerPlanningScreen extends StatefulWidget {
  const CareerPlanningScreen({super.key});

  @override
  State<CareerPlanningScreen> createState() => _CareerPlanningScreenState();
}

class _CareerPlanningScreenState extends State<CareerPlanningScreen> {
  // --- STATE VARIABLES (Mock Data) ---

  // Career Roadmap state
  String _currentRole = 'Data Analyst';
  String _nextStep = 'Senior Analyst';
  int _targetYear = 2025;

  // Skills Tracker state
  String _skillName = 'AI Fundamentals Course';
  String _skillStatus = 'Completed: 2024';

  // Business Planner state
  String _businessIdea = 'Startup Idea';

  // --- COLORS ---
  static const Color accentColor = Color(0xFF00ADB5); // Teal/Cyan Accent
  static const Color iconColor = Color(0xFF5A5A5A); // Grey for unselected icons/track
  static const Color lightCardColor = Color(0xFFF0F5F7); // Light background for the AI Insight

  // --- STATE MANAGEMENT EXAMPLE ---
  void _advanceCareerStep() {
    setState(() {
      // Simulate moving to the next career step
      if (_nextStep == 'Senior Analyst') {
        _currentRole = 'Senior Analyst';
        _nextStep = 'Team Lead';
        _targetYear = 2027;
        _skillStatus = 'In Progress: Certifications';
      } else {
        // Reset or reach final goal
        _currentRole = 'Data Science Lead';
        _nextStep = 'Executive';
        _targetYear = 2030;
      }
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Career step updated to: $_currentRole'),
        backgroundColor: accentColor,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black87),
          onPressed: () {
            // Handle back navigation
          },
        ),
        title: const Text(
          'Career & Business Planning',
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black87),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            // --- HERO HEADER SECTION (The Office Scene) ---
            _buildHeaderSection(),

            // --- CAREER ROADMAP ---
            _buildCareerRoadmap(),

            // --- BUSINESS PLANNER ---
            _buildBusinessPlanner(),

            // --- SKILLS TRACKER ---
            _buildSkillsTracker(),

            // --- AI INSIGHT ---
            _buildAIInsight(),

            const SizedBox(height: 20),
          ],
        ),
      ),
      // --- BOTTOM NAVIGATION BAR (Reused) ---
      bottomNavigationBar: MainScreen(selectedIndex: 3),   );
  }

  // --- WIDGET BUILDERS ---

  Widget _buildHeaderSection() {
    return Container(
      height: 350,
      width: double.infinity,
      // Placeholder for the immersive office image
      decoration: const BoxDecoration(
        color: Color(0xFF1E3231), // Dark green fallback
        image: DecorationImage(
          image: AssetImage('assets/images/vision image19.png'), // Replace with your actual asset
          fit: BoxFit.cover,
          alignment: Alignment.center,
        ),
      ),
      child: Stack(
        children: [
          Positioned(
            bottom: 20,
            left: 16,
            right: 16,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text(
                  'Plan Your Future',
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  'Craft your career path and business strategies with our intuitive planning tools.',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.white70,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCareerRoadmap() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Career Roadmap',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 16),
          // Time-line style list
          _buildRoadmapStep(
            icon: Icons.work_outline,
            title: 'Current Role: $_currentRole',
            subtitle: '2023 - Present',
            isComplete: true,
          ),
          _buildRoadmapStep(
            icon: Icons.trending_up,
            title: 'Next Step: $_nextStep',
            subtitle: 'Target: $_targetYear',
            isComplete: false,
            onTap: _advanceCareerStep, // Trigger state change
          ),
          _buildRoadmapStep(
            icon: Icons.star_border,
            title: 'Long-Term Goal: Data Science Lead',
            subtitle: 'Target: 2028',
            isComplete: false,
            isLast: true,
          ),
        ],
      ),
    );
  }

  Widget _buildRoadmapStep({
    required IconData icon,
    required String title,
    required String subtitle,
    required bool isComplete,
    bool isLast = false,
    VoidCallback? onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: IntrinsicHeight(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Timeline track and icon
            Column(
              children: [
                Icon(
                  icon,
                  color: isComplete ? accentColor : iconColor,
                  size: 28,
                ),
                if (!isLast)
                  Expanded(
                    child: Container(
                      width: 2,
                      color: isComplete ? accentColor : iconColor.withOpacity(0.5),
                      margin: const EdgeInsets.symmetric(vertical: 4),
                    ),
                  ),
              ],
            ),
            const SizedBox(width: 16),
            // Step details
            Expanded(
              child: Padding(
                padding: EdgeInsets.only(bottom: isLast ? 0 : 20.0, top: 4),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: Colors.black87,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      subtitle,
                      style: const TextStyle(
                        fontSize: 14,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBusinessPlanner() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Business Planner',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 12),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: lightCardColor,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Lean Canvas: $_businessIdea',
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 4),
                const Text(
                  'Outline your business model with our Lean Canvas template.',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.black54,
                  ),
                ),
                const SizedBox(height: 12),
                SizedBox(
                  height: 35,
                  child: OutlinedButton(
                    onPressed: () => setState(() => _businessIdea = 'New Business Idea!'), // State change example
                    style: OutlinedButton.styleFrom(
                      foregroundColor: accentColor,
                      side: BorderSide(color: accentColor.withOpacity(0.6)),
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                    ),
                    child: const Text('View', style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSkillsTracker() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Skills Tracker',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: lightCardColor,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(Icons.school_outlined, color: accentColor, size: 24),
              ),
              const SizedBox(width: 16),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    _skillName,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    _skillStatus,
                    style: const TextStyle(
                      fontSize: 14,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildAIInsight() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'AI Insight',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 12),
          Container(
            height: 200,
            width: double.infinity,
            decoration: BoxDecoration(
              color: lightCardColor,
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Center(
              // Placeholder for the custom AI visual and text
              child: Text(
                'Your industry is trending toward AI-core roles.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black54,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }


}