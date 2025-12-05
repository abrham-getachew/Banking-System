import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';

class FilterChipWidget extends StatelessWidget {
  final String label;
  final VoidCallback onRemove;

  const FilterChipWidget({
    super.key,
    required this.label,
    required this.onRemove,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(right: 2.w),
      child: Chip(
        label: Text(
          label,
          style: TextStyle(
            color: AppTheme.textPrimary,
            fontSize: 12.sp,
            fontWeight: FontWeight.w500,
          ),
        ),
        deleteIcon: CustomIconWidget(
          iconName: 'close',
          color: AppTheme.textSecondary,
          size: 16,
        ),
        onDeleted: onRemove,
        backgroundColor: AppTheme.accentGold.withValues(alpha: 0.2),
        side: BorderSide(
          color: AppTheme.accentGold.withValues(alpha: 0.5),
          width: 1,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 1.h),
      ),
    );
  }
}
