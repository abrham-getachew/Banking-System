import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../core/app_export.dart';
import './widgets/ai_insights_section.dart';
import './widgets/risk_breakdown_modal.dart';
import './widgets/risk_category_card.dart';
import './widgets/risk_meter_widget.dart';
import './widgets/scenario_simulator_widget.dart';

class RiskAnalysisDashboard extends StatefulWidget {
  const RiskAnalysisDashboard({Key? key}) : super(key: key);

  @override
  State<RiskAnalysisDashboard> createState() => _RiskAnalysisDashboardState();
}

class _RiskAnalysisDashboardState extends State<RiskAnalysisDashboard> {
  final ScrollController _scrollController = ScrollController();
  int _overallRiskScore = 72;
  bool _isRefreshing = false;

  // Mock data for risk categories
  final List<Map<String, dynamic>> _riskCategories = [
    {
      "title": "Emergency Fund Ratio",
      "currentValue": "3.2 months",
      "targetRange": "6-12 months",
      "progressValue": 0.53,
      "iconName": "savings",
      "statusColor": AppTheme.warningAmber,
      "improvementDirection": "Needs Attention",
    },
    {
      "title": "Credit Exposure",
      "currentValue": "28%",
      "targetRange": "< 30%",
      "progressValue": 0.72,
      "iconName": "credit_card",
      "statusColor": AppTheme.successGreen,
      "improvementDirection": "Good",
    },
    {
      "title": "Investment Diversification",
      "currentValue": "6 sectors",
      "targetRange": "8-12 sectors",
      "progressValue": 0.65,
      "iconName": "pie_chart",
      "statusColor": AppTheme.warningAmber,
      "improvementDirection": "Needs Attention",
    },
    {
      "title": "Market Volatility Impact",
      "currentValue": "High",
      "targetRange": "Medium-Low",
      "progressValue": 0.25,
      "iconName": "trending_down",
      "statusColor": AppTheme.errorRed,
      "improvementDirection": "Critical",
    },
  ];

  // Mock data for AI insights
  final List<Map<String, dynamic>> _aiInsights = [
    {
      "category": "Emergency Fund",
      "priority": "High",
      "title": "Build Emergency Fund to 6 Months",
      "description":
          "Your current emergency fund covers only 3.2 months of expenses. Increasing this to 6 months will significantly reduce your financial risk and provide better security during market downturns.",
      "difficulty": "Medium",
      "impact": "High",
    },
    {
      "category": "Diversification",
      "priority": "Medium",
      "title": "Expand Sector Diversification",
      "description":
          "Consider adding exposure to healthcare, utilities, and international markets to reduce concentration risk in your current portfolio.",
      "difficulty": "Easy",
      "impact": "Medium",
    },
    {
      "category": "Credit Management",
      "priority": "Low",
      "title": "Optimize Credit Utilization",
      "description":
          "Your credit utilization is well-managed at 28%. Consider keeping it below 20% for optimal credit score benefits.",
      "difficulty": "Easy",
      "impact": "Low",
    },
  ];

  // Mock data for risk breakdown
  final Map<String, dynamic> _riskBreakdown = {
    "components": [
      {
        "name": "Portfolio Concentration",
        "category": "Diversification",
        "score": 65,
        "weight": 30,
        "icon": "pie_chart",
        "description":
            "Your portfolio shows moderate concentration in technology and growth stocks. Consider diversifying across more sectors and asset classes.",
      },
      {
        "name": "Emergency Fund Coverage",
        "category": "Emergency Fund",
        "score": 53,
        "weight": 25,
        "icon": "savings",
        "description":
            "Current emergency fund covers 3.2 months of expenses. Recommended coverage is 6-12 months for optimal financial security.",
      },
      {
        "name": "Credit Utilization",
        "category": "Credit Exposure",
        "score": 85,
        "weight": 20,
        "icon": "credit_card",
        "description":
            "Excellent credit management with 28% utilization ratio. This low utilization positively impacts your overall risk profile.",
      },
      {
        "name": "Market Beta Exposure",
        "category": "Market Volatility",
        "score": 45,
        "weight": 25,
        "icon": "trending_up",
        "description":
            "Your portfolio has high correlation with market movements. Consider adding defensive assets to reduce volatility impact.",
      },
    ],
  };

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  Future<void> _handleRefresh() async {
    setState(() {
      _isRefreshing = true;
    });

    // Simulate API call
    await Future.delayed(const Duration(seconds: 2));

    // Update risk score with slight variation
    setState(() {
      _overallRiskScore =
          (_overallRiskScore + (DateTime.now().millisecond % 10 - 5))
              .clamp(1, 100);
      _isRefreshing = false;
    });

    // Show haptic feedback
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Risk analysis updated'),
          duration: const Duration(seconds: 2),
          behavior: SnackBarBehavior.floating,
        ),
      );
    }
  }

  void _showRiskBreakdownModal() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => RiskBreakdownModal(
        overallRiskScore: _overallRiskScore,
        riskBreakdown: _riskBreakdown,
      ),
    );
  }

  void _showCategoryDetails(Map<String, dynamic> category) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        height: 70.h,
        decoration: BoxDecoration(
          color: AppTheme.darkTheme.colorScheme.surface,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
        ),
        child: Column(
          children: [
            // Handle bar
            Container(
              margin: EdgeInsets.only(top: 2.h),
              width: 12.w,
              height: 1.w,
              decoration: BoxDecoration(
                color: AppTheme.textTertiary.withValues(alpha: 0.5),
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            // Content
            Expanded(
              child: Padding(
                padding: EdgeInsets.all(4.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          padding: EdgeInsets.all(3.w),
                          decoration: BoxDecoration(
                            color: (category['statusColor'] as Color)
                                .withValues(alpha: 0.2),
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: CustomIconWidget(
                            iconName: category['iconName'] as String,
                            color: category['statusColor'] as Color,
                            size: 8.w,
                          ),
                        ),
                        SizedBox(width: 4.w),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                category['title'] as String,
                                style: AppTheme
                                    .darkTheme.textTheme.headlineSmall
                                    ?.copyWith(
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              Text(
                                'Detailed Analysis & Recommendations',
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
                    SizedBox(height: 4.h),
                    // Current status
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.all(4.w),
                      decoration: BoxDecoration(
                        color: AppTheme.darkTheme.scaffoldBackgroundColor,
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: AppTheme.dividerSubtle),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Current Status',
                            style: AppTheme.darkTheme.textTheme.titleMedium
                                ?.copyWith(
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          SizedBox(height: 2.h),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Current Value',
                                    style: AppTheme
                                        .darkTheme.textTheme.bodySmall
                                        ?.copyWith(
                                      color: AppTheme.textSecondary,
                                    ),
                                  ),
                                  Text(
                                    category['currentValue'] as String,
                                    style: AppTheme
                                        .darkTheme.textTheme.headlineSmall
                                        ?.copyWith(
                                      color: category['statusColor'] as Color,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                ],
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Text(
                                    'Target Range',
                                    style: AppTheme
                                        .darkTheme.textTheme.bodySmall
                                        ?.copyWith(
                                      color: AppTheme.textSecondary,
                                    ),
                                  ),
                                  Text(
                                    category['targetRange'] as String,
                                    style: AppTheme
                                        .darkTheme.textTheme.titleMedium
                                        ?.copyWith(
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 3.h),
                    // Recommendations
                    Text(
                      'AI Recommendations',
                      style: AppTheme.darkTheme.textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(height: 2.h),
                    Expanded(
                      child: ListView(
                        children: [
                          _buildRecommendationCard(
                            'Immediate Action',
                            'Focus on building your emergency fund by setting up automatic transfers of \$500 monthly to a high-yield savings account.',
                            AppTheme.errorRed,
                            'priority_high',
                          ),
                          SizedBox(height: 2.h),
                          _buildRecommendationCard(
                            'Medium-term Strategy',
                            'Consider opening a separate emergency fund account to avoid temptation of using these funds for other purposes.',
                            AppTheme.warningAmber,
                            'schedule',
                          ),
                          SizedBox(height: 2.h),
                          _buildRecommendationCard(
                            'Long-term Goal',
                            'Aim to build 12 months of expenses for maximum financial security and peace of mind.',
                            AppTheme.successGreen,
                            'flag',
                          ),
                        ],
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

  Widget _buildRecommendationCard(
      String title, String description, Color color, String iconName) {
    return Container(
      padding: EdgeInsets.all(4.w),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: color.withValues(alpha: 0.2),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.all(2.w),
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.2),
              borderRadius: BorderRadius.circular(12),
            ),
            child: CustomIconWidget(
              iconName: iconName,
              color: color,
              size: 5.w,
            ),
          ),
          SizedBox(width: 3.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: AppTheme.darkTheme.textTheme.titleSmall?.copyWith(
                    color: color,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: 1.h),
                Text(
                  description,
                  style: AppTheme.darkTheme.textTheme.bodyMedium?.copyWith(
                    color: AppTheme.textSecondary,
                    height: 1.4,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _handleAllocationChanged(Map<String, double> allocation) {
    setState(() {
      _overallRiskScore = allocation['riskScore']?.toInt() ?? _overallRiskScore;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.darkTheme.scaffoldBackgroundColor,
      appBar: AppBar(
        title: Text('Risk Analysis'),
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: CustomIconWidget(
            iconName: 'arrow_back',
            color: AppTheme.textPrimary,
            size: 6.w,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              // Navigate to AI chat for risk consultation
              Navigator.pushNamed(context, '/ai-chat-interface');
            },
            icon: CustomIconWidget(
              iconName: 'chat',
              color: AppTheme.chronosGold,
              size: 6.w,
            ),
          ),
          IconButton(
            onPressed: () {
              // Show educational tooltips
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  backgroundColor: AppTheme.darkTheme.colorScheme.surface,
                  title: Text(
                    'Risk Analysis Help',
                    style: AppTheme.darkTheme.textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  content: Text(
                    'Your risk score is calculated based on multiple factors including emergency fund coverage, investment diversification, credit exposure, and market volatility. Tap on any component for detailed explanations and improvement strategies.',
                    style: AppTheme.darkTheme.textTheme.bodyMedium?.copyWith(
                      color: AppTheme.textSecondary,
                      height: 1.4,
                    ),
                  ),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: Text('Got it'),
                    ),
                  ],
                ),
              );
            },
            icon: CustomIconWidget(
              iconName: 'help_outline',
              color: AppTheme.textSecondary,
              size: 6.w,
            ),
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: _handleRefresh,
        color: AppTheme.chronosGold,
        backgroundColor: AppTheme.darkTheme.colorScheme.surface,
        child: SingleChildScrollView(
          controller: _scrollController,
          physics: const AlwaysScrollableScrollPhysics(),
          child: Column(
            children: [
              SizedBox(height: 2.h),
              // Risk meter
              RiskMeterWidget(
                riskScore: _overallRiskScore,
                onTap: _showRiskBreakdownModal,
              ),
              SizedBox(height: 4.h),
              // Risk categories section
              Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 4.w),
                  child: Text(
                    'Risk Categories',
                    style: AppTheme.darkTheme.textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 2.h),
              SizedBox(
                height: 35.h,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  padding: EdgeInsets.symmetric(horizontal: 4.w),
                  itemCount: _riskCategories.length,
                  itemBuilder: (context, index) {
                    final category = _riskCategories[index];
                    return RiskCategoryCard(
                      title: category['title'] as String,
                      currentValue: category['currentValue'] as String,
                      targetRange: category['targetRange'] as String,
                      progressValue: category['progressValue'] as double,
                      iconName: category['iconName'] as String,
                      statusColor: category['statusColor'] as Color,
                      improvementDirection:
                          category['improvementDirection'] as String,
                      onTap: () => _showCategoryDetails(category),
                    );
                  },
                ),
              ),
              SizedBox(height: 4.h),
              // AI insights section
              AiInsightsSection(insights: _aiInsights),
              SizedBox(height: 4.h),
              // Scenario simulator
              ScenarioSimulatorWidget(
                onAllocationChanged: _handleAllocationChanged,
              ),
              SizedBox(height: 4.h),
              // Quick actions
              Container(
                margin: EdgeInsets.symmetric(horizontal: 4.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Quick Actions',
                      style: AppTheme.darkTheme.textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(height: 2.h),
                    Row(
                      children: [
                        Expanded(
                          child: _buildQuickActionCard(
                            'Emergency Fund Calculator',
                            'Calculate optimal emergency fund size',
                            'calculate',
                            AppTheme.successGreen,
                            () {
                              // Navigate to emergency fund calculator
                            },
                          ),
                        ),
                        SizedBox(width: 3.w),
                        Expanded(
                          child: _buildQuickActionCard(
                            'Credit Optimizer',
                            'Optimize credit utilization',
                            'credit_score',
                            AppTheme.warningAmber,
                            () {
                              // Navigate to credit optimizer
                            },
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(height: 6.h),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Container(
        padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 2.h),
        decoration: BoxDecoration(
          color: AppTheme.darkTheme.colorScheme.surface,
          border: Border(
            top: BorderSide(
              color: AppTheme.dividerSubtle,
              width: 1,
            ),
          ),
        ),
        child: Row(
          children: [
            Expanded(
              child: OutlinedButton.icon(
                onPressed: () =>
                    Navigator.pushNamed(context, '/investment-portfolio'),
                icon: CustomIconWidget(
                  iconName: 'pie_chart',
                  color: AppTheme.chronosGold,
                  size: 5.w,
                ),
                label: Text('View Portfolio'),
              ),
            ),
            SizedBox(width: 3.w),
            Expanded(
              child: ElevatedButton.icon(
                onPressed: () =>
                    Navigator.pushNamed(context, '/financial-goals'),
                icon: CustomIconWidget(
                  iconName: 'flag',
                  color: AppTheme.darkTheme.colorScheme.onPrimary,
                  size: 5.w,
                ),
                label: Text('Set Goals'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildQuickActionCard(
    String title,
    String subtitle,
    String iconName,
    Color color,
    VoidCallback onTap,
  ) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(4.w),
        decoration: BoxDecoration(
          color: AppTheme.darkTheme.colorScheme.surface,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: color.withValues(alpha: 0.2),
          ),
          boxShadow: [
            BoxShadow(
              color: AppTheme.darkTheme.colorScheme.shadow,
              blurRadius: 8.0,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.all(2.w),
              decoration: BoxDecoration(
                color: color.withValues(alpha: 0.2),
                borderRadius: BorderRadius.circular(12),
              ),
              child: CustomIconWidget(
                iconName: iconName,
                color: color,
                size: 6.w,
              ),
            ),
            SizedBox(height: 2.h),
            Text(
              title,
              style: AppTheme.darkTheme.textTheme.titleSmall?.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(height: 0.5.h),
            Text(
              subtitle,
              style: AppTheme.darkTheme.textTheme.bodySmall?.copyWith(
                color: AppTheme.textSecondary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
