import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../core/app_export.dart';
import '../add_investment_flow_step_1/widgets/progress_indicator_widget.dart';
import './widgets/ai_recommendations_widget.dart';
import './widgets/confirmation_button_widget.dart';
import './widgets/investment_summary_widget.dart';
import './widgets/portfolio_allocation_widget.dart';

class AddInvestmentFlowStep3 extends StatefulWidget {
  const AddInvestmentFlowStep3({super.key});

  @override
  State<AddInvestmentFlowStep3> createState() => _AddInvestmentFlowStep3State();
}

class _AddInvestmentFlowStep3State extends State<AddInvestmentFlowStep3>
    with TickerProviderStateMixin {
  late AnimationController _fadeController;
  late Animation<double> _fadeAnimation;

  String? selectedInvestmentType;
  Map<String, dynamic>? investmentData;
  double amount = 0;
  double duration = 0;
  String? riskLevel;

  List<Map<String, dynamic>> aiRecommendations = [];
  Map<String, double> portfolioAllocation = {};
  bool _isLoading = true;
  bool _isConfirming = false;

  @override
  void initState() {
    super.initState();
    _fadeController =
        AnimationController(duration: AppTheme.standardAnimation, vsync: this);
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
        CurvedAnimation(parent: _fadeController, curve: Curves.easeInOut));

    // Get arguments from previous screen
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final args =
          ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;
      if (args != null) {
        setState(() {
          selectedInvestmentType = args['selectedType'];
          investmentData = args['typeData'];
          amount = args['amount'];
          duration = args['duration'];
          riskLevel = args['riskLevel'];
        });

        _generateAIRecommendations();
      }
    });

    _fadeController.forward();
  }

  @override
  void dispose() {
    _fadeController.dispose();
    super.dispose();
  }

  void _generateAIRecommendations() {
    // Simulate AI processing
    Future.delayed(const Duration(seconds: 2), () {
      if (mounted) {
        final recommendations = _getRecommendationsBasedOnProfile();
        final allocation = _generatePortfolioAllocation(recommendations);

        setState(() {
          aiRecommendations = recommendations;
          portfolioAllocation = allocation;
          _isLoading = false;
        });
      }
    });
  }

  List<Map<String, dynamic>> _getRecommendationsBasedOnProfile() {
    final baseType = selectedInvestmentType ?? 'stocks';
    final risk = riskLevel ?? 'Moderate';

    // Generate AI recommendations based on user profile
    final recommendations = <Map<String, dynamic>>[];

    switch (baseType) {
      case 'stocks':
        recommendations.addAll([
          {
            'name': 'S&P 500 ETF (SPY)',
            'type': 'ETF',
            'price': 428.50,
            'confidence': 4.8,
            'expectedReturn': risk == 'Conservative'
                ? 8.2
                : (risk == 'Moderate' ? 10.5 : 12.8),
            'description': 'Broad market exposure to US large-cap stocks',
            'aiReasoning':
                'Strong historical performance with diversified exposure. Low expense ratio of 0.09%. Perfect for ${risk.toLowerCase()} investors.',
            'allocation': risk == 'Conservative'
                ? 40.0
                : (risk == 'Moderate' ? 50.0 : 45.0),
          },
          {
            'name': 'Technology Select SPDR (XLK)',
            'type': 'ETF',
            'price': 186.25,
            'confidence': 4.5,
            'expectedReturn': risk == 'Conservative'
                ? 6.8
                : (risk == 'Moderate' ? 9.2 : 14.5),
            'description': 'Technology sector focused investment',
            'aiReasoning':
                'AI and cloud computing trends driving growth. Higher volatility but strong long-term potential.',
            'allocation': risk == 'Conservative'
                ? 15.0
                : (risk == 'Moderate' ? 25.0 : 35.0),
          },
        ]);
        break;
      case 'bonds':
        recommendations.addAll([
          {
            'name': 'iShares Core US Aggregate Bond ETF (AGG)',
            'type': 'Bond ETF',
            'price': 104.75,
            'confidence': 4.9,
            'expectedReturn': 4.2,
            'description': 'Comprehensive US bond market exposure',
            'aiReasoning':
                'High-quality bonds with steady income. Perfect for capital preservation strategy.',
            'allocation': 60.0,
          },
          {
            'name': 'Vanguard Short-Term Treasury ETF (VGSH)',
            'type': 'Treasury ETF',
            'price': 60.18,
            'confidence': 4.7,
            'expectedReturn': 3.5,
            'description': 'Short-term government bonds',
            'aiReasoning':
                'Low duration risk with government backing. Ideal for conservative portfolios.',
            'allocation': 40.0,
          },
        ]);
        break;
      default:
        // Add default recommendations based on risk level
        recommendations.addAll([
          {
            'name': 'Vanguard Total World Stock ETF (VT)',
            'type': 'Global ETF',
            'price': 108.90,
            'confidence': 4.6,
            'expectedReturn': risk == 'Conservative'
                ? 7.8
                : (risk == 'Moderate' ? 9.5 : 11.2),
            'description': 'Global equity market diversification',
            'aiReasoning':
                'Maximum diversification across global markets. Reduces single-country risk exposure.',
            'allocation': risk == 'Conservative'
                ? 50.0
                : (risk == 'Moderate' ? 60.0 : 55.0),
          },
        ]);
    }

    return recommendations;
  }

  Map<String, double> _generatePortfolioAllocation(
      List<Map<String, dynamic>> recommendations) {
    final allocation = <String, double>{};
    for (var recommendation in recommendations) {
      allocation[recommendation['name']] = recommendation['allocation'];
    }
    return allocation;
  }

  void _updateAllocation(String name, double newAllocation) {
    setState(() {
      portfolioAllocation[name] = newAllocation;

      // Rebalance other allocations
      final total =
          portfolioAllocation.values.fold(0.0, (sum, value) => sum + value);
      if (total > 100) {
        final excess = total - 100;
        final othersTotal = portfolioAllocation.length - 1;
        if (othersTotal > 0) {
          final reduction = excess / othersTotal;
          portfolioAllocation.forEach((key, value) {
            if (key != name) {
              portfolioAllocation[key] = (value - reduction).clamp(0.0, 100.0);
            }
          });
        }
      }
    });
  }

  void _confirmInvestment() async {
    setState(() {
      _isConfirming = true;
    });

    // Simulate investment processing
    await Future.delayed(const Duration(seconds: 2));

    if (mounted) {
      // Show success dialog
      showDialog(
          context: context,
          barrierDismissible: false,
          builder: (context) => Dialog(
              backgroundColor: AppTheme.surfaceDark,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0)),
              child: Padding(
                  padding: EdgeInsets.all(6.w),
                  child: Column(mainAxisSize: MainAxisSize.min, children: [
                    Container(
                        width: 20.w,
                        height: 20.w,
                        decoration: BoxDecoration(
                            color: AppTheme.successGreen.withValues(alpha: 0.2),
                            shape: BoxShape.circle),
                        child: CustomIconWidget(
                            iconName: 'check_circle',
                            color: AppTheme.successGreen,
                            size: 10.w)),
                    SizedBox(height: 3.h),
                    Text('Investment Confirmed!',
                        style: AppTheme.darkTheme.textTheme.titleLarge
                            ?.copyWith(
                                fontWeight: FontWeight.w600,
                                color: AppTheme.successGreen)),
                    SizedBox(height: 2.h),
                    Text(
                        'Your investment of \$${amount.toStringAsFixed(0)} has been successfully added to your portfolio.',
                        style: AppTheme.darkTheme.textTheme.bodyMedium
                            ?.copyWith(color: AppTheme.textSecondary)),
                    SizedBox(height: 3.h),
                    SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                            onPressed: () {
                              Navigator.of(context).popUntil((route) =>
                                  route.settings.name ==
                                      '/investment-portfolio' ||
                                  route.settings.name == '/ai-dashboard' ||
                                  route.isFirst);
                            },
                            child: const Text('View Portfolio'))),
                  ]))));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppTheme.darkTheme.scaffoldBackgroundColor,
        appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            leading: IconButton(
                onPressed: () => Navigator.pop(context),
                icon: CustomIconWidget(
                    iconName: 'arrow_back',
                    color: AppTheme.textPrimary,
                    size: 6.w)),
            title: Text('AI Recommendations',
                style: AppTheme.darkTheme.textTheme.titleLarge
                    ?.copyWith(fontWeight: FontWeight.w600)),
            centerTitle: true,
            actions: [
              TextButton(
                  onPressed: _generateAIRecommendations,
                  child: Text('Refresh',
                      style: AppTheme.darkTheme.textTheme.bodyMedium?.copyWith(
                          color: AppTheme.chronosGold,
                          fontWeight: FontWeight.w500))),
            ]),
        body: SafeArea(
            child: FadeTransition(
                opacity: _fadeAnimation,
                child: Column(children: [
                  const ProgressIndicatorWidget(currentStep: 3, totalSteps: 3),
                  SizedBox(height: 2.h),

                  Expanded(
                      child: SingleChildScrollView(
                          padding: EdgeInsets.symmetric(horizontal: 4.w),
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // Investment Summary
                                InvestmentSummaryWidget(
                                    investmentData: investmentData,
                                    amount: amount,
                                    duration: duration,
                                    riskLevel: riskLevel),
                                SizedBox(height: 3.h),

                                // AI Recommendations Section
                                AiRecommendationsWidget(
                                    isLoading: _isLoading,
                                    recommendations: aiRecommendations,
                                    onGetMoreOptions:
                                        _generateAIRecommendations),
                                SizedBox(height: 3.h),

                                // Portfolio Allocation Section
                                if (!_isLoading &&
                                    aiRecommendations.isNotEmpty) ...[
                                  PortfolioAllocationWidget(
                                      allocations: portfolioAllocation,
                                      recommendations: aiRecommendations,
                                      onAllocationChanged: _updateAllocation),
                                  SizedBox(height: 3.h),
                                ],
                              ]))),

                  // Confirmation Button
                  if (!_isLoading)
                    ConfirmationButtonWidget(
                        isEnabled:
                            aiRecommendations.isNotEmpty && !_isConfirming,
                        isLoading: _isConfirming,
                        amount: amount,
                        onPressed: _confirmInvestment),
                ]))));
  }
}
