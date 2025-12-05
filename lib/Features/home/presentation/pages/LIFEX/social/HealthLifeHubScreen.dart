import 'package:chronos/Features/home/presentation/pages/LIFEX/social/singledashboard.dart';
import 'package:flutter/material.dart';

import '../../nav_page.dart';
import 'CouplesDashboardScreen.dart';
// Import the three new, separate screen files
  // Make sure this file exists

// --- The main screen widget ---
class LifeStageScreen extends StatefulWidget {
  const LifeStageScreen({super.key});

  @override
  State<LifeStageScreen> createState() => _LifeStageScreenState();
}

class _LifeStageScreenState extends State<LifeStageScreen> {
  // State variable to track the currently selected life stage
  String? _selectedStage;

  // List of available life stages
  final List<String> _lifeStages = [
    'Single',
    'In a Relationship',
    'Started a Family',
  ];

  // Colors based on the image's aesthetic
  static const Color _primaryBackgroundColor = Color(0xFFE9E4DC);
  static const Color _accentColor = Color(0xFF26B0AB);
  static const Color _cardColor = Color(0xFFFFFFFF);
  static const Color _textColor = Color(0xFF333333);
  static const Color _instructionColor = Color(0xFF2E6B68);

  // --- UPDATED: Navigation logic to handle routing to specific pages ---
  void _navigateToNextScreen() {
    if (_selectedStage == null) return; // Guard clause

    Widget nextScreen;
    switch (_selectedStage) {
      case 'Single':
        nextScreen = const SingleDashboard();
        break;
    // --- FIXED: Uncommented the missing cases ---
      case 'In a Relationship':
        nextScreen = const CouplesDashboardScreen();
        break;
      case 'Started a Family':
        nextScreen = const SingleDashboard();
        break;
    // --- FIXED: Added a default case to guarantee assignment ---
      default:
      // This handles any unexpected values and ensures nextScreen is always assigned.
        nextScreen = const SingleDashboard();
    }

    Navigator.push(
      context,
      // The '!' is no longer needed because Dart now knows nextScreen will always have a value.
      MaterialPageRoute(builder: (context) => nextScreen),
    );
  }

  // --- Widget for the choice chips ---
  Widget _buildLifeStageChips() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: _lifeStages.map((stage) {
          final isSelected = _selectedStage == stage;
          return ChoiceChip(
            label: Text(stage),
            selected: isSelected,
            onSelected: (bool selected) {
              setState(() {
                _selectedStage = selected ? stage : null;
              });
            },
            // Custom styling to match the image
            selectedColor: _accentColor.withOpacity(0.1),
            backgroundColor: _cardColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
              side: BorderSide(
                color: isSelected ? _accentColor : Colors.grey.shade300,
                width: 1.5,
              ),
            ),
            labelStyle: TextStyle(
              color: isSelected ? _accentColor : _textColor,
              fontWeight: FontWeight.w600,
            ),
            padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
            elevation: 1,
          );
        }).toList(),
      ),
    );
  }

  // --- Widget for the custom background section ---
  Widget _buildBackgroundSection() {
    return Expanded(
      child: Stack(
        alignment: Alignment.center,
        children: [
          // 1. The image container
          Container(
            alignment: Alignment.topCenter,
            decoration: BoxDecoration(
              color: _primaryBackgroundColor,
              image: const DecorationImage(
                image: AssetImage('assets/images/social image1.png'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          // 2. The gradient overlay
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.black.withOpacity(0.1),
                    Colors.black.withOpacity(0.3),
                  ],
                  stops: const [0.4, 1.0],
                ),
              ),
            ),
          ),
          // 3. The main content (Text and Continue button)
          Positioned(
            bottom: 30,
            left: 30,
            right: 30,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  "What's\nyour current\nlife stage?",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    height: 1.1,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  "This helps us personalize your Family & Relationships\nLife experience.",
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.85),
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                const SizedBox(height: 20),
                SizedBox(
                  width: 180,
                  child: ElevatedButton(
                    onPressed: _selectedStage != null ? _navigateToNextScreen : null,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: _accentColor,
                      foregroundColor: Colors.white,
                      disabledBackgroundColor: Colors.grey.shade400,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      elevation: 5,
                      shadowColor: _accentColor.withOpacity(0.5),
                    ),
                    child: const Text(
                      'Continue',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // --- Widget for the "Ask AI" Card ---
  Widget _buildAskAICard() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Card(
        elevation: 2,
        color: _cardColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
          side: BorderSide(color: Colors.grey.shade300),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: [
              const Icon(Icons.smart_toy_outlined, color: _instructionColor, size: 30),
              const SizedBox(width: 15),
              Expanded(
                child: RichText(
                  text: const TextSpan(
                    style: TextStyle(
                      fontSize: 14,
                      color: _textColor,
                    ),
                    children: <TextSpan>[
                      TextSpan(text: 'Ask AI: "'),
                      TextSpan(
                        text: 'Best financial strategies for my life stage?',
                        style: TextStyle(
                          color: _instructionColor,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      TextSpan(text: '"'),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _primaryBackgroundColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          color: _textColor,
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        title: const Text(
          'Life Stage',
          style: TextStyle(
            color: _textColor,
            fontWeight: FontWeight.w600,
            fontSize: 18,
          ),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: <Widget>[
          _buildBackgroundSection(),
          const SizedBox(height: 20),
          _buildLifeStageChips(),
          const SizedBox(height: 30),
          _buildAskAICard(),
          const SizedBox(height: 20),
        ],
      ),
      bottomNavigationBar: MainScreen(selectedIndex: 3),
    );
  }
}