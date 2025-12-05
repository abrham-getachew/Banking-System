import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';

class MessageBubbleWidget extends StatelessWidget {
  final String message;
  final bool isUser;
  final DateTime timestamp;
  final bool showTimestamp;
  final VoidCallback? onLongPress;

  const MessageBubbleWidget({
    super.key,
    required this.message,
    required this.isUser,
    required this.timestamp,
    this.showTimestamp = false,
    this.onLongPress,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 4.w, vertical: 1.h),
      child: Column(
        crossAxisAlignment:
            isUser ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment:
                isUser ? MainAxisAlignment.end : MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              if (!isUser) ...[
                Container(
                  width: 8.w,
                  height: 8.w,
                  decoration: BoxDecoration(
                    color: AppTheme.chronosGold,
                    shape: BoxShape.circle,
                  ),
                  child: CustomIconWidget(
                    iconName: 'smart_toy',
                    color: AppTheme.primaryCharcoal,
                    size: 4.w,
                  ),
                ),
                SizedBox(width: 2.w),
              ],
              Flexible(
                child: GestureDetector(
                  onLongPress: onLongPress,
                  child: Container(
                    constraints: BoxConstraints(maxWidth: 75.w),
                    padding:
                        EdgeInsets.symmetric(horizontal: 4.w, vertical: 2.h),
                    decoration: BoxDecoration(
                      color:
                          isUser ? AppTheme.chronosGold : AppTheme.surfaceDark,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(4.w),
                        topRight: Radius.circular(4.w),
                        bottomLeft: Radius.circular(isUser ? 4.w : 1.w),
                        bottomRight: Radius.circular(isUser ? 1.w : 4.w),
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: AppTheme.shadowDark,
                          blurRadius: 8.0,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Text(
                      message,
                      style: AppTheme.darkTheme.textTheme.bodyMedium?.copyWith(
                        color: isUser
                            ? AppTheme.primaryCharcoal
                            : AppTheme.textPrimary,
                        height: 1.4,
                      ),
                    ),
                  ),
                ),
              ),
              if (isUser) ...[
                SizedBox(width: 2.w),
                Container(
                  width: 8.w,
                  height: 8.w,
                  decoration: BoxDecoration(
                    color: AppTheme.textSecondary,
                    shape: BoxShape.circle,
                  ),
                  child: CustomIconWidget(
                    iconName: 'person',
                    color: AppTheme.primaryCharcoal,
                    size: 4.w,
                  ),
                ),
              ],
            ],
          ),
          if (showTimestamp) ...[
            SizedBox(height: 0.5.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: isUser ? 0 : 10.w),
              child: Text(
                _formatTimestamp(timestamp),
                style: AppTheme.darkTheme.textTheme.labelSmall?.copyWith(
                  color: AppTheme.textTertiary,
                ),
                textAlign: isUser ? TextAlign.end : TextAlign.start,
              ),
            ),
          ],
        ],
      ),
    );
  }

  String _formatTimestamp(DateTime timestamp) {
    final now = DateTime.now();
    final difference = now.difference(timestamp);

    if (difference.inMinutes < 1) {
      return 'Just now';
    } else if (difference.inHours < 1) {
      return '${difference.inMinutes}m ago';
    } else if (difference.inDays < 1) {
      return '${difference.inHours}h ago';
    } else {
      return '${timestamp.day}/${timestamp.month}/${timestamp.year}';
    }
  }
}
