import 'package:flutter/material.dart';

import '../../nav_page.dart';


// --- FaithCalendarScreen Widget (Stateful) ---
class FaithCalendarScreen extends StatefulWidget {
  const FaithCalendarScreen({super.key});

  @override
  State<FaithCalendarScreen> createState() => _FaithCalendarScreenState();
}

class _FaithCalendarScreenState extends State<FaithCalendarScreen> {
  // State for Bottom Navigation Bar
  // Assuming 'LifeX' is the selected tab initially (index 3)
  int _selectedIndex = 3;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  // Define custom colors
  static const Color darkTextColor = Color(0xFF333333);
  static const Color accentBlue = Color(0xFF1976D2); // Standard blue for selection

  // Helper widget for the Event list tiles
  Widget _buildEventTile(String title, String date) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              // Custom radio button circle look-alike
              Container(
                width: 24,
                height: 24,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.grey, width: 2),
                ),
              ),
              const SizedBox(width: 16),
              Text(
                title,
                style: const TextStyle(
                  fontSize: 16,
                  color: darkTextColor,
                ),
              ),
            ],
          ),
          Text(
            date,
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey[600],
            ),
          ),
        ],
      ),
    );
  }

  // Helper widget for the Add Reminder tiles
  Widget _buildReminderTile(IconData icon, String title) {
    return InkWell(
      onTap: () {
        // Handle reminder action
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16.0),
        child: Row(
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: Colors.grey[100], // Light grey background
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(
                icon,
                color: darkTextColor,
                size: 24,
              ),
            ),
            const SizedBox(width: 16),
            Text(
              title,
              style: const TextStyle(
                fontSize: 16,
                color: darkTextColor,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // --- Widget Build Method ---
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // --- AppBar (Top Section) ---
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            // Handle back button press
          },
        ),
        title: const Text(
          'Faith Calendar',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),

      // --- Body (Scrollable Content) ---
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            // **1. Calendar Header**
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  Icon(Icons.chevron_left),
                  Text(
                    'October 2024',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: darkTextColor,
                    ),
                  ),
                  Icon(Icons.chevron_right),
                ],
              ),
            ),

            // **2. Calendar Grid**
            _buildCalendarGrid(),
            const SizedBox(height: 32),

            // **3. Events Section**
            const Text(
              'Events',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: darkTextColor,
              ),
            ),
            const SizedBox(height: 12),
            _buildEventTile('Fasting...', 'Oct 10'),
            const Divider(height: 1, color: Colors.grey),
            _buildEventTile('Prayer', 'Oct 15'),
            const Divider(height: 1, color: Colors.grey),
            _buildEventTile('Holiday...', 'Oct 20'),
            const Divider(height: 1, color: Colors.grey),
            _buildEventTile('Retreat', 'Oct 25'),
            const SizedBox(height: 40),

            // **4. Add Reminder Section**
            const Text(
              'Add Reminder',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: darkTextColor,
              ),
            ),
            const SizedBox(height: 12),
            _buildReminderTile(Icons.add, 'Daily Devotion'),
            _buildReminderTile(Icons.add, 'Weekly Temple Visit'),
            _buildReminderTile(Icons.calendar_month_outlined, 'Sync with Device Calendar'),
            const SizedBox(height: 40), // Space before bottom nav bar
          ],
        ),
      ),

      // --- Bottom Navigation Bar ---
        bottomNavigationBar: MainScreen(selectedIndex: 3),
    );
  }

  // --- Custom Calendar Grid Widget ---
  Widget _buildCalendarGrid() {
    // Days of the week header (S, M, T, W, T, F, S)
    const List<String> daysOfWeek = ['S', 'M', 'T', 'W', 'T', 'F', 'S'];
    // List of date numbers for October 2024 (starting on a Tuesday/Wednesday for Oct 1st)
    // The provided calendar shows the 1st on Tuesday, so the 29th and 30th wrap correctly.
    const List<String> dates = [
      '', '', '1', '2', '3', '4', '5',
      '6', '7', '8', '9', '10', '11', '12',
      '13', '14', '15', '16', '17', '18', '19',
      '20', '21', '22', '23', '24', '25', '26',
      '27', '28', '29', '30', '', '', '',
    ];

    return Column(
      children: [
        // Days of the Week Row
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: daysOfWeek.map((day) => Expanded(
            child: Center(
              child: Text(
                day,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.grey[600],
                ),
              ),
            ),
          )).toList(),
        ),
        const SizedBox(height: 8),

        // Date Grid
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 7,
            childAspectRatio: 1.0, // Ensures square cells
            mainAxisSpacing: 8,
            crossAxisSpacing: 0,
          ),
          itemCount: dates.length,
          itemBuilder: (context, index) {
            final date = dates[index];
            final isSelected = date == '5'; // Highlight the 5th
            final isEventDay = ['10', '15', '20', '25'].contains(date);

            return Center(
              child: Container(
                width: 35,
                height: 35,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: isSelected ? accentBlue : Colors.transparent,
                ),
                child: Center(
                  child: Text(
                    date,
                    style: TextStyle(
                      color: isSelected ? Colors.white : darkTextColor,
                      fontWeight: isEventDay ? FontWeight.bold : FontWeight.normal,
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}