import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';

class PdfExportCardWidget extends StatelessWidget {
  final VoidCallback onExportPressed;
  final bool isExporting;

  const PdfExportCardWidget({
    super.key,
    required this.onExportPressed,
    required this.isExporting,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 4.w),
      padding: EdgeInsets.all(4.w),
      decoration: BoxDecoration(
        color: AppTheme.surfaceDark,
        borderRadius: BorderRadius.circular(16.0),
        border: Border.all(
          color: AppTheme.chronosGold.withValues(alpha: 0.2),
          width: 1.0,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 12.w,
                height: 12.w,
                decoration: BoxDecoration(
                  color: AppTheme.chronosGold.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(12.0),
                ),
                child: CustomIconWidget(
                  iconName: 'picture_as_pdf',
                  color: AppTheme.chronosGold,
                  size: 6.w,
                ),
              ),
              SizedBox(width: 3.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Export PDF Report',
                      style: AppTheme.darkTheme.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      'Generate a comprehensive PDF version of your wealth report',
                      style: AppTheme.darkTheme.textTheme.bodyMedium?.copyWith(
                        color: AppTheme.textSecondary,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 3.h),
          Container(
            padding: EdgeInsets.all(3.w),
            decoration: BoxDecoration(
              color: AppTheme.primaryCharcoal.withValues(alpha: 0.3),
              borderRadius: BorderRadius.circular(12.0),
            ),
            child: Column(
              children: [
                Row(
                  children: [
                    CustomIconWidget(
                      iconName: 'check_circle',
                      color: AppTheme.successGreen,
                      size: 4.w,
                    ),
                    SizedBox(width: 2.w),
                    Text(
                      'Portfolio overview and performance metrics',
                      style: AppTheme.darkTheme.textTheme.bodySmall,
                    ),
                  ],
                ),
                SizedBox(height: 1.h),
                Row(
                  children: [
                    CustomIconWidget(
                      iconName: 'check_circle',
                      color: AppTheme.successGreen,
                      size: 4.w,
                    ),
                    SizedBox(width: 2.w),
                    Text(
                      'AI-generated insights and recommendations',
                      style: AppTheme.darkTheme.textTheme.bodySmall,
                    ),
                  ],
                ),
                SizedBox(height: 1.h),
                Row(
                  children: [
                    CustomIconWidget(
                      iconName: 'check_circle',
                      color: AppTheme.successGreen,
                      size: 4.w,
                    ),
                    SizedBox(width: 2.w),
                    Text(
                      'Asset allocation breakdown and charts',
                      style: AppTheme.darkTheme.textTheme.bodySmall,
                    ),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(height: 3.h),
          SizedBox(
            width: double.infinity,
            height: 6.h,
            child: ElevatedButton.icon(
              onPressed: isExporting ? null : onExportPressed,
              icon: isExporting
                  ? SizedBox(
                      width: 4.w,
                      height: 4.w,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        valueColor: AlwaysStoppedAnimation<Color>(
                            AppTheme.primaryCharcoal),
                      ),
                    )
                  : CustomIconWidget(
                      iconName: 'download',
                      color: AppTheme.primaryCharcoal,
                      size: 5.w,
                    ),
              label: Text(
                isExporting ? 'Generating PDF...' : 'Export PDF Report',
                style: AppTheme.darkTheme.elevatedButtonTheme.style!.textStyle!
                    .resolve({})?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: isExporting ? AppTheme.textTertiary : null,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.0),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
