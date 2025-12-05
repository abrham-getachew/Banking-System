import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sizer/sizer.dart';

import '../../core/app_export.dart';
import '../add_investment_flow_step_1/widgets/continue_button_widget.dart';
import '../add_investment_flow_step_1/widgets/progress_indicator_widget.dart';
import './widgets/amount_input_widget.dart';
import './widgets/duration_slider_widget.dart';
import './widgets/investment_preview_widget.dart';
import './widgets/risk_selection_widget.dart';

class AddInvestmentFlowStep2 extends StatefulWidget {
  const AddInvestmentFlowStep2({super.key});

  @override
  State<AddInvestmentFlowStep2> createState() => _AddInvestmentFlowStep2State();
}

class _AddInvestmentFlowStep2State extends State<AddInvestmentFlowStep2>
    with TickerProviderStateMixin {
  late AnimationController _fadeController;
  late Animation<double> _fadeAnimation;

  final TextEditingController _amountController = TextEditingController();
  double _selectedDuration = 12.0; // months
  String? _selectedRiskLevel;

  String? selectedInvestmentType;
  Map<String, dynamic>? investmentData;

  final double _minAmount = 100.0;
  final double _maxAmount = 1000000.0;

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

    // Get arguments from previous screen
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final args =
          ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;
      if (args != null) {
        setState(() {
          selectedInvestmentType = args['selectedType'];
          investmentData = args['typeData'];
        });
      }
    });
  }

  @override
  void dispose() {
    _fadeController.dispose();
    _amountController.dispose();
    super.dispose();
  }

  bool get _isFormValid {
    final amount = double.tryParse(_amountController.text.replaceAll(',', ''));
    return amount != null &&
        amount >= _minAmount &&
        amount <= _maxAmount &&
        _selectedRiskLevel != null;
  }

  void _onAmountChanged(String value) {
    setState(() {});
  }

  void _onDurationChanged(double value) {
    setState(() {
      _selectedDuration = value;
    });
    HapticFeedback.lightImpact();
  }

  void _onRiskLevelSelected(String riskLevel) {
    setState(() {
      _selectedRiskLevel = riskLevel;
    });
    HapticFeedback.selectionClick();
  }

  void _onContinuePressed() {
    if (_isFormValid) {
      final amount = double.parse(_amountController.text.replaceAll(',', ''));

      Navigator.pushNamed(
        context,
        '/add-investment-flow-step-3',
        arguments: {
          'selectedType': selectedInvestmentType,
          'typeData': investmentData,
          'amount': amount,
          'duration': _selectedDuration,
          'riskLevel': _selectedRiskLevel,
        },
      );
    }
  }

  double _calculateProjectedReturns() {
    final amount =
        double.tryParse(_amountController.text.replaceAll(',', '')) ?? 0;
    if (amount == 0 || _selectedRiskLevel == null) return 0;

    double annualRate = 0.08; // Default 8%
    switch (_selectedRiskLevel) {
      case 'Conservative':
        annualRate = 0.03; // 3%
        break;
      case 'Moderate':
        annualRate = 0.065; // 6.5%
        break;
      case 'Aggressive':
        annualRate = 0.12; // 12%
        break;
    }

    final years = _selectedDuration / 12;
    return amount * (1 + annualRate) * years - amount;
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
            size: 6.w,
          ),
        ),
        title: Text(
          'Investment Details',
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
                currentStep: 2,
                totalSteps: 3,
              ),
              SizedBox(height: 2.h),

              // Investment type reminder
              if (investmentData != null) ...[
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 4.w),
                  padding: EdgeInsets.all(3.w),
                  decoration: BoxDecoration(
                    color: AppTheme.surfaceDark,
                    borderRadius: BorderRadius.circular(12.0),
                    border: Border.all(
                      color: AppTheme.chronosGold.withValues(alpha: 0.3),
                      width: 1.0,
                    ),
                  ),
                  child: Row(
                    children: [
                      Container(
                        width: 10.w,
                        height: 10.w,
                        decoration: BoxDecoration(
                          color: AppTheme.chronosGold.withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        child: CustomIconWidget(
                          iconName: investmentData!['icon'] as String,
                          color: AppTheme.chronosGold,
                          size: 5.w,
                        ),
                      ),
                      SizedBox(width: 3.w),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              investmentData!['title'] as String,
                              style: AppTheme.darkTheme.textTheme.titleMedium
                                  ?.copyWith(
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Text(
                              investmentData!['description'] as String,
                              style: AppTheme.darkTheme.textTheme.bodySmall
                                  ?.copyWith(
                                color: AppTheme.textSecondary,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 3.h),
              ],

              Expanded(
                child: SingleChildScrollView(
                  padding: EdgeInsets.symmetric(horizontal: 4.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Amount Input Section
                      AmountInputWidget(
                        controller: _amountController,
                        onChanged: _onAmountChanged,
                        minAmount: _minAmount,
                        maxAmount: _maxAmount,
                      ),
                      SizedBox(height: 4.h),

                      // Duration Slider Section
                      DurationSliderWidget(
                        value: _selectedDuration,
                        onChanged: _onDurationChanged,
                      ),
                      SizedBox(height: 4.h),

                      // Risk Selection Section
                      RiskSelectionWidget(
                        selectedRisk: _selectedRiskLevel,
                        onRiskSelected: _onRiskLevelSelected,
                      ),
                      SizedBox(height: 4.h),

                      // Investment Preview Section
                      InvestmentPreviewWidget(
                        amount: double.tryParse(
                                _amountController.text.replaceAll(',', '')) ??
                            0,
                        duration: _selectedDuration,
                        riskLevel: _selectedRiskLevel,
                        projectedReturns: _calculateProjectedReturns(),
                      ),
                      SizedBox(height: 2.h),
                    ],
                  ),
                ),
              ),

              ContinueButtonWidget(
                isEnabled: _isFormValid,
                onPressed: _onContinuePressed,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
