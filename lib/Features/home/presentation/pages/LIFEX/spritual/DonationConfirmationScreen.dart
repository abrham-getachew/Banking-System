import 'package:chronos/Features/home/presentation/pages/LIFEX/spritual/spritualHomePageScreen.dart';
import 'package:flutter/material.dart';

import '../../nav_page.dart';


// --- DonationConfirmationScreen Widget (Stateful) ---
class DonationConfirmationScreen extends StatefulWidget {
  const DonationConfirmationScreen({super.key});

  @override
  State<DonationConfirmationScreen> createState() => _DonationConfirmationScreenState();
}

class _DonationConfirmationScreenState extends State<DonationConfirmationScreen> {
  // State for Bottom Navigation Bar
  // Assuming 'BlockHub' is the selected tab initially (index 2)
  int _selectedIndex = 2;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  // Define custom colors
  static const Color primaryBlue = Color(0xFF13A08D);
  static const Color lightGreyButton = Color(0xFFE0E0E0); // Light grey for the secondary button
  static const Color darkTextColor = Color(0xFF333333);

  // --- Widget Build Method ---
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // --- AppBar (Top Section) ---
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.close), // Close icon (X)
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => spritualHomePageScreen(),
              ),
            );

            // Handle close button press
          },
        ),
        title: Center(
          child: const Text(
            'Donation',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),

      // --- Body (Content) ---
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          // Center content vertically and align text to center
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            const SizedBox(height: 48), // Spacing from the top

            // **1. Title**
            const Text(
              'Thank you for your generosity',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 28, // Large, bold text
                fontWeight: FontWeight.bold,
                color: darkTextColor,
                height: 1.2,
              ),
            ),
            const SizedBox(height: 24),

            // **2. Description**
            Text(
              'Your contribution will help us continue to support the community and drive innovation in the blockchain space.',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey[700],
                height: 1.4,
              ),
            ),
            const SizedBox(height: 40),

            // **3. Primary Button: Share donation receipt**
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  // Handle Share button press
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: primaryBlue,
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  elevation: 0,
                ),
                child: const Text(
                  'Share donation receipt',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),

            // **4. Secondary Button: Post anonymously**
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  // Handle Post Anonymously button press
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: lightGreyButton,
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  elevation: 0,
                ),
                child: const Text(
                  'Post anonymously',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: darkTextColor,
                  ),
                ),
              ),
            ),

            // The rest of the screen is empty space, so no more widgets are needed here.
          ],
        ),
      ),

      // --- Bottom Navigation Bar ---
      bottomNavigationBar: MainScreen(selectedIndex: 3),
    );
  }
}