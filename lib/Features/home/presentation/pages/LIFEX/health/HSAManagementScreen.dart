import 'package:flutter/material.dart';

import '../../nav_page.dart';



class HSAManagementScreen extends StatefulWidget {
  const HSAManagementScreen({super.key});

  @override
  State<HSAManagementScreen> createState() => _HSAManagementScreenState();
}

class _HSAManagementScreenState extends State<HSAManagementScreen> {
  // --- STATE VARIABLES (Mock Data) ---
  double contributionGoal = 3850.0; // Example Annual limit
  double currentContribution = 1800.0; // Current contributed amount

  // Spending data (used to calculate progress bar lengths)
  final Map<String, double> spendingData = {
    'Medication': 550.0,
    'Doctor Visits': 1200.0,
    'Therapy': 800.0,
    'Other': 200.0,
  };

  // Max spending value for determining relative bar width
  double get _maxSpendingValue {
    if (spendingData.values.isEmpty) return 1.0;
    return spendingData.values.reduce((a, b) => a > b ? a : b);
  }

  // --- COLORS ---
  static const Color primaryColor = Color(0xFF00ADB5); // Teal/Cyan Accent
  static const Color darkHeaderColor = Color(0xFF1E3231); // Dark Teal/Green background
  static const Color lightGreyColor = Color(0xFFF0F5F7); // Light background for spending bars

  // --- STATE MANAGEMENT EXAMPLE ---
  void _increaseContribution(double amount) {
    setState(() {
      currentContribution += amount;
      if (currentContribution > contributionGoal) {
        currentContribution = contributionGoal;
      }
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
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop(); // Handle back button
          },
        ),
        title: const Text(
          'HSA Management',
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black87),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            // --- HEADER / ILLUSTRATION SECTION ---
            _buildHeaderSection(context),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Positioned(
                bottom: 0,
                left: 16,
                right: 16,
                child: Container(
                  height: 150,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    gradient: LinearGradient(
                      colors: [
                        primaryColor.withOpacity(0.8),
                        primaryColor,
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: primaryColor.withOpacity(0.5),
                        blurRadius: 10,
                        offset: const Offset(0, 5),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            // --- Spending Breakdown Section ---
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Spending Breakdown',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Spending Breakdown Bars
                  ...spendingData.entries.map((entry) => Padding(
                    padding: const EdgeInsets.only(bottom: 10.0),
                    child: _buildSpendingBar(entry.key, entry.value),
                  )).toList(),
                ],
              ),
            ),

            const Divider(height: 30, thickness: 1, indent: 16, endIndent: 16),

            // --- Contribution Tracker Section ---
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Contribution Tracker',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 12),
                  _buildContributionTracker(),
                  const SizedBox(height: 8),

                  // Example button to show state change
                  Center(
                    child: ElevatedButton.icon(
                      onPressed: () => _increaseContribution(100.0),
                      icon: const Icon(Icons.add, color: Colors.white),
                      label: const Text('Add \$100 Contribution', style: TextStyle(color: Colors.white)),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: primaryColor,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const Divider(height: 30, thickness: 1, indent: 16, endIndent: 16),

            // --- AI Tip Section ---
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: _buildAITip(),
            ),

            const SizedBox(height: 20),
          ],
        ),
      ),
      // --- BOTTOM NAVIGATION BAR ---
      bottomNavigationBar: MainScreen(selectedIndex: 3),
    );
  }

  // --- WIDGET BUILDERS ---

  Widget _buildHeaderSection(BuildContext context) {
    return Container(
      height: 250,
      width: double.infinity,
      color: darkHeaderColor,
      child: Stack(
        alignment: Alignment.topCenter,
        children: [
          // Wallet Icon (White outline)
          const Padding(
            padding: EdgeInsets.only(top: 40.0),
            child: Icon(
              Icons.account_balance_wallet_outlined,
              color: Colors.white,
              size: 120,
            ),
          ),

          // Teal Gradient Box (below the icon)

        ],
      ),
    );
  }

  Widget _buildSpendingBar(String label, double amount) {
    // Calculate the width of the progress bar relative to the maximum spending value
    double relativeWidth = amount / _maxSpendingValue;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(
          width: 100,
          child: Text(
            label,
            style: const TextStyle(
              fontSize: 15,
              color: primaryColor,
            ),
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Stack(
            children: [
              // Background bar (simulates the light grey bar)
              Container(
                height: 18,
                decoration: BoxDecoration(
                  color: lightGreyColor,
                  borderRadius: BorderRadius.circular(9),
                ),
              ),
              // Foreground bar (the actual progress)
              FractionallySizedBox(
                widthFactor: relativeWidth > 1.0 ? 1.0 : relativeWidth, // Clamp to 100%
                child: Container(
                  height: 18,
                  decoration: BoxDecoration(
                    color: primaryColor,
                    borderRadius: BorderRadius.circular(9),
                  ),
                ),
              ),
            ],
          ),
        ),
        // Displaying the amount (hidden in the original image but often useful)
        // const SizedBox(width: 8),
        // Text('\$${amount.toStringAsFixed(0)}'),
      ],
    );
  }

  Widget _buildContributionTracker() {
    double contributionProgress = currentContribution / contributionGoal;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'This Year vs. Goal',
              style: TextStyle(fontSize: 16, color: Colors.black87),
            ),
            Text(
              // Using currency formatting is better for real apps, but matching the image text '1800'
              '\$${currentContribution.toStringAsFixed(0)}',
              style: const TextStyle(fontSize: 16, color: Colors.black87),
            ),
          ],
        ),
        const SizedBox(height: 10),
        ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: LinearProgressIndicator(
            value: contributionProgress,
            minHeight: 12,
            backgroundColor: lightGreyColor,
            valueColor: const AlwaysStoppedAnimation<Color>(primaryColor),
          ),
        ),
      ],
    );
  }

  Widget _buildAITip() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: lightGreyColor,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.lightbulb_outline, color: primaryColor, size: 20),
              const SizedBox(width: 8),
              const Text(
                'AI Tip',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          const Text(
            'Maxing your annual HSA contribution saves \$800 in taxes.',
            style: TextStyle(
              fontSize: 16,
              color: Colors.black54,
            ),
          ),
        ],
      ),
    );
  }


}