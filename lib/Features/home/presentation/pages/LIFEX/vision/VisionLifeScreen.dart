import 'package:flutter/material.dart';
import '../../nav_page.dart';
import 'AICareerAssistantScreen.dart';
import 'CareerPlanningScreen.dart';
import 'DreamSavingsScreen.dart';
import 'VisionBoardScreen.dart';
import 'VisionProgressReportScreen.dart';


class VisionLifeScreen extends StatefulWidget {
  const VisionLifeScreen({super.key});

  @override
  State<VisionLifeScreen> createState() => _VisionLifeScreenState();
}

class _VisionLifeScreenState extends State<VisionLifeScreen> {
  // --- STATE VARIABLES (Mock Data) ---
  double _dreamSavingsProgress = 1200;
  final double _dreamSavingsGoal = 5000;
  String _careerPathwayStatus = 'Next Step';
  int _lifeGoalsCompleted = 3;
  final int _totalLifeGoals = 5;

  // --- COLORS ---
  static const Color primaryDarkBg = Color(0xFF1A1A2E); // Main background
  static const Color cardDarkBg = Color(0xFF2C2C3E); // No longer used for tool cards, but kept for potential future use
  static const Color accentColor = Color(0xFF00ADB5); // Teal/Cyan Accent (reused)

  // --- STATE MANAGEMENT EXAMPLE ---
  void _updateDreamSavings(double amount) {
    setState(() {
      _dreamSavingsProgress += amount;
      if (_dreamSavingsProgress > _dreamSavingsGoal) {
        _dreamSavingsProgress = _dreamSavingsGoal;
      }
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Added \$${amount.toStringAsFixed(0)} to Dream Savings!'),
        backgroundColor: accentColor,
      ),
    );
  }

  void _completeCareerStep() {
    setState(() {
      _careerPathwayStatus = 'Completed!';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Vision Life',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.settings, color: Colors.black, size: 28),
            onPressed: () {
              // Handle settings tap
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            // --- HEADER / HERO IMAGE SECTION ---
            _buildHeaderImage(),

            // --- QUICK SNAPSHOT HEADER ---
            const Padding(
              padding: EdgeInsets.only(left: 16.0, top: 24.0, bottom: 12.0),
              child: Text(
                'Quick Snapshot',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ),

            // --- QUICK SNAPSHOT CARDS (Horizontal Scroll) ---
            _buildQuickSnapshotCards(),

            // --- TOOLS HEADER ---
            const Padding(
              padding: EdgeInsets.only(left: 16.0, top: 24.0, bottom: 12.0),
              child: Text(
                'Tools',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ),

            // --- TOOLS GRID ---
            _buildToolsGrid(),

            const SizedBox(height: 20),
          ],
        ),
      ),
      // --- BOTTOM NAVIGATION BAR (Reused) ---
      bottomNavigationBar: MainScreen(selectedIndex: 3),
    );
  }

  // --- WIDGET BUILDERS ---

  Widget _buildHeaderImage() {
    return Container(
      height: 200,
      width: double.infinity,
      decoration: const BoxDecoration(
        color: primaryDarkBg, // Fallback color
        image: DecorationImage(
          image: AssetImage('assets/images/vision image1.png'), // Replace with your actual asset
          fit: BoxFit.cover,
          alignment: Alignment.bottomCenter,
        ),
      ),
      child: const Center(
        child: Text(
          'Design your future',
          style: TextStyle(
            fontSize: 16,
            color: Colors.white70,
            fontStyle: FontStyle.italic,
          ),
        ),
      ),
    );
  }

  Widget _buildQuickSnapshotCards() {
    return SizedBox(
      height: 250, // Height to accommodate card content and text
      child: ListView(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        children: [
          // Dream Savings Card
          _buildQuickSnapshotCard(
            context,
            title: 'Dream Savings',
            subtitle: 'Progress',
            value: '\$${_dreamSavingsProgress.toStringAsFixed(0)} / \$${_dreamSavingsGoal.toStringAsFixed(0)}',
            imagePath: 'assets/images/vision image2.png',
            onTap: () => _updateDreamSavings(200),
          ),
          const SizedBox(width: 16),
          // Career Pathway Card
          _buildQuickSnapshotCard(
            context,
            title: 'Career Pathway',
            subtitle: _careerPathwayStatus,
            value: 'Complete online course',
            imagePath: 'assets/images/vision image3.png',
            onTap: _completeCareerStep,
          ),
          const SizedBox(width: 16),
          // Life Goals Card
          _buildQuickSnapshotCard(
            context,
            title: 'Life Goals',
            subtitle: 'Progress',
            value: '$_lifeGoalsCompleted/$_totalLifeGoals completed',
            imagePath: 'assets/images/vision image4.png',
            onTap: () => setState(() {
              if (_lifeGoalsCompleted < _totalLifeGoals) {
                _lifeGoalsCompleted++;
              }
            }),
          ),
        ],
      ),
    );
  }

  Widget _buildQuickSnapshotCard(
      BuildContext context, {
        required String title,
        required String subtitle,
        required String value,
        required String imagePath,
        VoidCallback? onTap,
      }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 180,
        margin: const EdgeInsets.only(bottom: 10, top: 4),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image/Illustration Placeholder
            SizedBox(
              height: 120,
              width: double.infinity,
              // Use ClipRRect to give the image rounded top corners
              child: ClipRRect(
                borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
                child: Image.asset(
                  imagePath,
                  // Change fit to cover the entire area
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
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    subtitle,
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey.shade700,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    value,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: Colors.black87,
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

  Widget _buildToolsGrid() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: GridView.count(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        crossAxisCount: 2,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
        childAspectRatio: 0.8, // Adjusted aspect ratio for the new design
        children: [
          _buildToolCard(
            context,
            title: 'Vision Board',
            imagePath: 'assets/images/vision image4.png', // Replace with your asset
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) =>  VisionBoardScreen ()),
              );
            },
          ),
          _buildToolCard(
            context,
            title: 'Dream Savings',
            imagePath: 'assets/images/vision image5.png', // Replace with your asset
            onTap: () { Navigator.push(
              context,
              MaterialPageRoute(builder: (context) =>  DreamSavingsScreen ()),
            );
            },
          ),
          _buildToolCard(
            context,
            title: 'Career & Business Tools',
            imagePath: 'assets/images/vision image6.png', // Replace with your asset
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) =>  CareerPlanningScreen ()),
                   );
            },
          ),
          _buildToolCard(
            context,
            title: 'AI Career Assistant',
            imagePath: 'assets/images/vision image7.png', // Replace with your asset
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) =>  VisionProgressReportScreen ()),
              );
            },
          ),
        ],
      ),
    );
  }

  // --- UPDATED: _buildToolCard now matches the design of _buildQuickSnapshotCard ---
  Widget _buildToolCard(
      BuildContext context, {
        required String title,
        required String imagePath,
        VoidCallback? onTap,
      }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 10, top: 4),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image Placeholder (Expanded to fill available space)
            Expanded(
              child: SizedBox(
                width: double.infinity,
                child: ClipRRect(
                  borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
                  child: Image.asset(
                    imagePath,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),

            // Title Text
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Text(
                title,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }
}