import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';

class FormProgressIndicator extends StatelessWidget {
  final double progress;
  final List<String> steps;
  final int currentStep;

  const FormProgressIndicator({
    super.key,
    required this.progress,
    required this.steps,
    required this.currentStep,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(4.w),
      decoration: BoxDecoration(
        color: AppTheme.surfaceDark,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: AppTheme.primaryGold.withValues(alpha: 0.2),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Application Progress',
                style: AppTheme.darkTheme.textTheme.titleSmall?.copyWith(
                  color: AppTheme.textPrimary,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                '${(progress * 100).toInt()}%',
                style: AppTheme.darkTheme.textTheme.titleSmall?.copyWith(
                  color: AppTheme.primaryGold,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          SizedBox(height: 2.h),
          _buildProgressBar(),
          SizedBox(height: 2.h),
          _buildStepIndicators(),
        ],
      ),
    );
  }

  Widget _buildProgressBar() {
    return Container(
      height: 8,
      decoration: BoxDecoration(
        color: AppTheme.neutralGray.withValues(alpha: 0.3),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Stack(
        children: [
          AnimatedContainer(
            duration: Duration(milliseconds: 300),
            width: progress * 100.w,
            height: 8,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  AppTheme.primaryGold,
                  AppTheme.primaryGoldVariant,
                ],
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
              ),
              borderRadius: BorderRadius.circular(4),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStepIndicators() {
    return Row(
      children: steps.asMap().entries.map((entry) {
        int index = entry.key;
        String step = entry.value;
        bool isCompleted = index < currentStep;
        bool isCurrent = index == currentStep;

        return Expanded(
          child: Row(
            children: [
              Expanded(
                child: Column(
                  children: [
                    Container(
                      width: 8.w,
                      height: 8.w,
                      decoration: BoxDecoration(
                        color: isCompleted
                            ? AppTheme.successGreen
                            : isCurrent
                                ? AppTheme.primaryGold
                                : AppTheme.neutralGray.withValues(alpha: 0.3),
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: isCompleted
                              ? AppTheme.successGreen
                              : isCurrent
                                  ? AppTheme.primaryGold
                                  : AppTheme.neutralGray,
                          width: 2,
                        ),
                      ),
                      child: isCompleted
                          ? CustomIconWidget(
                              iconName: 'check',
                              color: AppTheme.backgroundDark,
                              size: 16,
                            )
                          : isCurrent
                              ? Container(
                                  width: 3.w,
                                  height: 3.w,
                                  decoration: BoxDecoration(
                                    color: AppTheme.backgroundDark,
                                    shape: BoxShape.circle,
                                  ),
                                )
                              : null,
                    ),
                    SizedBox(height: 1.h),
                    Text(
                      step,
                      textAlign: TextAlign.center,
                      style: AppTheme.darkTheme.textTheme.bodySmall?.copyWith(
                        color: isCompleted || isCurrent
                            ? AppTheme.textPrimary
                            : AppTheme.textSecondary,
                        fontWeight:
                            isCurrent ? FontWeight.bold : FontWeight.normal,
                      ),
                    ),
                  ],
                ),
              ),
              if (index < steps.length - 1)
                Container(
                  width: 4.w,
                  height: 2,
                  color: isCompleted
                      ? AppTheme.successGreen
                      : AppTheme.neutralGray.withValues(alpha: 0.3),
                ),
            ],
          ),
        );
      }).toList(),
    );
  }
}
