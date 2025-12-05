import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../core/app_export.dart';
import '../../theme/app_theme.dart';
import './widgets/animated_shimmer_icon_widget.dart';
import './widgets/benefits_showcase_widget.dart';
import './widgets/cta_buttons_widget.dart';
import './widgets/feature_details_widget.dart';
import './widgets/hero_card_widget.dart';
import './widgets/social_proof_widget.dart';

class TickPayLandingPage extends StatefulWidget {
  const TickPayLandingPage({super.key});

  @override
  State<TickPayLandingPage> createState() => _TickPayLandingPageState();
}

class _TickPayLandingPageState extends State<TickPayLandingPage>
    with SingleTickerProviderStateMixin {
  late ScrollController _scrollController;
  late AnimationController _parallaxController;
  double _scrollOffset = 0.0;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _parallaxController = AnimationController(
      duration: const Duration(seconds: 20),
      vsync: this,
    );

    _scrollController.addListener(() {
      setState(() {
        _scrollOffset = _scrollController.offset;
      });
    });

    _parallaxController.repeat();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _parallaxController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.backgroundDark,
      body: SafeArea(
        child: CustomScrollView(
          controller: _scrollController,
          slivers: [
            // Header with shimmer icon
            SliverToBoxAdapter(
              child: _buildHeader(),
            ),

            // Hero section with animated card
            SliverToBoxAdapter(
              child: _buildHeroSection(),
            ),

            // Benefits showcase
            SliverToBoxAdapter(
              child: _buildBenefitsSection(),
            ),

            // CTA buttons
            SliverToBoxAdapter(
              child: _buildCtaSection(),
            ),

            // Feature details (expandable)
            SliverToBoxAdapter(
              child: _buildFeatureDetailsSection(),
            ),

            // Social proof and trust signals
            SliverToBoxAdapter(
              child: _buildSocialProofSection(),
            ),

            // Bottom spacing
            SliverToBoxAdapter(
              child: SizedBox(height: 10.h),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Transform.translate(
      offset: Offset(0, _scrollOffset * 0.3),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 4.h),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const AnimatedShimmerIconWidget(),
                SizedBox(width: 3.w),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'TickPay',
                      style:
                          AppTheme.darkTheme.textTheme.headlineMedium?.copyWith(
                        color: AppTheme.textPrimary,
                        fontWeight: FontWeight.w700,
                        fontSize: 24.sp,
                      ),
                    ),
                    Text(
                      'Buy Now, Pay Later',
                      style: AppTheme.darkTheme.textTheme.bodyMedium?.copyWith(
                        color: AppTheme.primaryGold,
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: 2.h),
            Text(
              'Instant credit approval with flexible payment plans',
              textAlign: TextAlign.center,
              style: AppTheme.darkTheme.textTheme.bodyLarge?.copyWith(
                color: AppTheme.textSecondary,
                fontSize: 16.sp,
                height: 1.4,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeroSection() {
    return Transform.translate(
      offset: Offset(0, _scrollOffset * 0.2),
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 4.h),
        child: const HeroCardWidget(),
      ),
    );
  }

  Widget _buildBenefitsSection() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 4.h),
      child: Column(
        children: [
          Text(
            'Why Choose TickPay?',
            style: AppTheme.darkTheme.textTheme.headlineSmall?.copyWith(
              color: AppTheme.textPrimary,
              fontWeight: FontWeight.w700,
              fontSize: 22.sp,
            ),
          ),
          SizedBox(height: 3.h),
          const BenefitsShowcaseWidget(),
        ],
      ),
    );
  }

  Widget _buildCtaSection() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 4.h),
      child: const CtaButtonsWidget(),
    );
  }

  Widget _buildFeatureDetailsSection() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 3.h),
      child: const FeatureDetailsWidget(),
    );
  }

  Widget _buildSocialProofSection() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 4.h),
      child: Column(
        children: [
          Text(
            'Trusted by Thousands',
            style: AppTheme.darkTheme.textTheme.headlineSmall?.copyWith(
              color: AppTheme.textPrimary,
              fontWeight: FontWeight.w700,
              fontSize: 20.sp,
            ),
          ),
          SizedBox(height: 3.h),
          const SocialProofWidget(),
        ],
      ),
    );
  }
}
