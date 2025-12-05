import 'package:flutter/material.dart';

import '../../nav_page.dart';


// --- The main screen widget (Stateful to handle BottomNavigationBar and general state) ---
class FaithCalendarDetailsScreen extends StatefulWidget {
  const FaithCalendarDetailsScreen({super.key});

  @override
  State<FaithCalendarDetailsScreen> createState() =>
      _FaithCalendarDetailsScreenState();
}

class _FaithCalendarDetailsScreenState extends State<FaithCalendarDetailsScreen> {
  // State for the bottom navigation bar
  int _selectedIndex = 3; // 'LifeX' tab is the 4th item (index 3)

  // Custom colors derived from the image and app suite
  static const Color _primaryTextColor = Color(0xFF333333);
  static const Color _secondaryTextColor = Color(0xFF6A6A6A);
  static const Color _blueAccentColor = Color(0xFF007AFF); // Blue for main actions
  static const Color _scaffoldBackgroundColor = Colors.white;

  // --- Widget for a section title (e.g., Origin, Rituals, Time) ---
  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(top: 25.0, bottom: 8.0),
      child: Text(
        title,
        style: const TextStyle(
          color: _primaryTextColor,
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  // --- Widget for the fixed bottom navigation bar ---


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent, // Transparent to show background image
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          color: _primaryTextColor,
          onPressed: () {
            // Handle back button press
          },
        ),
        title: const Text(
          'Faith Calendar',
          style: TextStyle(
            color: _primaryTextColor,
            fontWeight: FontWeight.w600,
            fontSize: 18,
          ),
        ),
        centerTitle: true,
      ),
      extendBodyBehindAppBar: true,
      body: Column(
        children: [
          // 1. Image Header Section (Fixed Height)
          Container(
            height: 250, // Height to encompass the image and the text background
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.grey.shade200, // Placeholder background
              // Simulating the painting/table illustration
              image: const DecorationImage(
                // Use a placeholder image or a solid color that matches the tone
                image: AssetImage('assets/faith_calendar_placeholder.png'),
                fit: BoxFit.cover,
              ),
            ),
            child: const Stack(
              children: [
                // Content for the background image area
              ],
            ),
          ),
          // 2. Main Content Area (Scrollable)
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  // --- Event Title ---
                  const Padding(
                    padding: EdgeInsets.only(top: 20.0, bottom: 10.0),
                    child: Text(
                      'Easter Sunday Service',
                      style: TextStyle(
                        color: _primaryTextColor,
                        fontSize: 26,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),

                  // --- Main Description ---
                  const Text(
                    'Easter Sunday is the most significant day in the Christian calendar, celebrating the resurrection of Jesus Christ from the dead, described in the New Testament as having occurred on the third day of his burial after his crucifixion by the Romans at Calvary c. 30 AD.',
                    style: TextStyle(
                      color: _primaryTextColor,
                      fontSize: 16,
                      height: 1.5,
                    ),
                  ),

                  // --- Origin Section ---
                  _buildSectionTitle('Origin'),
                  const Text(
                    'The origin of Easter is deeply rooted in Christian theology, marking the fulfillment of prophecies and the cornerstone of Christian faith. It symbolizes hope, renewal, and the promise of eternal life through Christ\'s sacrifice and resurrection.',
                    style: TextStyle(
                      color: _primaryTextColor,
                      fontSize: 16,
                      height: 1.5,
                    ),
                  ),

                  // --- Rituals Section ---
                  _buildSectionTitle('Rituals'),
                  const Text(
                    'Easter rituals often include special church services, such as sunrise services, where believers gather to celebrate the resurrection. Other traditions involve egg hunts, symbolizing new life, and festive meals, reflecting the joy and celebration of the occasion.',
                    style: TextStyle(
                      color: _primaryTextColor,
                      fontSize: 16,
                      height: 1.5,
                    ),
                  ),

                  // --- Time Section ---
                  _buildSectionTitle('Time'),
                  const Text(
                    '10:00 AM - 12:00 PM',
                    style: TextStyle(
                      color: _primaryTextColor,
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),

                  // --- Location Section ---
                  _buildSectionTitle('Location'),
                  const Text(
                    'Grace Community Church, 456 Faith Avenue',
                    style: TextStyle(
                      color: _primaryTextColor,
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 30),
                ],
              ),
            ),
          ),
          // 3. Action Buttons (Fixed at Bottom, above Nav Bar)
          Padding(
            padding: const EdgeInsets.fromLTRB(20.0, 0, 20.0, 10.0),
            child: Column(
              children: [
                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: () {
                      print('Add to My Calendar pressed');
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: _blueAccentColor,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      elevation: 0,
                    ),
                    child: const Text(
                      'Add to My Calendar',
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: OutlinedButton(
                    onPressed: () {
                      print('Join Online Service pressed');
                    },
                    style: OutlinedButton.styleFrom(
                      foregroundColor: _blueAccentColor,
                      side: const BorderSide(color: _blueAccentColor, width: 1.5),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 16),
                    ),
                    child: const Text(
                      'Join Online Service',
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: MainScreen(selectedIndex: 3),
    );
  }
}