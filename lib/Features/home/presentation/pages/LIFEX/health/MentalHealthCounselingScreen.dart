import 'package:flutter/material.dart';

import '../../nav_page.dart';

// --- Colors and Styles (to match the image) ---
const Color kPrimaryColor = Color(0xFF133F53);
const Color kBackgroundColor = Color(0xFFFFFFFF);
const Color kLightGrey = Color(0xFFF7F7F7);
const Color kDarkGrey = Color(0xFF5A5A5A);
const Color kAccentColor = Color(0xFF4ECDC4); // For the selected date circle
const Color kCrisisColor = Color(0xFF00C853); // A bright green for the crisis button

class MentalHealthCounselingScreen extends StatefulWidget {
  const MentalHealthCounselingScreen({super.key});

  @override
  State<MentalHealthCounselingScreen> createState() =>
      _MentalHealthCounselingScreenState();
}

class _MentalHealthCounselingScreenState
    extends State<MentalHealthCounselingScreen> {
  // Simple state for demonstration, e.g., the selected date
  int _selectedDate = 5;
  String _selectedMood = 'Neutral';

  // --- Widget Builders ---

  // Build the main header image and text section
  Widget _buildHeader() {
    return Container(
      height: 400,
      decoration: const BoxDecoration(
        color: Color(0xFFE0E0E0), // Placeholder background color
        // The actual image effect is a gradient fade from the bottom,
        // which would require a specific asset and complex blending.
        // We'll use a placeholder image and a gradient overlay.
      ),
      child: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          // Placeholder for the main image (Woman meditating)
          Opacity(
            opacity: 1.0,
            child: Image.asset(
              'assets/images/health image20.png', // **REPLACE with your actual asset path**
              fit: BoxFit.cover,
              width: double.infinity,
              height: double.infinity,
            ),
          ),
          // Gradient Overlay to blend with the background
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Colors.transparent, kBackgroundColor],
                stops: [0.6, 1.0],
              ),
            ),
          ),

        ],
      ),
    );
  }

  // A card template for the Counseling Options
  Widget _buildCounselingCard({
    required String title,
    required String assetPath,
    required Color color,
    double height = 150,
  }) {
    // Note: Since we can't directly use the images from the file,
    // these assets are placeholders and the colors approximate the look.
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Container(
        height: height,
        width: MediaQuery.of(context).size.width / 2 - 30, // Approx half screen width
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: color, // Use color as a backdrop/placeholder
          image: DecorationImage(
            // Placeholder: Replace with actual image asset
            image: AssetImage(assetPath),
            fit: BoxFit.cover,
            opacity: 0.5,
          ),
        ),
        alignment: Alignment.bottomLeft,
        padding: const EdgeInsets.all(10),
        child: Text(
          title,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 16,
            shadows: [
              Shadow(
                blurRadius: 2.0,
                color: Colors.black54,
                offset: Offset(1.0, 1.0),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Build the "Book a Session" calendar widget
  Widget _buildCalendar() {
    const List<String> weekdays = ['S', 'M', 'T', 'W', 'T', 'F', 'S'];
    // Mock data for July 2024 (starts on a Monday, so 1 empty slot)
    final List<int?> days = [
      null, 1, 2, 3, 4, 5, 6,
      7, 8, 9, 10, 11, 12, 13,
      14, 15, 16, 17, 18, 19, 20,
      21, 22, 23, 24, 25, 26, 27,
      28, 29, 30, // July has 31 days, but image shows a cutoff here
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Month Header
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Icon(Icons.arrow_back_ios, size: 16, color: kDarkGrey),
              const Text(
                'July 2024',
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: kPrimaryColor),
              ),
              const Icon(Icons.arrow_forward_ios, size: 16, color: kDarkGrey),
            ],
          ),
        ),
        // Weekday Headers
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: weekdays.map((day) {
              return Text(
                day,
                style: const TextStyle(
                    fontWeight: FontWeight.bold, color: kDarkGrey),
              );
            }).toList(),
          ),
        ),
        const Divider(height: 20, indent: 16, endIndent: 16),

        // Days Grid
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 7,
              childAspectRatio: 1.0,
              mainAxisSpacing: 10,
              crossAxisSpacing: 5,
            ),
            itemCount: days.length,
            itemBuilder: (context, index) {
              final day = days[index];
              final isSelected = day == _selectedDate;

              return InkWell(
                onTap: day != null
                    ? () {
                  setState(() {
                    _selectedDate = day;
                  });
                }
                    : null,
                child: Center(
                  child: Container(
                    width: 35,
                    height: 35,
                    decoration: isSelected
                        ? BoxDecoration(
                      color: kAccentColor,
                      shape: BoxShape.circle,
                    )
                        : null,
                    child: Center(
                      child: Text(
                        day?.toString() ?? '',
                        style: TextStyle(
                          color: isSelected
                              ? kBackgroundColor
                              : (day == null ? Colors.transparent : kDarkGrey),
                          fontWeight:
                          isSelected ? FontWeight.bold : FontWeight.normal,
                        ),
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  // Build the AI Mental Health Bot section
  Widget _buildAiBot() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'AI Mental Health Bot',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          const Text(
            'How are you feeling today?',
            style: TextStyle(color: kDarkGrey),
          ),
          const SizedBox(height: 15),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildMoodOption('Happy', '😊'),
              _buildMoodOption('Neutral', '😐'),
              _buildMoodOption('Sad', '😔'),
            ],
          ),
        ],
      ),
    );
  }

  // Helper widget for mood options
  Widget _buildMoodOption(String label, String emoji) {
    bool isSelected = _selectedMood == label;
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedMood = label;
        });
      },
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: isSelected ? kPrimaryColor : kDarkGrey.withOpacity(0.3),
                width: isSelected ? 2.0 : 1.0,
              ),
              color: isSelected ? kLightGrey : Colors.transparent,
            ),
            child: Text(emoji, style: const TextStyle(fontSize: 24)),
          ),
          const SizedBox(height: 4),
          Text(label, style: const TextStyle(fontSize: 12, color: kDarkGrey)),
        ],
      ),
    );
  }

  // Build the Emergency Hotline section
  Widget _buildEmergencyHotline() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Text(
            'Emergency Hotline',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 5),
          const Text(
            'If you\'re in immediate danger, please call the',
            textAlign: TextAlign.center,
            style: TextStyle(color: kDarkGrey),
          ),
          const Text(
            'emergency hotline.',
            textAlign: TextAlign.center,
            style: TextStyle(color: kDarkGrey),
          ),
          const SizedBox(height: 15),
          ElevatedButton(
            onPressed: () {
              // Add crisis help logic
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.teal,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
              padding:
              const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
              elevation: 4,
            ),
            child: const Text(
              'Crisis Help',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }

  // Build the bottom navigation bar


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundColor,
      // 1. App Bar
      appBar: AppBar(
        backgroundColor: kBackgroundColor,
        elevation: 0,
        leading: const Icon(Icons.arrow_back, color: Colors.black),
        title: const Text(
          'Mental Health Counseling',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.normal),
        ),
        centerTitle: true,
      ),
      // 7. Bottom Navigation Bar
      bottomNavigationBar: MainScreen(selectedIndex: 3),


      // Main Body
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            // 2. Header Image/Text
            _buildHeader(),

            // 3. Counseling Options
            const Padding(
              padding: EdgeInsets.fromLTRB(16.0, 20.0, 16.0, 10.0),
              child: Text(
                'Counseling Options',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      // Top Row
                      _buildCounselingCard(
                        title: 'Therapy',
                        assetPath: 'assets/images/health image21.png', // Placeholder
                        color: kPrimaryColor,
                        height: 180, // Image is taller
                      ),
                      _buildCounselingCard(
                        title: 'Coaching',
                        assetPath: 'assets/images/health image22.png', // Placeholder
                        color: const Color(0xFFB0C5AE),
                        height: 180,
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      // Bottom Row
                      _buildCounselingCard(
                        title: 'Meditation',
                        assetPath: 'assets/images/health image23.png', // Placeholder
                        color: const Color(0xFF4C8F99),
                        height: 180,
                      ),
                      _buildCounselingCard(
                        title: 'Stress Relief',
                        assetPath: 'assets/images/health image24.png', // Placeholder
                        color: const Color(0xFF133F53),
                        height: 180,
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Horizontal Separator
            const SizedBox(height: 25),

            // 4. Book a Session Calendar
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                'Book a Session',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
            _buildCalendar(),

            const SizedBox(height: 20),

            // 5. AI Mental Health Bot
            _buildAiBot(),

            const SizedBox(height: 20),

            // 6. Emergency Hotline
            Center(child: _buildEmergencyHotline()),

            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}

// Custom widget for Bottom Navigation Bar Items
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
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            color: isSelected ? kPrimaryColor : kDarkGrey,
            size: 24,
          ),
          Text(
            label,
            style: TextStyle(
              fontSize: 10,
              color: isSelected ? kPrimaryColor : kDarkGrey,
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
  // Ensure you have assets/meditation_image.jpg, assets/therapy.jpg, etc.
  // or replace the Image.asset with a placeholder like Image.network or Container.
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MentalHealthCounselingScreen(),
    );
  }
}
*/