import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../../core/app_export.dart';

class RiskMeterWidget extends StatefulWidget {
  final int riskScore;
  final VoidCallback onTap;

  const RiskMeterWidget({
    Key? key,
    required this.riskScore,
    required this.onTap,
  }) : super(key: key);

  @override
  State<RiskMeterWidget> createState() => _RiskMeterWidgetState();
}

class _RiskMeterWidgetState extends State<RiskMeterWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _needleAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: AppTheme.aiAnimation,
      vsync: this,
    );
    _needleAnimation = Tween<double>(
      begin: 0.0,
      end: widget.riskScore / 100.0,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeOutBack,
    ));
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  Color _getRiskColor(int score) {
    if (score <= 30) return AppTheme.successGreen;
    if (score <= 70) return AppTheme.warningAmber;
    return AppTheme.errorRed;
  }

  String _getRiskLabel(int score) {
    if (score <= 30) return 'Conservative';
    if (score <= 70) return 'Moderate';
    return 'Aggressive';
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: Container(
        width: 80.w,
        height: 80.w,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: AppTheme.darkTheme.colorScheme.surface,
          boxShadow: [
            BoxShadow(
              color: AppTheme.darkTheme.colorScheme.shadow,
              blurRadius: 12.0,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Stack(
          alignment: Alignment.center,
          children: [
            // Background circle with gradient
            Container(
              width: 75.w,
              height: 75.w,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: RadialGradient(
                  colors: [
                    AppTheme.darkTheme.colorScheme.surface,
                    AppTheme.darkTheme.colorScheme.surface
                        .withValues(alpha: 0.8),
                  ],
                ),
              ),
            ),
            // Risk zones
            CustomPaint(
              size: Size(70.w, 70.w),
              painter: RiskZonesPainter(),
            ),
            // Animated needle
            AnimatedBuilder(
              animation: _needleAnimation,
              builder: (context, child) {
                return CustomPaint(
                  size: Size(70.w, 70.w),
                  painter: NeedlePainter(
                    progress: _needleAnimation.value,
                    color: _getRiskColor(widget.riskScore),
                  ),
                );
              },
            ),
            // Center content
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  '${widget.riskScore}',
                  style: AppTheme.darkTheme.textTheme.displaySmall?.copyWith(
                    color: _getRiskColor(widget.riskScore),
                    fontWeight: FontWeight.w700,
                  ),
                ),
                SizedBox(height: 1.h),
                Text(
                  _getRiskLabel(widget.riskScore),
                  style: AppTheme.darkTheme.textTheme.titleMedium?.copyWith(
                    color: AppTheme.textSecondary,
                  ),
                ),
                SizedBox(height: 0.5.h),
                Text(
                  'Risk Score',
                  style: AppTheme.darkTheme.textTheme.bodySmall?.copyWith(
                    color: AppTheme.textTertiary,
                  ),
                ),
              ],
            ),
            // Tap indicator
            Positioned(
              bottom: 8.w,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 1.h),
                decoration: BoxDecoration(
                  color: AppTheme.chronosGold.withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: AppTheme.chronosGold.withValues(alpha: 0.3),
                  ),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    CustomIconWidget(
                      iconName: 'touch_app',
                      color: AppTheme.chronosGold,
                      size: 4.w,
                    ),
                    SizedBox(width: 1.w),
                    Text(
                      'Tap for details',
                      style: AppTheme.darkTheme.textTheme.bodySmall?.copyWith(
                        color: AppTheme.chronosGold,
                        fontSize: 10.sp,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class RiskZonesPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2 - 20;
    final paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 8.0;

    // Conservative zone (0-30%)
    paint.color = AppTheme.successGreen.withValues(alpha: 0.3);
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      -math.pi,
      math.pi * 0.6,
      false,
      paint,
    );

    // Moderate zone (30-70%)
    paint.color = AppTheme.warningAmber.withValues(alpha: 0.3);
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      -math.pi + math.pi * 0.6,
      math.pi * 0.8,
      false,
      paint,
    );

    // Aggressive zone (70-100%)
    paint.color = AppTheme.errorRed.withValues(alpha: 0.3);
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      -math.pi + math.pi * 1.4,
      math.pi * 0.6,
      false,
      paint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class NeedlePainter extends CustomPainter {
  final double progress;
  final Color color;

  NeedlePainter({required this.progress, required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2 - 30;

    // Calculate needle angle based on progress
    final angle = -math.pi + (math.pi * 2 * progress);

    final needleEnd = Offset(
      center.dx + radius * math.cos(angle),
      center.dy + radius * math.sin(angle),
    );

    // Draw needle
    final needlePaint = Paint()
      ..color = color
      ..strokeWidth = 4.0
      ..strokeCap = StrokeCap.round;

    canvas.drawLine(center, needleEnd, needlePaint);

    // Draw center dot
    final centerPaint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;

    canvas.drawCircle(center, 8.0, centerPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return oldDelegate is NeedlePainter && oldDelegate.progress != progress;
  }
}
