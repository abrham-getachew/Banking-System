import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../core/app_export.dart';
import './widgets/empty_goals_widget.dart';
import './widgets/goal_card_widget.dart';
import './widgets/goal_creation_dialog.dart';
import './widgets/goal_timeline_widget.dart';
import './widgets/goals_header_widget.dart';

class FinancialGoals extends StatefulWidget {
  const FinancialGoals({Key? key}) : super(key: key);

  @override
  State<FinancialGoals> createState() => _FinancialGoalsState();
}

class _FinancialGoalsState extends State<FinancialGoals>
    with TickerProviderStateMixin {
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
      GlobalKey<RefreshIndicatorState>();

  late AnimationController _fabAnimationController;
  late Animation<double> _fabAnimation;

  List<Map<String, dynamic>> _goals = [];
  bool _isLoading = false;

  // Mock data for goals
  final List<Map<String, dynamic>> _mockGoals = [
    {
      "id": 1,
      "title": "Dream Vacation to Japan",
      "category": "Vacation",
      "targetAmount": 8000.0,
      "currentAmount": 3200.0,
      "monthlyContribution": 400.0,
      "timelineMonths": 20,
      "status": "On Track",
      "image":
          "https://images.unsplash.com/photo-1493976040374-85c8e12f0c0e?w=400&h=300&fit=crop",
      "estimatedCompletion": "2025-12-15",
      "aiSuggestion":
          "Consider increasing contributions by \$50/month to reach your goal 2 months earlier",
    },
    {
      "id": 2,
      "title": "Emergency Fund",
      "category": "Emergency",
      "targetAmount": 15000.0,
      "currentAmount": 12750.0,
      "monthlyContribution": 500.0,
      "timelineMonths": 30,
      "status": "On Track",
      "image":
          "https://images.unsplash.com/photo-1579621970563-ebec7560ff3e?w=400&h=300&fit=crop",
      "estimatedCompletion": "2025-08-20",
      "aiSuggestion":
          "You're doing great! Consider automating transfers to maintain consistency",
    },
    {
      "id": 3,
      "title": "New Tesla Model 3",
      "category": "Car",
      "targetAmount": 45000.0,
      "currentAmount": 18000.0,
      "monthlyContribution": 750.0,
      "timelineMonths": 36,
      "status": "Behind",
      "image":
          "https://images.unsplash.com/photo-1560958089-b8a1929cea89?w=400&h=300&fit=crop",
      "estimatedCompletion": "2027-07-19",
      "aiSuggestion":
          "Consider a side income or reduce dining out expenses to boost savings",
    },
    {
      "id": 4,
      "title": "Master's Degree",
      "category": "Education",
      "targetAmount": 25000.0,
      "currentAmount": 25000.0,
      "monthlyContribution": 800.0,
      "timelineMonths": 31,
      "status": "Completed",
      "image":
          "https://images.unsplash.com/photo-1523050854058-8df90110c9f1?w=400&h=300&fit=crop",
      "estimatedCompletion": "2025-01-15",
      "aiSuggestion": null,
    },
  ];

  // Mock timeline milestones
  final List<Map<String, dynamic>> _mockMilestones = [
    {
      "title": "First \$1,000 Saved",
      "description": "Build your initial emergency buffer",
      "targetAmount": 1000.0,
      "progress": 100.0,
      "isCompleted": true,
      "isCurrent": false,
      "estimatedDate": "Jan 2025",
      "aiTip": null,
    },
    {
      "title": "Quarter Goal Reached",
      "description": "25% of your total savings target",
      "targetAmount": 2500.0,
      "progress": 85.0,
      "isCompleted": false,
      "isCurrent": true,
      "estimatedDate": "Mar 2025",
      "aiTip": "You're close! Consider a small bonus contribution",
    },
    {
      "title": "Halfway Milestone",
      "description": "50% of your savings goal achieved",
      "targetAmount": 5000.0,
      "progress": 0.0,
      "isCompleted": false,
      "isCurrent": false,
      "estimatedDate": "Jun 2025",
      "aiTip": "Set up automatic transfers to stay consistent",
    },
    {
      "title": "Final Sprint",
      "description": "75% completed - you're almost there!",
      "targetAmount": 7500.0,
      "progress": 0.0,
      "isCompleted": false,
      "isCurrent": false,
      "estimatedDate": "Sep 2025",
      "aiTip": null,
    },
    {
      "title": "Goal Achieved!",
      "description": "Congratulations on reaching your target",
      "targetAmount": 10000.0,
      "progress": 0.0,
      "isCompleted": false,
      "isCurrent": false,
      "estimatedDate": "Dec 2025",
      "aiTip": null,
    },
  ];

  @override
  void initState() {
    super.initState();
    _goals = List.from(_mockGoals);

    _fabAnimationController = AnimationController(
      duration: AppTheme.standardAnimation,
      vsync: this,
    );
    _fabAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _fabAnimationController,
      curve: Curves.elasticOut,
    ));

    _fabAnimationController.forward();
  }

  @override
  void dispose() {
    _fabAnimationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.primaryCharcoal,
      appBar: _buildAppBar(),
      body: _goals.isEmpty ? _buildEmptyState() : _buildGoalsContent(),
      floatingActionButton: _buildFloatingActionButton(),
      bottomNavigationBar: _buildBottomNavigationBar(),
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      title: Text(
        "Financial Goals",
        style: AppTheme.darkTheme.textTheme.titleLarge?.copyWith(
          fontWeight: FontWeight.w600,
        ),
      ),
      actions: [
        IconButton(
          onPressed: () => _showFilterOptions(),
          icon: CustomIconWidget(
            iconName: 'filter_list',
            color: AppTheme.chronosGold,
            size: 24,
          ),
        ),
        IconButton(
          onPressed: () => _showSortOptions(),
          icon: CustomIconWidget(
            iconName: 'sort',
            color: AppTheme.textSecondary,
            size: 24,
          ),
        ),
      ],
    );
  }

  Widget _buildEmptyState() {
    return EmptyGoalsWidget(
      onCreateGoal: _showGoalCreationDialog,
    );
  }

  Widget _buildGoalsContent() {
    final completedGoals =
        _goals.where((goal) => goal["status"] == "Completed").length;
    final totalProgress = _calculateTotalProgress();

    return RefreshIndicator(
      key: _refreshIndicatorKey,
      onRefresh: _refreshGoals,
      color: AppTheme.chronosGold,
      backgroundColor: AppTheme.surfaceDark,
      child: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: GoalsHeaderWidget(
              totalProgress: totalProgress,
              totalGoals: _goals.length,
              completedGoals: completedGoals,
            ),
          ),
          SliverToBoxAdapter(
            child: SizedBox(height: 2.h),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                final goal = _goals[index];
                return GoalCardWidget(
                  goal: goal,
                  onTap: () => _showGoalDetails(goal),
                  onAddMoney: () => _showAddMoneyDialog(goal),
                  onAdjustTarget: () => _showAdjustTargetDialog(goal),
                  onShareProgress: () => _shareGoalProgress(goal),
                  onViewPlan: () => _showAIPlan(goal),
                );
              },
              childCount: _goals.length,
            ),
          ),
          SliverToBoxAdapter(
            child: SizedBox(height: 2.h),
          ),
          SliverToBoxAdapter(
            child: GoalTimelineWidget(
              milestones: _mockMilestones,
            ),
          ),
          SliverToBoxAdapter(
            child: SizedBox(height: 10.h),
          ),
        ],
      ),
    );
  }

  Widget _buildFloatingActionButton() {
    return ScaleTransition(
      scale: _fabAnimation,
      child: FloatingActionButton.extended(
        onPressed: _showGoalCreationDialog,
        icon: CustomIconWidget(
          iconName: 'add',
          color: AppTheme.primaryCharcoal,
          size: 24,
        ),
        label: Text(
          "New Goal",
          style: TextStyle(
            fontWeight: FontWeight.w600,
            color: AppTheme.primaryCharcoal,
          ),
        ),
        backgroundColor: AppTheme.chronosGold,
        elevation: AppTheme.elevationResting,
      ),
    );
  }

  Widget _buildBottomNavigationBar() {
    return Container(
      decoration: BoxDecoration(
        color: AppTheme.surfaceDark,
        boxShadow: [
          BoxShadow(
            color: AppTheme.shadowDark,
            blurRadius: 8.0,
            offset: Offset(0, -2),
          ),
        ],
      ),
      child: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: AppTheme.surfaceDark,
        selectedItemColor: AppTheme.chronosGold,
        unselectedItemColor: AppTheme.textSecondary,
        currentIndex: 4, // Goals tab
        items: [
          BottomNavigationBarItem(
            icon: CustomIconWidget(
              iconName: 'dashboard',
              color: AppTheme.textSecondary,
              size: 24,
            ),
            activeIcon: CustomIconWidget(
              iconName: 'dashboard',
              color: AppTheme.chronosGold,
              size: 24,
            ),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: CustomIconWidget(
              iconName: 'auto_awesome',
              color: AppTheme.textSecondary,
              size: 24,
            ),
            activeIcon: CustomIconWidget(
              iconName: 'auto_awesome',
              color: AppTheme.chronosGold,
              size: 24,
            ),
            label: 'AI',
          ),
          BottomNavigationBarItem(
            icon: CustomIconWidget(
              iconName: 'swap_horiz',
              color: AppTheme.textSecondary,
              size: 24,
            ),
            activeIcon: CustomIconWidget(
              iconName: 'swap_horiz',
              color: AppTheme.chronosGold,
              size: 24,
            ),
            label: 'Transfer',
          ),
          BottomNavigationBarItem(
            icon: CustomIconWidget(
              iconName: 'currency_bitcoin',
              color: AppTheme.textSecondary,
              size: 24,
            ),
            activeIcon: CustomIconWidget(
              iconName: 'currency_bitcoin',
              color: AppTheme.chronosGold,
              size: 24,
            ),
            label: 'Crypto',
          ),
          BottomNavigationBarItem(
            icon: CustomIconWidget(
              iconName: 'flag',
              color: AppTheme.chronosGold,
              size: 24,
            ),
            activeIcon: CustomIconWidget(
              iconName: 'flag',
              color: AppTheme.chronosGold,
              size: 24,
            ),
            label: 'Goals',
          ),
        ],
        onTap: (index) => _handleBottomNavigation(index),
      ),
    );
  }

  double _calculateTotalProgress() {
    if (_goals.isEmpty) return 0.0;

    double totalProgress = 0.0;
    for (final goal in _goals) {
      final progress =
          (goal["currentAmount"] as double) / (goal["targetAmount"] as double);
      totalProgress += progress > 1.0 ? 1.0 : progress;
    }

    return (totalProgress / _goals.length) * 100;
  }

  Future<void> _refreshGoals() async {
    setState(() {
      _isLoading = true;
    });

    // Simulate API call
    await Future.delayed(Duration(seconds: 1));

    setState(() {
      _isLoading = false;
      // In a real app, this would fetch updated data from the server
    });
  }

  void _showGoalCreationDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => GoalCreationDialog(
        onGoalCreated: (newGoal) {
          setState(() {
            _goals.add(newGoal);
          });
        },
      ),
    );
  }

  void _showGoalDetails(Map<String, dynamic> goal) {
    showModalBottomSheet(
      context: context,
      backgroundColor: AppTheme.surfaceDark,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20.0)),
      ),
      builder: (context) => Container(
        height: 70.h,
        padding: EdgeInsets.all(4.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 10.w,
              height: 0.5.h,
              decoration: BoxDecoration(
                color: AppTheme.dividerSubtle,
                borderRadius: BorderRadius.circular(2.0),
              ),
            ),
            SizedBox(height: 2.h),
            Text(
              goal["title"] as String,
              style: AppTheme.darkTheme.textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(height: 2.h),
            // Add more goal details here
            Text(
              "Goal details and analytics would be displayed here",
              style: AppTheme.darkTheme.textTheme.bodyMedium?.copyWith(
                color: AppTheme.textSecondary,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showAddMoneyDialog(Map<String, dynamic> goal) {
    final TextEditingController amountController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: AppTheme.surfaceDark,
        title: Text("Add Money to Goal"),
        content: TextField(
          controller: amountController,
          keyboardType: TextInputType.number,
          decoration: InputDecoration(
            labelText: "Amount",
            hintText: "0.00",
            prefixText: "\$ ",
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text("Cancel"),
          ),
          ElevatedButton(
            onPressed: () {
              final amount = double.tryParse(amountController.text) ?? 0;
              if (amount > 0) {
                setState(() {
                  goal["currentAmount"] =
                      (goal["currentAmount"] as double) + amount;
                });
              }
              Navigator.pop(context);
            },
            child: Text("Add Money"),
          ),
        ],
      ),
    );
  }

  void _showAdjustTargetDialog(Map<String, dynamic> goal) {
    // Implementation for adjusting target amount
  }

  void _shareGoalProgress(Map<String, dynamic> goal) {
    // Implementation for sharing goal progress
  }

  void _showAIPlan(Map<String, dynamic> goal) {
    // Implementation for showing AI-generated savings plan
  }

  void _showFilterOptions() {
    showModalBottomSheet(
      context: context,
      backgroundColor: AppTheme.surfaceDark,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20.0)),
      ),
      builder: (context) => Container(
        padding: EdgeInsets.all(4.w),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              "Filter Goals",
              style: AppTheme.darkTheme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(height: 2.h),
            // Add filter options here
          ],
        ),
      ),
    );
  }

  void _showSortOptions() {
    showModalBottomSheet(
      context: context,
      backgroundColor: AppTheme.surfaceDark,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20.0)),
      ),
      builder: (context) => Container(
        padding: EdgeInsets.all(4.w),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              "Sort Goals",
              style: AppTheme.darkTheme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(height: 2.h),
            // Add sort options here
          ],
        ),
      ),
    );
  }

  void _handleBottomNavigation(int index) {
    switch (index) {
      case 0:
        Navigator.pushNamed(context, '/ai-dashboard');
        break;
      case 1:
        Navigator.pushNamed(context, '/ai-chat-interface');
        break;
      case 2:
        // Transfer functionality
        break;
      case 3:
        // Crypto functionality
        break;
      case 4:
        // Current screen - Goals
        break;
    }
  }
}
