import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';

class ApprovalAnimationWidget extends StatefulWidget {
  final bool isApproved;
  final VoidCallback? onAnimationComplete;

  const ApprovalAnimationWidget({
    Key? key,
    required this.isApproved,
    this.onAnimationComplete,
  }) : super(key: key);

  @override
  State<ApprovalAnimationWidget> createState() =>
      _ApprovalAnimationWidgetState();
}

class _ApprovalAnimationWidgetState extends State<ApprovalAnimationWidget>
    with TickerProviderStateMixin {
  late AnimationController _checkmarkController;
  late AnimationController _circleController;
  late AnimationController _confettiController;

  late Animation<double> _checkmarkAnimation;
  late Animation<double> _circleAnimation;
  late Animation<double> _confettiAnimation;

  @override
  void initState() {
    super.initState();
    _initializeAnimations();
    _startAnimationSequence();
  }

  void _initializeAnimations() {
    _checkmarkController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );

    _circleController = AnimationController(
      duration: const Duration(milliseconds: 1200),
      vsync: this,
    );

    _confettiController = AnimationController(
      duration: const Duration(milliseconds: 2000),
      vsync: this,
    );

    _checkmarkAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _checkmarkController,
      curve: Curves.elasticOut,
    ));

    _circleAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _circleController,
      curve: Curves.easeOutBack,
    ));

    _confettiAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _confettiController,
      curve: Curves.easeOut,
    ));
  }

  void _startAnimationSequence() async {
    if (widget.isApproved) {
      await _circleController.forward();
      await Future.delayed(const Duration(milliseconds: 200));
      await _checkmarkController.forward();
      await Future.delayed(const Duration(milliseconds: 300));
      await _confettiController.forward();

      if (widget.onAnimationComplete != null) {
        widget.onAnimationComplete!();
      }
    }
  }

  @override
  void dispose() {
    _checkmarkController.dispose();
    _circleController.dispose();
    _confettiController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 40.w,
      height: 40.w,
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Expanding circle background
          AnimatedBuilder(
            animation: _circleAnimation,
            builder: (context, child) {
              return Container(
                width: 40.w * _circleAnimation.value,
                height: 40.w * _circleAnimation.value,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: widget.isApproved
                      ? AppTheme.successGreen.withValues(alpha: 0.2)
                      : AppTheme.errorRed.withValues(alpha: 0.2),
                ),
              );
            },
          ),

          // Main circle
          Container(
            width: 25.w,
            height: 25.w,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color:
                  widget.isApproved ? AppTheme.successGreen : AppTheme.errorRed,
              boxShadow: [
                BoxShadow(
                  color: (widget.isApproved
                          ? AppTheme.successGreen
                          : AppTheme.errorRed)
                      .withValues(alpha: 0.3),
                  blurRadius: 20,
                  spreadRadius: 5,
                ),
              ],
            ),
            child: AnimatedBuilder(
              animation: _checkmarkAnimation,
              builder: (context, child) {
                return Transform.scale(
                  scale: _checkmarkAnimation.value,
                  child: CustomIconWidget(
                    iconName: widget.isApproved ? 'check' : 'close',
                    color: Colors.white,
                    size: 8.w,
                  ),
                );
              },
            ),
          ),

          // Confetti particles
          if (widget.isApproved)
            AnimatedBuilder(
              animation: _confettiAnimation,
              builder: (context, child) {
                return Opacity(
                  opacity: _confettiAnimation.value,
                  child: _buildConfettiParticles(),
                );
              },
            ),
        ],
      ),
    );
  }

  Widget _buildConfettiParticles() {
    return Container(
      width: 50.w,
      height: 50.w,
      child: Stack(
        children: List.generate(12, (index) {
          final angle = (index * 30.0) * (3.14159 / 180);
          final radius = 20.w;
          final x = radius *
              (1 + 0.5 * _confettiAnimation.value) *
              (angle.isNaN ? 0 : math.cos(angle * 180 / 3.14159));
          final y = radius *
              (1 + 0.5 * _confettiAnimation.value) *
              (angle.isNaN ? 0 : math.sin(angle * 180 / 3.14159));

          return Positioned(
            left: 25.w + x,
            top: 25.w + y,
            child: Transform.rotate(
              angle: _confettiAnimation.value * 4 * 3.14159,
              child: Container(
                width: 1.w,
                height: 3.w,
                decoration: BoxDecoration(
                  color: [
                    AppTheme.primaryGold,
                    AppTheme.successGreen,
                    AppTheme.accentBlue,
                  ][index % 3],
                  borderRadius: BorderRadius.circular(0.5.w),
                ),
              ),
            ),
          );
        }),
      ),
    );
  }
}
