import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../core/app_export.dart';
import '../../theme/app_theme.dart';
import '../../widgets/custom_icon_widget.dart';
import './widgets/ai_insights_cards_widget.dart';
import './widgets/budget_rules_toggle_widget.dart';
import './widgets/category_analysis_widget.dart';
import './widgets/quick_actions_widget.dart';
import './widgets/spending_donut_chart_widget.dart';
import './widgets/spending_header_widget.dart';
import './widgets/spending_timeline_widget.dart';

class SpendingHabitAnalyzer extends StatefulWidget {
  const SpendingHabitAnalyzer({super.key});

  @override
  State<SpendingHabitAnalyzer> createState() => _SpendingHabitAnalyzerState();
}

class _SpendingHabitAnalyzerState extends State<SpendingHabitAnalyzer>
    with TickerProviderStateMixin {
  late AnimationController _fadeController;
  late Animation<double> _fadeAnimation;
  bool _isRefreshing = false;

  // Mock data for spending analysis
  final Map<String, dynamic> spendingData = {
    'monthlyTotal': 3420.00,
    'monthlyChange': -8.5,
    'currentMonth': 'January 2025',
  };

  final List<Map<String, dynamic>> spendingCategories = [
    {
      'category': 'Groceries',
      'amount': 850.00,
      'percentage': 24.9,
      'budgetLimit': 900.00,
      'color': const Color(0xFF10B981),
      'trend': 'up',
      'trendValue': 5.2,
    },
    {
      'category': 'Takeout',
      'amount': 485.00,
      'percentage': 14.2,
      'budgetLimit': 350.00,
      'color': const Color(0xFFEF4444),
      'trend': 'up',
      'trendValue': 28.5,
    },
    {
      'category': 'Transportation',
      'amount': 420.00,
      'percentage': 12.3,
      'budgetLimit': 500.00,
      'color': const Color(0xFF3B82F6),
      'trend': 'down',
      'trendValue': 10.2,
    },
    {
      'category': 'Entertainment',
      'amount': 380.00,
      'percentage': 11.1,
      'budgetLimit': 400.00,
      'color': const Color(0xFF8B5CF6),
      'trend': 'up',
      'trendValue': 15.8,
    },
    {
      'category': 'Utilities',
      'amount': 285.00,
      'percentage': 8.3,
      'budgetLimit': 300.00,
      'color': AppTheme.warningAmber,
      'trend': 'stable',
      'trendValue': 1.2,
    },
    {
      'category': 'Shopping',
      'amount': 650.00,
      'percentage': 19.0,
      'budgetLimit': 600.00,
      'color': AppTheme.chronosGold,
      'trend': 'up',
      'trendValue': 12.3,
    },
    {
      'category': 'Healthcare',
      'amount': 350.00,
      'percentage': 10.2,
      'budgetLimit': 400.00,
      'color': const Color(0xFFF59E0B),
      'trend': 'down',
      'trendValue': 5.5,
    },
  ];

  final List<String> aiInsights = [
    "You're overspending on takeout by \$135 this month. Try meal prepping to save \$400 monthly.",
    "Your grocery spending is 15% below budget - great job shopping smart!",
    "Entertainment spending increased 16% - consider free activities this weekend.",
    "Transportation costs dropped 10% thanks to remote work days.",
  ];

  final Map<String, bool> budgetRules = {
    '50/30/20 Rule': false,
    'Envelope Method': true,
    'Zero-Based Budget': false,
    'Pay Yourself First': true,
  };

  final List<Map<String, dynamic>> dailySpending = [
    {'date': '2025-01-15', 'amount': 125.50, 'category': 'Groceries'},
    {'date': '2025-01-16', 'amount': 45.00, 'category': 'Takeout'},
    {'date': '2025-01-17', 'amount': 280.00, 'category': 'Shopping'},
    {'date': '2025-01-18', 'amount': 85.50, 'category': 'Entertainment'},
    {'date': '2025-01-19', 'amount': 165.00, 'category': 'Groceries'},
  ];

  @override
  void initState() {
    super.initState();
    _fadeController = AnimationController(
      duration: AppTheme.standardAnimation,
      vsync: this,
    );
    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _fadeController,
      curve: Curves.easeInOut,
    ));
    _fadeController.forward();
  }

  @override
  void dispose() {
    _fadeController.dispose();
    super.dispose();
  }

  Future<void> _refreshData() async {
    setState(() {
      _isRefreshing = true;
    });

    // Simulate API call
    await Future.delayed(const Duration(seconds: 2));

    setState(() {
      _isRefreshing = false;
    });

    if (mounted) {
      Fluttertoast.showToast(
        msg: "Spending data synchronized",
        backgroundColor: AppTheme.successGreen,
        textColor: AppTheme.textPrimary,
      );
    }
  }

  void _onBudgetRuleToggled(String rule, bool value) {
    setState(() {
      budgetRules[rule] = value;
    });

    Fluttertoast.showToast(
      msg: value ? "$rule activated" : "$rule deactivated",
      backgroundColor: AppTheme.chronosGold,
      textColor: AppTheme.textPrimary,
    );
  }

  void _onCategoryLongPress(Map<String, dynamic> category) {
    _showCategoryDetails(category);
  }

  void _showCategoryDetails(Map<String, dynamic> category) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (context) => Container(
        height: 70.h,
        decoration: BoxDecoration(
          color: AppTheme.surfaceDark,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(24.0),
            topRight: Radius.circular(24.0),
          ),
        ),
        child: Column(
          children: [
            Container(
              width: 12.w,
              height: 0.5.h,
              margin: EdgeInsets.only(top: 1.h),
              decoration: BoxDecoration(
                color: AppTheme.dividerSubtle,
                borderRadius: BorderRadius.circular(2.0),
              ),
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.all(4.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          width: 12.w,
                          height: 12.w,
                          decoration: BoxDecoration(
                            color: category['color'].withValues(alpha: 0.1),
                            borderRadius: BorderRadius.circular(12.0),
                          ),
                          child: Icon(
                            _getCategoryIcon(category['category']),
                            color: category['color'],
                            size: 6.w,
                          ),
                        ),
                        SizedBox(width: 4.w),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                category['category'],
                                style: AppTheme.darkTheme.textTheme.titleLarge
                                    ?.copyWith(
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              Text(
                                'This month: \$${category['amount'].toStringAsFixed(2)}',
                                style: AppTheme.darkTheme.textTheme.bodyMedium
                                    ?.copyWith(
                                  color: AppTheme.textSecondary,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 3.h),
                    Text(
                      'Budget Analysis',
                      style: AppTheme.darkTheme.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(height: 2.h),
                    // Add detailed transaction list here
                    Text(
                      'Recent transactions and detailed breakdown would appear here',
                      style: AppTheme.darkTheme.textTheme.bodyMedium?.copyWith(
                        color: AppTheme.textSecondary,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.primaryCharcoal,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: CustomIconWidget(
            iconName: 'arrow_back',
            color: AppTheme.textPrimary,
            size: 6.w,
          ),
        ),
        title: Text(
          'Spending Analyzer',
          style: AppTheme.darkTheme.textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
      ),
      body: RefreshIndicator(
        onRefresh: _refreshData,
        color: AppTheme.chronosGold,
        backgroundColor: AppTheme.surfaceDark,
        child: FadeTransition(
          opacity: _fadeAnimation,
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            child: Column(
              children: [
                SpendingHeaderWidget(
                  monthlyTotal: spendingData['monthlyTotal'],
                  monthlyChange: spendingData['monthlyChange'],
                  currentMonth: spendingData['currentMonth'],
                ),
                SizedBox(height: 2.h),
                SpendingDonutChartWidget(
                  spendingCategories: spendingCategories,
                  onCategoryTap: _onCategoryLongPress,
                ),
                SizedBox(height: 2.h),
                AiInsightsCardsWidget(
                  insights: aiInsights,
                ),
                SizedBox(height: 2.h),
                CategoryAnalysisWidget(
                  categories: spendingCategories,
                  onCategoryLongPress: _onCategoryLongPress,
                ),
                SizedBox(height: 2.h),
                BudgetRulesToggleWidget(
                  budgetRules: budgetRules,
                  onRuleToggled: _onBudgetRuleToggled,
                ),
                SizedBox(height: 2.h),
                SpendingTimelineWidget(
                  dailySpending: dailySpending,
                ),
                SizedBox(height: 2.h),
                const QuickActionsWidget(),
                SizedBox(height: 4.h),
              ],
            ),
          ),
        ),
      ),
    );
  }
}