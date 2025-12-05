import 'dart:io' if (dart.library.io) 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:sizer/sizer.dart';

import '../../core/app_export.dart';
import '../../theme/app_theme.dart';
import '../../widgets/custom_icon_widget.dart';
import './widgets/achievements_section_widget.dart';
import './widgets/ai_insights_panel_widget.dart';
import './widgets/asset_allocation_card_widget.dart';
import './widgets/pdf_export_card_widget.dart';
import './widgets/performance_metrics_widget.dart';
import './widgets/report_header_widget.dart';
import './widgets/wealth_timeline_chart_widget.dart';

class WealthSummaryReport extends StatefulWidget {
  const WealthSummaryReport({super.key});

  @override
  State<WealthSummaryReport> createState() => _WealthSummaryReportState();
}

class _WealthSummaryReportState extends State<WealthSummaryReport>
    with TickerProviderStateMixin {
  late AnimationController _fadeController;
  late Animation<double> _fadeAnimation;
  bool _isRefreshing = false;
  bool _isExportingPdf = false;

  // Mock data for wealth summary
  final Map<String, dynamic> wealthData = {
    'totalWealth': 245750.00,
    'yearOverYearChange': 23.5,
    'reportDate': '2025-01-19',
    'diversificationScore': 8.5,
    'riskScore': 6.2,
    'portfolioReturn': 15.8,
    'volatility': 12.3,
    'sharpeRatio': 1.28,
  };

  final List<Map<String, dynamic>> timelineData = [
    {'date': '2024-01', 'value': 180000},
    {'date': '2024-03', 'value': 195000},
    {'date': '2024-06', 'value': 210000},
    {'date': '2024-09', 'value': 230000},
    {'date': '2024-12', 'value': 245750},
  ];

  final List<Map<String, dynamic>> assetAllocation = [
    {'category': 'Stocks', 'percentage': 45.0, 'value': 110587.50},
    {'category': 'Bonds', 'percentage': 25.0, 'value': 61437.50},
    {'category': 'Real Estate', 'percentage': 15.0, 'value': 36862.50},
    {'category': 'Crypto', 'percentage': 10.0, 'value': 24575.00},
    {'category': 'Cash', 'percentage': 5.0, 'value': 12287.50},
  ];

  final List<String> aiInsights = [
    "Your diversification improved 23% this quarter through strategic asset rebalancing.",
    "Consider increasing bond allocation by 5% to reduce portfolio volatility.",
    "Your technology stock holdings are outperforming market by 8.2%.",
    "Recommended: Set up automatic rebalancing for Q2 2025.",
  ];

  final List<Map<String, dynamic>> achievements = [
    {
      'title': 'Portfolio Milestone',
      'description': 'Reached \$250K portfolio value',
      'date': '2024-12-15',
      'badge': 'milestone'
    },
    {
      'title': 'Diversification Master',
      'description': 'Achieved optimal risk distribution',
      'date': '2024-11-28',
      'badge': 'achievement'
    },
    {
      'title': 'Consistent Investor',
      'description': '12 months of regular contributions',
      'date': '2024-10-01',
      'badge': 'streak'
    },
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
        msg: "Report data refreshed",
        backgroundColor: AppTheme.successGreen,
        textColor: AppTheme.textPrimary,
      );
    }
  }

  Future<void> _exportPdf() async {
    setState(() {
      _isExportingPdf = true;
    });

    try {
      // Generate PDF content
      final pdfContent = _generatePdfContent();

      // Handle platform-specific PDF export
      if (kIsWeb) {
        // final bytes = utf8.encode(pdfContent);
        // final blob = html.Blob([bytes]);
        // final url = html.Url.createObjectUrlFromBlob(blob);
        // final anchor = html.AnchorElement(href: url)
        //   ..setAttribute("download",
        //       "wealth_summary_report_${DateTime.now().millisecondsSinceEpoch}.txt")
        //   ..click();
        // html.Url.revokeObjectUrl(url);
      } else {
        // For mobile platforms, you would use a proper PDF generation library
        // For now, we'll show a success message
        Fluttertoast.showToast(
          msg: "PDF export feature coming soon",
          backgroundColor: AppTheme.warningAmber,
          textColor: AppTheme.textPrimary,
        );
      }
    } catch (e) {
      Fluttertoast.showToast(
        msg: "Export failed. Please try again.",
        backgroundColor: AppTheme.errorRed,
        textColor: AppTheme.textPrimary,
      );
    } finally {
      setState(() {
        _isExportingPdf = false;
      });
    }
  }

  String _generatePdfContent() {
    return '''
    WEALTH SUMMARY REPORT
    Generated: ${wealthData['reportDate']}
    
    PORTFOLIO OVERVIEW
    Total Wealth: \$${wealthData['totalWealth'].toStringAsFixed(2)}
    Year-over-Year Change: ${wealthData['yearOverYearChange']}%
    
    PERFORMANCE METRICS
    Portfolio Return: ${wealthData['portfolioReturn']}%
    Volatility: ${wealthData['volatility']}%
    Sharpe Ratio: ${wealthData['sharpeRatio']}
    
    ASSET ALLOCATION
    ${assetAllocation.map((asset) => '${asset['category']}: ${asset['percentage']}% (\$${asset['value'].toStringAsFixed(2)})').join('\n')}
    
    AI INSIGHTS
    ${aiInsights.map((insight) => '• $insight').join('\n')}
    ''';
  }

  void _shareReport() {
    Fluttertoast.showToast(
      msg: "Share functionality coming soon",
      backgroundColor: AppTheme.chronosGold,
      textColor: AppTheme.textPrimary,
    );
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
          'Wealth Summary Report',
          style: AppTheme.darkTheme.textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: _shareReport,
            icon: CustomIconWidget(
              iconName: 'share',
              color: AppTheme.chronosGold,
              size: 5.5.w,
            ),
          ),
        ],
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
                ReportHeaderWidget(
                  totalWealth: wealthData['totalWealth'],
                  yearOverYearChange: wealthData['yearOverYearChange'],
                  reportDate: wealthData['reportDate'],
                ),
                SizedBox(height: 2.h),
                WealthTimelineChartWidget(
                  timelineData: timelineData,
                ),
                SizedBox(height: 2.h),
                AssetAllocationCardWidget(
                  allocationData: assetAllocation,
                ),
                SizedBox(height: 2.h),
                PerformanceMetricsWidget(
                  portfolioReturn: wealthData['portfolioReturn'],
                  volatility: wealthData['volatility'],
                  sharpeRatio: wealthData['sharpeRatio'],
                ),
                SizedBox(height: 2.h),
                AiInsightsPanelWidget(
                  insights: aiInsights,
                  diversificationScore: wealthData['diversificationScore'],
                ),
                SizedBox(height: 2.h),
                AchievementsSectionWidget(
                  achievements: achievements,
                ),
                SizedBox(height: 2.h),
                PdfExportCardWidget(
                  onExportPressed: _exportPdf,
                  isExporting: _isExportingPdf,
                ),
                SizedBox(height: 4.h),
              ],
            ),
          ),
        ),
      ),
    );
  }
}