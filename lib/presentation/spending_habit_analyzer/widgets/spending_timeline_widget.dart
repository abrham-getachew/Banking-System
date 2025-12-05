import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';

class SpendingTimelineWidget extends StatelessWidget {
  final List<Map<String, dynamic>> dailySpending;

  const SpendingTimelineWidget({
    super.key,
    required this.dailySpending,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 4.w),
      padding: EdgeInsets.all(4.w),
      decoration: BoxDecoration(
        color: AppTheme.surfaceDark,
        borderRadius: BorderRadius.circular(16.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Recent Spending',
                    style: AppTheme.darkTheme.textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    'Your latest transactions and patterns',
                    style: AppTheme.darkTheme.textTheme.bodyMedium?.copyWith(
                      color: AppTheme.textSecondary,
                    ),
                  ),
                ],
              ),
              CustomIconWidget(
                iconName: 'timeline',
                color: AppTheme.chronosGold,
                size: 6.w,
              ),
            ],
          ),
          SizedBox(height: 3.h),
          ...dailySpending
              .map((spending) => Container(
                    margin: EdgeInsets.only(bottom: 2.h),
                    padding: EdgeInsets.all(3.w),
                    decoration: BoxDecoration(
                      color: AppTheme.primaryCharcoal.withValues(alpha: 0.3),
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                    child: Row(
                      children: [
                        Container(
                          width: 10.w,
                          height: 10.w,
                          decoration: BoxDecoration(
                            color: _getCategoryColor(spending['category'])
                                .withValues(alpha: 0.1),
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          child: Icon(
                            _getCategoryIcon(spending['category']),
                            color: _getCategoryColor(spending['category']),
                            size: 5.w,
                          ),
                        ),
                        SizedBox(width: 3.w),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    spending['category'],
                                    style: AppTheme
                                        .darkTheme.textTheme.titleMedium
                                        ?.copyWith(
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  Text(
                                    '\$${spending['amount'].toStringAsFixed(2)}',
                                    style:
                                        AppTheme.financialDataMedium.copyWith(
                                      fontSize: 16.sp,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 0.5.h),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    _formatDate(spending['date']),
                                    style: AppTheme
                                        .darkTheme.textTheme.bodySmall
                                        ?.copyWith(
                                      color: AppTheme.textSecondary,
                                    ),
                                  ),
                                  if (spending['amount'] > 200)
                                    Container(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 2.w, vertical: 0.3.h),
                                      decoration: BoxDecoration(
                                        color: AppTheme.warningAmber
                                            .withValues(alpha: 0.1),
                                        borderRadius:
                                            BorderRadius.circular(6.0),
                                      ),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          CustomIconWidget(
                                            iconName: 'warning',
                                            color: AppTheme.warningAmber,
                                            size: 3.w,
                                          ),
                                          SizedBox(width: 1.w),
                                          Text(
                                            'Large Purchase',
                                            style: AppTheme
                                                .darkTheme.textTheme.labelSmall
                                                ?.copyWith(
                                              color: AppTheme.warningAmber,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ))
              .toList(),
        ],
      ),
    );
  }

  IconData _getCategoryIcon(String category) {
    switch (category.toLowerCase()) {
      case 'groceries':
        return Icons.shopping_cart;
      case 'takeout':
        return Icons.restaurant;
      case 'transportation':
        return Icons.directions_car;
      case 'entertainment':
        return Icons.movie;
      case 'utilities':
        return Icons.flash_on;
      case 'shopping':
        return Icons.shopping_bag;
      case 'healthcare':
        return Icons.local_hospital;
      default:
        return Icons.category;
    }
  }

  Color _getCategoryColor(String category) {
    switch (category.toLowerCase()) {
      case 'groceries':
        return const Color(0xFF10B981);
      case 'takeout':
        return const Color(0xFFEF4444);
      case 'transportation':
        return const Color(0xFF3B82F6);
      case 'entertainment':
        return const Color(0xFF8B5CF6);
      case 'utilities':
        return AppTheme.warningAmber;
      case 'shopping':
        return AppTheme.chronosGold;
      case 'healthcare':
        return const Color(0xFFF59E0B);
      default:
        return AppTheme.textSecondary;
    }
  }

  String _formatDate(String date) {
    final parts = date.split('-');
    if (parts.length == 3) {
      final month = _getMonthName(int.parse(parts[1]));
      final day = int.parse(parts[2]);
      return '$month $day';
    }
    return date;
  }

  String _getMonthName(int month) {
    const months = [
      '',
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec'
    ];
    return months[month];
  }
}
