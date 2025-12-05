import 'package:flutter/material.dart';

import '../../nav_page.dart';

class InsuranceMarketplaceScreen extends StatefulWidget {
  const InsuranceMarketplaceScreen({super.key});

  @override
  State<InsuranceMarketplaceScreen> createState() =>
      _InsuranceMarketplaceScreenState();
}

class _InsuranceMarketplaceScreenState
    extends State<InsuranceMarketplaceScreen> {
  // --- STATE VARIABLES ---
  String _selectedPremiumPlan = 'Plan A';
  String _selectedDeductiblePlan = 'Plan B';
  String _selectedCoveragePlan = 'Plan C';

  // --- COLORS ---
  static const Color accentColor = Color(0xFF00ADB5); // Teal/Cyan Accent
  static const Color lightGreyColor = Color(0xFFF0F5F7); // Light background for cards
  static const Color subtleGreenColor = Color(0xFF1E3231); // Dark green for the logo background

  // --- Mock Data ---
  final List<Map<String, dynamic>> insuranceCategories = [
    {'name': 'Health', 'color': subtleGreenColor, 'imagePath': 'assets/images/health image3.png'},
    {'name': 'Dental', 'color': accentColor, 'imagePath': 'assets/images/health image4.png'},
    {'name': 'Life', 'color': accentColor, 'imagePath': 'assets/images/health image5.png'},
  ];

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
            Navigator.of(context).pop(); // Make back button functional
          },
        ),
        title: const Text(
          'Insurance Marketplace',
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black87),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            // --- HERO IMAGE SECTION ---
            Container(
              height: 200,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.white,
                image: const DecorationImage(
                  image: AssetImage('assets/images/health image2.png'), // Replace with your actual asset
                  fit: BoxFit.cover,
                  alignment: Alignment.topCenter,
                ),
              ),
            ),
            const SizedBox(height: 16),

            // --- INSURANCE CATEGORIES (Horizontal Scroll) ---
            _buildCategorySelector(),
            const SizedBox(height: 24),

            // --- QUICK COMPARISON HEADER ---
            const Padding(
              padding: EdgeInsets.only(left: 16.0, bottom: 12.0),
              child: Text(
                'Quick Comparison',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
            ),

            // --- QUICK COMPARISON LIST ---
            _buildQuickComparisonList(),
            const SizedBox(height: 24),

            // --- AI RECOMMENDATION HEADER ---
            const Padding(
              padding: EdgeInsets.only(left: 16.0, bottom: 12.0),
              child: Text(
                'AI Recommendation',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
            ),

            // --- AI RECOMMENDATION CARD ---
            _buildAIRecommendationCard(),
            const SizedBox(height: 20),
          ],
        ),
      ),
      // --- BOTTOM NAVIGATION BAR (Reused from previous screens) ---
      bottomNavigationBar: MainScreen(selectedIndex: 3),
    );
  }

  // --- WIDGET BUILDERS ---

  Widget _buildCategorySelector() {
    return SizedBox(
      height: 180, // Height to accommodate both card and label
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        // --- THE FIX IS APPLIED HERE ---
        itemCount: insuranceCategories.length,
        itemBuilder: (context, index) {
          final category = insuranceCategories[index];

          return Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 150,
                  height: 150,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: category['color'], // Use the distinct color
                  ),
                  // Use an Image instead of an Icon
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.asset(
                      category['imagePath'] as String,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  category['name'] as String,
                  style: const TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
  Widget _buildQuickComparisonList() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        children: [
          // 1. Premium
          _buildComparisonRow(
            title: 'Premium',
            value: '\$250/mo',
            plan: 'Plan A',
            isSelected: _selectedPremiumPlan == 'Plan A',
            illustrationImagePath: 'assets/images/health image5.png', // Image path instead of icon
            onSelect: () => setState(() => _selectedPremiumPlan = 'Plan A'),
          ),
          const SizedBox(height: 8),

          // 2. Deductible
          _buildComparisonRow(
            title: 'Deductible',
            value: '\$1,500',
            plan: 'Plan B',
            isSelected: _selectedDeductiblePlan == 'Plan B',
            illustrationImagePath: 'assets/images/health image6.png', // Image path instead of icon
            onSelect: () => setState(() => _selectedDeductiblePlan = 'Plan B'),
          ),
          const SizedBox(height: 8),

          // 3. Coverage %
          _buildComparisonRow(
            title: 'Coverage %',
            value: '80%',
            plan: 'Plan C',
            isSelected: _selectedCoveragePlan == 'Plan C',
            illustrationImagePath: 'assets/images/health image7.png', // Image path instead of icon
            onSelect: () => setState(() => _selectedCoveragePlan = 'Plan C'),
          ),
        ],
      ),
    );
  }

  Widget _buildComparisonRow({
    required String title,
    required String value,
    required String plan,
    required bool isSelected,
    required String illustrationImagePath, // Changed from IconData to String
    required VoidCallback onSelect,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Left Column (Text and Button)
        Expanded(
          flex: 2,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                value,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                plan,
                style: const TextStyle(
                  fontSize: 14,
                  color: Colors.grey,
                ),
              ),
              const SizedBox(height: 8),
              SizedBox(
                height: 30,
                child: OutlinedButton(
                  onPressed: onSelect,
                  style: OutlinedButton.styleFrom(
                    foregroundColor: isSelected ? Colors.white : accentColor,
                    backgroundColor: isSelected ? accentColor : Colors.white,
                    side: BorderSide(color: isSelected ? accentColor : Colors.grey.shade300),
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                  ),
                  child: Text(
                    'Select',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),

        // Right Column (Illustration)
        Expanded(
          flex: 1,
          child: Container(
            height: 100, // Fixed height for visual alignment
            margin: const EdgeInsets.only(left: 8),
            decoration: BoxDecoration(
              color: lightGreyColor,
              borderRadius: BorderRadius.circular(12),
            ),
            // Use an Image instead of an Icon
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.asset(
                illustrationImagePath,
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildAIRecommendationCard() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Container(
        height: 200,
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          // Use DecorationImage to make the image the background of the container
          image: const DecorationImage(
            image: AssetImage('assets/images/health image8.png'),
            fit: BoxFit.cover, // Use BoxFit.cover to fill the entire space
          ),
        ),
        // Use a Stack to overlay text on top of the background image
        child: Stack(
          children: [
            // Add a gradient overlay for better text readability
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                gradient: LinearGradient(
                  colors: [
                    Colors.black.withOpacity(0.6),
                    Colors.transparent,
                    Colors.black.withOpacity(0.8)
                  ],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
            ),
            // Position the text at the bottom of the card
            Positioned(
              bottom: 16.0,
              left: 16.0,
              right: 16.0,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Manimal Natural',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white, // Change text color to white for visibility
                    ),
                  ),
                  Text(
                    'Complete Network',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.white.withOpacity(0.9), // Make subtitle slightly transparent
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}