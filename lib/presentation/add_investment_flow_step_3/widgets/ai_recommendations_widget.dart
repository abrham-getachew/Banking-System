import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';

class AiRecommendationsWidget extends StatefulWidget {
  final bool isLoading;
  final List<Map<String, dynamic>> recommendations;
  final VoidCallback onGetMoreOptions;

  const AiRecommendationsWidget({
    super.key,
    required this.isLoading,
    required this.recommendations,
    required this.onGetMoreOptions,
  });

  @override
  State<AiRecommendationsWidget> createState() =>
      _AiRecommendationsWidgetState();
}

class _AiRecommendationsWidgetState extends State<AiRecommendationsWidget>
    with TickerProviderStateMixin {
  late AnimationController _shimmerController;
  String? expandedRecommendation;

  @override
  void initState() {
    super.initState();
    _shimmerController = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..repeat();
  }

  @override
  void dispose() {
    _shimmerController.dispose();
    super.dispose();
  }

  Widget _buildStarRating(double confidence) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(5, (index) {
        return CustomIconWidget(
          iconName: index < confidence.floor()
              ? 'star'
              : (index < confidence ? 'star_half' : 'star_border'),
          color: AppTheme.chronosGold,
          size: 4.w,
        );
      }),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              padding: EdgeInsets.all(2.w),
              decoration: BoxDecoration(
                color: AppTheme.chronosGold.withValues(alpha: 0.2),
                borderRadius: BorderRadius.circular(12.0),
              ),
              child: CustomIconWidget(
                iconName: 'auto_awesome',
                color: AppTheme.chronosGold,
                size: 6.w,
              ),
            ),
            SizedBox(width: 3.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'AI-Powered Recommendations',
                    style: AppTheme.darkTheme.textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    widget.isLoading
                        ? 'Analyzing market data and your preferences...'
                        : 'Based on your investment profile and current market conditions',
                    style: AppTheme.darkTheme.textTheme.bodyMedium?.copyWith(
                      color: AppTheme.textSecondary,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        SizedBox(height: 3.h),
        if (widget.isLoading) ...[
          // Shimmer loading state
          Column(
            children: List.generate(3, (index) => _buildShimmerCard()),
          ),
        ] else if (widget.recommendations.isEmpty) ...[
          // Empty state
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(6.w),
            decoration: BoxDecoration(
              color: AppTheme.surfaceDark,
              borderRadius: BorderRadius.circular(16.0),
              border: Border.all(color: AppTheme.dividerSubtle),
            ),
            child: Column(
              children: [
                CustomIconWidget(
                  iconName: 'error_outline',
                  color: AppTheme.textSecondary,
                  size: 12.w,
                ),
                SizedBox(height: 2.h),
                Text(
                  'Unable to generate recommendations',
                  style: AppTheme.darkTheme.textTheme.titleMedium?.copyWith(
                    color: AppTheme.textSecondary,
                  ),
                ),
                SizedBox(height: 1.h),
                Text(
                  'Please try again or adjust your preferences',
                  style: AppTheme.darkTheme.textTheme.bodyMedium?.copyWith(
                    color: AppTheme.textTertiary,
                  ),
                ),
                SizedBox(height: 2.h),
                OutlinedButton(
                  onPressed: widget.onGetMoreOptions,
                  child: const Text('Retry'),
                ),
              ],
            ),
          ),
        ] else ...[
          // Recommendations list
          Column(
            children: widget.recommendations.map((recommendation) {
              final isExpanded =
                  expandedRecommendation == recommendation['name'];

              return GestureDetector(
                onTap: () {
                  setState(() {
                    expandedRecommendation =
                        isExpanded ? null : recommendation['name'];
                  });
                },
                child: AnimatedContainer(
                  duration: AppTheme.standardAnimation,
                  margin: EdgeInsets.only(bottom: 3.h),
                  padding: EdgeInsets.all(4.w),
                  decoration: BoxDecoration(
                    color: AppTheme.surfaceDark,
                    borderRadius: BorderRadius.circular(16.0),
                    border: Border.all(
                      color: isExpanded
                          ? AppTheme.chronosGold
                          : AppTheme.dividerSubtle,
                      width: isExpanded ? 2.0 : 1.0,
                    ),
                    boxShadow: isExpanded
                        ? [
                            BoxShadow(
                              color:
                                  AppTheme.chronosGold.withValues(alpha: 0.2),
                              blurRadius: 8.0,
                              offset: const Offset(0, 2),
                            ),
                          ]
                        : null,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Header
                      Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  recommendation['name'],
                                  style: AppTheme
                                      .darkTheme.textTheme.titleMedium
                                      ?.copyWith(
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                SizedBox(height: 0.5.h),
                                Row(
                                  children: [
                                    Container(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 2.w, vertical: 0.5.h),
                                      decoration: BoxDecoration(
                                        color: AppTheme.chronosGold
                                            .withValues(alpha: 0.2),
                                        borderRadius:
                                            BorderRadius.circular(6.0),
                                      ),
                                      child: Text(
                                        recommendation['type'],
                                        style: AppTheme
                                            .darkTheme.textTheme.labelSmall
                                            ?.copyWith(
                                          color: AppTheme.chronosGold,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ),
                                    SizedBox(width: 2.w),
                                    Text(
                                      '\$${recommendation['price'].toStringAsFixed(2)}',
                                      style: AppTheme
                                          .darkTheme.textTheme.bodyMedium
                                          ?.copyWith(
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              _buildStarRating(recommendation['confidence']),
                              SizedBox(height: 0.5.h),
                              Text(
                                '${recommendation['expectedReturn'].toStringAsFixed(1)}% return',
                                style: AppTheme.darkTheme.textTheme.bodySmall
                                    ?.copyWith(
                                  color: AppTheme.successGreen,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),

                      SizedBox(height: 2.h),
                      Text(
                        recommendation['description'],
                        style:
                            AppTheme.darkTheme.textTheme.bodyMedium?.copyWith(
                          color: AppTheme.textSecondary,
                        ),
                      ),

                      if (isExpanded) ...[
                        SizedBox(height: 2.h),
                        Container(
                          padding: EdgeInsets.all(3.w),
                          decoration: BoxDecoration(
                            color: AppTheme.primaryCharcoal,
                            borderRadius: BorderRadius.circular(12.0),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  CustomIconWidget(
                                    iconName: 'psychology',
                                    color: AppTheme.chronosGold,
                                    size: 5.w,
                                  ),
                                  SizedBox(width: 2.w),
                                  Text(
                                    'AI Analysis',
                                    style: AppTheme
                                        .darkTheme.textTheme.titleSmall
                                        ?.copyWith(
                                      color: AppTheme.chronosGold,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 1.h),
                              Text(
                                recommendation['aiReasoning'],
                                style: AppTheme.darkTheme.textTheme.bodySmall
                                    ?.copyWith(
                                  color: AppTheme.textSecondary,
                                  fontStyle: FontStyle.italic,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],

                      SizedBox(height: 2.h),
                      Row(
                        children: [
                          Text(
                            'Suggested allocation: ${recommendation['allocation'].toStringAsFixed(0)}%',
                            style: AppTheme.darkTheme.textTheme.bodyMedium
                                ?.copyWith(
                              color: AppTheme.textSecondary,
                            ),
                          ),
                          const Spacer(),
                          CustomIconWidget(
                            iconName:
                                isExpanded ? 'expand_less' : 'expand_more',
                            color: AppTheme.chronosGold,
                            size: 5.w,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            }).toList(),
          ),

          // Get more options button
          SizedBox(
            width: double.infinity,
            child: OutlinedButton(
              onPressed: widget.onGetMoreOptions,
              style: OutlinedButton.styleFrom(
                side: BorderSide(
                  color: AppTheme.chronosGold.withValues(alpha: 0.5),
                ),
                padding: EdgeInsets.symmetric(vertical: 2.h),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CustomIconWidget(
                    iconName: 'refresh',
                    color: AppTheme.chronosGold,
                    size: 5.w,
                  ),
                  SizedBox(width: 2.w),
                  Text('Get More Options'),
                ],
              ),
            ),
          ),
        ],
      ],
    );
  }

  Widget _buildShimmerCard() {
    return AnimatedBuilder(
      animation: _shimmerController,
      builder: (context, child) {
        return Container(
          margin: EdgeInsets.only(bottom: 3.h),
          padding: EdgeInsets.all(4.w),
          decoration: BoxDecoration(
            color: AppTheme.surfaceDark,
            borderRadius: BorderRadius.circular(16.0),
            border: Border.all(color: AppTheme.dividerSubtle),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    flex: 3,
                    child: _buildShimmerBox(height: 3.h),
                  ),
                  SizedBox(width: 4.w),
                  Expanded(
                    flex: 1,
                    child: _buildShimmerBox(height: 2.h),
                  ),
                ],
              ),
              SizedBox(height: 2.h),
              _buildShimmerBox(height: 2.h),
              SizedBox(height: 1.h),
              _buildShimmerBox(height: 1.5.h, width: 60.w),
            ],
          ),
        );
      },
    );
  }

  Widget _buildShimmerBox({required double height, double? width}) {
    return Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4.0),
        gradient: LinearGradient(
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
          stops: [
            _shimmerController.value - 0.3,
            _shimmerController.value,
            _shimmerController.value + 0.3,
          ].map((stop) => stop.clamp(0.0, 1.0)).toList(),
          colors: [
            AppTheme.dividerSubtle,
            AppTheme.dividerSubtle.withValues(alpha: 0.5),
            AppTheme.dividerSubtle,
          ],
        ),
      ),
    );
  }
}
