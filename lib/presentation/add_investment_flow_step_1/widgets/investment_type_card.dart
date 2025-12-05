import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../../core/app_export.dart';

class InvestmentTypeCard extends StatelessWidget {
  final String title;
  final String description;
  final String iconName;
  final String riskLevel;
  final bool isSelected;
  final VoidCallback onTap;

  const InvestmentTypeCard({
    super.key,
    required this.title,
    required this.description,
    required this.iconName,
    required this.riskLevel,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: AppTheme.standardAnimation,
        margin: EdgeInsets.symmetric(horizontal: 2.w, vertical: 1.h),
        padding: EdgeInsets.all(4.w),
        decoration: BoxDecoration(
          color: AppTheme.darkTheme.colorScheme.surface,
          borderRadius: BorderRadius.circular(16.0),
          border: Border.all(
            color: isSelected ? AppTheme.chronosGold : AppTheme.dividerSubtle,
            width: isSelected ? 2.0 : 1.0,
          ),
          boxShadow: [
            BoxShadow(
              color: isSelected
                  ? AppTheme.chronosGold.withValues(alpha: 0.2)
                  : AppTheme.shadowDark,
              blurRadius: isSelected ? 8.0 : 4.0,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Stack(
              alignment: Alignment.center,
              children: [
                Container(
                  width: 15.w,
                  height: 15.w,
                  decoration: BoxDecoration(
                    color: AppTheme.chronosGold.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  child: CustomIconWidget(
                    iconName: iconName,
                    color: AppTheme.chronosGold,
                    size: 8.w,
                  ),
                ),
                if (isSelected)
                  Positioned(
                    top: -2,
                    right: -2,
                    child: Container(
                      width: 6.w,
                      height: 6.w,
                      decoration: BoxDecoration(
                        color: AppTheme.chronosGold,
                        shape: BoxShape.circle,
                      ),
                      child: CustomIconWidget(
                        iconName: 'check',
                        color: AppTheme.primaryCharcoal,
                        size: 4.w,
                      ),
                    ),
                  ),
              ],
            ),
            SizedBox(height: 2.h),
            Text(
              title,
              style: AppTheme.darkTheme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w600,
                color: isSelected ? AppTheme.chronosGold : AppTheme.textPrimary,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 1.h),
            Text(
              description,
              style: AppTheme.darkTheme.textTheme.bodySmall?.copyWith(
                color: AppTheme.textSecondary,
              ),
              textAlign: TextAlign.center,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            SizedBox(height: 1.5.h),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 0.5.h),
              decoration: BoxDecoration(
                color: _getRiskColor().withValues(alpha: 0.2),
                borderRadius: BorderRadius.circular(12.0),
              ),
              child: Text(
                riskLevel,
                style: AppTheme.darkTheme.textTheme.labelSmall?.copyWith(
                  color: _getRiskColor(),
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Color _getRiskColor() {
    switch (riskLevel.toLowerCase()) {
      case 'low risk':
        return AppTheme.successGreen;
      case 'medium risk':
        return AppTheme.warningAmber;
      case 'high risk':
        return AppTheme.errorRed;
      default:
        return AppTheme.textSecondary;
    }
  }
}
