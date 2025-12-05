import 'package:flutter/material.dart';

import '../../nav_page.dart';

class GymFitnessScreen extends StatefulWidget {
  const GymFitnessScreen({super.key});

  @override
  State<GymFitnessScreen> createState() => _GymFitnessScreenState();
}

class _GymFitnessScreenState extends State<GymFitnessScreen> {
  // --- STATE VARIABLES ---
  int _steps = 5230;
  int _caloriesBurned = 350;
  double _workoutHours = 1.5;

  // --- COLORS ---
  static const Color accentColor = Color(0xFF00ADB5); // Teal/Cyan Accent
  static const Color lightCardColor = Color(0xFFF0F5F7); // Light background for fitness cards
  static const Color neonButtonColor = Color(0xFF33FFFF); // Bright cyan for the main button
  static const Color darkTextColor = Color(0xFF1E3231); // Dark text color for gym titles

  // --- Mock Data (Updated with image paths) ---
  final List<Map<String, dynamic>> partnerGyms = [
    {
      'name': 'FitZone',
      'offer': '20% off membership',
      'imagePath': 'assets/images/health image11.png',
    },
    {
      'name': 'Powerhouse Gym',
      'offer': '15% off personal training',
      'imagePath': 'assets/images/health image12.png',
    },
    {
      'name': 'ActiveLife Fitness',
      'offer': 'Free trial week',
      'imagePath': 'assets/images/health image13.png',
    },
  ];

  // --- STATE MANAGEMENT EXAMPLE ---
  void _updateFitnessStats() {
    setState(() {
      // Simulate real-time update from a wearable or API
      _steps += 50;
      _caloriesBurned += 10;
      _workoutHours = double.parse((_workoutHours + 0.1).toStringAsFixed(1));
    });
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
          'Gym & Fitness Partnerships',
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black87),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            // --- HERO IMAGE SECTION (Dumbbells) ---
            _buildHeaderImage(),

            // --- PARTNER GYMS HEADER ---
            const Padding(
              padding: EdgeInsets.only(left: 16.0, top: 16.0, bottom: 12.0),
              child: Text(
                'Partner Gyms',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
            ),

            // --- PARTNER GYMS LIST (Updated to a Column layout) ---
            _buildPartnerGymsLayout(),

            // --- DAILY FITNESS TRACKER HEADER ---
            const Padding(
              padding: EdgeInsets.only(left: 16.0, top: 24.0, bottom: 12.0),
              child: Text(
                'Daily Fitness Tracker',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
            ),

            // --- FITNESS STATS (Reverted to simple card design) ---
            _buildFitnessStatsTracker(),
            const SizedBox(height: 24),

            // --- ACTION BUTTON ---
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _updateFitnessStats, // Example of state change
                  style: ElevatedButton.styleFrom(
                    backgroundColor: neonButtonColor,
                    foregroundColor: Colors.black,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    elevation: 0,
                  ),
                  child: const Text(
                    'Redeem Free Trial or Book Session',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 24),

            // --- AI REMINDER HEADER ---
            const Padding(
              padding: EdgeInsets.only(left: 16.0, bottom: 12.0),
              child: Text(
                'AI Reminder',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
            ),

            // --- AI REMINDER CARD (Updated with image) ---
            _buildAIReminderCard(),
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
        image: DecorationImage(
          image: AssetImage('assets/images/health image10.png'),
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  Widget _buildPartnerGymsLayout() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        children: [
          // The first row now contains the two smaller cards
          Row(
            children: [
              Expanded(child: _buildPartnerCard(partnerGyms[0])),
              const SizedBox(width: 16),
              Expanded(child: _buildPartnerCard(partnerGyms[1])),
            ],
          ),
          const SizedBox(height: 16),

          // The second row now contains the single, full-width card
          _buildPartnerCard(partnerGyms[2], isFullWidth: true),
        ],
      ),
    );
  }
  Widget _buildPartnerCard(Map<String, dynamic> gym, {bool isFullWidth = false}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: isFullWidth ? 150 : 120,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            image: DecorationImage(
              image: AssetImage(gym['imagePath'] as String),
              fit: BoxFit.cover,
            ),
          ),
        ),
        const SizedBox(height: 8),
        Text(
          gym['name'] as String,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: darkTextColor,
          ),
        ),
        Text(
          gym['offer'] as String,
          style: TextStyle(
            fontSize: 14,
            color: accentColor.withOpacity(0.9),
          ),
        ),
      ],
    );
  }

  // --- FITNESS TRACKER WIDGETS (REVERTED TO SIMPLE STYLE) ---
  // --- FITNESS TRACKER WIDGETS (SIMPLE STYLE) ---
  Widget _buildFitnessStatsTracker() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column( // This Column arranges the cards vertically
        children: [
          // This Row contains the two smaller cards side-by-side
          Row(
            children: <Widget>[
              Expanded(
                child: _buildStatCard(
                  title: 'Steps',
                  value: _steps.toString(),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _buildStatCard(
                  title: 'Calories',
                  value: _caloriesBurned.toString(),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),

          // --- FIX IS HERE ---
          // Wrap the card in a SizedBox to force it to take the full width.
          SizedBox(
            width: double.infinity,
            child: _buildStatCard(
              title: 'Workout Hours',
              value: _workoutHours.toString(),
            ),
          ),
        ],
      ),
    );
  }
// The helper method for creating each card (without a border)
  // The helper method for creating each card (now with a border)
  Widget _buildStatCard({
    required String title,
    required String value,
  }) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.teal[100]!, // The requested border color
          width: 2, // A good visible border width
        ),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Card(
        color: lightCardColor,
        elevation: 0,
        margin: EdgeInsets.zero, // Remove card margin to fit inside the border
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10), // Slightly smaller radius for the inner card
        ),
        child: Container(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                title,
                style: const TextStyle(
                  fontSize: 16,
                  color: Colors.black54,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                value,
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
  // Reverted Stat Card (no image)


  Widget _buildAIReminderCard() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Container(
        height: 200,
        width: double.infinity,
        padding: const EdgeInsets.all(24.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          image: const DecorationImage(
            image: AssetImage('assets/images/health image14.png'), // Motivational image
            fit: BoxFit.cover,
            //colorFilter: ColorFilter.mode(Colors.black.withOpacity(0.5), BlendMode.darken),
          ),
        ),
        child: const Center(
          child: Text(
            '\"The only bad workout is the one that didn\'t happen.\"',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: Colors.white,
              fontStyle: FontStyle.italic,
            ),
          ),
        ),
      ),
    );
  }
}