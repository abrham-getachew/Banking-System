import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';

class GoalsHeaderWidget extends StatefulWidget {
  final double totalProgress;
  final int totalGoals;
  final int completedGoals;

  const GoalsHeaderWidget({
    Key? key,
    required this.totalProgress,
    required this.totalGoals,
    required this.completedGoals,
  }) : super(key: key);

  @override
  State<GoalsHeaderWidget> createState() => _GoalsHeaderWidgetState();
}

class _GoalsHeaderWidgetState extends State<GoalsHeaderWidget>
    with TickerProviderStateMixin {
  late AnimationController _progressAnimationController;
  late Animation<double> _progressAnimation;

  @override
  void initState() {
    super.initState();
    _progressAnimationController = AnimationController(
      duration: AppTheme.aiAnimation,
      vsync: this,
    );
    _progressAnimation = Tween<double>(
      begin: 0.0,
      end: widget.totalProgress,
    ).animate(CurvedAnimation(
      parent: _progressAnimationController,
      curve: Curves.easeInOut,
    ));

    _progressAnimationController.forward();
  }

  @override
  void dispose() {
    _progressAnimationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 4.w, vertical: 2.h),
      child: Card(
        elevation: AppTheme.elevationResting,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
        child: Container(
          padding: EdgeInsets.all(5.w),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20.0),
            gradient: LinearGradient(
              colors: [
                AppTheme.chronosGold.withValues(alpha: 0.1),
                AppTheme.successGreen.withValues(alpha: 0.05),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildGreeting(),
              SizedBox(height: 3.h),
              _buildProgressSection(),
              SizedBox(height: 3.h),
              _buildStatsRow(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildGreeting() {
    final hour = DateTime.now().hour;
    String greeting;
    String emoji;

    if (hour < 12) {
      greeting = "Good Morning";
      emoji = "🌅";
    } else if (hour < 17) {
      greeting = "Good Afternoon";
      emoji = "☀️";
    } else {
      greeting = "Good Evening";
      emoji = "🌙";
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              emoji,
              style: TextStyle(fontSize: 24),
            ),
            SizedBox(width: 2.w),
            Text(
              greeting,
              style: AppTheme.darkTheme.textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.w600,
                color: AppTheme.chronosGold,
              ),
            ),
          ],
        ),
        SizedBox(height: 1.h),
        Text(
          "Let's make your financial dreams a reality",
          style: AppTheme.darkTheme.textTheme.bodyMedium?.copyWith(
            color: AppTheme.textSecondary,
          ),
        ),
      ],
    );
  }

  Widget _buildProgressSection() {
    return Row(
      children: [
        Expanded(
          flex: 2,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Overall Progress",
                style: AppTheme.darkTheme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(height: 1.h),
              AnimatedBuilder(
                animation: _progressAnimation,
                builder: (context, child) {
                  return Text(
                    "${_progressAnimation.value.toStringAsFixed(1)}%",
                    style: AppTheme.financialDataLarge.copyWith(
                      color: AppTheme.chronosGold,
                      fontWeight: FontWeight.w700,
                    ),
                  );
                },
              ),
              SizedBox(height: 0.5.h),
              Text(
                "of all goals completed",
                style: AppTheme.darkTheme.textTheme.bodySmall?.copyWith(
                  color: AppTheme.textTertiary,
                ),
              ),
            ],
          ),
        ),
        SizedBox(width: 4.w),
        Expanded(
          flex: 1,
          child: _buildCircularProgress(),
        ),
      ],
    );
  }

  Widget _buildCircularProgress() {
    return Container(
      width: 25.w,
      height: 25.w,
      child: Stack(
        alignment: Alignment.center,
        children: [
          SizedBox(
            width: 25.w,
            height: 25.w,
            child: AnimatedBuilder(
              animation: _progressAnimation,
              builder: (context, child) {
                return CircularProgressIndicator(
                  value: _progressAnimation.value / 100,
                  strokeWidth: 8.0,
                  backgroundColor: AppTheme.dividerSubtle,
                  valueColor: AlwaysStoppedAnimation<Color>(
                    _progressAnimation.value >= 75
                        ? AppTheme.successGreen
                        : AppTheme.chronosGold,
                  ),
                );
              },
            ),
          ),
          Container(
            width: 15.w,
            height: 15.w,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: AppTheme.surfaceDark,
              border: Border.all(
                color: AppTheme.dividerSubtle,
                width: 1,
              ),
            ),
            child: Center(
              child: CustomIconWidget(
                iconName: 'flag',
                color: widget.totalProgress >= 75
                    ? AppTheme.successGreen
                    : AppTheme.chronosGold,
                size: 20,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatsRow() {
    return Row(
      children: [
        Expanded(
          child: _buildStatItem(
            "Active Goals",
            "${widget.totalGoals - widget.completedGoals}",
            CustomIconWidget(
              iconName: 'trending_up',
              color: AppTheme.chronosGold,
              size: 20,
            ),
          ),
        ),
        Container(
          width: 1,
          height: 6.h,
          color: AppTheme.dividerSubtle,
        ),
        Expanded(
          child: _buildStatItem(
            "Completed",
            "${widget.completedGoals}",
            CustomIconWidget(
              iconName: 'check_circle',
              color: AppTheme.successGreen,
              size: 20,
            ),
          ),
        ),
        Container(
          width: 1,
          height: 6.h,
          color: AppTheme.dividerSubtle,
        ),
        Expanded(
          child: _buildStatItem(
            "This Month",
            "\$2,450",
            CustomIconWidget(
              iconName: 'savings',
              color: AppTheme.warningAmber,
              size: 20,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildStatItem(String label, String value, Widget icon) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 1.h),
      child: Column(
        children: [
          icon,
          SizedBox(height: 1.h),
          Text(
            value,
            style: AppTheme.darkTheme.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.w700,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 0.5.h),
          Text(
            label,
            style: AppTheme.darkTheme.textTheme.bodySmall?.copyWith(
              color: AppTheme.textTertiary,
            ),
            textAlign: TextAlign.center,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}
