import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../core/app_export.dart';
import './widgets/ai_insights_widget.dart';
import './widgets/empty_portfolio_widget.dart';
import './widgets/filter_chips_widget.dart';
import './widgets/investment_card_widget.dart';
import './widgets/portfolio_chart_widget.dart';
import './widgets/portfolio_header_widget.dart';

class InvestmentPortfolio extends StatefulWidget {
  const InvestmentPortfolio({super.key});

  @override
  State<InvestmentPortfolio> createState() => _InvestmentPortfolioState();
}

class _InvestmentPortfolioState extends State<InvestmentPortfolio> {
  String _selectedPeriod = '1M';
  String _selectedFilter = 'All';
  bool _isLoading = false;

  // Mock data for portfolio
  final List<Map<String, dynamic>> _investments = [
    {
      "id": 1,
      "name": "Apple Inc.",
      "type": "Technology Stock",
      "icon":
          "https://images.unsplash.com/photo-1611532736597-de2d4265fba3?w=100&h=100&fit=crop",
      "currentValue": "\$12,450.00",
      "roi": 15.67,
      "riskLevel": "Medium",
      "category": "Stocks"
    },
    {
      "id": 2,
      "name": "Bitcoin",
      "type": "Cryptocurrency",
      "icon":
          "https://images.unsplash.com/photo-1518546305927-5a555bb7020d?w=100&h=100&fit=crop",
      "currentValue": "\$8,920.00",
      "roi": -5.23,
      "riskLevel": "High",
      "category": "Crypto"
    },
    {
      "id": 3,
      "name": "Vanguard S&P 500",
      "type": "Index Fund",
      "icon":
          "https://images.unsplash.com/photo-1559526324-4b87b5e36e44?w=100&h=100&fit=crop",
      "currentValue": "\$25,680.00",
      "roi": 12.34,
      "riskLevel": "Low",
      "category": "Funds"
    },
    {
      "id": 4,
      "name": "Tesla Inc.",
      "type": "Electric Vehicle Stock",
      "icon":
          "https://images.unsplash.com/photo-1560958089-b8a1929cea89?w=100&h=100&fit=crop",
      "currentValue": "\$6,750.00",
      "roi": 28.91,
      "riskLevel": "High",
      "category": "Stocks"
    },
    {
      "id": 5,
      "name": "Gold ETF",
      "type": "Precious Metals",
      "icon":
          "https://images.unsplash.com/photo-1610375461246-83df859d849d?w=100&h=100&fit=crop",
      "currentValue": "\$4,320.00",
      "roi": 3.45,
      "riskLevel": "Low",
      "category": "Commodities"
    }
  ];

  final List<Map<String, dynamic>> _chartData = [
    {"label": "Jan", "value": 45000},
    {"label": "Feb", "value": 47500},
    {"label": "Mar", "value": 46800},
    {"label": "Apr", "value": 49200},
    {"label": "May", "value": 52100},
    {"label": "Jun", "value": 50800},
    {"label": "Jul", "value": 53600},
    {"label": "Aug", "value": 55200},
    {"label": "Sep", "value": 54100},
    {"label": "Oct", "value": 56800},
    {"label": "Nov", "value": 58120},
    {"label": "Dec", "value": 58120}
  ];

  final List<Map<String, dynamic>> _aiInsights = [
    {
      "type": "recommendation",
      "title": "Diversification Opportunity",
      "description":
          "Consider adding international stocks to your portfolio. Your current allocation is 65% US stocks, which could benefit from geographic diversification.",
      "priority": "medium",
      "action": "Explore International Funds"
    },
    {
      "type": "warning",
      "title": "High Volatility Alert",
      "description":
          "Your cryptocurrency holdings represent 15% of your portfolio. Consider reducing exposure if this exceeds your risk tolerance.",
      "priority": "high",
      "action": "Review Risk Settings"
    },
    {
      "type": "opportunity",
      "title": "Rebalancing Suggestion",
      "description":
          "Your tech stocks have outperformed and now represent 40% of your portfolio. Consider taking some profits and rebalancing.",
      "priority": "medium",
      "action": "Auto-Rebalance Portfolio"
    }
  ];

  final List<String> _filterOptions = [
    'All',
    'Stocks',
    'Crypto',
    'Funds',
    'Commodities'
  ];

  List<Map<String, dynamic>> get _filteredInvestments {
    if (_selectedFilter == 'All') {
      return _investments;
    }
    return (_investments as List)
        .where((investment) {
          return (investment as Map<String, dynamic>)['category'] ==
              _selectedFilter;
        })
        .cast<Map<String, dynamic>>()
        .toList();
  }

  double get _totalPortfolioValue {
    return (_investments as List).fold(0.0, (sum, investment) {
      final valueString =
          (investment as Map<String, dynamic>)['currentValue'] as String;
      final value =
          double.parse(valueString.replaceAll('\$', '').replaceAll(',', ''));
      return sum + value;
    });
  }

  double get _portfolioChange {
    return (_investments as List).fold(0.0, (sum, investment) {
          final roi = (investment as Map<String, dynamic>)['roi'] as double;
          return sum + roi;
        }) /
        _investments.length;
  }

  Future<void> _refreshPortfolio() async {
    setState(() {
      _isLoading = true;
    });

    // Simulate API call
    await Future.delayed(Duration(seconds: 2));

    setState(() {
      _isLoading = false;
    });
  }

  void _navigateToAddInvestment() {
    Navigator.pushNamed(context, '/add-investment-flow-step-1');
  }

  void _navigateToAiDashboard() {
    Navigator.pushNamed(context, '/ai-dashboard');
  }

  void _navigateToAiChat() {
    Navigator.pushNamed(context, '/ai-chat-interface');
  }

  void _navigateToGoals() {
    Navigator.pushNamed(context, '/financial-goals');
  }

  void _navigateToRiskAnalysis() {
    Navigator.pushNamed(context, '/risk-analysis-dashboard');
  }

  void _showInvestmentActions(
      BuildContext context, Map<String, dynamic> investment) {
    showModalBottomSheet(
      context: context,
      backgroundColor: AppTheme.darkTheme.colorScheme.surface,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => Container(
        padding: EdgeInsets.all(6.w),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 12.w,
              height: 0.5.h,
              decoration: BoxDecoration(
                color: AppTheme.dividerSubtle,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            SizedBox(height: 3.h),
            Text(
              investment['name'] as String,
              style: AppTheme.darkTheme.textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(height: 3.h),
            _buildActionTile(
              icon: 'add_shopping_cart',
              title: 'Buy More',
              subtitle: 'Increase your position',
              onTap: () {
                Navigator.pop(context);
                _navigateToAddInvestment();
              },
            ),
            _buildActionTile(
              icon: 'sell',
              title: 'Sell Position',
              subtitle: 'Reduce or close position',
              onTap: () {
                Navigator.pop(context);
                // Handle sell action
              },
            ),
            _buildActionTile(
              icon: 'info',
              title: 'View Details',
              subtitle: 'See complete analysis',
              onTap: () {
                Navigator.pop(context);
                // Handle view details
              },
            ),
            _buildActionTile(
              icon: 'share',
              title: 'Share',
              subtitle: 'Share investment details',
              onTap: () {
                Navigator.pop(context);
                // Handle share action
              },
            ),
            SizedBox(height: 2.h),
          ],
        ),
      ),
    );
  }

  Widget _buildActionTile({
    required String icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return ListTile(
      leading: Container(
        padding: EdgeInsets.all(2.w),
        decoration: BoxDecoration(
          color: AppTheme.chronosGold.withValues(alpha: 0.2),
          borderRadius: BorderRadius.circular(8),
        ),
        child: CustomIconWidget(
          iconName: icon,
          color: AppTheme.chronosGold,
          size: 20,
        ),
      ),
      title: Text(
        title,
        style: AppTheme.darkTheme.textTheme.titleMedium?.copyWith(
          fontWeight: FontWeight.w600,
        ),
      ),
      subtitle: Text(
        subtitle,
        style: AppTheme.darkTheme.textTheme.bodyMedium?.copyWith(
          color: AppTheme.textSecondary,
        ),
      ),
      onTap: onTap,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.darkTheme.scaffoldBackgroundColor,
      appBar: AppBar(
        title: Text('Investment Portfolio'),
        actions: [
          IconButton(
            onPressed: _navigateToAiChat,
            icon: CustomIconWidget(
              iconName: 'psychology',
              color: AppTheme.chronosGold,
              size: 24,
            ),
          ),
          IconButton(
            onPressed: _navigateToRiskAnalysis,
            icon: CustomIconWidget(
              iconName: 'analytics',
              color: AppTheme.textSecondary,
              size: 24,
            ),
          ),
        ],
      ),
      body: _investments.isEmpty
          ? EmptyPortfolioWidget(
              onAddInvestment: _navigateToAddInvestment,
            )
          : RefreshIndicator(
              onRefresh: _refreshPortfolio,
              color: AppTheme.chronosGold,
              backgroundColor: AppTheme.darkTheme.colorScheme.surface,
              child: CustomScrollView(
                slivers: [
                  SliverToBoxAdapter(
                    child: PortfolioHeaderWidget(
                      totalValue:
                          '\$${_totalPortfolioValue.toStringAsFixed(2)}',
                      percentageChange:
                          '${_portfolioChange >= 0 ? '+' : ''}${_portfolioChange.toStringAsFixed(2)}%',
                      isPositive: _portfolioChange >= 0,
                      selectedPeriod: _selectedPeriod,
                      onPeriodChanged: (period) {
                        setState(() {
                          _selectedPeriod = period;
                        });
                      },
                    ),
                  ),
                  SliverToBoxAdapter(
                    child: PortfolioChartWidget(
                      chartData: _chartData,
                      selectedPeriod: _selectedPeriod,
                    ),
                  ),
                  SliverToBoxAdapter(
                    child: FilterChipsWidget(
                      filters: _filterOptions,
                      selectedFilter: _selectedFilter,
                      onFilterChanged: (filter) {
                        setState(() {
                          _selectedFilter = filter;
                        });
                      },
                    ),
                  ),
                  SliverToBoxAdapter(
                    child: Container(
                      margin:
                          EdgeInsets.symmetric(horizontal: 4.w, vertical: 1.h),
                      child: Text(
                        'Your Investments',
                        style:
                            AppTheme.darkTheme.textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                  SliverToBoxAdapter(
                    child: Container(
                      height: 35.h,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        padding: EdgeInsets.symmetric(horizontal: 4.w),
                        itemCount: _filteredInvestments.length,
                        itemBuilder: (context, index) {
                          final investment = _filteredInvestments[index];
                          return InvestmentCardWidget(
                            investment: investment,
                            onTap: () =>
                                _showInvestmentActions(context, investment),
                            onBuyMore: _navigateToAddInvestment,
                            onSell: () {
                              // Handle sell action
                            },
                            onViewDetails: () {
                              // Handle view details
                            },
                          );
                        },
                      ),
                    ),
                  ),
                  SliverToBoxAdapter(
                    child: AiInsightsWidget(
                      insights: _aiInsights,
                    ),
                  ),
                  SliverToBoxAdapter(
                    child: SizedBox(height: 10.h),
                  ),
                ],
              ),
            ),
      floatingActionButton: _investments.isNotEmpty
          ? FloatingActionButton.extended(
              onPressed: _navigateToAddInvestment,
              icon: CustomIconWidget(
                iconName: 'add',
                color: AppTheme.primaryCharcoal,
                size: 20,
              ),
              label: Text(
                'Add Investment',
                style: TextStyle(
                  color: AppTheme.primaryCharcoal,
                  fontWeight: FontWeight.w600,
                ),
              ),
            )
          : null,
    );
  }
}
