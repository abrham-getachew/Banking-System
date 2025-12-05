import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../core/app_export.dart';
import './widgets/continue_button_widget.dart';
import './widgets/investment_grid_widget.dart';
import './widgets/progress_indicator_widget.dart';

class AddInvestmentFlowStep1 extends StatefulWidget {
  const AddInvestmentFlowStep1({super.key});

  @override
  State<AddInvestmentFlowStep1> createState() => _AddInvestmentFlowStep1State();
}

class _AddInvestmentFlowStep1State extends State<AddInvestmentFlowStep1>
    with TickerProviderStateMixin {
  String? selectedInvestmentType;
  late AnimationController _fadeController;
  late Animation<double> _fadeAnimation;

  final List<Map<String, dynamic>> investmentTypes = [
    {
      "type": "stocks",
      "title": "Stocks",
      "description": "Individual company shares with growth potential",
      "icon": "trending_up",
      "riskLevel": "Medium Risk",
      "details":
          "Invest in individual companies and benefit from their growth. Historical average return: 8-12% annually.",
    },
    {
      "type": "crypto",
      "title": "Cryptocurrency",
      "description": "Digital assets with high volatility",
      "icon": "currency_bitcoin",
      "riskLevel": "High Risk",
      "details":
          "Digital currencies like Bitcoin and Ethereum. Highly volatile with potential for significant gains or losses.",
    },
    {
      "type": "bonds",
      "title": "Bonds",
      "description": "Fixed-income securities for stable returns",
      "icon": "security",
      "riskLevel": "Low Risk",
      "details":
          "Government and corporate bonds offering steady income. Historical average return: 3-6% annually.",
    },
    {
      "type": "real_estate",
      "title": "Real Estate",
      "description": "Property investments and REITs",
      "icon": "home",
      "riskLevel": "Medium Risk",
      "details":
          "Real Estate Investment Trusts and property funds. Provides diversification and potential rental income.",
    },
    {
      "type": "etfs",
      "title": "ETFs",
      "description": "Diversified exchange-traded funds",
      "icon": "account_balance_wallet",
      "riskLevel": "Low Risk",
      "details":
          "Exchange-traded funds offering instant diversification across multiple assets and markets.",
    },
    {
      "type": "commodities",
      "title": "Commodities",
      "description": "Gold, oil, and other raw materials",
      "icon": "local_atm",
      "riskLevel": "Medium Risk",
      "details":
          "Physical commodities and commodity funds. Good hedge against inflation and market volatility.",
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

  void _onInvestmentTypeSelected(String type) {
    setState(() {
      selectedInvestmentType = type;
    });
  }

  void _onContinuePressed() {
    if (selectedInvestmentType != null) {
      Navigator.pushNamed(
        context,
        '/add-investment-flow-step-2',
        arguments: {
          'selectedType': selectedInvestmentType,
          'typeData': investmentTypes.firstWhere(
            (element) => element['type'] == selectedInvestmentType,
          ),
        },
      );
    }
  }

  void _showInvestmentDetails(Map<String, dynamic> investment) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (context) => Container(
        height: 50.h,
        decoration: BoxDecoration(
          color: AppTheme.darkTheme.colorScheme.surface,
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
            Padding(
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
                          color: AppTheme.chronosGold.withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                        child: CustomIconWidget(
                          iconName: investment['icon'] as String,
                          color: AppTheme.chronosGold,
                          size: 6.w,
                        ),
                      ),
                      SizedBox(width: 4.w),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              investment['title'] as String,
                              style: AppTheme.darkTheme.textTheme.titleLarge
                                  ?.copyWith(
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            SizedBox(height: 0.5.h),
                            Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 2.w, vertical: 0.5.h),
                              decoration: BoxDecoration(
                                color: _getRiskColor(
                                        investment['riskLevel'] as String)
                                    .withValues(alpha: 0.2),
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                              child: Text(
                                investment['riskLevel'] as String,
                                style: AppTheme.darkTheme.textTheme.labelSmall
                                    ?.copyWith(
                                  color: _getRiskColor(
                                      investment['riskLevel'] as String),
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 3.h),
                  Text(
                    'About ${investment['title']}',
                    style: AppTheme.darkTheme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: 1.h),
                  Text(
                    investment['details'] as String,
                    style: AppTheme.darkTheme.textTheme.bodyMedium?.copyWith(
                      color: AppTheme.textSecondary,
                      height: 1.5,
                    ),
                  ),
                  SizedBox(height: 3.h),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                        _onInvestmentTypeSelected(investment['type'] as String);
                      },
                      child: Text('Select ${investment['title']}'),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Color _getRiskColor(String riskLevel) {
    switch (riskLevel.toLowerCase()) {
      case 'low risk':
        return AppTheme.successGreen;
      case 'medium risk':
        return AppTheme.warningAmber;
      case 'high risk':
        return AppTheme.errorRed;
      default:
        return AppTheme.textSecondary;
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
          onPressed: () {
            if (selectedInvestmentType != null) {
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  backgroundColor: AppTheme.darkTheme.colorScheme.surface,
                  title: Text(
                    'Discard Changes?',
                    style: AppTheme.darkTheme.textTheme.titleLarge,
                  ),
                  content: Text(
                    'You have selected an investment type. Are you sure you want to go back?',
                    style: AppTheme.darkTheme.textTheme.bodyMedium?.copyWith(
                      color: AppTheme.textSecondary,
                    ),
                  ),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: const Text('Cancel'),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                        Navigator.pop(context);
                      },
                      child: Text(
                        'Discard',
                        style: TextStyle(color: AppTheme.errorRed),
                      ),
                    ),
                  ],
                ),
              );
            } else {
              Navigator.pop(context);
            }
          },
          icon: CustomIconWidget(
            iconName: 'close',
            color: AppTheme.textPrimary,
            size: 6.w,
          ),
        ),
        title: Text(
          'Choose Investment Type',
          style: AppTheme.darkTheme.textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: FadeTransition(
          opacity: _fadeAnimation,
          child: Column(
            children: [
              const ProgressIndicatorWidget(
                currentStep: 1,
                totalSteps: 3,
              ),
              SizedBox(height: 2.h),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 4.w),
                child: Text(
                  'Select the type of investment you\'d like to add to your portfolio. Long press on any card for detailed information.',
                  style: AppTheme.darkTheme.textTheme.bodyMedium?.copyWith(
                    color: AppTheme.textSecondary,
                    height: 1.4,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(height: 2.h),
              InvestmentGridWidget(
                investmentTypes: investmentTypes,
                selectedType: selectedInvestmentType,
                onTypeSelected: _onInvestmentTypeSelected,
              ),
              ContinueButtonWidget(
                isEnabled: selectedInvestmentType != null,
                onPressed: _onContinuePressed,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
