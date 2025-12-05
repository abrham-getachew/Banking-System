import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';

class EligibilityFactorsWidget extends StatefulWidget {
  final bool isVisible;

  const EligibilityFactorsWidget({
    Key? key,
    required this.isVisible,
  }) : super(key: key);

  @override
  State<EligibilityFactorsWidget> createState() =>
      _EligibilityFactorsWidgetState();
}

class _EligibilityFactorsWidgetState extends State<EligibilityFactorsWidget>
    with TickerProviderStateMixin {
  late AnimationController _slideController;
  late Animation<Offset> _slideAnimation;

  final List<Map<String, dynamic>> _factors = [
    {
      'title': 'Chronos Relationship',
      'description': 'Active banking customer for 2+ years',
      'score': 'Excellent',
      'icon': 'account_balance',
      'isExpanded': false,
    },
    {
      'title': 'Account History',
      'description': 'Consistent positive balance and transactions',
      'score': 'Very Good',
      'icon': 'history',
      'isExpanded': false,
    },
    {
      'title': 'Transaction Patterns',
      'description': 'Regular income deposits and responsible spending',
      'score': 'Good',
      'icon': 'trending_up',
      'isExpanded': false,
    },
    {
      'title': 'AI Risk Assessment',
      'description': 'Low risk profile based on behavioral analysis',
      'score': 'Excellent',
      'icon': 'psychology',
      'isExpanded': false,
    },
  ];

  @override
  void initState() {
    super.initState();
    _initializeAnimations();
  }

  void _initializeAnimations() {
    _slideController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.5),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _slideController,
      curve: Curves.easeOutCubic,
    ));
  }

  @override
  void didUpdateWidget(EligibilityFactorsWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.isVisible && !oldWidget.isVisible) {
      _slideController.forward();
    }
  }

  @override
  void dispose() {
    _slideController.dispose();
    super.dispose();
  }

  Color _getScoreColor(String score) {
    switch (score.toLowerCase()) {
      case 'excellent':
        return AppTheme.successGreen;
      case 'very good':
        return AppTheme.primaryGold;
      case 'good':
        return AppTheme.accentBlue;
      default:
        return AppTheme.textSecondary;
    }
  }

  void _toggleExpansion(int index) {
    setState(() {
      _factors[index]['isExpanded'] = !_factors[index]['isExpanded'];
    });
  }

  @override
  Widget build(BuildContext context) {
    if (!widget.isVisible) {
      return const SizedBox.shrink();
    }

    return SlideTransition(
      position: _slideAnimation,
      child: Container(
        width: 85.w,
        margin: EdgeInsets.symmetric(vertical: 2.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Eligibility Factors',
              style: AppTheme.darkTheme.textTheme.titleLarge?.copyWith(
                color: AppTheme.textPrimary,
                fontWeight: FontWeight.w700,
              ),
            ),
            SizedBox(height: 2.h),
            ...List.generate(_factors.length, (index) {
              final factor = _factors[index];
              return _buildFactorCard(factor, index);
            }),
          ],
        ),
      ),
    );
  }

  Widget _buildFactorCard(Map<String, dynamic> factor, int index) {
    final isExpanded = factor['isExpanded'] as bool;

    return Container(
      margin: EdgeInsets.only(bottom: 2.h),
      decoration: BoxDecoration(
        color: AppTheme.darkTheme.colorScheme.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: AppTheme.primaryGold.withValues(alpha: 0.1),
          width: 1,
        ),
      ),
      child: Column(
        children: [
          InkWell(
            onTap: () => _toggleExpansion(index),
            borderRadius: BorderRadius.circular(16),
            child: Padding(
              padding: EdgeInsets.all(4.w),
              child: Row(
                children: [
                  Container(
                    width: 12.w,
                    height: 12.w,
                    decoration: BoxDecoration(
                      color: _getScoreColor(factor['score'])
                          .withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: CustomIconWidget(
                      iconName: factor['icon'],
                      color: _getScoreColor(factor['score']),
                      size: 6.w,
                    ),
                  ),
                  SizedBox(width: 3.w),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          factor['title'],
                          style: AppTheme.darkTheme.textTheme.titleMedium
                              ?.copyWith(
                            color: AppTheme.textPrimary,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        SizedBox(height: 0.5.h),
                        Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: 2.w, vertical: 0.5.h),
                          decoration: BoxDecoration(
                            color: _getScoreColor(factor['score'])
                                .withValues(alpha: 0.1),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Text(
                            factor['score'],
                            style: AppTheme.darkTheme.textTheme.bodySmall
                                ?.copyWith(
                              color: _getScoreColor(factor['score']),
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      CustomIconWidget(
                        iconName: 'check_circle',
                        color: AppTheme.successGreen,
                        size: 5.w,
                      ),
                      SizedBox(width: 2.w),
                      CustomIconWidget(
                        iconName: isExpanded ? 'expand_less' : 'expand_more',
                        color: AppTheme.textSecondary,
                        size: 6.w,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeInOut,
            height: isExpanded ? null : 0,
            child: isExpanded
                ? Container(
                    width: double.infinity,
                    padding: EdgeInsets.fromLTRB(4.w, 0, 4.w, 4.w),
                    decoration: BoxDecoration(
                      border: Border(
                        top: BorderSide(
                          color: AppTheme.primaryGold.withValues(alpha: 0.1),
                          width: 1,
                        ),
                      ),
                    ),
                    child: Text(
                      factor['description'],
                      style: AppTheme.darkTheme.textTheme.bodyMedium?.copyWith(
                        color: AppTheme.textSecondary,
                        height: 1.5,
                      ),
                    ),
                  )
                : const SizedBox.shrink(),
          ),
        ],
      ),
    );
  }
}
