import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sizer/sizer.dart';

import '../../core/app_export.dart';
import './widgets/page_indicator_widget.dart';
import './widgets/tutorial_navigation_widget.dart';
import './widgets/tutorial_step_widget.dart';

class HowItWorksTutorial extends StatefulWidget {
  const HowItWorksTutorial({Key? key}) : super(key: key);

  @override
  State<HowItWorksTutorial> createState() => _HowItWorksTutorialState();
}

class _HowItWorksTutorialState extends State<HowItWorksTutorial>
    with TickerProviderStateMixin {
  late PageController _pageController;
  late AnimationController _animationController;
  int _currentPage = 0;
  final int _totalPages = 3;

  // Mock tutorial data
  final List<Map<String, dynamic>> tutorialSteps = [
    {
      "stepNumber": 1,
      "title": "Your Chronos Tick Card",
      "description":
          "Get instant access to virtual and physical cards. Make contactless payments anywhere with premium security and style.",
      "imageUrl":
          "https://images.unsplash.com/photo-1556742049-0cfed4f6a45d?fm=jpg&q=60&w=3000&ixlib=rb-4.0.3",
    },
    {
      "stepNumber": 2,
      "title": "Split Your Payments",
      "description":
          "Choose flexible installment plans of 3, 6, or 12 months. See transparent interest rates and total amounts upfront.",
      "imageUrl":
          "https://images.unsplash.com/photo-1554224155-6726b3ff858f?fm=jpg&q=60&w=3000&ixlib=rb-4.0.3",
    },
    {
      "stepNumber": 3,
      "title": "AI-Powered Insights",
      "description":
          "Get personalized credit health tips, spending recommendations, and seamless wallet integration with LifeX goals.",
      "imageUrl":
          "https://images.unsplash.com/photo-1551288049-bebda4e38f71?fm=jpg&q=60&w=3000&ixlib=rb-4.0.3",
    },
  ];

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    _animationController.forward();
  }

  @override
  void dispose() {
    _pageController.dispose();
    _animationController.dispose();
    super.dispose();
  }

  void _nextPage() {
    if (_currentPage < _totalPages - 1) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
      // Haptic feedback for iOS
      HapticFeedback.lightImpact();
    }
  }

  void _skipTutorial() {
    Navigator.pushReplacementNamed(context, '/credit-eligibility-preview');
  }

  void _getStarted() {
    Navigator.pushReplacementNamed(context, '/credit-eligibility-preview');
  }

  void _closeTutorial() {
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.backgroundDark,
      body: SafeArea(
        child: Stack(
          children: [
            // Main content
            Column(
              children: [
                // Header with close button
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 2.h),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // TickPay logo/title
                      Text(
                        'TickPay Tutorial',
                        style:
                            AppTheme.darkTheme.textTheme.titleLarge?.copyWith(
                          color: AppTheme.primaryGold,
                          fontWeight: FontWeight.w700,
                        ),
                      ),

                      // Close button
                      GestureDetector(
                        onTap: _closeTutorial,
                        child: Container(
                          width: 10.w,
                          height: 5.h,
                          decoration: BoxDecoration(
                            color: AppTheme.surfaceDark.withValues(alpha: 0.5),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Center(
                            child: CustomIconWidget(
                              iconName: 'close',
                              color: AppTheme.textSecondary,
                              size: 20,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                // Page indicator
                Container(
                  padding: EdgeInsets.symmetric(vertical: 2.h),
                  child: PageIndicatorWidget(
                    currentPage: _currentPage,
                    totalPages: _totalPages,
                  ),
                ),

                // Tutorial content
                Expanded(
                  child: PageView.builder(
                    controller: _pageController,
                    onPageChanged: (index) {
                      setState(() {
                        _currentPage = index;
                      });
                      HapticFeedback.selectionClick();
                    },
                    itemCount: _totalPages,
                    itemBuilder: (context, index) {
                      final step = tutorialSteps[index];
                      return TutorialStepWidget(
                        title: step["title"] as String,
                        description: step["description"] as String,
                        imageUrl: step["imageUrl"] as String,
                        stepNumber: step["stepNumber"] as int,
                      );
                    },
                  ),
                ),

                // Navigation buttons
                TutorialNavigationWidget(
                  currentPage: _currentPage,
                  totalPages: _totalPages,
                  onNext: _nextPage,
                  onSkip: _skipTutorial,
                  onGetStarted: _getStarted,
                ),
              ],
            ),

            // Animated overlay for smooth transitions
            AnimatedBuilder(
              animation: _animationController,
              builder: (context, child) {
                return Opacity(
                  opacity: 1.0 - _animationController.value,
                  child: Container(
                    color: AppTheme.backgroundDark,
                    width: 100.w,
                    height: 100.h,
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
