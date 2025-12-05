import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';

class DurationSliderWidget extends StatelessWidget {
  final double value;
  final Function(double) onChanged;

  const DurationSliderWidget({
    super.key,
    required this.value,
    required this.onChanged,
  });

  String _formatDuration(double months) {
    if (months < 12) {
      return '${months.toInt()} month${months.toInt() == 1 ? '' : 's'}';
    } else if (months == 120) {
      return '10+ years';
    } else {
      final years = (months / 12).toInt();
      final remainingMonths = (months % 12).toInt();

      if (remainingMonths == 0) {
        return '$years year${years == 1 ? '' : 's'}';
      } else {
        return '$years.${(remainingMonths * 10 / 12).toInt()} years';
      }
    }
  }

  List<double> _getSliderMarks() {
    return [1, 3, 6, 12, 24, 36, 48, 60, 84, 120];
  }

  @override
  Widget build(BuildContext context) {
    final marks = _getSliderMarks();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Investment Duration',
          style: AppTheme.darkTheme.textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
        SizedBox(height: 1.h),
        Text(
          'How long do you plan to invest for?',
          style: AppTheme.darkTheme.textTheme.bodyMedium?.copyWith(
            color: AppTheme.textSecondary,
          ),
        ),
        SizedBox(height: 3.h),
        Container(
          padding: EdgeInsets.all(4.w),
          decoration: BoxDecoration(
            color: AppTheme.surfaceDark,
            borderRadius: BorderRadius.circular(16.0),
            border: Border.all(
              color: AppTheme.dividerSubtle,
              width: 1.0,
            ),
          ),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    padding:
                        EdgeInsets.symmetric(horizontal: 4.w, vertical: 1.h),
                    decoration: BoxDecoration(
                      color: AppTheme.chronosGold.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    child: Text(
                      _formatDuration(value),
                      style: AppTheme.darkTheme.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                        color: AppTheme.chronosGold,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 3.h),
              SliderTheme(
                data: SliderTheme.of(context).copyWith(
                  activeTrackColor: AppTheme.chronosGold,
                  inactiveTrackColor: AppTheme.dividerSubtle,
                  thumbColor: AppTheme.chronosGold,
                  overlayColor: AppTheme.chronosGold.withValues(alpha: 0.2),
                  thumbShape:
                      const RoundSliderThumbShape(enabledThumbRadius: 12.0),
                  overlayShape:
                      const RoundSliderOverlayShape(overlayRadius: 20.0),
                  trackHeight: 6.0,
                  activeTickMarkColor: AppTheme.chronosGold,
                  inactiveTickMarkColor: AppTheme.dividerSubtle,
                  tickMarkShape:
                      const RoundSliderTickMarkShape(tickMarkRadius: 3.0),
                ),
                child: Slider(
                  value: value,
                  min: marks.first,
                  max: marks.last,
                  divisions: marks.length - 1,
                  onChanged: onChanged,
                ),
              ),
              SizedBox(height: 2.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '1 month',
                    style: AppTheme.darkTheme.textTheme.bodySmall?.copyWith(
                      color: AppTheme.textTertiary,
                    ),
                  ),
                  Text(
                    '10+ years',
                    style: AppTheme.darkTheme.textTheme.bodySmall?.copyWith(
                      color: AppTheme.textTertiary,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 3.h),
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(3.w),
                decoration: BoxDecoration(
                  color: AppTheme.primaryCharcoal,
                  borderRadius: BorderRadius.circular(12.0),
                ),
                child: Row(
                  children: [
                    CustomIconWidget(
                      iconName: 'lightbulb',
                      color: AppTheme.chronosGold,
                      size: 4.w,
                    ),
                    SizedBox(width: 2.w),
                    Expanded(
                      child: Text(
                        value >= 36
                            ? 'Long-term investments typically yield better returns!'
                            : 'Consider longer durations for compound growth benefits.',
                        style: AppTheme.darkTheme.textTheme.bodySmall?.copyWith(
                          color: AppTheme.textSecondary,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
