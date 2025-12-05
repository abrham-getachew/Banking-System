import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';

class EmptyGoalsWidget extends StatefulWidget {
  final VoidCallback onCreateGoal;

  const EmptyGoalsWidget({
    Key? key,
    required this.onCreateGoal,
  }) : super(key: key);

  @override
  State<EmptyGoalsWidget> createState() => _EmptyGoalsWidgetState();
}

class _EmptyGoalsWidgetState extends State<EmptyGoalsWidget>
    with TickerProviderStateMixin {
  late AnimationController _floatingAnimationController;
  late Animation<double> _floatingAnimation;
  late AnimationController _scaleAnimationController;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();

    _floatingAnimationController = AnimationController(
      duration: Duration(seconds: 3),
      vsync: this,
    );
    _floatingAnimation = Tween<double>(
      begin: -10.0,
      end: 10.0,
    ).animate(CurvedAnimation(
      parent: _floatingAnimationController,
      curve: Curves.easeInOut,
    ));

    _scaleAnimationController = AnimationController(
      duration: AppTheme.standardAnimation,
      vsync: this,
    );
    _scaleAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _scaleAnimationController,
      curve: Curves.elasticOut,
    ));

    _floatingAnimationController.repeat(reverse: true);
    _scaleAnimationController.forward();
  }

  @override
  void dispose() {
    _floatingAnimationController.dispose();
    _scaleAnimationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ScaleTransition(
      scale: _scaleAnimation,
      child: Container(
        padding: EdgeInsets.all(6.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildIllustration(),
            SizedBox(height: 4.h),
            _buildEmptyStateText(),
            SizedBox(height: 4.h),
            _buildCreateGoalButton(),
            SizedBox(height: 4.h),
            _buildGoalTemplates(),
          ],
        ),
      ),
    );
  }

  Widget _buildIllustration() {
    return AnimatedBuilder(
      animation: _floatingAnimation,
      builder: (context, child) {
        return Transform.translate(
          offset: Offset(0, _floatingAnimation.value),
          child: Container(
            width: 50.w,
            height: 50.w,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: RadialGradient(
                colors: [
                  AppTheme.chronosGold.withValues(alpha: 0.2),
                  AppTheme.chronosGold.withValues(alpha: 0.05),
                  Colors.transparent,
                ],
                stops: [0.3, 0.7, 1.0],
              ),
            ),
            child: Stack(
              alignment: Alignment.center,
              children: [
                Container(
                  width: 35.w,
                  height: 35.w,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppTheme.chronosGold.withValues(alpha: 0.1),
                    border: Border.all(
                      color: AppTheme.chronosGold.withValues(alpha: 0.3),
                      width: 2,
                    ),
                  ),
                  child: Center(
                    child: CustomIconWidget(
                      iconName: 'flag',
                      color: AppTheme.chronosGold,
                      size: 60,
                    ),
                  ),
                ),
                Positioned(
                  top: 8.w,
                  right: 8.w,
                  child: Container(
                    width: 8.w,
                    height: 8.w,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: AppTheme.successGreen,
                    ),
                    child: Center(
                      child: CustomIconWidget(
                        iconName: 'star',
                        color: AppTheme.textPrimary,
                        size: 16,
                      ),
                    ),
                  ),
                ),
                Positioned(
                  bottom: 12.w,
                  left: 6.w,
                  child: Container(
                    width: 6.w,
                    height: 6.w,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: AppTheme.warningAmber,
                    ),
                    child: Center(
                      child: CustomIconWidget(
                        iconName: 'trending_up',
                        color: AppTheme.textPrimary,
                        size: 12,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildEmptyStateText() {
    return Column(
      children: [
        Text(
          "Set Your First Goal",
          style: AppTheme.darkTheme.textTheme.headlineMedium?.copyWith(
            fontWeight: FontWeight.w700,
            color: AppTheme.chronosGold,
          ),
          textAlign: TextAlign.center,
        ),
        SizedBox(height: 2.h),
        Text(
          "Turn your dreams into achievable milestones.\nStart building your financial future today.",
          style: AppTheme.darkTheme.textTheme.bodyLarge?.copyWith(
            color: AppTheme.textSecondary,
            height: 1.5,
          ),
          textAlign: TextAlign.center,
        ),
        SizedBox(height: 2.h),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 1.h),
          decoration: BoxDecoration(
            color: AppTheme.successGreen.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(20.0),
            border: Border.all(
              color: AppTheme.successGreen.withValues(alpha: 0.3),
              width: 1,
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              CustomIconWidget(
                iconName: 'auto_awesome',
                color: AppTheme.successGreen,
                size: 16,
              ),
              SizedBox(width: 2.w),
              Text(
                "AI-powered recommendations included",
                style: AppTheme.darkTheme.textTheme.bodySmall?.copyWith(
                  color: AppTheme.successGreen,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildCreateGoalButton() {
    return Container(
      width: double.infinity,
      child: ElevatedButton.icon(
        onPressed: widget.onCreateGoal,
        icon: CustomIconWidget(
          iconName: 'add',
          color: AppTheme.primaryCharcoal,
          size: 24,
        ),
        label: Text(
          "Create Your First Goal",
          style: TextStyle(
            fontSize: 16.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
        style: ElevatedButton.styleFrom(
          padding: EdgeInsets.symmetric(vertical: 2.h),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.0),
          ),
          elevation: AppTheme.elevationResting,
        ),
      ),
    );
  }

  Widget _buildGoalTemplates() {
    final templates = [
      {
        "title": "Dream Vacation",
        "amount": "\$5,000",
        "icon": "flight_takeoff",
        "color": AppTheme.successGreen,
      },
      {
        "title": "Emergency Fund",
        "amount": "\$10,000",
        "icon": "security",
        "color": AppTheme.warningAmber,
      },
      {
        "title": "New Car",
        "amount": "\$25,000",
        "icon": "directions_car",
        "color": AppTheme.chronosGold,
      },
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Popular Goals",
          style: AppTheme.darkTheme.textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
        SizedBox(height: 2.h),
        Column(
          children: templates.map((template) {
            return Container(
              margin: EdgeInsets.only(bottom: 2.h),
              child: InkWell(
                onTap: widget.onCreateGoal,
                borderRadius: BorderRadius.circular(12.0),
                child: Container(
                  padding: EdgeInsets.all(4.w),
                  decoration: BoxDecoration(
                    color: AppTheme.surfaceDark.withValues(alpha: 0.5),
                    borderRadius: BorderRadius.circular(12.0),
                    border: Border.all(
                      color: AppTheme.dividerSubtle,
                      width: 1,
                    ),
                  ),
                  child: Row(
                    children: [
                      Container(
                        width: 12.w,
                        height: 12.w,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: (template["color"] as Color)
                              .withValues(alpha: 0.2),
                        ),
                        child: Center(
                          child: CustomIconWidget(
                            iconName: template["icon"] as String,
                            color: template["color"] as Color,
                            size: 20,
                          ),
                        ),
                      ),
                      SizedBox(width: 4.w),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              template["title"] as String,
                              style: AppTheme.darkTheme.textTheme.titleSmall
                                  ?.copyWith(
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Text(
                              "Target: ${template["amount"]}",
                              style: AppTheme.darkTheme.textTheme.bodySmall
                                  ?.copyWith(
                                color: AppTheme.textSecondary,
                              ),
                            ),
                          ],
                        ),
                      ),
                      CustomIconWidget(
                        iconName: 'arrow_forward_ios',
                        color: AppTheme.textTertiary,
                        size: 16,
                      ),
                    ],
                  ),
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }
}
