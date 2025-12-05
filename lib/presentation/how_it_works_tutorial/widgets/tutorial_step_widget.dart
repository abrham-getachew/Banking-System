import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';

class TutorialStepWidget extends StatelessWidget {
  final String title;
  final String description;
  final String imageUrl;
  final int stepNumber;

  const TutorialStepWidget({
    Key? key,
    required this.title,
    required this.description,
    required this.imageUrl,
    required this.stepNumber,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100.w,
      padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 4.h),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Step indicator
          Container(
            width: 12.w,
            height: 6.h,
            decoration: BoxDecoration(
              color: AppTheme.primaryGold,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Center(
              child: Text(
                stepNumber.toString(),
                style: AppTheme.darkTheme.textTheme.titleMedium?.copyWith(
                  color: AppTheme.backgroundDark,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ),
          SizedBox(height: 4.h),

          // Illustration
          Container(
            width: 70.w,
            height: 25.h,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              color: AppTheme.surfaceDark.withValues(alpha: 0.3),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: CustomImageWidget(
                imageUrl: imageUrl,
                width: 70.w,
                height: 25.h,
                fit: BoxFit.cover,
              ),
            ),
          ),
          SizedBox(height: 4.h),

          // Title
          Text(
            title,
            textAlign: TextAlign.center,
            style: AppTheme.darkTheme.textTheme.headlineSmall?.copyWith(
              color: AppTheme.textPrimary,
              fontWeight: FontWeight.w700,
            ),
          ),
          SizedBox(height: 2.h),

          // Description
          Text(
            description,
            textAlign: TextAlign.center,
            style: AppTheme.darkTheme.textTheme.bodyLarge?.copyWith(
              color: AppTheme.textSecondary,
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }
}
