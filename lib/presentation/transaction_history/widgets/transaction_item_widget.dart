import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';

class TransactionItemWidget extends StatelessWidget {
  final Map<String, dynamic> transaction;
  final VoidCallback onTap;

  const TransactionItemWidget({
    super.key,
    required this.transaction,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final amount = transaction['amount'] as double;
    final isIncome = amount > 0;

    return Dismissible(
      key: Key(transaction['id']),
      background: _buildSwipeBackground(isLeft: true),
      secondaryBackground: _buildSwipeBackground(isLeft: false),
      onDismissed: (direction) {
        if (direction == DismissDirection.startToEnd) {
          _showQuickActions(context);
        } else {
          _showSecondaryActions(context);
        }
      },
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 0.5.h),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: onTap,
            borderRadius: BorderRadius.circular(12),
            child: Container(
              padding: EdgeInsets.all(4.w),
              decoration: BoxDecoration(
                color: AppTheme.secondaryDark,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: AppTheme.borderGray.withValues(alpha: 0.3),
                  width: 1,
                ),
              ),
              child: Row(
                children: [
                  // Category icon
                  Container(
                    width: 12.w,
                    height: 12.w,
                    decoration: BoxDecoration(
                      color: _getCategoryColor().withValues(alpha: 0.2),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Center(
                      child: CustomIconWidget(
                        iconName: transaction['categoryIcon'],
                        color: _getCategoryColor(),
                        size: 20,
                      ),
                    ),
                  ),

                  SizedBox(width: 4.w),

                  // Transaction details
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          transaction['merchant'],
                          style: TextStyle(
                            color: AppTheme.textPrimary,
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w600,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        SizedBox(height: 0.5.h),
                        Row(
                          children: [
                            Text(
                              transaction['category'],
                              style: TextStyle(
                                color: AppTheme.textSecondary,
                                fontSize: 12.sp,
                              ),
                            ),
                            Text(
                              ' • ',
                              style: TextStyle(
                                color: AppTheme.textSecondary,
                                fontSize: 12.sp,
                              ),
                            ),
                            Text(
                              _formatTime(transaction['timestamp']),
                              style: TextStyle(
                                color: AppTheme.textSecondary,
                                fontSize: 12.sp,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),

                  // Amount
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        '${isIncome ? '+' : ''}\$${amount.abs().toStringAsFixed(2)}',
                        style: TextStyle(
                          color: isIncome
                              ? AppTheme.successGreen
                              : AppTheme.textPrimary,
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(height: 0.5.h),
                      Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: 2.w, vertical: 0.5.h),
                        decoration: BoxDecoration(
                          color: AppTheme.successGreen.withValues(alpha: 0.2),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Text(
                          'Completed',
                          style: TextStyle(
                            color: AppTheme.successGreen,
                            fontSize: 10.sp,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSwipeBackground({required bool isLeft}) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 0.5.h),
      decoration: BoxDecoration(
        color: isLeft ? AppTheme.accentGold : AppTheme.errorRed,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Align(
        alignment: isLeft ? Alignment.centerLeft : Alignment.centerRight,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 6.w),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CustomIconWidget(
                iconName: isLeft ? 'edit' : 'share',
                color: AppTheme.textPrimary,
                size: 24,
              ),
              SizedBox(height: 0.5.h),
              Text(
                isLeft ? 'Edit' : 'Share',
                style: TextStyle(
                  color: AppTheme.textPrimary,
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Color _getCategoryColor() {
    switch (transaction['category']) {
      case 'Food & Dining':
        return AppTheme.warningAmber;
      case 'Income':
        return AppTheme.successGreen;
      case 'Shopping':
        return AppTheme.accentGold;
      case 'Transportation':
        return Colors.blue;
      case 'Entertainment':
        return Colors.purple;
      case 'Groceries':
        return Colors.green;
      case 'Technology':
        return Colors.cyan;
      default:
        return AppTheme.textSecondary;
    }
  }

  String _formatTime(DateTime timestamp) {
    final now = DateTime.now();
    final difference = now.difference(timestamp);

    if (difference.inMinutes < 60) {
      return '${difference.inMinutes}m ago';
    } else if (difference.inHours < 24) {
      return '${difference.inHours}h ago';
    } else {
      return '${timestamp.hour.toString().padLeft(2, '0')}:${timestamp.minute.toString().padLeft(2, '0')}';
    }
  }

  void _showQuickActions(BuildContext context) {
    // Show quick actions modal
    showModalBottomSheet(
      context: context,
      backgroundColor: AppTheme.darkTheme.colorScheme.surface,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => Container(
        padding: EdgeInsets.all(4.w),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: CustomIconWidget(
                iconName: 'category',
                color: AppTheme.accentGold,
                size: 24,
              ),
              title: Text(
                'Categorize',
                style: TextStyle(color: AppTheme.textPrimary),
              ),
              onTap: () => Navigator.pop(context),
            ),
            ListTile(
              leading: CustomIconWidget(
                iconName: 'note_add',
                color: AppTheme.accentGold,
                size: 24,
              ),
              title: Text(
                'Add Note',
                style: TextStyle(color: AppTheme.textPrimary),
              ),
              onTap: () => Navigator.pop(context),
            ),
            ListTile(
              leading: CustomIconWidget(
                iconName: 'receipt',
                color: AppTheme.accentGold,
                size: 24,
              ),
              title: Text(
                'Request Receipt',
                style: TextStyle(color: AppTheme.textPrimary),
              ),
              onTap: () => Navigator.pop(context),
            ),
          ],
        ),
      ),
    );
  }

  void _showSecondaryActions(BuildContext context) {
    // Show secondary actions modal
    showModalBottomSheet(
      context: context,
      backgroundColor: AppTheme.darkTheme.colorScheme.surface,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => Container(
        padding: EdgeInsets.all(4.w),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: CustomIconWidget(
                iconName: 'share',
                color: AppTheme.accentGold,
                size: 24,
              ),
              title: Text(
                'Share',
                style: TextStyle(color: AppTheme.textPrimary),
              ),
              onTap: () => Navigator.pop(context),
            ),
            ListTile(
              leading: CustomIconWidget(
                iconName: 'report_problem',
                color: AppTheme.errorRed,
                size: 24,
              ),
              title: Text(
                'Dispute',
                style: TextStyle(color: AppTheme.textPrimary),
              ),
              onTap: () => Navigator.pop(context),
            ),
          ],
        ),
      ),
    );
  }
}
