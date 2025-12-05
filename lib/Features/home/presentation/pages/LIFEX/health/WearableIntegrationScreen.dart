import 'package:flutter/material.dart';

import '../../nav_page.dart';


class WearableIntegrationScreen extends StatefulWidget {
  const WearableIntegrationScreen({super.key});

  @override
  State<WearableIntegrationScreen> createState() => _WearableIntegrationScreenState();
}

class _WearableIntegrationScreenState extends State<WearableIntegrationScreen> {
  // --- STATE VARIABLES (Mock Data) ---
  int _steps = 8450;
  double _sleepHours = 7.5;
  int _heartRate = 72;
  int _caloriesBurned = 2150;
  String _healthAlert = 'Heart rate above average during sleep';

  // State for sync status (demonstrating statefulness)
  final Map<String, bool> _syncStatus = {
    'Fitbit': true, // Assume Fitbit is synced
    'Apple Watch': false,
    'Oura': false,
    'Garmin': false,
  };

  // --- COLORS ---
  static const Color accentColor = Color(0xFF00ADB5); // Teal/Cyan Accent
  static const Color lightCardColor = Color(0xFFF0F5F7); // Light background for metric cards
  static const Color headerBackgroundColor = Color(0xFFE0E0E0); // Light grey/beige for the top section

  // --- STATE MANAGEMENT EXAMPLE ---
  void _syncDevice(String device) {
    setState(() {
      // Toggle the sync status for the tapped device
      _syncStatus[device] = !(_syncStatus[device] ?? false);

      // If a device is synced, update stats for demonstration
      if (_syncStatus[device] == true) {
        _steps = 9000;
        _heartRate = 68;
        _healthAlert = 'New device synced! Stats updated.';
      } else {
        _steps = 8450; // Revert or adjust mock data
        _heartRate = 72;
        _healthAlert = 'Heart rate above average during sleep';
      }
    });
    // In a real app, this would trigger an actual device connection
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
            Navigator.of(context).pop(); // Correct back navigation
          },
        ),
        title: const Text(
          'Wearable Integration',
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black87),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            // --- HERO HEADER SECTION ---
            _buildHeaderSection(),

            // --- SYNC DEVICES SECTION ---
            _buildSyncDevicesSection(),

            // --- METRICS DASHBOARD HEADER ---
            const Padding(
              padding: EdgeInsets.only(left: 16.0, top: 24.0, bottom: 12.0),
              child: Text(
                'Metrics Dashboard',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
            ),

            // --- METRICS DASHBOARD (Stateful) ---
            _buildMetricsDashboard(),

            // --- HEALTH ALERTS (Now a Card) ---
            _buildHealthAlerts(),

            // --- AI SUGGESTION ---
            _buildAISuggestion(),

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
      // The color property is replaced by a decoration to allow for an image
      decoration: BoxDecoration(
        color: headerBackgroundColor, // Fallback color
        image: DecorationImage(
          // IMPORTANT: Replace with your actual image path in assets
          image: const AssetImage('assets/images/health image25.png'),
          fit: BoxFit.cover, // Ensures the image covers the container
          // Add a color filter to darken the image so text is more readable

        ),
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Text and Button

        ],
      ),
    );
  }

  Widget _buildSyncDevicesSection() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Sync Devices',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 12),
          ..._syncStatus.keys.map((device) => _buildDeviceTile(
            device,
            _syncStatus[device] ?? false,
          )).toList(),
        ],
      ),
    );
  }

  Widget _buildDeviceTile(String device, bool isSynced) {
    return ListTile(
      onTap: () => _syncDevice(device), // Trigger state change
      contentPadding: EdgeInsets.zero,
      leading: Icon(
        Icons.watch_outlined,
        color: isSynced ? accentColor : Colors.grey.shade400,
      ),
      title: Text(
        device,
        style: TextStyle(
          fontWeight: FontWeight.w500,
          color: isSynced ? Colors.black87 : Colors.grey.shade600,
        ),
      ),
      trailing: Icon(
        isSynced ? Icons.check_circle : Icons.add_circle_outline,
        color: isSynced ? accentColor : Colors.grey.shade400,
      ),
    );
  }

  Widget _buildMetricsDashboard() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        children: [
          Row(
            children: <Widget>[
              // Steps Card (Stateful)
              Expanded(
                child: _buildStatCard(
                  title: 'Steps',
                  value: _steps.toString(),
                ),
              ),
              const SizedBox(width: 12),
              // Sleep Hours Card (Stateful)
              Expanded(
                child: _buildStatCard(
                  title: 'Sleep Hours',
                  value: _sleepHours.toString(),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: <Widget>[
              // Heart Rate Card (Stateful)
              Expanded(
                child: _buildStatCard(
                  title: 'Heart Rate',
                  value: '$_heartRate bpm',
                ),
              ),
              const SizedBox(width: 12),
              // Calories Burned Card (Stateful)
              Expanded(
                child: _buildStatCard(
                  title: 'Calories Burned',
                  value: _caloriesBurned.toString(),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // UPDATED to include a border
  Widget _buildStatCard({
    required String title,
    required String value,
  }) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.teal[100]!, // The requested border color
          width: 2,
        ),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Card(
        color: lightCardColor,
        elevation: 0,
        margin: EdgeInsets.zero,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        child: Container(
          padding: const EdgeInsets.all(16.0),
          height: 100, // Fixed height for alignment
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                title,
                style: const TextStyle(
                  fontSize: 14,
                  color: Colors.black54,
                ),
              ),
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

  // UPDATED to be a styled Card
  Widget _buildHealthAlerts() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Health Alerts',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 12),
          Card(
            elevation: 2,
            color: Colors.red[50],
            shadowColor: Colors.red.withOpacity(0.2),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
              side: BorderSide(color: Colors.red[200]!),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: [
                  Icon(Icons.warning_amber_rounded, color: Colors.red[700], size: 30),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          _healthAlert, // State-driven alert text
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.black87,
                          ),
                        ),
                        const SizedBox(height: 4),
                        const Text(
                          '1 hour ago',
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAISuggestion() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'AI Suggestion',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 12),
          Container(
            height: 200,
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.brown.shade200, // Placeholder for a themed image
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Center(
              // Placeholder for the custom AI visual
              child: Text(
                'AI Recommendation Placeholder',
                style: TextStyle(
                  fontStyle: FontStyle.italic,
                  color: Colors.black54,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }


}