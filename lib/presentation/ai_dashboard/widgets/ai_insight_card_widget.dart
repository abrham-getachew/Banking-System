import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';

class AiInsightCardWidget extends StatefulWidget {
  final Map<String, dynamic> insightData;
  final VoidCallback? onLearnMore;
  final VoidCallback? onRemindLater;
  final VoidCallback? onShare;

  const AiInsightCardWidget({
    super.key,
    required this.insightData,
    this.onLearnMore,
    this.onRemindLater,
    this.onShare,
  });

  @override
  State<AiInsightCardWidget> createState() => _AiInsightCardWidgetState();
}

class _AiInsightCardWidgetState extends State<AiInsightCardWidget>
    with TickerProviderStateMixin {
  late AnimationController _pulseController;
  late Animation<double> _pulseAnimation;
  bool _showActions = false;

  @override
  void initState() {
    super.initState();
    _pulseController = AnimationController(
      duration: const Duration(milliseconds: 2000),
      vsync: this,
    )..repeat(reverse: true);
    _pulseAnimation = Tween<double>(
      begin: 0.7,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _pulseController,
      curve: Curves.easeInOut,
    ));
  }

  @override
  void dispose() {
    _pulseController.dispose();
    super.dispose();
  }

  Color _getPriorityColor() {
    final priority = widget.insightData["priority"] as String;
    switch (priority.toLowerCase()) {
      case 'high':
        return AppTheme.errorRed;
      case 'medium':
        return AppTheme.warningAmber;
      case 'low':
        return AppTheme.successGreen;
      default:
        return AppTheme.chronosGold;
    }
  }

  IconData _getCategoryIcon() {
    final category = widget.insightData["category"] as String;
    switch (category.toLowerCase()) {
      case 'investment':
        return Icons.trending_up;
      case 'savings':
        return Icons.savings;
      case 'risk':
        return Icons.warning;
      case 'tax':
        return Icons.receipt_long;
      case 'goal':
        return Icons.flag;
      default:
        return Icons.lightbulb;
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onLongPress: () {
        setState(() {
          _showActions = !_showActions;
        });
      },
      child: Container(
        width: double.infinity,
        margin: EdgeInsets.symmetric(horizontal: 4.w, vertical: 1.h),
        decoration: BoxDecoration(
          color: AppTheme.surfaceDark,
          borderRadius: BorderRadius.circular(16.0),
          boxShadow: [
            BoxShadow(
              color: AppTheme.shadowDark,
              blurRadius: 8.0,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.all(5.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      AnimatedBuilder(
                        animation: _pulseAnimation,
                        builder: (context, child) {
                          return Container(
                            padding: EdgeInsets.all(2.w),
                            decoration: BoxDecoration(
                              color: _getPriorityColor().withValues(alpha: 0.2),
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: _getPriorityColor()
                                    .withValues(alpha: _pulseAnimation.value),
                                width: 1.5,
                              ),
                            ),
                            child: CustomIconWidget(
                              iconName: _getCategoryIcon().codePoint.toString(),
                              color: _getPriorityColor(),
                              size: 5.w,
                            ),
                          );
                        },
                      ),
                      SizedBox(width: 3.w),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              widget.insightData["title"] as String,
                              style: AppTheme.darkTheme.textTheme.titleMedium
                                  ?.copyWith(
                                color: AppTheme.textPrimary,
                                fontWeight: FontWeight.w600,
                              ),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                            SizedBox(height: 0.5.h),
                            Row(
                              children: [
                                Container(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 2.w, vertical: 0.5.h),
                                  decoration: BoxDecoration(
                                    color: _getPriorityColor()
                                        .withValues(alpha: 0.2),
                                    borderRadius: BorderRadius.circular(12.0),
                                  ),
                                  child: Text(
                                    widget.insightData["priority"] as String,
                                    style: AppTheme
                                        .darkTheme.textTheme.labelSmall
                                        ?.copyWith(
                                      color: _getPriorityColor(),
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                                SizedBox(width: 2.w),
                                Text(
                                  widget.insightData["category"] as String,
                                  style: AppTheme.darkTheme.textTheme.labelSmall
                                      ?.copyWith(
                                    color: AppTheme.textTertiary,
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
                  Text(
                    widget.insightData["description"] as String,
                    style: AppTheme.darkTheme.textTheme.bodyMedium?.copyWith(
                      color: AppTheme.textSecondary,
                      height: 1.5,
                    ),
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                  ),
                  if (widget.insightData["impact"] != null) ...[
                    SizedBox(height: 2.h),
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.all(3.w),
                      decoration: BoxDecoration(
                        color: AppTheme.chronosGold.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(12.0),
                        border: Border.all(
                          color: AppTheme.chronosGold.withValues(alpha: 0.3),
                          width: 1.0,
                        ),
                      ),
                      child: Row(
                        children: [
                          CustomIconWidget(
                            iconName: 'insights',
                            color: AppTheme.chronosGold,
                            size: 4.w,
                          ),
                          SizedBox(width: 2.w),
                          Expanded(
                            child: Text(
                              'Potential Impact: ${widget.insightData["impact"]}',
                              style: AppTheme.darkTheme.textTheme.bodySmall
                                  ?.copyWith(
                                color: AppTheme.chronosGold,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                  SizedBox(height: 2.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        widget.insightData["timestamp"] as String,
                        style: AppTheme.darkTheme.textTheme.bodySmall?.copyWith(
                          color: AppTheme.textTertiary,
                        ),
                      ),
                      TextButton(
                        onPressed: widget.onLearnMore,
                        child: Text(
                          'Learn More',
                          style: AppTheme.darkTheme.textTheme.labelMedium
                              ?.copyWith(
                            color: AppTheme.chronosGold,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            if (_showActions)
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(3.w),
                decoration: BoxDecoration(
                  color: AppTheme.primaryCharcoal,
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(16.0),
                    bottomRight: Radius.circular(16.0),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    TextButton.icon(
                      onPressed: widget.onShare,
                      icon: CustomIconWidget(
                        iconName: 'share',
                        color: AppTheme.textSecondary,
                        size: 4.w,
                      ),
                      label: Text(
                        'Share',
                        style:
                            AppTheme.darkTheme.textTheme.labelSmall?.copyWith(
                          color: AppTheme.textSecondary,
                        ),
                      ),
                    ),
                    Container(
                      width: 1,
                      height: 4.h,
                      color: AppTheme.dividerSubtle,
                    ),
                    TextButton.icon(
                      onPressed: widget.onRemindLater,
                      icon: CustomIconWidget(
                        iconName: 'schedule',
                        color: AppTheme.textSecondary,
                        size: 4.w,
                      ),
                      label: Text(
                        'Remind Later',
                        style:
                            AppTheme.darkTheme.textTheme.labelSmall?.copyWith(
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
    );
  }
}
