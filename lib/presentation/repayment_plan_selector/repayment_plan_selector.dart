import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sizer/sizer.dart';

import '../../core/app_export.dart';
import './widgets/interest_calculator_widget.dart';
import './widgets/lifex_integration_widget.dart';
import './widgets/payment_slider_widget.dart';
import './widgets/payment_timeline_widget.dart';
import './widgets/plan_card_widget.dart';

class RepaymentPlanSelector extends StatefulWidget {
  const RepaymentPlanSelector({super.key});

  @override
  State<RepaymentPlanSelector> createState() => _RepaymentPlanSelectorState();
}

class _RepaymentPlanSelectorState extends State<RepaymentPlanSelector>
    with TickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  int _selectedPlanIndex = 1; // Default to 6-month plan (AI recommended)
  double _creditAmount = 1500.0; // Mock approved credit amount
  bool _showComparison = false;

  // Mock repayment plans data
  final List<Map<String, dynamic>> _repaymentPlans = [
    {
      "id": 1,
      "title": "3-Month Plan",
      "description": "Minimal interest, higher monthly payments",
      "months": 3,
      "monthlyPayment": 520.75,
      "totalInterest": 62.25,
      "totalAmount": 1562.25,
      "apr": 8.9,
      "affordability": "moderate",
      "isRecommended": false,
    },
    {
      "id": 2,
      "title": "6-Month Plan",
      "description": "Balanced payments and interest",
      "months": 6,
      "monthlyPayment": 268.50,
      "totalInterest": 111.00,
      "totalAmount": 1611.00,
      "apr": 12.5,
      "affordability": "good",
      "isRecommended": true,
    },
    {
      "id": 3,
      "title": "12-Month Plan",
      "description": "Maximum flexibility, lower monthly payments",
      "months": 12,
      "monthlyPayment": 145.25,
      "totalInterest": 243.00,
      "totalAmount": 1743.00,
      "apr": 18.9,
      "affordability": "excellent",
      "isRecommended": false,
    },
  ];

  @override
  void initState() {
    super.initState();
    _initializeAnimations();
  }

  void _initializeAnimations() {
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 1200),
      vsync: this,
    );

    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: const Interval(0.0, 0.6, curve: Curves.easeOut),
    ));

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.3),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: const Interval(0.2, 0.8, curve: Curves.easeOut),
    ));

    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _selectPlan(int index) {
    HapticFeedback.selectionClick();
    setState(() {
      _selectedPlanIndex = index;
    });
  }

  void _adjustPaymentAmount(double newAmount) {
    setState(() {
      // Recalculate plan based on new payment amount
      final selectedPlan = _repaymentPlans[_selectedPlanIndex];
      final months = selectedPlan['months'] as int;
      final totalWithInterest = newAmount * months;
      final interest = totalWithInterest - _creditAmount;

      _repaymentPlans[_selectedPlanIndex]['monthlyPayment'] = newAmount;
      _repaymentPlans[_selectedPlanIndex]['totalAmount'] = totalWithInterest;
      _repaymentPlans[_selectedPlanIndex]['totalInterest'] = interest;
    });
  }

  void _confirmPlan() {
    HapticFeedback.lightImpact();
    // Navigate to virtual card generator
    Navigator.pushNamed(context, '/virtual-card-generator');
  }

  void _showDetailedComparison() {
    setState(() {
      _showComparison = !_showComparison;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.backgroundDark,
      appBar: _buildAppBar(),
      body: AnimatedBuilder(
        animation: _animationController,
        builder: (context, child) {
          return FadeTransition(
            opacity: _fadeAnimation,
            child: SlideTransition(
              position: _slideAnimation,
              child: _buildBody(),
            ),
          );
        },
      ),
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      backgroundColor: AppTheme.backgroundDark,
      elevation: 0,
      leading: IconButton(
        onPressed: () => Navigator.pop(context),
        icon: CustomIconWidget(
          iconName: 'arrow_back',
          color: AppTheme.textPrimary,
          size: 24,
        ),
      ),
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Choose Your Plan',
            style: AppTheme.darkTheme.textTheme.titleLarge?.copyWith(
              color: AppTheme.textPrimary,
              fontWeight: FontWeight.w600,
            ),
          ),
          Text(
            'Credit Approved: \$${_creditAmount.toStringAsFixed(0)}',
            style: AppTheme.darkTheme.textTheme.bodySmall?.copyWith(
              color: AppTheme.primaryGold,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
      actions: [
        Container(
          margin: EdgeInsets.only(right: 4.w),
          child: Row(
            children: [
              Container(
                width: 8,
                height: 8,
                decoration: const BoxDecoration(
                  color: AppTheme.successGreen,
                  shape: BoxShape.circle,
                ),
              ),
              SizedBox(width: 2.w),
              Text(
                'Step 5 of 6',
                style: AppTheme.darkTheme.textTheme.bodySmall?.copyWith(
                  color: AppTheme.textSecondary,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildBody() {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 2.h),

          // Header section
          _buildHeaderSection(),

          SizedBox(height: 3.h),

          // Plan selection cards
          _buildPlanCards(),

          SizedBox(height: 3.h),

          // Payment timeline for selected plan
          if (_selectedPlanIndex >= 0)
            PaymentTimelineWidget(
              selectedPlan: _repaymentPlans[_selectedPlanIndex],
            ),

          SizedBox(height: 2.h),

          // Payment adjustment slider
          if (_selectedPlanIndex >= 0)
            PaymentSliderWidget(
              currentAmount: _repaymentPlans[_selectedPlanIndex]
                  ['monthlyPayment'] as double,
              minAmount: 100.0,
              maxAmount: 600.0,
              onChanged: _adjustPaymentAmount,
            ),

          SizedBox(height: 2.h),

          // LifeX integration
          if (_selectedPlanIndex >= 0)
            LifeXIntegrationWidget(
              selectedPlan: _repaymentPlans[_selectedPlanIndex],
            ),

          SizedBox(height: 2.h),

          // Interest calculator
          InterestCalculatorWidget(
            principalAmount: _creditAmount,
          ),

          SizedBox(height: 3.h),

          // Action buttons
          _buildActionButtons(),

          SizedBox(height: 4.h),
        ],
      ),
    );
  }

  Widget _buildHeaderSection() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 4.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: EdgeInsets.all(3.w),
                decoration: BoxDecoration(
                  color: AppTheme.primaryGold.withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: CustomIconWidget(
                  iconName: 'credit_card',
                  color: AppTheme.primaryGold,
                  size: 24,
                ),
              ),
              SizedBox(width: 3.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Select Payment Terms',
                      style:
                          AppTheme.darkTheme.textTheme.headlineSmall?.copyWith(
                        color: AppTheme.textPrimary,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    SizedBox(height: 0.5.h),
                    Text(
                      'Choose the plan that fits your budget and goals',
                      style: AppTheme.darkTheme.textTheme.bodyMedium?.copyWith(
                        color: AppTheme.textSecondary,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),

          SizedBox(height: 2.h),

          // AI recommendation banner
          Container(
            padding: EdgeInsets.all(3.w),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  AppTheme.primaryGold.withValues(alpha: 0.1),
                  AppTheme.accentBlue.withValues(alpha: 0.1),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: AppTheme.primaryGold.withValues(alpha: 0.3),
              ),
            ),
            child: Row(
              children: [
                CustomIconWidget(
                  iconName: 'psychology',
                  color: AppTheme.primaryGold,
                  size: 20,
                ),
                SizedBox(width: 3.w),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'AI Recommendation',
                        style:
                            AppTheme.darkTheme.textTheme.titleSmall?.copyWith(
                          color: AppTheme.primaryGold,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Text(
                        'Based on your Chronos spending patterns, the 6-month plan offers the best balance of affordability and total cost.',
                        style: AppTheme.darkTheme.textTheme.bodySmall?.copyWith(
                          color: AppTheme.textPrimary,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPlanCards() {
    return SizedBox(
      height: 45.h,
      child: PageView.builder(
        itemCount: _repaymentPlans.length,
        onPageChanged: (index) {
          _selectPlan(index);
        },
        itemBuilder: (context, index) {
          final plan = _repaymentPlans[index];
          return PlanCardWidget(
            planData: plan,
            isSelected: _selectedPlanIndex == index,
            isRecommended: plan['isRecommended'] as bool,
            onTap: () => _selectPlan(index),
          );
        },
      ),
    );
  }

  Widget _buildActionButtons() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 4.w),
      child: Column(
        children: [
          // Primary confirm button
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: _confirmPlan,
              style: AppTheme.darkTheme.elevatedButtonTheme.style?.copyWith(
                padding: WidgetStateProperty.all(
                  EdgeInsets.symmetric(vertical: 4.w),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Confirm ${_repaymentPlans[_selectedPlanIndex]['title']} - \$${(_repaymentPlans[_selectedPlanIndex]['monthlyPayment'] as double).toStringAsFixed(0)}/month',
                    style: AppTheme.darkTheme.textTheme.titleMedium?.copyWith(
                      color: AppTheme.backgroundDark,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(width: 2.w),
                  CustomIconWidget(
                    iconName: 'arrow_forward',
                    color: AppTheme.backgroundDark,
                    size: 20,
                  ),
                ],
              ),
            ),
          ),

          SizedBox(height: 2.h),

          // Secondary comparison button
          SizedBox(
            width: double.infinity,
            child: OutlinedButton(
              onPressed: _showDetailedComparison,
              style: AppTheme.darkTheme.outlinedButtonTheme.style?.copyWith(
                padding: WidgetStateProperty.all(
                  EdgeInsets.symmetric(vertical: 3.w),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CustomIconWidget(
                    iconName: 'compare_arrows',
                    color: AppTheme.primaryGold,
                    size: 20,
                  ),
                  SizedBox(width: 2.w),
                  Text(
                    'Compare All Options',
                    style: AppTheme.darkTheme.textTheme.titleMedium?.copyWith(
                      color: AppTheme.primaryGold,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
          ),

          SizedBox(height: 1.h),

          // Terms and conditions
          Text(
            'By confirming, you agree to the TickPay Terms of Service and acknowledge the repayment schedule. Early payments accepted without penalties.',
            textAlign: TextAlign.center,
            style: AppTheme.darkTheme.textTheme.bodySmall?.copyWith(
              color: AppTheme.textSecondary,
              height: 1.4,
            ),
          ),
        ],
      ),
    );
  }
}
