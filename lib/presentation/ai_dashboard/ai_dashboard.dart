import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../core/app_export.dart';
import './widgets/ai_insight_card_widget.dart';
import './widgets/financial_health_widget.dart';
import './widgets/greeting_header_widget.dart';
import './widgets/net_worth_card_widget.dart';
import './widgets/wealth_pie_chart_widget.dart';

class AiDashboard extends StatefulWidget {
  const AiDashboard({super.key});

  @override
  State<AiDashboard> createState() => _AiDashboardState();
}

class _AiDashboardState extends State<AiDashboard>
    with TickerProviderStateMixin {
  late AnimationController _fabController;
  late Animation<double> _fabAnimation;
  final ScrollController _scrollController = ScrollController();
  bool _isRefreshing = false;

  final List<Map<String, dynamic>> _aiInsights = [
    {
      "id": 1,
      "title": "Optimize Your Tax Strategy",
      "description":
          "Based on your current portfolio, you could save up to \$3,200 annually by implementing tax-loss harvesting strategies. Consider rebalancing your investments before year-end.",
      "category": "Tax",
      "priority": "High",
      "impact": "+\$3,200 annual savings",
      "timestamp": "2 hours ago",
    },
    {
      "id": 2,
      "title": "Emergency Fund Alert",
      "description":
          "Your emergency fund covers 4.5 months of expenses. Financial experts recommend 6 months. Consider increasing your monthly savings by \$400 to reach this goal within 6 months.",
      "category": "Savings",
      "priority": "Medium",
      "impact": "Improved financial security",
      "timestamp": "5 hours ago",
    },
    {
      "id": 3,
      "title": "Investment Opportunity",
      "description":
          "Market analysis suggests a potential 15% upside in renewable energy ETFs over the next 12 months. This aligns with your ESG investment preferences.",
      "category": "Investment",
      "priority": "Medium",
      "impact": "Potential 15% returns",
      "timestamp": "1 day ago",
    },
    {
      "id": 4,
      "title": "Retirement Goal Progress",
      "description":
          "You're on track to exceed your retirement goal by 8%. Consider increasing your risk tolerance slightly to potentially accelerate wealth building.",
      "category": "Goal",
      "priority": "Low",
      "impact": "Accelerated wealth growth",
      "timestamp": "2 days ago",
    },
  ];

  @override
  void initState() {
    super.initState();
    _fabController = AnimationController(
      duration: AppTheme.standardAnimation,
      vsync: this,
    );
    _fabAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _fabController,
      curve: Curves.easeInOut,
    ));

    _fabController.forward();

    _scrollController.addListener(() {
      if (_scrollController.offset > 100 && !_fabController.isCompleted) {
        _fabController.forward();
      } else if (_scrollController.offset <= 100 &&
          _fabController.isCompleted) {
        _fabController.reverse();
      }
    });
  }

  @override
  void dispose() {
    _fabController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  Future<void> _handleRefresh() async {
    setState(() {
      _isRefreshing = true;
    });

    // Simulate data refresh
    await Future.delayed(const Duration(seconds: 2));

    setState(() {
      _isRefreshing = false;
    });

    // Show success feedback
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Financial data updated successfully',
            style: AppTheme.darkTheme.textTheme.bodyMedium?.copyWith(
              color: AppTheme.textPrimary,
            ),
          ),
          backgroundColor: AppTheme.surfaceDark,
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.0),
          ),
          action: SnackBarAction(
            label: 'View Details',
            textColor: AppTheme.chronosGold,
            onPressed: () {
              Navigator.pushNamed(context, '/investment-portfolio');
            },
          ),
        ),
      );
    }
  }

  void _navigateToAiChat() {
    Navigator.pushNamed(context, '/ai-chat-interface');
  }

  void _handleInsightAction(String action, Map<String, dynamic> insight) {
    switch (action) {
      case 'learn_more':
        _showInsightDetails(insight);
        break;
      case 'remind_later':
        _scheduleReminder(insight);
        break;
      case 'share':
        _shareInsight(insight);
        break;
    }
  }

  void _showInsightDetails(Map<String, dynamic> insight) {
    showModalBottomSheet(
      context: context,
      backgroundColor: AppTheme.surfaceDark,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20.0)),
      ),
      builder: (context) => Container(
        padding: EdgeInsets.all(6.w),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 12.w,
              height: 0.5.h,
              margin: EdgeInsets.only(bottom: 3.h),
              decoration: BoxDecoration(
                color: AppTheme.dividerSubtle,
                borderRadius: BorderRadius.circular(2.0),
              ),
            ),
            Text(
              insight["title"] as String,
              style: AppTheme.darkTheme.textTheme.headlineSmall?.copyWith(
                color: AppTheme.textPrimary,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(height: 2.h),
            Text(
              insight["description"] as String,
              style: AppTheme.darkTheme.textTheme.bodyLarge?.copyWith(
                color: AppTheme.textSecondary,
                height: 1.6,
              ),
            ),
            SizedBox(height: 3.h),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                      // Navigate to relevant section based on category
                      final category = insight["category"] as String;
                      switch (category.toLowerCase()) {
                        case 'investment':
                          Navigator.pushNamed(context, '/investment-portfolio');
                          break;
                        case 'goal':
                          Navigator.pushNamed(context, '/financial-goals');
                          break;
                        case 'risk':
                          Navigator.pushNamed(
                              context, '/risk-analysis-dashboard');
                          break;
                        default:
                          Navigator.pushNamed(context, '/ai-chat-interface');
                      }
                    },
                    child: Text('Take Action'),
                  ),
                ),
                SizedBox(width: 3.w),
                Expanded(
                  child: OutlinedButton(
                    onPressed: () => Navigator.pop(context),
                    child: Text('Maybe Later'),
                  ),
                ),
              ],
            ),
            SizedBox(height: 2.h),
          ],
        ),
      ),
    );
  }

  void _scheduleReminder(Map<String, dynamic> insight) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          'Reminder set for tomorrow at 9:00 AM',
          style: AppTheme.darkTheme.textTheme.bodyMedium?.copyWith(
            color: AppTheme.textPrimary,
          ),
        ),
        backgroundColor: AppTheme.surfaceDark,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0),
        ),
      ),
    );
  }

  void _shareInsight(Map<String, dynamic> insight) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          'Insight shared successfully',
          style: AppTheme.darkTheme.textTheme.bodyMedium?.copyWith(
            color: AppTheme.textPrimary,
          ),
        ),
        backgroundColor: AppTheme.surfaceDark,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.primaryCharcoal,
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: _handleRefresh,
          color: AppTheme.chronosGold,
          backgroundColor: AppTheme.surfaceDark,
          child: CustomScrollView(
            controller: _scrollController,
            physics: const AlwaysScrollableScrollPhysics(),
            slivers: [
              SliverToBoxAdapter(
                child: Column(
                  children: [
                    const GreetingHeaderWidget(),
                    SizedBox(height: 1.h),
                    const NetWorthCardWidget(),
                    SizedBox(height: 1.h),
                    const WealthPieChartWidget(),
                    SizedBox(height: 1.h),
                    const FinancialHealthWidget(),
                    SizedBox(height: 2.h),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 4.w),
                      child: Row(
                        children: [
                          CustomIconWidget(
                            iconName: 'auto_awesome',
                            color: AppTheme.chronosGold,
                            size: 6.w,
                          ),
                          SizedBox(width: 2.w),
                          Text(
                            'AI Insights',
                            style: AppTheme.darkTheme.textTheme.titleLarge
                                ?.copyWith(
                              color: AppTheme.textPrimary,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 1.h),
                  ],
                ),
              ),
              if (_isRefreshing)
                SliverToBoxAdapter(
                  child: Container(
                    height: 10.h,
                    child: Center(
                      child: CircularProgressIndicator(
                        color: AppTheme.chronosGold,
                      ),
                    ),
                  ),
                )
              else
                SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (context, index) {
                      final insight = _aiInsights[index];
                      return AiInsightCardWidget(
                        insightData: insight,
                        onLearnMore: () =>
                            _handleInsightAction('learn_more', insight),
                        onRemindLater: () =>
                            _handleInsightAction('remind_later', insight),
                        onShare: () => _handleInsightAction('share', insight),
                      );
                    },
                    childCount: _aiInsights.length,
                  ),
                ),
              SliverToBoxAdapter(
                child: SizedBox(height: 10.h),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: AnimatedBuilder(
        animation: _fabAnimation,
        builder: (context, child) {
          return Transform.scale(
            scale: _fabAnimation.value,
            child: FloatingActionButton.extended(
              onPressed: _navigateToAiChat,
              backgroundColor: AppTheme.chronosGold,
              foregroundColor: AppTheme.primaryCharcoal,
              elevation: 6.0,
              icon: CustomIconWidget(
                iconName: 'chat',
                color: AppTheme.primaryCharcoal,
                size: 6.w,
              ),
              label: Text(
                'Ask AI',
                style: AppTheme.darkTheme.textTheme.labelLarge?.copyWith(
                  color: AppTheme.primaryCharcoal,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          );
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: AppTheme.surfaceDark,
          boxShadow: [
            BoxShadow(
              color: AppTheme.shadowDark,
              blurRadius: 8.0,
              offset: const Offset(0, -2),
            ),
          ],
        ),
        child: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          backgroundColor: AppTheme.surfaceDark,
          selectedItemColor: AppTheme.chronosGold,
          unselectedItemColor: AppTheme.textSecondary,
          currentIndex: 0, // Home tab is active
          elevation: 0,
          items: [
            BottomNavigationBarItem(
              icon: CustomIconWidget(
                iconName: 'home',
                color: AppTheme.chronosGold,
                size: 6.w,
              ),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: CustomIconWidget(
                iconName: 'psychology',
                color: AppTheme.textSecondary,
                size: 6.w,
              ),
              label: 'AI',
            ),
            BottomNavigationBarItem(
              icon: CustomIconWidget(
                iconName: 'swap_horiz',
                color: AppTheme.textSecondary,
                size: 6.w,
              ),
              label: 'Transfer',
            ),
            BottomNavigationBarItem(
              icon: CustomIconWidget(
                iconName: 'currency_bitcoin',
                color: AppTheme.textSecondary,
                size: 6.w,
              ),
              label: 'Crypto',
            ),
            BottomNavigationBarItem(
              icon: CustomIconWidget(
                iconName: 'explore',
                color: AppTheme.textSecondary,
                size: 6.w,
              ),
              label: 'LifeX',
            ),
          ],
          onTap: (index) {
            // Handle navigation to other tabs
            switch (index) {
              case 0:
                // Already on Home
                break;
              case 1:
                Navigator.pushNamed(context, '/ai-chat-interface');
                break;
              case 2:
                // Navigate to Transfer
                break;
              case 3:
                // Navigate to Crypto
                break;
              case 4:
                // Navigate to LifeX
                break;
            }
          },
        ),
      ),
    );
  }
}
