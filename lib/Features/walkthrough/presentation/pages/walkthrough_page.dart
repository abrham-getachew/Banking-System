import 'dart:async';
import 'package:flutter/material.dart';
import '../../../../presentation/auth/auth_screen.dart';
import '../../../signup/presentation/pages/signup_page.dart';

class WalkthroughPage extends StatefulWidget {
  const WalkthroughPage({super.key});

  @override
  State<WalkthroughPage> createState() => _WalkthroughPageState();
}

class _WalkthroughPageState extends State<WalkthroughPage>
    with TickerProviderStateMixin {
  final PageController _pageController = PageController();
  late Timer _timer;
  bool _showFinalAnimation = false;

  late AnimationController _animController;
  late Animation<double> _scaleAnimation;

  late AnimationController _pageProgressController;

  final List<Map<String, dynamic>> steps = [
    {
      'bg': Colors.blue,
      'title': 'Welcome to Chronos',
      'subtitle': 'Managing money is easy with Chronos',
      'subtitleColor': Colors.white,
      'subtitleScale': 1.5,
    },
    {
      'bg': Colors.purple,
      'title': 'Welcome to Chronos',
      'subtitle': 'Control your card security in app',
      'subtitleColor': Colors.white,
      'subtitleScale': 1.8,
    },
    {
      'bg': Colors.lightBlueAccent,
      'title': 'Welcome to Chronos',
      'subtitle': 'Send cash abroad hassle free',
      'subtitleColor': Colors.white,
      'subtitleScale': 1.5,
    },
    {
      'bg': Colors.lightBlueAccent,
      'title': 'Welcome to Chronos',
      'subtitle': 'Great foreign exchange',
      'subtitleColor': Colors.white,
      'subtitleScale': 1.5,
    },
    {
      'bg': Colors.purple,
      'title': 'Welcome to Chronos',
      'subtitle': 'Your money is in safe hands',
      'subtitleColor': Colors.white,
      'subtitleScale': 1.5,
    },
    {
      'bg': Colors.purple,
      'title': 'Welcome to Chronos',
      'subtitle': 'Take control with budgeting tools',
      'subtitleColor': Colors.white,
      'subtitleScale': 1.5,
    },
    {
      'bg': Colors.lightBlueAccent,
      'title': 'Welcome to Chronos',
      'subtitle': 'Spend smarter, daily. Let’s go!',
      'subtitleColor': Colors.white,
      'subtitleScale': 1.5,
    },
  ];

  int currentIndex = 0;

  void _goToAuth(BuildContext context) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => const SignupPage()),
    );
  }

  @override
  void initState() {
    super.initState();

    // Final animation for CHRONOS text
    _animController =
        AnimationController(vsync: this, duration: const Duration(seconds: 5));
    _scaleAnimation =
        Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(
          parent: _animController,
          curve: Curves.easeOutBack,
        ));

    // Per-page progress animation
    _pageProgressController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..forward();

    // Auto page change every 2 seconds
    _timer = Timer.periodic(const Duration(seconds: 2), (timer) {
      if (currentIndex < steps.length - 1) {
        _pageController.nextPage(
          duration: const Duration(milliseconds: 500),
          curve: Curves.easeInOut,
        );
      } else {
        _timer.cancel();
        setState(() {
          _showFinalAnimation = true;
        });
        _animController.forward();
        Future.delayed(const Duration(seconds: 3), () {
          _goToAuth(context);
        });
      }
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    _animController.dispose();
    _pageProgressController.dispose();
    _pageController.dispose();
    super.dispose();
  }

  void _onPageChanged(int page) {
    setState(() {
      currentIndex = page;
    });
    _pageProgressController
      ..reset()
      ..forward();
  }

  @override
  Widget build(BuildContext context) {
    final totalSteps = steps.length;
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    if (_showFinalAnimation) {
      return Scaffold(
        backgroundColor: Colors.white,
        body: Center(
          child: ScaleTransition(
            scale: _scaleAnimation,
            child: Text(
              'CHRONOS',
              style: TextStyle(
                color: Colors.amber,
                fontSize: screenWidth * 0.15,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      );
    }

    return Scaffold(
      body: AnimatedContainer(
        duration: const Duration(milliseconds: 400),
        color: steps[currentIndex]['bg'] as Color,
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.04),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: screenHeight * 0.02),

                // Segmented progress bar (7 parts)
                Row(
                  children: List.generate(totalSteps, (i) {
                    return Expanded(
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: screenWidth * 0.004),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(4),
                          child: AnimatedBuilder(
                            animation: _pageProgressController,
                            builder: (context, _) {
                              double value;
                              if (i < currentIndex) {
                                value = 1.0; // fully filled
                              } else if (i == currentIndex) {
                                value = _pageProgressController.value; // animating
                              } else {
                                value = 0.0; // empty
                              }
                              return LinearProgressIndicator(
                                value: value,
                                backgroundColor:
                                Colors.white.withOpacity(0.3),
                                valueColor: const AlwaysStoppedAnimation<Color>(
                                    Colors.white),
                                minHeight: screenHeight * 0.004,
                              );
                            },
                          ),
                        ),
                      ),
                    );
                  }),
                ),

                SizedBox(height: screenHeight * 0.015),

                // PageView
                Expanded(
                  child: PageView.builder(
                    controller: _pageController,
                    onPageChanged: _onPageChanged,
                    itemCount: totalSteps,
                    itemBuilder: (context, index) {
                      final step = steps[index];
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            step['title'] as String,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: screenWidth * 0.05,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                          SizedBox(height: screenHeight * 0.02),
                          Text(
                            step['subtitle'] as String,
                            style: TextStyle(
                              color: step['subtitleColor'] as Color,
                              fontSize: screenWidth *
                                  0.07 *
                                  (step['subtitleScale'] as double),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                ),

                // Buttons
                Padding(
                  padding: EdgeInsets.only(bottom: screenHeight * 0.02),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        height: screenHeight * 0.08,
                        width: screenWidth * 0.35,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white,
                            foregroundColor: Colors.black,
                          ),
                          onPressed: () => _goToAuth(context),
                          child: Text(
                            'Login',
                            style: TextStyle(fontSize: screenWidth * 0.05),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: screenHeight * 0.08,
                        width: screenWidth * 0.35,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white,
                            foregroundColor: Colors.black,
                          ),
                          onPressed: () {
                            if (currentIndex < totalSteps - 1) {
                              _pageController.nextPage(
                                duration: const Duration(milliseconds: 500),
                                curve: Curves.easeInOutCubicEmphasized,
                              );
                            } else {
                              _goToAuth(context);
                            }
                          },
                          child: Text(
                            currentIndex == totalSteps - 1
                                ? 'Login'
                                : 'Signup',
                            style: TextStyle(fontSize: screenWidth * 0.05),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
