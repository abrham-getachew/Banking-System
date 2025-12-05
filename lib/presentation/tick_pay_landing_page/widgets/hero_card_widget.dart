import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../../core/app_export.dart';

class HeroCardWidget extends StatefulWidget {
  const HeroCardWidget({super.key});

  @override
  State<HeroCardWidget> createState() => _HeroCardWidgetState();
}

class _HeroCardWidgetState extends State<HeroCardWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _rotationAnimation;
  late Animation<double> _scaleAnimation;

  int _currentCardIndex = 0;
  final List<Map<String, dynamic>> _cardVariations = [
    {
      'name': 'Gold',
      'gradient': [Color(0xFFFFD700), Color(0xFFB8860B), Color(0xFF9e814e)],
      'shadowColor': Color(0xFFFFD700),
    },
    {
      'name': 'Silver',
      'gradient': [Color(0xFFC0C0C0), Color(0xFF808080), Color(0xFF696969)],
      'shadowColor': Color(0xFFC0C0C0),
    },
    {
      'name': 'Black',
      'gradient': [Color(0xFF2C2C2C), Color(0xFF1A1A1A), Color(0xFF000000)],
      'shadowColor': Color(0xFF2C2C2C),
    },
  ];

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this,
    );

    _rotationAnimation = Tween<double>(
      begin: 0.0,
      end: 0.02,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    ));

    _scaleAnimation = Tween<double>(
      begin: 1.0,
      end: 1.05,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    ));

    _animationController.repeat(reverse: true);

    // Auto-cycle through card variations
    _startCardCycling();
  }

  void _startCardCycling() {
    Future.delayed(const Duration(seconds: 4), () {
      if (mounted) {
        setState(() {
          _currentCardIndex = (_currentCardIndex + 1) % _cardVariations.length;
        });
        _startCardCycling();
      }
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final currentCard = _cardVariations[_currentCardIndex];

    return AnimatedBuilder(
      animation: _animationController,
      builder: (context, child) {
        return Transform.scale(
          scale: _scaleAnimation.value,
          child: Transform(
            alignment: Alignment.center,
            transform: Matrix4.identity()
              ..setEntry(3, 2, 0.001)
              ..rotateX(_rotationAnimation.value)
              ..rotateY(_rotationAnimation.value * 0.5),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 800),
              width: 80.w,
              height: 25.h,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: currentCard['gradient'],
                ),
                boxShadow: [
                  BoxShadow(
                    color: currentCard['shadowColor'].withValues(alpha: 0.3),
                    blurRadius: 20,
                    offset: const Offset(0, 10),
                  ),
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.1),
                    blurRadius: 40,
                    offset: const Offset(0, 20),
                  ),
                ],
              ),
              child: Stack(
                children: [
                  // Card pattern overlay
                  Positioned.fill(
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        gradient: LinearGradient(
                          begin: Alignment.topRight,
                          end: Alignment.bottomLeft,
                          colors: [
                            Colors.white.withValues(alpha: 0.1),
                            Colors.transparent,
                            Colors.black.withValues(alpha: 0.1),
                          ],
                        ),
                      ),
                    ),
                  ),

                  // Card content
                  Padding(
                    padding: EdgeInsets.all(6.w),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'TickPay',
                              style: AppTheme.darkTheme.textTheme.titleLarge
                                  ?.copyWith(
                                color: Colors.white,
                                fontWeight: FontWeight.w700,
                                fontSize: 18.sp,
                              ),
                            ),
                            CustomIconWidget(
                              iconName: 'contactless_payment',
                              color: Colors.white.withValues(alpha: 0.8),
                              size: 6.w,
                            ),
                          ],
                        ),

                        const Spacer(),

                        // Card number placeholder
                        Text(
                          '**** **** **** 2024',
                          style: AppTheme.darkTheme.textTheme.titleMedium
                              ?.copyWith(
                            color: Colors.white.withValues(alpha: 0.9),
                            fontSize: 16.sp,
                            letterSpacing: 2,
                          ),
                        ),

                        SizedBox(height: 2.h),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'CARDHOLDER',
                                  style: AppTheme.darkTheme.textTheme.bodySmall
                                      ?.copyWith(
                                    color: Colors.white.withValues(alpha: 0.7),
                                    fontSize: 10.sp,
                                    letterSpacing: 1,
                                  ),
                                ),
                                Text(
                                  'CHRONOS USER',
                                  style: AppTheme.darkTheme.textTheme.bodyMedium
                                      ?.copyWith(
                                    color: Colors.white,
                                    fontSize: 12.sp,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text(
                                  'EXPIRES',
                                  style: AppTheme.darkTheme.textTheme.bodySmall
                                      ?.copyWith(
                                    color: Colors.white.withValues(alpha: 0.7),
                                    fontSize: 10.sp,
                                    letterSpacing: 1,
                                  ),
                                ),
                                Text(
                                  '12/29',
                                  style: AppTheme.darkTheme.textTheme.bodyMedium
                                      ?.copyWith(
                                    color: Colors.white,
                                    fontSize: 12.sp,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
