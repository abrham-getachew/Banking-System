import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../../core/app_export.dart';

class CustomBottomNavigationBar extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;

  const CustomBottomNavigationBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> navItems = [
      {
        'icon': 'account_balance',
        'label': 'Banking',
        'route': '/banking',
      },
      {
        'icon': 'payment',
        'label': 'Payments',
        'route': '/payments',
      },
      {
        'icon': 'currency_bitcoin',
        'label': 'Blockchain',
        'route': '/blockchain-module-home',
      },
      {
        'icon': 'trending_up',
        'label': 'Investments',
        'route': '/investments',
      },
      {
        'icon': 'person',
        'label': 'Profile',
        'route': '/profile',
      },
    ];

    return Container(
      decoration: BoxDecoration(
        color: AppTheme.elevatedSurface,
        boxShadow: [
          BoxShadow(
            color: AppTheme.shadowDark,
            blurRadius: 12,
            offset: const Offset(0, -4),
          ),
        ],
      ),
      child: SafeArea(
        child: Container(
          height: 10.h,
          padding: EdgeInsets.symmetric(horizontal: 2.w, vertical: 1.h),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: navItems.asMap().entries.map((entry) {
              final int index = entry.key;
              final Map<String, dynamic> item = entry.value;
              final bool isSelected = currentIndex == index;

              return Expanded(
                child: GestureDetector(
                  onTap: () => onTap(index),
                  child: Container(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          padding: EdgeInsets.all(2.w),
                          decoration: isSelected
                              ? BoxDecoration(
                                  color: AppTheme.primaryGold
                                      .withValues(alpha: 0.2),
                                  borderRadius: BorderRadius.circular(3.w),
                                )
                              : null,
                          child: CustomIconWidget(
                            iconName: item['icon'] as String,
                            color: isSelected
                                ? AppTheme.primaryGold
                                : AppTheme.textSecondary,
                            size: isSelected ? 6.w : 5.w,
                          ),
                        ),
                        SizedBox(height: 0.5.h),
                        Text(
                          item['label'] as String,
                          style:
                              AppTheme.darkTheme.textTheme.labelSmall?.copyWith(
                            color: isSelected
                                ? AppTheme.primaryGold
                                : AppTheme.textSecondary,
                            fontWeight:
                                isSelected ? FontWeight.w600 : FontWeight.w400,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
        ),
      ),
    );
  }
}
