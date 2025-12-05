import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';

class CategoryAnalysisWidget extends StatelessWidget {
  final List<Map<String, dynamic>> categories;
  final Function(Map<String, dynamic>) onCategoryLongPress;

  const CategoryAnalysisWidget({
    super.key,
    required this.categories,
    required this.onCategoryLongPress,
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
          Text(
            'Category Analysis',
            style: AppTheme.darkTheme.textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: 1.h),
          Text(
            'Long press any category for detailed transactions',
            style: AppTheme.darkTheme.textTheme.bodyMedium?.copyWith(
              color: AppTheme.textSecondary,
            ),
          ),
          SizedBox(height: 2.h),
          ...categories
              .map((category) => GestureDetector(
                    onLongPress: () => onCategoryLongPress(category),
                    child: Container(
                      margin: EdgeInsets.only(bottom: 2.h),
                      padding: EdgeInsets.all(3.w),
                      decoration: BoxDecoration(
                        color: AppTheme.primaryCharcoal.withValues(alpha: 0.3),
                        borderRadius: BorderRadius.circular(12.0),
                        border: Border.all(
                          color: _getCategoryStatusColor(category)
                              .withValues(alpha: 0.3),
                          width: 1.0,
                        ),
                      ),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Container(
                                width: 10.w,
                                height: 10.w,
                                decoration: BoxDecoration(
                                  color:
                                      category['color'].withValues(alpha: 0.1),
                                  borderRadius: BorderRadius.circular(8.0),
                                ),
                                child: Icon(
                                  _getCategoryIcon(category['category']),
                                  color: category['color'],
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
                                          category['category'],
                                          style: AppTheme
                                              .darkTheme.textTheme.titleMedium
                                              ?.copyWith(
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                        Row(
                                          children: [
                                            CustomIconWidget(
                                              iconName: _getTrendIcon(
                                                  category['trend']),
                                              color: _getTrendColor(
                                                  category['trend']),
                                              size: 4.w,
                                            ),
                                            SizedBox(width: 1.w),
                                            Text(
                                              '${category['trendValue'].toStringAsFixed(1)}%',
                                              style: AppTheme.darkTheme
                                                  .textTheme.labelMedium
                                                  ?.copyWith(
                                                color: _getTrendColor(
                                                    category['trend']),
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 0.5.h),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          '\$${category['amount'].toStringAsFixed(2)}',
                                          style: AppTheme.financialDataMedium
                                              .copyWith(
                                            fontSize: 16.sp,
                                          ),
                                        ),
                                        Text(
                                          'Budget: \$${category['budgetLimit'].toStringAsFixed(0)}',
                                          style: AppTheme
                                              .darkTheme.textTheme.bodySmall
                                              ?.copyWith(
                                            color: AppTheme.textSecondary,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 2.h),
                          LinearProgressIndicator(
                            value:
                                (category['amount'] / category['budgetLimit'])
                                    .clamp(0.0, 1.0),
                            backgroundColor: AppTheme.dividerSubtle,
                            valueColor: AlwaysStoppedAnimation<Color>(
                                _getCategoryStatusColor(category)),
                            minHeight: 0.5.h,
                          ),
                          SizedBox(height: 1.h),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                '${((category['amount'] / category['budgetLimit']) * 100).toInt()}% of budget used',
                                style: AppTheme.darkTheme.textTheme.labelSmall
                                    ?.copyWith(
                                  color: AppTheme.textTertiary,
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 2.w, vertical: 0.5.h),
                                decoration: BoxDecoration(
                                  color: _getCategoryStatusColor(category)
                                      .withValues(alpha: 0.1),
                                  borderRadius: BorderRadius.circular(6.0),
                                ),
                                child: Text(
                                  _getCategoryStatus(category),
                                  style: AppTheme.darkTheme.textTheme.labelSmall
                                      ?.copyWith(
                                    color: _getCategoryStatusColor(category),
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
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

  String _getTrendIcon(String trend) {
    switch (trend.toLowerCase()) {
      case 'up':
        return 'trending_up';
      case 'down':
        return 'trending_down';
      case 'stable':
        return 'trending_flat';
      default:
        return 'trending_flat';
    }
  }

  Color _getTrendColor(String trend) {
    switch (trend.toLowerCase()) {
      case 'up':
        return AppTheme.warningAmber;
      case 'down':
        return AppTheme.successGreen;
      case 'stable':
        return AppTheme.textSecondary;
      default:
        return AppTheme.textSecondary;
    }
  }

  Color _getCategoryStatusColor(Map<String, dynamic> category) {
    final percentage = (category['amount'] / category['budgetLimit']) * 100;
    if (percentage > 100) return AppTheme.errorRed;
    if (percentage > 80) return AppTheme.warningAmber;
    return AppTheme.successGreen;
  }

  String _getCategoryStatus(Map<String, dynamic> category) {
    final percentage = (category['amount'] / category['budgetLimit']) * 100;
    if (percentage > 100) return 'Over Budget';
    if (percentage > 80) return 'Near Limit';
    return 'On Track';
  }
}
