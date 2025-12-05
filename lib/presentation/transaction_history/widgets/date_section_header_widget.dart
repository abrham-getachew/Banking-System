import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';
import '../../../theme/app_theme.dart';

class DateSectionHeaderWidget extends StatelessWidget {
  final String dateKey;

  const DateSectionHeaderWidget({
    super.key,
    required this.dateKey,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 2.h),
      child: Row(
        children: [
          Text(
            dateKey,
            style: TextStyle(
              color: AppTheme.textPrimary,
              fontSize: 16.sp,
              fontWeight: FontWeight.w600,
            ),
          ),
          Expanded(
            child: Container(
              margin: EdgeInsets.only(left: 4.w),
              height: 1,
              color: AppTheme.borderGray.withValues(alpha: 0.3),
            ),
          ),
        ],
      ),
    );
  }
}
