import 'package:flutter/material.dart';

import '../../nav_page.dart';

class AICareerAssistantScreen extends StatefulWidget {
  const AICareerAssistantScreen({super.key});

  @override
  State<AICareerAssistantScreen> createState() => _AICareerAssistantScreenState();
}

class _AICareerAssistantScreenState extends State<AICareerAssistantScreen> {
  // --- STATE VARIABLES (Mock Data) ---

  // Suggested Pathways state
  String _activePathway = 'Tech Leadership';

  // Roadmap state (to show progress change)
  String _milestone1Status = 'Complete';
  String _milestone2Status = 'In Progress';

  // AI Encouragement state
  int _alignmentPercentage = 70;

  // --- COLORS ---
  static const Color accentColor = Color(0xFF00ADB5); // Teal/Cyan Accent
  static const Color darkHeaderColor = Color(0xFF003347); // Dark blue/green for the header
  static const Color lightCardColor = Color(0xFFF0F5F7); // Light background for suggested pathways/encouragement
  static const Color timelineColor = Color(0xFF5A5A5A); // Grey for the timeline track

  // --- STATE MANAGEMENT EXAMPLE ---
  void _followPath() {
    setState(() {
      // Simulate advancing the career roadmap and increasing alignment
      if (_milestone1Status == 'Complete') {
        _milestone2Status = 'Complete';
        _milestone1Status = 'Achieved'; // Further clarity
        _alignmentPercentage = 85;
        _activePathway = 'Global Finance'; // Change active pathway
      } else {
        _milestone1Status = 'Complete';
      }
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Following the $_activePathway pathway!'),
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
            Navigator.of(context).pop();
          },
        ),
        title: const Text(
          'AI Career Pathway Assistant',
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black87),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            // --- HERO HEADER SECTION (AI Portrait) ---
            _buildHeaderSection(),

            // --- SUGGESTED PATHWAYS ---
            _buildSuggestedPathways(),

            // --- ROADMAP VIEW ---
            _buildRoadmapView(),

            // --- AI ENCOURAGEMENT ---
            _buildAIEncouragement(),

            const SizedBox(height: 20),
          ],
        ),
      ),
      // --- BOTTOM NAVIGATION BAR (Reused) ---
      bottomNavigationBar: MainScreen(selectedIndex: 3),
    );
  }

  // --- WIDGET BUILDERS ---

  Widget _buildHeaderSection() {
    return Container(
      height: 400,
      width: double.infinity,
      // Placeholder for the AI portrait image
      decoration: const BoxDecoration(
        color: darkHeaderColor, // Dark background fallback
        image: DecorationImage(
          image: AssetImage('assets/images/vision image20.png'), // Replace with your actual asset
          fit: BoxFit.cover,
          alignment: Alignment.topCenter,
        ),
      ),
      child: Stack(
        children: [
          Positioned(
            bottom: 40,
            left: 16,
            right: 16,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Text(
                  'Welcome to Your AI-\nPowered Career Journey',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 8),
                const Text(
                  "Let's explore your interests, skills, and passions to map out your ideal career path.",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.white70,
                  ),
                ),
                const SizedBox(height: 20),
                SizedBox(
                  height: 48,
                  width: 200,
                  child: ElevatedButton(
                    onPressed: () {
                      // Handle start onboarding action
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: accentColor,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
                      elevation: 4,
                    ),
                    child: const Text(
                      'Start Onboarding',
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // --- UPDATED to pass image paths ---
  Widget _buildSuggestedPathways() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Suggested Pathways',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 16),
          // List of pathways
          _buildPathwayTile(
            title: 'Tech Leadership',
            description: 'Lead innovation in tech with AI-driven strategies.',
            isActive: _activePathway == 'Tech Leadership',
            imagePath: 'assets/images/vision image21.png', // Replace with your asset
          ),
          _buildPathwayTile(
            title: 'Creative Entrepreneurship',
            description: 'Build creativity and business with AI-powered tools.',
            isActive: _activePathway == 'Creative Entrepreneurship',
            imagePath: 'assets/images/vision image22.png', // Replace with your asset
          ),
          _buildPathwayTile(
            title: 'Global Finance',
            description: 'Transform finance with AI insights and global strategies.',
            isActive: _activePathway == 'Global Finance',
            imagePath: 'assets/images/vision image23.png', // Replace with your asset
          ),
        ],
      ),
    );
  }

  // --- UPDATED to use imagePath instead of imageColor ---
  Widget _buildPathwayTile({
    required String title,
    required String description,
    required String imagePath, // Changed from imageColor
    required bool isActive,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Text Details
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: isActive ? accentColor : Colors.black87,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  description,
                  style: const TextStyle(
                    fontSize: 14,
                    color: Colors.black54,
                  ),
                ),
                const SizedBox(height: 12),
                SizedBox(
                  height: 35,
                  child: OutlinedButton(
                    onPressed: () => setState(() => _activePathway = title), // State change example
                    style: OutlinedButton.styleFrom(
                      foregroundColor: Colors.black87,
                      side: BorderSide(color: Colors.grey.shade400),
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                    ),
                    child: const Text('Explore', style: TextStyle(fontSize: 14)),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 16),
          // Image Placeholder
          SizedBox(
            width: 80,
            height: 80,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.asset(
                imagePath,
                fit: BoxFit.cover,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRoadmapView() {
    return Padding(
      padding: const EdgeInsets.only(left: 16.0, right: 16.0, top: 8.0, bottom: 24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Roadmap View',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 16),
          // Timeline steps
          _buildRoadmapStep(
            milestone: 'Milestone 1: Foundation',
            timeline: 'Timeline: 3 months',
            status: _milestone1Status,
          ),
          _buildRoadmapStep(
            milestone: 'Milestone 2: Specialization',
            timeline: 'Timeline: 6 months',
            status: _milestone2Status,
            onTap: _followPath, // Trigger state change
          ),
          _buildRoadmapStep(
            milestone: 'Milestone 3: Leadership',
            timeline: 'Timeline: 12 months',
            status: 'Pending',
            isLast: true,
          ),
        ],
      ),
    );
  }

  Widget _buildRoadmapStep({
    required String milestone,
    required String timeline,
    required String status,
    bool isLast = false,
    VoidCallback? onTap,
  }) {
    final bool isComplete = status.contains('Complete') || status.contains('Achieved');

    return IntrinsicHeight(
      child: InkWell(
        onTap: onTap,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Timeline circle and line
            Column(
              children: [
                Container(
                  width: 18,
                  height: 18,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: isComplete ? accentColor : Colors.white,
                    border: Border.all(
                      color: isComplete ? accentColor : timelineColor,
                      width: 2,
                    ),
                  ),
                ),
                if (!isLast)
                  Expanded(
                    child: Container(
                      width: 2,
                      color: isComplete ? accentColor : timelineColor,
                      margin: const EdgeInsets.symmetric(vertical: 2),
                    ),
                  ),
              ],
            ),
            const SizedBox(width: 16),
            // Step details
            Expanded(
              child: Padding(
                padding: EdgeInsets.only(bottom: isLast ? 0 : 20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      milestone,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: Colors.black87,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      timeline,
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

  Widget _buildAIEncouragement() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: lightCardColor,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'AI Encouragement',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              "You're $_alignmentPercentage% aligned with your dream role — keep learning!", // State-driven text
              style: const TextStyle(
                fontSize: 16,
                color: Colors.black54,
              ),
            ),
            const SizedBox(height: 12),
            SizedBox(
              height: 40,
              child: ElevatedButton(
                onPressed: _followPath, // Button to trigger state change
                style: ElevatedButton.styleFrom(
                  backgroundColor: accentColor,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                  elevation: 0,
                ),
                child: const Text('Follow Path', style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}