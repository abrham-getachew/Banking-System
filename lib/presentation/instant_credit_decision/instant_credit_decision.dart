import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/foundation.dart';
import 'package:sizer/sizer.dart';

import '../../core/app_export.dart';
import './widgets/action_buttons_widget.dart';
import './widgets/ai_recommendations_widget.dart';
import './widgets/approval_animation_widget.dart';
import './widgets/credit_limit_display_widget.dart';
import './widgets/payment_terms_widget.dart';

class InstantCreditDecision extends StatefulWidget {
  const InstantCreditDecision({Key? key}) : super(key: key);

  @override
  State<InstantCreditDecision> createState() => _InstantCreditDecisionState();
}

class _InstantCreditDecisionState extends State<InstantCreditDecision>
    with TickerProviderStateMixin {
  late AnimationController _slideController;
  late Animation<Offset> _slideAnimation;

  bool _showContent = false;
  bool _animationComplete = false;

  // Mock credit decision data
  final Map<String, dynamic> creditDecision = {
    "applicationId": "APP-2025-001234",
    "userId": "user_12345",
    "status": "approved", // approved, declined, pending
    "creditLimit": 2500.0,
    "interestRate": 2.9,
    "decisionTimestamp": "2025-07-20T11:45:42.362625",
    "riskScore": 750,
    "approvalFactors": [
      "Excellent payment history",
      "Strong income verification",
      "Low debt-to-income ratio",
      "Stable employment record"
    ],
    "terms": {
      "minimumPayment": 25.0,
      "lateFee": 35.0,
      "overlimitFee": 25.0,
      "cashAdvanceFee": 5.0
    }
  };

  @override
  void initState() {
    super.initState();
    _initializeAnimations();
    _startRevealSequence();
    _preventScreenshots();
  }

  void _initializeAnimations() {
    _slideController = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    );

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 1),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _slideController,
      curve: Curves.easeOutCubic,
    ));
  }

  void _startRevealSequence() async {
    // Simulate processing time
    await Future.delayed(const Duration(milliseconds: 500));

    setState(() {
      _showContent = true;
    });

    await _slideController.forward();

    // Trigger haptic feedback for approval
    if (_isApproved) {
      HapticFeedback.heavyImpact();
      await Future.delayed(const Duration(milliseconds: 200));
      HapticFeedback.mediumImpact();
    }
  }

  void _preventScreenshots() {
    // Note: This would require platform-specific implementation
    // For now, we'll just show a warning in debug mode
    if (kDebugMode) {
      print('Screenshot prevention would be enabled in production');
    }
  }

  bool get _isApproved => (creditDecision['status'] as String) == 'approved';
  double get _creditLimit => creditDecision['creditLimit'] as double;

  void _onAnimationComplete() {
    setState(() {
      _animationComplete = true;
    });

    // Auto-progress timer (30 seconds)
    Future.delayed(const Duration(seconds: 30), () {
      if (mounted && _isApproved) {
        _navigateToCardCreation();
      }
    });
  }

  void _navigateToCardCreation() {
    Navigator.pushNamed(context, '/repayment-plan-selector');
  }

  void _navigateToPhysicalCard() {
    // Navigate to physical card ordering
    Navigator.pushNamed(context, '/repayment-plan-selector');
  }

  void _showFullTerms() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => _buildTermsBottomSheet(),
    );
  }

  void _shareAchievement() {
    // Implement social sharing
    HapticFeedback.lightImpact();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Achievement shared successfully!'),
        backgroundColor: AppTheme.successGreen,
      ),
    );
  }

  void _contactSupport() {
    showDialog(
      context: context,
      builder: (context) => _buildSupportDialog(),
    );
  }

  @override
  void dispose() {
    _slideController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.backgroundDark,
      body: SafeArea(
        child: _showContent ? _buildMainContent() : _buildLoadingState(),
      ),
    );
  }

  Widget _buildLoadingState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(AppTheme.primaryGold),
            strokeWidth: 3,
          ),
          SizedBox(height: 3.h),
          Text(
            'Processing your application...',
            style: AppTheme.darkTheme.textTheme.titleMedium?.copyWith(
              color: AppTheme.textPrimary,
            ),
          ),
          SizedBox(height: 1.h),
          Text(
            'This may take a few moments',
            style: AppTheme.darkTheme.textTheme.bodyMedium?.copyWith(
              color: AppTheme.textSecondary,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMainContent() {
    return SlideTransition(
      position: _slideAnimation,
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            // Header with close button
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 2.h),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Credit Decision',
                    style: AppTheme.darkTheme.textTheme.titleLarge?.copyWith(
                      color: AppTheme.textPrimary,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: CustomIconWidget(
                      iconName: 'close',
                      color: AppTheme.textSecondary,
                      size: 6.w,
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(height: 2.h),

            // Approval animation
            ApprovalAnimationWidget(
              isApproved: _isApproved,
              onAnimationComplete: _onAnimationComplete,
            ),

            SizedBox(height: 3.h),

            // Credit limit display
            CreditLimitDisplayWidget(
              creditLimit: _creditLimit,
              isApproved: _isApproved,
            ),

            if (_isApproved && _animationComplete) ...[
              SizedBox(height: 2.h),

              // Payment terms
              PaymentTermsWidget(
                creditLimit: _creditLimit,
              ),
            ],

            SizedBox(height: 3.h),

            // Action buttons
            ActionButtonsWidget(
              isApproved: _isApproved,
              onCreateVirtualCard: _navigateToCardCreation,
              onOrderPhysicalCard: _navigateToPhysicalCard,
              onViewTerms: _showFullTerms,
              onShareAchievement: _shareAchievement,
              onContactSupport: _contactSupport,
            ),

            if (_animationComplete) ...[
              SizedBox(height: 2.h),

              // AI recommendations
              AiRecommendationsWidget(
                isApproved: _isApproved,
                creditLimit: _creditLimit,
              ),
            ],

            SizedBox(height: 4.h),
          ],
        ),
      ),
    );
  }

  Widget _buildTermsBottomSheet() {
    return Container(
      height: 80.h,
      decoration: BoxDecoration(
        color: AppTheme.surfaceDark,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Column(
        children: [
          // Handle bar
          Container(
            width: 12.w,
            height: 0.5.h,
            margin: EdgeInsets.symmetric(vertical: 2.h),
            decoration: BoxDecoration(
              color: AppTheme.textSecondary,
              borderRadius: BorderRadius.circular(2),
            ),
          ),

          // Header
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 4.w),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Full Terms & Conditions',
                  style: AppTheme.darkTheme.textTheme.titleLarge?.copyWith(
                    color: AppTheme.textPrimary,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: CustomIconWidget(
                    iconName: 'close',
                    color: AppTheme.textSecondary,
                    size: 6.w,
                  ),
                ),
              ],
            ),
          ),

          Divider(color: AppTheme.dividerDark),

          // Terms content
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.all(4.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildTermSection(
                      'Credit Limit', '\$${_creditLimit.toStringAsFixed(2)}'),
                  _buildTermSection('Interest Rate',
                      '${creditDecision['interestRate']}% APR'),
                  _buildTermSection('Minimum Payment',
                      '\$${(creditDecision['terms']['minimumPayment'] as double).toStringAsFixed(2)}'),
                  _buildTermSection('Late Fee',
                      '\$${(creditDecision['terms']['lateFee'] as double).toStringAsFixed(2)}'),
                  _buildTermSection('Over-Limit Fee',
                      '\$${(creditDecision['terms']['overlimitFee'] as double).toStringAsFixed(2)}'),
                  SizedBox(height: 3.h),
                  Text(
                    'Important Information',
                    style: AppTheme.darkTheme.textTheme.titleMedium?.copyWith(
                      color: AppTheme.textPrimary,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: 2.h),
                  Text(
                    'By accepting this credit offer, you agree to the terms and conditions outlined in your credit agreement. Your credit limit and interest rate are based on your creditworthiness and may be subject to change.',
                    style: AppTheme.darkTheme.textTheme.bodyMedium?.copyWith(
                      color: AppTheme.textSecondary,
                      height: 1.5,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTermSection(String title, String value) {
    return Padding(
      padding: EdgeInsets.only(bottom: 2.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: AppTheme.darkTheme.textTheme.bodyMedium?.copyWith(
              color: AppTheme.textSecondary,
            ),
          ),
          Text(
            value,
            style: AppTheme.darkTheme.textTheme.bodyMedium?.copyWith(
              color: AppTheme.textPrimary,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSupportDialog() {
    return AlertDialog(
      backgroundColor: AppTheme.surfaceDark,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      title: Text(
        'Contact Support',
        style: AppTheme.darkTheme.textTheme.titleMedium?.copyWith(
          color: AppTheme.textPrimary,
          fontWeight: FontWeight.w600,
        ),
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ListTile(
            leading: CustomIconWidget(
              iconName: 'chat',
              color: AppTheme.primaryGold,
              size: 6.w,
            ),
            title: Text(
              'Live Chat',
              style: AppTheme.darkTheme.textTheme.bodyMedium?.copyWith(
                color: AppTheme.textPrimary,
              ),
            ),
            subtitle: Text(
              'Available 24/7',
              style: AppTheme.darkTheme.textTheme.bodySmall?.copyWith(
                color: AppTheme.textSecondary,
              ),
            ),
            onTap: () {
              Navigator.pop(context);
              // Implement live chat
            },
          ),
          ListTile(
            leading: CustomIconWidget(
              iconName: 'phone',
              color: AppTheme.primaryGold,
              size: 6.w,
            ),
            title: Text(
              'Call Support',
              style: AppTheme.darkTheme.textTheme.bodyMedium?.copyWith(
                color: AppTheme.textPrimary,
              ),
            ),
            subtitle: Text(
              '1-800-CHRONOS',
              style: AppTheme.darkTheme.textTheme.bodySmall?.copyWith(
                color: AppTheme.textSecondary,
              ),
            ),
            onTap: () {
              Navigator.pop(context);
              // Implement phone call
            },
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: Text(
            'Cancel',
            style: TextStyle(color: AppTheme.textSecondary),
          ),
        ),
      ],
    );
  }
}
