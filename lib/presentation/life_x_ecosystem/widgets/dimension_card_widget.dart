import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';

class DimensionCardWidget extends StatelessWidget {
  final Map<String, dynamic> dimension;
  final VoidCallback onTap;

  const DimensionCardWidget({
    Key? key,
    required this.dimension,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(4.w),
        decoration: BoxDecoration(
          color: AppTheme.secondaryDark,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: _getStatusColor().withValues(alpha: 0.3),
            width: 1,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: EdgeInsets.all(2.w),
                  decoration: BoxDecoration(
                    color: (dimension['color'] as Color).withValues(alpha: 0.2),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: CustomIconWidget(
                    iconName: dimension['icon'],
                    color: dimension['color'],
                    size: 20,
                  ),
                ),
                _buildStatusIndicator(),
              ],
            ),
            SizedBox(height: 2.h),
            Text(
              dimension['name'],
              style: AppTheme.darkTheme.textTheme.titleMedium?.copyWith(
                color: AppTheme.textPrimary,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(height: 1.h),
            _buildProgressBar(),
            SizedBox(height: 1.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '${(dimension['progress'] * 100).toInt()}%',
                  style: AppTheme.darkTheme.textTheme.bodySmall?.copyWith(
                    color: dimension['color'],
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  dimension['spent'],
                  style: AppTheme.darkTheme.textTheme.bodySmall?.copyWith(
                    color: AppTheme.textSecondary,
                  ),
                ),
              ],
            ),
            SizedBox(height: 1.h),
            Text(
              'Budget: ${dimension['budget']}',
              style: AppTheme.darkTheme.textTheme.bodySmall?.copyWith(
                color: AppTheme.textSecondary,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProgressBar() {
    return Stack(
      children: [
        Container(
          height: 6,
          decoration: BoxDecoration(
            color: AppTheme.borderGray,
            borderRadius: BorderRadius.circular(3),
          ),
        ),
        Container(
          height: 6,
          width: 35.w * (dimension['progress'] as double),
          decoration: BoxDecoration(
            color: dimension['color'],
            borderRadius: BorderRadius.circular(3),
          ),
        ),
      ],
    );
  }

  Widget _buildStatusIndicator() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 2.w, vertical: 0.5.h),
      decoration: BoxDecoration(
        color: _getStatusColor().withValues(alpha: 0.2),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        _getStatusText(),
        style: AppTheme.darkTheme.textTheme.bodySmall?.copyWith(
          color: _getStatusColor(),
          fontWeight: FontWeight.w500,
          fontSize: 10.sp,
        ),
      ),
    );
  }

  Color _getStatusColor() {
    switch (dimension['status']) {
      case 'excellent':
        return AppTheme.successGreen;
      case 'on_track':
        return AppTheme.accentGold;
      case 'needs_attention':
        return AppTheme.warningAmber;
      case 'behind':
        return AppTheme.errorRed;
      default:
        return AppTheme.textSecondary;
    }
  }

  String _getStatusText() {
    switch (dimension['status']) {
      case 'excellent':
        return 'Excellent';
      case 'on_track':
        return 'On Track';
      case 'needs_attention':
        return 'Attention';
      case 'behind':
        return 'Behind';
      default:
        return 'Unknown';
    }
  }
}
