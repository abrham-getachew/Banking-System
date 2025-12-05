import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';

class ProgressAnimationWidget extends StatefulWidget {
  final VoidCallback? onComplete;

  const ProgressAnimationWidget({
    Key? key,
    this.onComplete,
  }) : super(key: key);

  @override
  State<ProgressAnimationWidget> createState() =>
      _ProgressAnimationWidgetState();
}

class _ProgressAnimationWidgetState extends State<ProgressAnimationWidget>
    with TickerProviderStateMixin {
  late AnimationController _progressController;
  late AnimationController _shimmerController;
  late Animation<double> _progressAnimation;
  late Animation<double> _shimmerAnimation;

  int _currentStage = 0;
  final List<String> _stages = [
    'Analyzing Profile',
    'Checking Credit Health',
    'Calculating Limit'
  ];

  @override
  void initState() {
    super.initState();
    _initializeAnimations();
    _startProgressAnimation();
  }

  void _initializeAnimations() {
    _progressController = AnimationController(
      duration: const Duration(seconds: 6),
      vsync: this,
    );

    _shimmerController = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    );

    _progressAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _progressController,
      curve: Curves.easeInOut,
    ));

    _shimmerAnimation = Tween<double>(
      begin: -1.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _shimmerController,
      curve: Curves.easeInOut,
    ));

    _shimmerController.repeat();
  }

  void _startProgressAnimation() {
    _progressController.addListener(() {
      final progress = _progressAnimation.value;
      final newStage = (progress * 3).floor().clamp(0, 2);

      if (newStage != _currentStage) {
        setState(() {
          _currentStage = newStage;
        });
      }

      if (progress >= 1.0) {
        Future.delayed(const Duration(milliseconds: 500), () {
          widget.onComplete?.call();
        });
      }
    });

    _progressController.forward();
  }

  @override
  void dispose() {
    _progressController.dispose();
    _shimmerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: Listenable.merge([_progressAnimation, _shimmerAnimation]),
      builder: (context, child) {
        return Container(
          width: 85.w,
          padding: EdgeInsets.all(4.w),
          decoration: BoxDecoration(
            color: AppTheme.darkTheme.colorScheme.surface,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: AppTheme.primaryGold.withValues(alpha: 0.2),
              width: 1,
            ),
          ),
          child: Column(
            children: [
              _buildProgressBar(),
              SizedBox(height: 3.h),
              _buildStageIndicators(),
            ],
          ),
        );
      },
    );
  }

  Widget _buildProgressBar() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Credit Assessment in Progress',
          style: AppTheme.darkTheme.textTheme.titleMedium?.copyWith(
            color: AppTheme.textPrimary,
            fontWeight: FontWeight.w600,
          ),
        ),
        SizedBox(height: 2.h),
        Container(
          height: 8,
          decoration: BoxDecoration(
            color: AppTheme.neutralGray.withValues(alpha: 0.2),
            borderRadius: BorderRadius.circular(4),
          ),
          child: Stack(
            children: [
              Container(
                width: 85.w * 0.85 * _progressAnimation.value,
                height: 8,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      AppTheme.primaryGold,
                      AppTheme.primaryGold.withValues(alpha: 0.8),
                    ],
                  ),
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
              if (_progressAnimation.value < 1.0)
                Positioned(
                  left: (85.w * 0.85 * _progressAnimation.value) - 20,
                  child: Container(
                    width: 40,
                    height: 8,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight,
                        colors: [
                          Colors.transparent,
                          AppTheme.primaryGold.withValues(alpha: 0.3),
                          Colors.transparent,
                        ],
                        stops: [
                          0.0,
                          _shimmerAnimation.value.clamp(0.0, 1.0),
                          1.0,
                        ],
                      ),
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                ),
            ],
          ),
        ),
        SizedBox(height: 1.h),
        Text(
          '${(_progressAnimation.value * 100).toInt()}% Complete',
          style: AppTheme.darkTheme.textTheme.bodySmall?.copyWith(
            color: AppTheme.textSecondary,
          ),
        ),
      ],
    );
  }

  Widget _buildStageIndicators() {
    return Column(
      children: List.generate(_stages.length, (index) {
        final isCompleted = index < _currentStage;
        final isActive =
            index == _currentStage && _progressAnimation.value < 1.0;
        final isUpcoming = index > _currentStage;

        return Container(
          margin: EdgeInsets.only(bottom: 1.5.h),
          child: Row(
            children: [
              Container(
                width: 6.w,
                height: 6.w,
                decoration: BoxDecoration(
                  color: isCompleted
                      ? AppTheme.successGreen
                      : isActive
                          ? AppTheme.primaryGold
                          : AppTheme.neutralGray.withValues(alpha: 0.3),
                  shape: BoxShape.circle,
                  border: isActive
                      ? Border.all(
                          color: AppTheme.primaryGold.withValues(alpha: 0.5),
                          width: 2,
                        )
                      : null,
                ),
                child: isCompleted
                    ? CustomIconWidget(
                        iconName: 'check',
                        color: AppTheme.backgroundDark,
                        size: 3.w,
                      )
                    : isActive
                        ? Container(
                            width: 2.w,
                            height: 2.w,
                            decoration: BoxDecoration(
                              color: AppTheme.backgroundDark,
                              shape: BoxShape.circle,
                            ),
                          )
                        : null,
              ),
              SizedBox(width: 3.w),
              Expanded(
                child: Text(
                  _stages[index],
                  style: AppTheme.darkTheme.textTheme.bodyMedium?.copyWith(
                    color: isCompleted || isActive
                        ? AppTheme.textPrimary
                        : AppTheme.textSecondary,
                    fontWeight: isActive ? FontWeight.w600 : FontWeight.w400,
                  ),
                ),
              ),
              if (isActive)
                SizedBox(
                  width: 4.w,
                  height: 4.w,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    valueColor: AlwaysStoppedAnimation<Color>(
                      AppTheme.primaryGold,
                    ),
                  ),
                ),
            ],
          ),
        );
      }),
    );
  }
}
