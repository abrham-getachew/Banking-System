import 'package:flutter/material.dart';

import '../../nav_page.dart';

// --- Theme Colors and Constants ---
const Color _kPrimaryAccent = Color(0xFF00C7B3); // The bright teal color
const Color _kDarkTextColor = Color(0xFF333333);
const Color _kLightTextColor = Color(0xFF666666);
const Color _kBackgroundColor = Color(0xFFF8F8F8); // Light grey background
const Color _kVaultCardColor = Color(0xFFFDFDFD); // White/very light background for vaults
const Color _kInputFillColor = Color(0xFFEFEFEF); // Light grey fill for input fields

class ChildEducationSavingsScreen extends StatefulWidget {
  const ChildEducationSavingsScreen({super.key});

  @override
  State<ChildEducationSavingsScreen> createState() => _ChildEducationSavingsScreenState();
}

class _ChildEducationSavingsScreenState extends State<ChildEducationSavingsScreen> {
  // --- State Variables ---
  int _selectedIndex = 0; // For the bottom navigation bar
  String _targetAmountInput = ''; // State for the Target Amount input
  String _monthlyContributionInput = ''; // State for the Monthly Contribution input
  String _aiProjectionMessage = 'At your current savings rate, your child\'s college fund will be fully covered in 6 years.';

  // Controllers for text fields (used for state management/retrieval)
  final TextEditingController _targetController = TextEditingController();
  final TextEditingController _monthlyController = TextEditingController();

  // --- Life Cycle Methods ---
  @override
  void initState() {
    super.initState();
    // Initialize controllers and listen for changes if needed for complex logic
  }

  @override
  void dispose() {
    _targetController.dispose();
    _monthlyController.dispose();
    super.dispose();
  }

  // --- Helper Methods ---
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    // In a real app, this would handle navigation
  }

  void _calculateProjection() {
    // In a real app, this would perform the calculation and update _aiProjectionMessage
    // For this clone, we'll just demonstrate state interaction
    String target = _targetController.text;
    String monthly = _monthlyController.text;

    if (target.isEmpty || monthly.isEmpty) {
      setState(() {
        _aiProjectionMessage = 'Please enter both target and contribution amounts to calculate.';
      });
      return;
    }

    // Placeholder logic to demonstrate state change
    setState(() {
      _targetAmountInput = target;
      _monthlyContributionInput = monthly;
      _aiProjectionMessage = 'Based on a goal of \$$target and \$$monthly/month, the new projection is 5 years.';
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
        leading: const BackButton(color: Colors.black),
        title: const Text(
          'Child Education Savings',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.w500),
        ),
        centerTitle: false,
      ),
      // 2. Body Content
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            // Header Image and Text
            _buildHeaderSection(),
            const SizedBox(height: 30),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Savings Vaults Section
                  _buildSectionTitle('Savings Vaults'),
                  const SizedBox(height: 15),
                  _buildVaultItem(
                    vaultName: 'Vault 1',
                    fundName: 'Ethan\'s Education Fund',
                    amount: '\$12,500',
                    imagePath: 'assets/images/family image24.png', // Placeholder
                  ),
                  const SizedBox(height: 15),
                  _buildVaultItem(
                    vaultName: 'Vault 2',
                    fundName: 'Sophia\'s Education Fund',
                    amount: '\$8,750',
                    imagePath: 'assets/images/family image25.png', // Placeholder
                  ),
                  const SizedBox(height: 30),
                  // Growth Calculator Section
                  _buildSectionTitle('Growth Calculator'),
                  const SizedBox(height: 15),
                  _buildGrowthCalculator(),
                  const SizedBox(height: 30),
                  // AI Projection Section
                  _buildSectionTitle('AI Projection'),
                  const SizedBox(height: 15),
                  _buildAIProjection(),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ],
        ),
      ),
      // 3. Bottom Navigation Bar
      bottomNavigationBar: MainScreen(selectedIndex: 3),  );
  }

  // --- Component Builders ---

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: TextStyle(
        fontSize: 22,
        fontWeight: FontWeight.bold,
        color: _kDarkTextColor,
      ),
    );
  }

  Widget _buildHeaderSection() {
    return Container(
      height: 350, // Height of the header section
      width: double.infinity,
      decoration: const BoxDecoration(
        color: Color(0xFF333333), // Dark background for the image
        // Placeholder for the main header image
        image: DecorationImage(
          image: AssetImage('assets/images/family image26.png'), // Replace with your image
          fit: BoxFit.cover,
          colorFilter: ColorFilter.mode(
            Colors.black54, // Darken the image slightly
            BlendMode.darken,
          ),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.only(left: 20.0, right: 20.0, bottom: 20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Secure Your Child\'s Future',
              style: TextStyle(
                color: Colors.white,
                fontSize: 32,
                fontWeight: FontWeight.w900,
                height: 1.2,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'Start planning and saving for your child\'s education with our tailored plans.',
              style: TextStyle(
                color: Colors.white70,
                fontSize: 15,
                height: 1.4,
              ),
            ),
            const SizedBox(height: 15),
            Container(
              height: 4,
              width: 80,
              decoration: BoxDecoration(
                color: _kPrimaryAccent,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildVaultItem({
    required String vaultName,
    required String fundName,
    required String amount,
    required String imagePath,
  }) {
    return Container(
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: _kVaultCardColor,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.05),
            spreadRadius: 1,
            blurRadius: 3,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  vaultName,
                  style: TextStyle(
                    fontSize: 14,
                    color: _kLightTextColor.withOpacity(0.8),
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  fundName,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: _kDarkTextColor,
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  amount,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: _kPrimaryAccent,
                  ),
                ),
              ],
            ),
          ),
          // Placeholder for the child illustration image
          Container(
            width: 100,
            height: 80,
            decoration: BoxDecoration(
              color: Colors.transparent, // Placeholder color
              borderRadius: BorderRadius.circular(8),
              // In a real app, you'd load the image here
              image: const DecorationImage(
                image: AssetImage('assets/placeholder_vault_img.png'), // Replace
                fit: BoxFit.contain,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildGrowthCalculator() {
    return Column(
      children: [
        _buildInputField(
          controller: _targetController,
          hintText: 'Enter target amount',
          keyboardType: TextInputType.number,
        ),
        const SizedBox(height: 15),
        _buildInputField(
          controller: _monthlyController,
          hintText: 'Enter monthly contribution',
          keyboardType: TextInputType.number,
        ),
        const SizedBox(height: 15),
        SizedBox(
          width: double.infinity,
          height: 50,
          child: ElevatedButton(
            onPressed: _calculateProjection,
            style: ElevatedButton.styleFrom(
              backgroundColor: _kPrimaryAccent,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              elevation: 0,
            ),
            child: const Text(
              'Calculate',
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildInputField({
    required TextEditingController controller,
    required String hintText,
    required TextInputType keyboardType,
  }) {
    return Container(
      height: 50,
      decoration: BoxDecoration(
        color: _kInputFillColor,
        borderRadius: BorderRadius.circular(10),
      ),
      child: TextField(
        controller: controller,
        keyboardType: keyboardType,
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: TextStyle(color: _kLightTextColor.withOpacity(0.7)),
          contentPadding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
          border: InputBorder.none, // Remove default border
          isDense: true,
        ),
        style: const TextStyle(color: _kDarkTextColor),
      ),
    );
  }

  Widget _buildAIProjection() {
    return Container(
      padding: const EdgeInsets.all(15.0),
      // AI Projection is just text in the image, but we'll use a container
      // for better visual separation if it were a complex element.
      child: Text(
        _aiProjectionMessage, // Displaying state variable
        style: const TextStyle(
          fontSize: 16,
          height: 1.4,
          color: _kDarkTextColor,
        ),
      ),
    );
  }


}