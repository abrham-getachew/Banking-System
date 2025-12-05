import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';

class RiskSelectionWidget extends StatelessWidget {
  final String? selectedRisk;
  final Function(String) onRiskSelected;

  const RiskSelectionWidget({
    super.key,
    required this.selectedRisk,
    required this.onRiskSelected,
  });

  List<Map<String, dynamic>> get _riskOptions => [
        {
          'level': 'Conservative',
          'description': 'Lower risk, steady returns',
          'icon': 'security',
          'returns': '2-4% annually',
          'color': AppTheme.successGreen,
          'details':
              'Focus on capital preservation with minimal volatility. Suitable for risk-averse investors.',
        },
        {
          'level': 'Moderate',
          'description': 'Balanced growth potential',
          'icon': 'balance',
          'returns': '5-8% annually',
          'color': AppTheme.warningAmber,
          'details':
              'Moderate risk with balanced growth. Good for most long-term investors.',
        },
        {
          'level': 'Aggressive',
          'description': 'High growth, higher volatility',
          'icon': 'trending_up',
          'returns': '9-15% annually',
          'color': AppTheme.errorRed,
          'details':
              'High-risk, high-reward strategy. Suitable for experienced investors with high risk tolerance.',
        },
      ];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Risk Appetite',
          style: AppTheme.darkTheme.textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
        SizedBox(height: 1.h),
        Text(
          'Choose your preferred risk level',
          style: AppTheme.darkTheme.textTheme.bodyMedium?.copyWith(
            color: AppTheme.textSecondary,
          ),
        ),
        SizedBox(height: 2.h),
        Column(
          children: _riskOptions.map((option) {
            final isSelected = selectedRisk == option['level'];

            return GestureDetector(
              onTap: () => onRiskSelected(option['level'] as String),
              child: AnimatedContainer(
                duration: AppTheme.standardAnimation,
                margin: EdgeInsets.only(bottom: 2.h),
                padding: EdgeInsets.all(4.w),
                decoration: BoxDecoration(
                  color: AppTheme.surfaceDark,
                  borderRadius: BorderRadius.circular(16.0),
                  border: Border.all(
                    color: isSelected
                        ? AppTheme.chronosGold
                        : AppTheme.dividerSubtle,
                    width: isSelected ? 2.0 : 1.0,
                  ),
                  boxShadow: isSelected
                      ? [
                          BoxShadow(
                            color: AppTheme.chronosGold.withValues(alpha: 0.2),
                            blurRadius: 8.0,
                            offset: const Offset(0, 2),
                          ),
                        ]
                      : null,
                ),
                child: Row(
                  children: [
                    Container(
                      width: 12.w,
                      height: 12.w,
                      decoration: BoxDecoration(
                        color:
                            (option['color'] as Color).withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                      child: CustomIconWidget(
                        iconName: option['icon'] as String,
                        color: option['color'] as Color,
                        size: 6.w,
                      ),
                    ),
                    SizedBox(width: 4.w),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text(
                                option['level'] as String,
                                style: AppTheme.darkTheme.textTheme.titleMedium
                                    ?.copyWith(
                                  fontWeight: FontWeight.w600,
                                  color:
                                      isSelected ? AppTheme.chronosGold : null,
                                ),
                              ),
                              const Spacer(),
                              Container(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 2.w, vertical: 0.5.h),
                                decoration: BoxDecoration(
                                  color: (option['color'] as Color)
                                      .withValues(alpha: 0.2),
                                  borderRadius: BorderRadius.circular(8.0),
                                ),
                                child: Text(
                                  option['returns'] as String,
                                  style: AppTheme.darkTheme.textTheme.labelSmall
                                      ?.copyWith(
                                    color: option['color'] as Color,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 0.5.h),
                          Text(
                            option['description'] as String,
                            style: AppTheme.darkTheme.textTheme.bodyMedium
                                ?.copyWith(
                              color: AppTheme.textSecondary,
                            ),
                          ),
                          if (isSelected) ...[
                            SizedBox(height: 1.h),
                            Text(
                              option['details'] as String,
                              style: AppTheme.darkTheme.textTheme.bodySmall
                                  ?.copyWith(
                                color: AppTheme.textTertiary,
                                fontStyle: FontStyle.italic,
                              ),
                            ),
                          ],
                        ],
                      ),
                    ),
                    if (isSelected) ...[
                      SizedBox(width: 2.w),
                      Container(
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
                    ],
                  ],
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }
}
