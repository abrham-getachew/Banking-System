import 'package:flutter/material.dart';

import '../../nav_page.dart';
import 'DonationConfirmationScreen.dart';


// --- DonationDetailsScreen Widget (Stateful) ---
class DonationDetailsScreen extends StatefulWidget {
  // UPDATED: Added a field to hold the cause data passed from the previous screen.
  final Map<String, String> cause;

  // UPDATED: The constructor now requires the 'cause' data.
  const DonationDetailsScreen({super.key, required this.cause});

  @override
  State<DonationDetailsScreen> createState() => _DonationDetailsScreenState();
}

class _DonationDetailsScreenState extends State<DonationDetailsScreen> {
  // State for the checkbox
  bool _isMonthlyGift = false;

  // State for Bottom Navigation Bar
  // Assuming 'LifeX' is the selected tab initially (index 3)
  int _selectedIndex = 3;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  // --- Widget Build Method ---
  @override
  Widget build(BuildContext context) {
    // Define custom colors
    const Color primaryBlue = Color(0xFF13A08D); // Standard Material Blue for the button/progress
    const Color darkTextColor = Color(0xFF333333); // Dark text color

    // Donation Goal Data
    const double goalAmount = 10000.0;
    const double currentAmount = 6000.0;
    final double progress = currentAmount / goalAmount;

    return Scaffold(
      // --- AppBar (Top Section) ---
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            // UPDATED: Make the back button functional.
            Navigator.pop(context);
          },
        ),
        // UPDATED: Use the cause title for the AppBar title.
        title: Text(
          widget.cause['title'] ?? 'Donation Details',
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),

      // --- Body (Scrollable Content) ---
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            // **1. Header Illustration**
            SizedBox(
              width: double.infinity,
              height: 200, // Fixed height for the header image
              // UPDATED: Use the image from the passed 'cause' data.
              child: Image.asset(
                widget.cause['image']!,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(height: 24),

            // **2. Title and Description**
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // UPDATED: Use the title from the 'cause' data.
                  Text(
                    widget.cause['title']!,
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: darkTextColor,
                    ),
                  ),
                  const SizedBox(height: 12),
                  // UPDATED: Use the subtitle from the 'cause' data.
                  Text(
                    widget.cause['subtitle']!,
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey[700],
                      height: 1.4,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 32),

            // **3. Goal and Progress Bar**
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Goal: \$${goalAmount.toStringAsFixed(0)}', // Goal
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: darkTextColor,
                        ),
                      ),
                      Text(
                        // Current amount
                        '\$${currentAmount.toStringAsFixed(0)}',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Colors.grey[700],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  // Linear Progress Indicator
                  LinearProgressIndicator(
                    value: progress, // 6000/10000 = 0.6
                    minHeight: 8, // Set a noticeable height
                    backgroundColor: Colors.grey[300],
                    valueColor: const AlwaysStoppedAnimation<Color>(
                        primaryBlue), // Use primary blue for progress
                    borderRadius: BorderRadius.circular(4),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 32),

            // **4. Donate Now Button**
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => DonationConfirmationScreen(),
                      ),
                    );   // Handle Donate Now button press
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
                    'Donate Now',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 24),

            // **5. Monthly Gift Checkbox**
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0), // Smaller padding for Checkbox
              child: Row(
                children: [
                  Checkbox(
                    value: _isMonthlyGift,
                    onChanged: (bool? newValue) {
                      setState(() {
                        _isMonthlyGift = newValue ?? false;
                      });
                    },
                    activeColor: primaryBlue,
                  ),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        _isMonthlyGift = !_isMonthlyGift;
                      });
                    },
                    child: const Text(
                      'Make this a monthly gift',
                      style: TextStyle(
                        fontSize: 16,
                        color: darkTextColor,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 40), // Space before bottom nav bar
          ],
        ),
      ),

      // --- Bottom Navigation Bar ---
      bottomNavigationBar: MainScreen(selectedIndex: 3),
    );
  }
}