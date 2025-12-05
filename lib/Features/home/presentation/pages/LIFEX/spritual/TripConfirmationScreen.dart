import 'package:flutter/material.dart';

import '../../nav_page.dart';

// --- Theme Colors and Constants ---
const Color _kDarkTextColor = Color(0xFF333333);
const Color _kLightTextColor = Color(0xFF666666);
const Color _kPrimaryButtonColor = Color(0xFF13A08D); // Bright blue for the main button
const Color _kIconColor = Color(0xFF333333); // For bottom nav icons
const Color _kLifeXSelectedColor = Color(0xFF333333); // Black/Dark color for the selected LifeX tab

class TripConfirmationScreen extends StatefulWidget {
  const TripConfirmationScreen({super.key});

  @override
  State<TripConfirmationScreen> createState() => _TripConfirmationScreenState();
}

class _TripConfirmationScreenState extends State<TripConfirmationScreen> {
  // --- State Variables ---
  int _selectedIndex = 3; // Initial selection for 'LifeX' tab (index 3)
  bool _isLoading = false; // Example state for button loading

  // --- Helper Methods ---
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    // Implement navigation logic here
  }

  void _viewTripDetails() {
    setState(() {
      _isLoading = true;
    });

    // Simulate an async operation like navigating or fetching data
    Future.delayed(const Duration(seconds: 2), () {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
        // In a real app: Navigator.push(context, MaterialPageRoute(builder: (context) => TripDetailsScreen()));
        print('Navigating to Trip Details...');
      }
    });
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
          'Trip Confirmation',
          style: TextStyle(color: _kDarkTextColor, fontWeight: FontWeight.w500),
        ),
        centerTitle: true,
      ),
      // 2. Body Content
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              const SizedBox(height: 20),

              // Confirmation Ticket/Card Image
              _buildConfirmationCard(context),
              const SizedBox(height: 40),

              // Title and Subtitle Text
              const Text(
                'Your Spiritual Journey is\nConfirmed',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.w800,
                  color: _kDarkTextColor,
                  height: 1.2,
                ),
              ),
              const SizedBox(height: 15),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 10.0),
                child: Text(
                  'We\'re thrilled to confirm your upcoming spiritual trip. Get ready for a transformative experience.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16,
                    height: 1.4,
                    color: _kLightTextColor,
                  ),
                ),
              ),
              const SizedBox(height: 40),

              // Action Button
              _buildActionButton(),
              const SizedBox(height: 20), // Space above nav bar
            ],
          ),
        ),
      ),
      // 3. Bottom Navigation Bar
      bottomNavigationBar: MainScreen(selectedIndex: 3),
    );
  }

  // --- Component Builders ---

  Widget _buildConfirmationCard(BuildContext context) {
    // This Stack recreates the ticket overlayed on the background image
    return SizedBox(
      height: 350,
      width: double.infinity,
      child: Stack(
        alignment: Alignment.topCenter,
        children: [
          // Background Image (Large view of the floor/sky)
          Container(
            height: 300,
            width: double.infinity,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/spritual image16.png'), // Replace with your image
                fit: BoxFit.cover,
              ),
            ),
          ),
          // Ticket Card Overlay (Central element)
          Positioned(
            top: 50,
            child: Container(
              height: 250,
              width: 180,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    spreadRadius: 2,
                    blurRadius: 10,
                    offset: const Offset(0, 5),
                  ),
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: Column(
                  children: [
                    // Main image of the church/temple

                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActionButton() {
    return SizedBox(
      width: double.infinity,
      height: 55,
      child: ElevatedButton(
        onPressed: _isLoading ? null : _viewTripDetails, // Disable button if loading
        style: ElevatedButton.styleFrom(
          backgroundColor: _kPrimaryButtonColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          elevation: 0,
        ),
        child: _isLoading
            ? const SizedBox(
          height: 20,
          width: 20,
          child: CircularProgressIndicator(
            color: Colors.white,
            strokeWidth: 2,
          ),
        )
            : const Text(
          'View Trip Details',
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }


}