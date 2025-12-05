import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';

class WealthPieChartWidget extends StatefulWidget {
  const WealthPieChartWidget({super.key});

  @override
  State<WealthPieChartWidget> createState() => _WealthPieChartWidgetState();
}

class _WealthPieChartWidgetState extends State<WealthPieChartWidget>
    with TickerProviderStateMixin {
  late TabController _tabController;
  int _touchedIndex = -1;

  final List<Map<String, dynamic>> _wealthData = [
    {
      "category": "Stocks",
      "amount": 65000.0,
      "percentage": 51.0,
      "color": AppTheme.chronosGold,
      "icon": "trending_up"
    },
    {
      "category": "Real Estate",
      "amount": 35000.0,
      "percentage": 27.5,
      "color": AppTheme.successGreen,
      "icon": "home"
    },
    {
      "category": "Cash",
      "amount": 20000.0,
      "percentage": 15.7,
      "color": AppTheme.warningAmber,
      "icon": "account_balance_wallet"
    },
    {
      "category": "Crypto",
      "amount": 7500.0,
      "percentage": 5.8,
      "color": Color(0xFF6C5CE7),
      "icon": "currency_bitcoin"
    },
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  String _formatCurrency(double amount) {
    if (amount >= 1000000) {
      return '\$${(amount / 1000000).toStringAsFixed(1)}M';
    } else if (amount >= 1000) {
      return '\$${(amount / 1000).toStringAsFixed(1)}K';
    } else {
      return '\$${amount.toStringAsFixed(0)}';
    }
  }

  List<PieChartSectionData> _getSections() {
    return _wealthData.asMap().entries.map((entry) {
      final index = entry.key;
      final data = entry.value;
      final isTouched = index == _touchedIndex;
      final double radius = isTouched ? 25.w : 20.w;

      return PieChartSectionData(
        color: data["color"] as Color,
        value: data["percentage"] as double,
        title: isTouched ? '${data["percentage"].toStringAsFixed(1)}%' : '',
        radius: radius,
        titleStyle: AppTheme.darkTheme.textTheme.labelMedium?.copyWith(
          color: AppTheme.textPrimary,
          fontWeight: FontWeight.w600,
        ),
        titlePositionPercentageOffset: 0.6,
      );
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.symmetric(horizontal: 4.w, vertical: 1.h),
      padding: EdgeInsets.all(5.w),
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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Wealth Snapshot',
                style: AppTheme.darkTheme.textTheme.titleLarge?.copyWith(
                  color: AppTheme.textPrimary,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  color: AppTheme.primaryCharcoal,
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: TabBar(
                  controller: _tabController,
                  tabs: const [
                    Tab(text: 'W'),
                    Tab(text: 'M'),
                    Tab(text: 'Y'),
                  ],
                  labelColor: AppTheme.chronosGold,
                  unselectedLabelColor: AppTheme.textSecondary,
                  indicatorSize: TabBarIndicatorSize.tab,
                  indicator: BoxDecoration(
                    color: AppTheme.chronosGold.withValues(alpha: 0.2),
                    borderRadius: BorderRadius.circular(6.0),
                  ),
                  dividerColor: Colors.transparent,
                  labelStyle: AppTheme.darkTheme.textTheme.labelSmall?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 3.h),
          SizedBox(
            height: 50.w,
            child: PieChart(
              PieChartData(
                sections: _getSections(),
                pieTouchData: PieTouchData(
                  touchCallback: (FlTouchEvent event, pieTouchResponse) {
                    setState(() {
                      if (!event.isInterestedForInteractions ||
                          pieTouchResponse == null ||
                          pieTouchResponse.touchedSection == null) {
                        _touchedIndex = -1;
                        return;
                      }
                      _touchedIndex =
                          pieTouchResponse.touchedSection!.touchedSectionIndex;
                    });
                  },
                ),
                sectionsSpace: 2,
                centerSpaceRadius: 8.w,
                startDegreeOffset: -90,
              ),
            ),
          ),
          SizedBox(height: 3.h),
          ...(_wealthData.asMap().entries.map((entry) {
            final index = entry.key;
            final data = entry.value;
            final isHighlighted = index == _touchedIndex;

            return Container(
              margin: EdgeInsets.only(bottom: 1.h),
              padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 1.5.h),
              decoration: BoxDecoration(
                color: isHighlighted
                    ? (data["color"] as Color).withValues(alpha: 0.1)
                    : Colors.transparent,
                borderRadius: BorderRadius.circular(8.0),
                border: isHighlighted
                    ? Border.all(color: data["color"] as Color, width: 1.0)
                    : null,
              ),
              child: Row(
                children: [
                  Container(
                    width: 4.w,
                    height: 4.w,
                    decoration: BoxDecoration(
                      color: data["color"] as Color,
                      shape: BoxShape.circle,
                    ),
                  ),
                  SizedBox(width: 3.w),
                  CustomIconWidget(
                    iconName: data["icon"] as String,
                    color: AppTheme.textSecondary,
                    size: 5.w,
                  ),
                  SizedBox(width: 3.w),
                  Expanded(
                    child: Text(
                      data["category"] as String,
                      style: AppTheme.darkTheme.textTheme.bodyMedium?.copyWith(
                        color: AppTheme.textPrimary,
                        fontWeight:
                            isHighlighted ? FontWeight.w600 : FontWeight.w400,
                      ),
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        _formatCurrency(data["amount"] as double),
                        style: AppTheme.financialDataMedium.copyWith(
                          color: AppTheme.textPrimary,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Text(
                        '${(data["percentage"] as double).toStringAsFixed(1)}%',
                        style: AppTheme.darkTheme.textTheme.bodySmall?.copyWith(
                          color: AppTheme.textSecondary,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            );
          }).toList()),
        ],
      ),
    );
  }
}
