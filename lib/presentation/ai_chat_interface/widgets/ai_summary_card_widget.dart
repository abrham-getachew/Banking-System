import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';

class AiSummaryCardWidget extends StatefulWidget {
  final String title;
  final String summary;
  final String actionText;
  final VoidCallback? onActionPressed;
  final List<Map<String, dynamic>>? details;
  final String cardType;

  const AiSummaryCardWidget({
    super.key,
    required this.title,
    required this.summary,
    required this.actionText,
    this.onActionPressed,
    this.details,
    required this.cardType,
  });

  @override
  State<AiSummaryCardWidget> createState() => _AiSummaryCardWidgetState();
}

class _AiSummaryCardWidgetState extends State<AiSummaryCardWidget>
    with SingleTickerProviderStateMixin {
  bool _isExpanded = false;
  late AnimationController _animationController;
  late Animation<double> _expandAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: AppTheme.standardAnimation,
      vsync: this,
    );
    _expandAnimation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _toggleExpansion() {
    setState(() {
      _isExpanded = !_isExpanded;
      if (_isExpanded) {
        _animationController.forward();
      } else {
        _animationController.reverse();
      }
    });
  }

  Color _getCardColor() {
    switch (widget.cardType) {
      case 'investment':
        return AppTheme.successGreen.withValues(alpha: 0.1);
      case 'goal':
        return AppTheme.chronosGold.withValues(alpha: 0.1);
      case 'risk':
        return AppTheme.warningAmber.withValues(alpha: 0.1);
      default:
        return AppTheme.surfaceDark;
    }
  }

  Color _getAccentColor() {
    switch (widget.cardType) {
      case 'investment':
        return AppTheme.successGreen;
      case 'goal':
        return AppTheme.chronosGold;
      case 'risk':
        return AppTheme.warningAmber;
      default:
        return AppTheme.chronosGold;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 4.w, vertical: 1.h),
      child: Card(
        color: _getCardColor(),
        elevation: 4.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(3.w),
          side: BorderSide(
            color: _getAccentColor().withValues(alpha: 0.3),
            width: 1.0,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.all(4.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        padding: EdgeInsets.all(2.w),
                        decoration: BoxDecoration(
                          color: _getAccentColor(),
                          borderRadius: BorderRadius.circular(2.w),
                        ),
                        child: CustomIconWidget(
                          iconName: _getCardIcon(),
                          color: AppTheme.primaryCharcoal,
                          size: 4.w,
                        ),
                      ),
                      SizedBox(width: 3.w),
                      Expanded(
                        child: Text(
                          widget.title,
                          style: AppTheme.darkTheme.textTheme.titleMedium
                              ?.copyWith(
                            color: AppTheme.textPrimary,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      if (widget.details != null &&
                          (widget.details?.isNotEmpty ?? false))
                        GestureDetector(
                          onTap: _toggleExpansion,
                          child: AnimatedRotation(
                            turns: _isExpanded ? 0.5 : 0.0,
                            duration: AppTheme.standardAnimation,
                            child: CustomIconWidget(
                              iconName: 'keyboard_arrow_down',
                              color: _getAccentColor(),
                              size: 5.w,
                            ),
                          ),
                        ),
                    ],
                  ),
                  SizedBox(height: 2.h),
                  Text(
                    widget.summary,
                    style: AppTheme.darkTheme.textTheme.bodyMedium?.copyWith(
                      color: AppTheme.textSecondary,
                      height: 1.4,
                    ),
                  ),
                  SizedBox(height: 2.h),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: widget.onActionPressed,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: _getAccentColor(),
                        foregroundColor: AppTheme.primaryCharcoal,
                        padding: EdgeInsets.symmetric(vertical: 1.5.h),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(2.w),
                        ),
                      ),
                      child: Text(
                        widget.actionText,
                        style:
                            AppTheme.darkTheme.textTheme.labelLarge?.copyWith(
                          color: AppTheme.primaryCharcoal,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            if (widget.details != null && (widget.details?.isNotEmpty ?? false))
              SizeTransition(
                sizeFactor: _expandAnimation,
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: AppTheme.surfaceDark.withValues(alpha: 0.5),
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(3.w),
                      bottomRight: Radius.circular(3.w),
                    ),
                  ),
                  padding: EdgeInsets.all(4.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Details',
                        style:
                            AppTheme.darkTheme.textTheme.titleSmall?.copyWith(
                          color: _getAccentColor(),
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(height: 1.h),
                      ...(widget.details ?? []).map((detail) => Padding(
                            padding: EdgeInsets.symmetric(vertical: 0.5.h),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: Text(
                                    detail['label'] as String? ?? '',
                                    style: AppTheme
                                        .darkTheme.textTheme.bodySmall
                                        ?.copyWith(
                                      color: AppTheme.textSecondary,
                                    ),
                                  ),
                                ),
                                Text(
                                  detail['value'] as String? ?? '',
                                  style: AppTheme.darkTheme.textTheme.bodySmall
                                      ?.copyWith(
                                    color: AppTheme.textPrimary,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                          )),
                    ],
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  String _getCardIcon() {
    switch (widget.cardType) {
      case 'investment':
        return 'trending_up';
      case 'goal':
        return 'flag';
      case 'risk':
        return 'shield';
      default:
        return 'lightbulb';
    }
  }
}
