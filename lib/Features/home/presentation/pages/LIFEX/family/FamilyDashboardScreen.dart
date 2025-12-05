import 'package:flutter/material.dart';

import '../../nav_page.dart';

// --- Theme Colors and Constants ---
const Color _kBackgroundColor = Color(0xFFF8F8F8); // Light grey background for the main content
const Color _kPrimaryAccent = Color(0xFF13A08D); // Green accent, similar to previous screens
const Color _kDarkTextColor = Color(0xFF333333);
const Color _kLightTextColor = Color(0xFF666666);
const Color _kCardBackgroundLight = Color(0xFFFDFDFD); // Background for most cards
const Color _kHomeSavingsCardBg = Color(0xFFFEECE0); // Specific background for Home Savings card
const Color _kVacationFundCardBg = Color(0xFFE0F7FA); // Specific background for Vacation Fund card

class FamilyDashboardScreen extends StatefulWidget {
  const FamilyDashboardScreen({super.key});

  @override
  State<FamilyDashboardScreen> createState() => _FamilyDashboardScreenState();
}

class _FamilyDashboardScreenState extends State<FamilyDashboardScreen> {
  // --- State Variables (Example for a Stateful Widget) ---
  int _selectedIndex = 0; // For the bottom navigation bar
  double _homeSavingsProgress = 2500 / 10000; // Example for a progress bar
  double _vacationFundProgress = 500 / 5000;

  // --- Helper Methods ---
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    // Implement navigation logic here
  }

  // --- Main Build Method ---
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _kBackgroundColor, // Set scaffold background
      // 1. App Bar
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: const BackButton(color: Colors.black),
        title: const Text(
          'Family Shared Accounts & Budgets',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.w500, fontSize: 18),
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
            // Shared Savings Section
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Text(
                'Shared Savings',
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: _kDarkTextColor,
                ),
              ),
            ),
            const SizedBox(height: 15),
            _buildSharedSavingsCarousel(),
            const SizedBox(height: 30),
            // Expense Breakdown Section
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Text(
                'Expense Breakdown',
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: _kDarkTextColor,
                ),
              ),
            ),
            const SizedBox(height: 15),
            _buildExpenseBreakdownList(),
            const SizedBox(height: 30),
            // Automated Bill Splitting Section
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Text(
                'Automated Bill Splitting',
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: _kDarkTextColor,
                ),
              ),
            ),
            const SizedBox(height: 15),
            _buildBillSplittingList(),
            const SizedBox(height: 30),
            // AI Suggestion Section
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Text(
                'AI Suggestion',
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: _kDarkTextColor,
                ),
              ),
            ),
            const SizedBox(height: 15),
            _buildAiSuggestion(),
            const SizedBox(height: 20), // Extra space at the bottom
          ],
        ),
      ),
      // 3. Bottom Navigation Bar
      bottomNavigationBar: MainScreen(selectedIndex: 3), );
  }

  // --- Component Builders ---

  Widget _buildHeaderSection() {
    return Container(
      height: 300, // Height of the header section
      width: double.infinity,
      decoration: const BoxDecoration(
        color: Color(0xFF333333), // Dark background for the image
        // Placeholder for the main header image
        image: DecorationImage(
          image: AssetImage('assets/images/family image5.png'), // Replace with your image
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
              'Family Shared\nAccounts & Budgets',
              style: TextStyle(
                color: Colors.white,
                fontSize: 32,
                fontWeight: FontWeight.w900,
                height: 1.2,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'Manage shared savings, track expenses, and split bills effortlessly with your family.',
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

  Widget _buildSharedSavingsCarousel() {
    return SizedBox(
      height: 180, // Height of the carousel
      child: ListView(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        children: <Widget>[
          _buildSavingsCard(
            context: context,
            title: 'Home Savings',
            currentAmount: '\$2,500',
            goalAmount: '\$10,000',
            progress: _homeSavingsProgress,
            imagePath: 'assets/images/family image6.png', // Replace with your image
            backgroundColor: _kHomeSavingsCardBg,
          ),
          const SizedBox(width: 15),
          _buildSavingsCard(
            context: context,
            title: 'Vacation Fund',
            currentAmount: '\$500',
            goalAmount: '\$5,000',
            progress: _vacationFundProgress,
            imagePath: 'assets/images/family image7.png', // Replace with your image
            backgroundColor: _kVacationFundCardBg,
          ),
          const SizedBox(width: 15),
          _buildSavingsCard(
            context: context,
            title: 'Emergency Fund',
            currentAmount: '\$1,000',
            goalAmount: '\$3,000',
            progress: 1000 / 3000,
            imagePath: 'assets/images/family image6.png', // Replace with your image
            backgroundColor: _kCardBackgroundLight,
          ),
        ],
      ),
    );
  }

  Widget _buildSavingsCard({
    required BuildContext context,
    required String title,
    required String currentAmount,
    required String goalAmount,
    required double progress,
    required String imagePath,
    required Color backgroundColor,
  }) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.45, // About half the screen width
      padding: const EdgeInsets.all(15.0),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(15.0),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 3,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Center(
              child: Image.asset(
                imagePath,
                fit: BoxFit.contain,
                height: 60, // Adjust image height as needed
              ),
            ),
          ),
          const SizedBox(height: 10),
          Text(
            title,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
              color: _kDarkTextColor,
            ),
          ),
          const SizedBox(height: 5),
          Text(
            '$currentAmount / $goalAmount',
            style: TextStyle(
              fontSize: 13,
              color: _kLightTextColor.withOpacity(0.8),
            ),
          ),
          const SizedBox(height: 8),
          LinearProgressIndicator(
            value: progress,
            backgroundColor: Colors.grey.shade300,
            color: _kPrimaryAccent,
            minHeight: 5,
            borderRadius: BorderRadius.circular(5),
          ),
        ],
      ),
    );
  }

  Widget _buildExpenseBreakdownList() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20.0),
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      decoration: BoxDecoration(
        color: _kCardBackgroundLight,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 3,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          _buildExpenseMemberItem(
            avatarPath: 'assets/images/family image8.png', // Replace with your image
            amount: '\$1,200',
            memberName: 'Family Member 1',
          ),
          _buildExpenseMemberItem(
            avatarPath: 'assets/images/family image10.png', // Replace with your image
            amount: '\$800',
            memberName: 'Family Member 2',
          ),
          _buildExpenseMemberItem(
            avatarPath: 'assets/images/family image9.png', // Replace with your image
            amount: '\$500',
            memberName: 'Family Member 3',
          ),
        ],
      ),
    );
  }

  Widget _buildExpenseMemberItem({
    required String avatarPath,
    required String amount,
    required String memberName,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 15.0),
      child: Row(
        children: [
          CircleAvatar(
            radius: 20,
            backgroundImage: AssetImage(avatarPath), // Replace with NetworkImage if from URL
          ),
          const SizedBox(width: 15),
          Text(
            amount,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: _kDarkTextColor,
            ),
          ),
          const SizedBox(width: 10),
          Text(
            memberName,
            style: TextStyle(
              fontSize: 15,
              color: _kLightTextColor.withOpacity(0.8),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBillSplittingList() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20.0),
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      decoration: BoxDecoration(
        color: _kCardBackgroundLight,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 3,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          _buildBillSplitItem(icon: Icons.home_outlined, amount: '\$2,000', category: 'Rent'),
          _buildBillSplitItem(icon: Icons.access_time, amount: '\$300', category: 'Utilities'),
          _buildBillSplitItem(icon: Icons.shopping_cart_outlined, amount: '\$500', category: 'Groceries'),
        ],
      ),
    );
  }

  Widget _buildBillSplitItem({
    required IconData icon,
    required String amount,
    required String category,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 15.0),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.grey.shade100,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(icon, color: _kLightTextColor, size: 24),
          ),
          const SizedBox(width: 15),
          Text(
            amount,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: _kDarkTextColor,
            ),
          ),
          const SizedBox(width: 10),
          Text(
            category,
            style: TextStyle(
              fontSize: 15,
              color: _kLightTextColor.withOpacity(0.8),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAiSuggestion() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20.0),
      padding: const EdgeInsets.all(20.0),
      decoration: BoxDecoration(
        color: _kCardBackgroundLight,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 3,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: RichText(
        text: TextSpan(
          style: const TextStyle(
            fontSize: 16,
            height: 1.4,
            color: _kDarkTextColor,
          ),
          children: <TextSpan>[
            const TextSpan(text: 'If each family member contributes '),
            const TextSpan(
              text: '\$50/month',
              style: TextStyle(fontWeight: FontWeight.bold, color: _kPrimaryAccent),
            ),
            const TextSpan(text: ', you\'ll reach your goal in '),
            const TextSpan(
              text: '8 months',
              style: TextStyle(fontWeight: FontWeight.bold, color: _kPrimaryAccent),
            ),
            const TextSpan(text: '.'),
          ],
        ),
      ),
    );
  }


}