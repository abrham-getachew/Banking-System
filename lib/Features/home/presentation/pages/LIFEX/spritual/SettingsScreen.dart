import 'package:flutter/material.dart';

import '../../nav_page.dart';


// --- The main screen widget (Stateful to handle toggle switches and BottomNavigationBar) ---
class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  // State for the bottom navigation bar
  int _selectedIndex = 4; // 'More' tab is the 5th item (index 4)

  // State for the notification toggles
  bool _practiceRemindersEnabled = true; // Defaulted to on, matching the image
  bool _contentUpdatesEnabled = false; // Defaulted to off, matching the image

  // Custom colors derived from the image and app suite
  static const Color _primaryTextColor = Color(0xFF333333);
  static const Color _secondaryTextColor = Color(0xFF6A6A6A);
  static const Color _blueAccentColor = Color(0xFF007AFF); // Blue for toggles and selected nav item
  static const Color _scaffoldBackgroundColor = Colors.white;

  // --- Reusable Widget for a Settings Tile (Navigational) ---
  Widget _buildNavTile({
    required IconData icon,
    required String title,
    required String subtitle,
    required Color iconColor,
  }) {
    return ListTile(
      leading: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: iconColor.withOpacity(0.1), // Light background for icon
          borderRadius: BorderRadius.circular(10),
        ),
        child: Icon(icon, color: iconColor, size: 28),
      ),
      title: Text(
        title,
        style: const TextStyle(
          color: _primaryTextColor,
          fontWeight: FontWeight.w600,
          fontSize: 16,
        ),
      ),
      subtitle: Text(
        subtitle,
        style: const TextStyle(
          color: _secondaryTextColor,
          fontSize: 14,
        ),
      ),
      trailing: const Icon(Icons.arrow_forward_ios, color: Colors.grey, size: 16),
      onTap: () {
        print('$title pressed for navigation.');
      },
      contentPadding: const EdgeInsets.symmetric(horizontal: 0, vertical: 4),
    );
  }

  // --- Reusable Widget for a Notification Switch Tile ---
  Widget _buildSwitchTile({
    required IconData icon,
    required String title,
    required String subtitle,
    required bool value,
    required ValueChanged<bool> onChanged,
  }) {
    return ListTile(
      leading: Icon(icon, color: _primaryTextColor, size: 28),
      title: Text(
        title,
        style: const TextStyle(
          color: _primaryTextColor,
          fontWeight: FontWeight.w600,
          fontSize: 16,
        ),
      ),
      subtitle: Text(
        subtitle,
        style: const TextStyle(
          color: _secondaryTextColor,
          fontSize: 14,
        ),
      ),
      trailing: Switch(
        value: value,
        onChanged: onChanged,
        activeColor: Colors.white,
        activeTrackColor: _blueAccentColor,
        inactiveThumbColor: Colors.white,
        inactiveTrackColor: Colors.grey.shade300,
      ),
      onTap: () {
        // Tapping the row should also toggle the switch
        onChanged(!value);
      },
      contentPadding: const EdgeInsets.symmetric(horizontal: 0, vertical: 4),
    );
  }

  // --- Widget for the fixed bottom navigation bar ---


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: _scaffoldBackgroundColor,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: _primaryTextColor),
          onPressed: () {
            // Handle back button press
          },
        ),
        title: const Text(
          'Settings',
          style: TextStyle(
            color: _primaryTextColor,
            fontWeight: FontWeight.w600,
            fontSize: 18,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            // --- Spiritual Settings Section ---
            const Padding(
              padding: EdgeInsets.only(top: 10.0, bottom: 20.0),
              child: Text(
                'Spiritual Settings',
                style: TextStyle(
                  color: _primaryTextColor,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

            _buildNavTile(
              icon: Icons.explore_outlined,
              title: 'Personalized Paths',
              subtitle: 'Customize your spiritual journey',
              iconColor: const Color(0xFF6B58F2), // Purple tone
            ),
            _buildNavTile(
              icon: Icons.wb_sunny_outlined,
              title: 'Daily Intentions',
              subtitle: 'Set daily intentions and affirmations',
              iconColor: const Color(0xFFE4AD1E), // Yellow/Orange tone
            ),
            _buildNavTile(
              icon: Icons.flag_outlined,
              title: 'Goal Management',
              subtitle: 'Manage your spiritual goals',
              iconColor: const Color(0xFF4CAE50), // Green tone
            ),

            const SizedBox(height: 30),

            // --- Notifications Section ---
            const Text(
              'Notifications',
              style: TextStyle(
                color: _primaryTextColor,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),

            _buildSwitchTile(
              icon: Icons.notifications_none,
              title: 'Practice Reminders',
              subtitle: 'Receive reminders for your spiritual practices',
              value: _practiceRemindersEnabled,
              onChanged: (bool newValue) {
                setState(() {
                  _practiceRemindersEnabled = newValue;
                });
                print('Practice Reminders: $_practiceRemindersEnabled');
              },
            ),
            _buildSwitchTile(
              icon: Icons.campaign_outlined,
              title: 'Content Updates',
              subtitle: 'Get notified about new content and updates',
              value: _contentUpdatesEnabled,
              onChanged: (bool newValue) {
                setState(() {
                  _contentUpdatesEnabled = newValue;
                });
                print('Content Updates: $_contentUpdatesEnabled');
              },
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
      bottomNavigationBar: MainScreen(selectedIndex: 3),
    );
  }
}