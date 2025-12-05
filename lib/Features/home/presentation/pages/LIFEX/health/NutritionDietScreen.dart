import 'package:flutter/material.dart';

import '../../nav_page.dart';



class NutritionDietScreen extends StatefulWidget {
  const NutritionDietScreen({super.key});

  @override
  State<NutritionDietScreen> createState() => _NutritionDietScreenState();
}

class _NutritionDietScreenState extends State<NutritionDietScreen> {
  // --- STATE VARIABLES (Mock Data) ---
  int _caloriesGoal = 2000;
  int _proteinGoal = 100;
  int _fatGoal = 70;
  int _carbsGoal = 250;

  // Meal plan state (can be updated by AI or user action)
  final List<Map<String, dynamic>> _mealSuggestions = [
    {
      'time': 'Breakfast',
      'description': 'Oatmeal with berries and nuts',
      'image_url': 'assets/images/health image17.png', // Placeholder for asset
    },
    {
      'time': 'Lunch',
      'description': 'Grilled chicken salad with mixed greens',
      'image_url': 'assets/images/health image18.png', // Placeholder for asset
    },
    {
      'time': 'Dinner',
      'description': 'Baked salmon with roasted vegetables',
      'image_url': 'assets/images/health image19.png', // Placeholder for asset
    },
  ];

  // --- COLORS ---
  static const Color accentColor = Color(0xFF00ADB5); // Teal/Cyan Accent
  static const Color darkHeaderColor = Color(0xFF4C6656); // Dark olive/green for the header
  static const Color iconPanelGradientStart = Color(0xFF33D4C4);
  static const Color iconPanelGradientEnd = Color(0xFF00ADB5);
  static const Color darkTextColor = Color(0xFF1E3231);

  // --- STATE MANAGEMENT EXAMPLE ---
  void _getNewPlan() {
    // Simulate updating the diet plan and goals
    setState(() {
      _caloriesGoal = 1800;
      _proteinGoal = 120;
      _mealSuggestions[0]['description'] = 'Scrambled eggs with spinach';
    });
    // In a real app, this would trigger an API call and data refresh
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Fetching new personalized plan...')),
    );
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
            // Handle back navigation
          },
        ),
        title: const Text(
          'Nutrition & Diet Plans',
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

            // --- ICON PANEL SECTION ---
            _buildIconPanel(),

            // --- DAILY NUTRITION GOALS ---
            _buildDailyGoals(),

            // --- MEAL SUGGESTIONS ---
            _buildMealSuggestions(),

            // --- AI MEAL INSIGHTS ---
            _buildAIInsights(),

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
      // Use BoxDecoration to add a background image
      decoration: BoxDecoration(
        // The color can act as a fallback
        color: darkHeaderColor,
        image: DecorationImage(
          // Replace with your actual image path
          image: const AssetImage('assets/images/health image15.png'),
          fit: BoxFit.cover,
          // Add a dark overlay for better text contrast

        ),
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Plate Illustration Placeholder (Dark Brown Plate)
          // This can be removed or kept depending on your design preference
          Container(
            width: 200,
            height: 200,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
             // color: Colors.brown.shade400.withOpacity(0.3), // Made it semi-transparent
            ),
          ),

          // Example Text and Button (You can customize this)

        ],
      ),
    );
  }

  Widget _buildIconPanel() {
    return Container(
      height: 200,
      width: double.infinity,
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        // Add the image from assets as the background
        image: DecorationImage(
          // Replace with your actual image path from assets
          image: const AssetImage('assets/images/health image16.png'),
          fit: BoxFit.cover, // Make the image cover the entire container
          // Add a color filter to darken the image for better text contrast
          colorFilter: ColorFilter.mode(
            Colors.black.withOpacity(0.4),
            BlendMode.darken,
          ),
        ),

      ),
      child: const Column(
        // You can add child widgets here, like icons or text.
        // For example:

      ),
    );
  }

  Widget _buildDailyGoals() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Daily Nutrition Goals',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 8),
          // Goals text linked to state
          Text(
            'Calories: $_caloriesGoal | Protein: $_proteinGoal g | Fat: $_fatGoal g | Carbs: $_carbsGoal g',
            style: const TextStyle(
              fontSize: 16,
              color: Colors.black54,
            ),
          ),
          const SizedBox(height: 24),
        ],
      ),
    );
  }

  Widget _buildMealSuggestions() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Meal Suggestions',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 12),
          ..._mealSuggestions.map((meal) => _buildMealTile(
            meal['time'] as String,
            meal['description'] as String,
          )).toList(),
          const SizedBox(height: 24),
        ],
      ),
    );
  }

  Widget _buildMealTile(String time, String description) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  time,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: darkTextColor,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  description,
                  style: const TextStyle(
                    fontSize: 16,
                    color: Colors.black54,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 16),
          // Image placeholder
          Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: Colors.grey.shade200,
              // In a real app, use: image: DecorationImage(image: AssetImage(imageUrl), fit: BoxFit.cover),
            ),
            child: const Center(
              child: Icon(Icons.food_bank, color: Colors.grey, size: 30),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAIInsights() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      // Wrap the content in a Card for better visual separation
      child: Card(
        elevation: 0, // Use a flat design
        color: accentColor.withOpacity(0.1), // Light teal background
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
          side: BorderSide(color: accentColor.withOpacity(0.3)), // Subtle border
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Add an icon for visual interest
              Icon(Icons.lightbulb_outline, color: accentColor, size: 30),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'AI Meal Insights',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: darkTextColor,
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      'Reducing sugar intake by 10g/day can lower your risk of diabetes by 8%.',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.black54,
                        height: 1.4, // Improve line spacing for readability
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }


}