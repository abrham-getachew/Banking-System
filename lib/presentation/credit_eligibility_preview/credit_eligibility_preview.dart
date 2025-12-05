import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sizer/sizer.dart';

import '../../core/app_export.dart';
import './widgets/action_buttons_widget.dart';
import './widgets/credit_limit_display_widget.dart';
import './widgets/eligibility_factors_widget.dart';
import './widgets/personal_info_preview_widget.dart';
import './widgets/progress_animation_widget.dart';

class CreditEligibilityPreview extends StatefulWidget {
  const CreditEligibilityPreview({Key? key}) : super(key: key);

  @override
  State<CreditEligibilityPreview> createState() =>
      _CreditEligibilityPreviewState();
}

class _CreditEligibilityPreviewState extends State<CreditEligibilityPreview>
    with TickerProviderStateMixin {
  late AnimationController _headerController;
  late Animation<Offset> _headerAnimation;

  bool _isAssessmentComplete = false;
  bool _showCreditLimit = false;
  bool _showEligibilityFactors = false;
  bool _showPersonalInfo = false;
  bool _showActionButtons = false;

  final double _estimatedCreditLimit = 2500.0;

  @override
  void initState() {
    super.initState();
    _initializeAnimations();
    _startHeaderAnimation();
  }

  void _initializeAnimations() {
    _headerController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );

    _headerAnimation = Tween<Offset>(
      begin: const Offset(0, -1),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _headerController,
      curve: Curves.easeOutCubic,
    ));
  }

  void _startHeaderAnimation() {
    _headerController.forward();
  }

  void _onAssessmentComplete() {
    HapticFeedback.mediumImpact();

    setState(() {
      _isAssessmentComplete = true;
    });

    _showElementsSequentially();
  }

  void _showElementsSequentially() async {
    await Future.delayed(const Duration(milliseconds: 500));
    setState(() {
      _showCreditLimit = true;
    });

    await Future.delayed(const Duration(milliseconds: 1000));
    setState(() {
      _showEligibilityFactors = true;
    });

    await Future.delayed(const Duration(milliseconds: 800));
    setState(() {
      _showPersonalInfo = true;
    });

    await Future.delayed(const Duration(milliseconds: 600));
    setState(() {
      _showActionButtons = true;
    });
  }

  void _onApplyNow() {
    HapticFeedback.lightImpact();
    Navigator.pushNamed(context, '/credit-application-form');
  }

  void _onUpdatePersonalInfo() {
    // Show update form or navigate to profile edit
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          'Personal information update feature coming soon',
          style: AppTheme.darkTheme.textTheme.bodyMedium?.copyWith(
            color: AppTheme.textPrimary,
          ),
        ),
        backgroundColor: AppTheme.darkTheme.colorScheme.surface,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _headerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.backgroundDark,
      body: SafeArea(
        child: Column(
          children: [
            _buildHeader(),
            Expanded(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  children: [
                    SizedBox(height: 3.h),
                    _buildWelcomeSection(),
                    SizedBox(height: 3.h),
                    ProgressAnimationWidget(
                      onComplete: _onAssessmentComplete,
                    ),
                    CreditLimitDisplayWidget(
                      creditLimit: _estimatedCreditLimit,
                      isVisible: _showCreditLimit,
                    ),
                    EligibilityFactorsWidget(
                      isVisible: _showEligibilityFactors,
                    ),
                    PersonalInfoPreviewWidget(
                      isVisible: _showPersonalInfo,
                      onUpdatePressed: _onUpdatePersonalInfo,
                    ),
                    ActionButtonsWidget(
                      isEnabled: _isAssessmentComplete,
                      onApplyNow: _onApplyNow,
                    ),
                    SizedBox(height: 3.h),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return SlideTransition(
      position: _headerAnimation,
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 2.h),
        decoration: BoxDecoration(
          color: AppTheme.backgroundDark,
          border: Border(
            bottom: BorderSide(
              color: AppTheme.primaryGold.withValues(alpha: 0.1),
              width: 1,
            ),
          ),
        ),
        child: Row(
          children: [
            GestureDetector(
              onTap: () => Navigator.pop(context),
              child: Container(
                width: 10.w,
                height: 10.w,
                decoration: BoxDecoration(
                  color: AppTheme.darkTheme.colorScheme.surface,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: AppTheme.primaryGold.withValues(alpha: 0.2),
                    width: 1,
                  ),
                ),
                child: CustomIconWidget(
                  iconName: 'arrow_back',
                  color: AppTheme.textPrimary,
                  size: 5.w,
                ),
              ),
            ),
            SizedBox(width: 4.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'TickPay Credit',
                    style: AppTheme.darkTheme.textTheme.titleLarge?.copyWith(
                      color: AppTheme.primaryGold,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  Text(
                    'Eligibility Assessment',
                    style: AppTheme.darkTheme.textTheme.bodyMedium?.copyWith(
                      color: AppTheme.textSecondary,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 1.h),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    AppTheme.primaryGold.withValues(alpha: 0.2),
                    AppTheme.primaryGold.withValues(alpha: 0.1),
                  ],
                ),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: AppTheme.primaryGold.withValues(alpha: 0.3),
                  width: 1,
                ),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  CustomIconWidget(
                    iconName: 'security',
                    color: AppTheme.primaryGold,
                    size: 3.w,
                  ),
                  SizedBox(width: 1.w),
                  Text(
                    'Secure',
                    style: AppTheme.darkTheme.textTheme.bodySmall?.copyWith(
                      color: AppTheme.primaryGold,
                      fontWeight: FontWeight.w600,
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

  Widget _buildWelcomeSection() {
    return Container(
      width: 85.w,
      padding: EdgeInsets.all(4.w),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            AppTheme.primaryGold.withValues(alpha: 0.05),
            AppTheme.primaryGold.withValues(alpha: 0.02),
          ],
        ),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: AppTheme.primaryGold.withValues(alpha: 0.2),
          width: 1,
        ),
      ),
      child: Column(
        children: [
          Container(
            width: 16.w,
            height: 16.w,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  AppTheme.primaryGold,
                  AppTheme.primaryGold.withValues(alpha: 0.8),
                ],
              ),
              shape: BoxShape.circle,
            ),
            child: CustomIconWidget(
              iconName: 'credit_score',
              color: AppTheme.backgroundDark,
              size: 8.w,
            ),
          ),
          SizedBox(height: 2.h),
          Text(
            'Credit Eligibility Check',
            style: AppTheme.darkTheme.textTheme.headlineSmall?.copyWith(
              color: AppTheme.textPrimary,
              fontWeight: FontWeight.w700,
            ),
          ),
          SizedBox(height: 1.h),
          Text(
            'We\'re analyzing your Chronos account data to determine your TickPay credit eligibility and estimate your credit limit.',
            textAlign: TextAlign.center,
            style: AppTheme.darkTheme.textTheme.bodyMedium?.copyWith(
              color: AppTheme.textSecondary,
              height: 1.5,
            ),
          ),
          SizedBox(height: 2.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildFeatureBadge('Instant Decision', 'flash_on'),
              SizedBox(width: 3.w),
              _buildFeatureBadge('No Hard Inquiry', 'shield'),
              SizedBox(width: 3.w),
              _buildFeatureBadge('Secure Process', 'lock'),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildFeatureBadge(String text, String iconName) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 2.w, vertical: 1.h),
      decoration: BoxDecoration(
        color: AppTheme.backgroundDark.withValues(alpha: 0.5),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: AppTheme.primaryGold.withValues(alpha: 0.3),
          width: 1,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          CustomIconWidget(
            iconName: iconName,
            color: AppTheme.primaryGold,
            size: 3.w,
          ),
          SizedBox(width: 1.w),
          Text(
            text,
            style: AppTheme.darkTheme.textTheme.bodySmall?.copyWith(
              color: AppTheme.textPrimary,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
