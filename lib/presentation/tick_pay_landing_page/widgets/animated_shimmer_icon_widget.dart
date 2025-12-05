import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../../core/app_export.dart';

class AnimatedShimmerIconWidget extends StatefulWidget {
  const AnimatedShimmerIconWidget({super.key});

  @override
  State<AnimatedShimmerIconWidget> createState() =>
      _AnimatedShimmerIconWidgetState();
}

class _AnimatedShimmerIconWidgetState extends State<AnimatedShimmerIconWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _shimmerAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );

    _shimmerAnimation = Tween<double>(
      begin: -1.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    ));

    _animationController.repeat();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _shimmerAnimation,
      builder: (context, child) {
        return Container(
          width: 12.w,
          height: 12.w,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                AppTheme.primaryGold.withValues(alpha: 0.8),
                AppTheme.primaryGold,
                AppTheme.primaryGoldVariant,
              ],
              stops: [
                0.0,
                (_shimmerAnimation.value + 1) / 2,
                1.0,
              ],
            ),
            boxShadow: [
              BoxShadow(
                color: AppTheme.primaryGold.withValues(alpha: 0.3),
                blurRadius: 12,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Center(
            child: CustomIconWidget(
              iconName: 'credit_card',
              color: AppTheme.backgroundDark,
              size: 6.w,
            ),
          ),
        );
      },
    );
  }
}
