import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';

class TokenExplorerWidget extends StatefulWidget {
  final List<Map<String, dynamic>> tokens;
  final Function(Map<String, dynamic>) onTokenTap;

  const TokenExplorerWidget({
    Key? key,
    required this.tokens,
    required this.onTokenTap,
  }) : super(key: key);

  @override
  State<TokenExplorerWidget> createState() => _TokenExplorerWidgetState();
}

class _TokenExplorerWidgetState extends State<TokenExplorerWidget> {
  int? expandedIndex;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 2.h),
          child: Text(
            'Token Explorer',
            style: AppTheme.darkTheme.textTheme.headlineSmall?.copyWith(
              color: AppTheme.textPrimary,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: widget.tokens.length,
          itemBuilder: (context, index) {
            final token = widget.tokens[index];
            final isExpanded = expandedIndex == index;
            final bool isPositive = (token['changePercent'] as double) > 0;
            final Color changeColor =
                isPositive ? AppTheme.successGreen : AppTheme.errorRed;
            final String changeSign = isPositive ? '+' : '';

            return Container(
              margin: EdgeInsets.symmetric(horizontal: 4.w, vertical: 1.h),
              decoration: BoxDecoration(
                color: AppTheme.elevatedSurface.withValues(alpha: 0.8),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: isExpanded
                      ? AppTheme.primaryGold.withValues(alpha: 0.5)
                      : AppTheme.textSecondary.withValues(alpha: 0.2),
                  width: 1,
                ),
              ),
              child: Column(
                children: [
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        expandedIndex = isExpanded ? null : index;
                      });
                    },
                    child: Container(
                      padding: EdgeInsets.all(4.w),
                      child: Row(
                        children: [
                          Container(
                            width: 12.w,
                            height: 12.w,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12.w),
                              color:
                                  AppTheme.primaryGold.withValues(alpha: 0.2),
                            ),
                            child: Center(
                              child: Text(
                                token['symbol'] as String,
                                style: AppTheme.darkTheme.textTheme.titleSmall
                                    ?.copyWith(
                                  color: AppTheme.primaryGold,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(width: 3.w),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  token['name'] as String,
                                  style: AppTheme
                                      .darkTheme.textTheme.titleMedium
                                      ?.copyWith(
                                    color: AppTheme.textPrimary,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                Text(
                                  token['symbol'] as String,
                                  style: AppTheme.darkTheme.textTheme.bodySmall
                                      ?.copyWith(
                                    color: AppTheme.textSecondary,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                '\$${(token['price'] as double).toStringAsFixed(2)}',
                                style: AppTheme.darkTheme.textTheme.titleMedium
                                    ?.copyWith(
                                  color: AppTheme.textPrimary,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              Row(
                                children: [
                                  CustomIconWidget(
                                    iconName: isPositive
                                        ? 'trending_up'
                                        : 'trending_down',
                                    color: changeColor,
                                    size: 16,
                                  ),
                                  SizedBox(width: 1.w),
                                  Text(
                                    '$changeSign${(token['changePercent'] as double).toStringAsFixed(2)}%',
                                    style: AppTheme
                                        .darkTheme.textTheme.bodySmall
                                        ?.copyWith(
                                      color: changeColor,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          SizedBox(width: 2.w),
                          CustomIconWidget(
                            iconName:
                                isExpanded ? 'expand_less' : 'expand_more',
                            color: AppTheme.textSecondary,
                            size: 24,
                          ),
                        ],
                      ),
                    ),
                  ),
                  if (isExpanded) ...[
                    Container(
                      width: double.infinity,
                      height: 1,
                      color: AppTheme.textSecondary.withValues(alpha: 0.2),
                    ),
                    Padding(
                      padding: EdgeInsets.all(4.w),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: _buildStatItem(
                                  'Market Cap',
                                  '\$${_formatNumber(token['marketCap'] as double)}',
                                ),
                              ),
                              Expanded(
                                child: _buildStatItem(
                                  'Volume (24h)',
                                  '\$${_formatNumber(token['volume24h'] as double)}',
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 2.h),
                          Row(
                            children: [
                              Expanded(
                                child: _buildStatItem(
                                  'Circulating Supply',
                                  '${_formatNumber(token['circulatingSupply'] as double)} ${token['symbol']}',
                                ),
                              ),
                              Expanded(
                                child: _buildStatItem(
                                  'Rank',
                                  '#${token['rank']}',
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 2.h),
                          Row(
                            children: [
                              Expanded(
                                child: ElevatedButton(
                                  onPressed: () => widget.onTokenTap(token),
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: AppTheme.primaryGold,
                                    foregroundColor:
                                        AppTheme.trueDarkBackground,
                                    padding:
                                        EdgeInsets.symmetric(vertical: 1.5.h),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                  ),
                                  child: Text(
                                    'View Details',
                                    style: AppTheme
                                        .darkTheme.textTheme.titleSmall
                                        ?.copyWith(
                                      color: AppTheme.trueDarkBackground,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(width: 3.w),
                              Expanded(
                                child: OutlinedButton(
                                  onPressed: () {
                                    Navigator.pushNamed(
                                        context, '/buy-sell-interface');
                                  },
                                  style: OutlinedButton.styleFrom(
                                    foregroundColor: AppTheme.primaryGold,
                                    side:
                                        BorderSide(color: AppTheme.primaryGold),
                                    padding:
                                        EdgeInsets.symmetric(vertical: 1.5.h),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                  ),
                                  child: Text(
                                    'Trade',
                                    style: AppTheme
                                        .darkTheme.textTheme.titleSmall
                                        ?.copyWith(
                                      color: AppTheme.primaryGold,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ],
              ),
            );
          },
        ),
      ],
    );
  }

  Widget _buildStatItem(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: AppTheme.darkTheme.textTheme.bodySmall?.copyWith(
            color: AppTheme.textSecondary,
          ),
        ),
        SizedBox(height: 0.5.h),
        Text(
          value,
          style: AppTheme.darkTheme.textTheme.titleSmall?.copyWith(
            color: AppTheme.textPrimary,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }

  String _formatNumber(double number) {
    if (number >= 1e12) {
      return '${(number / 1e12).toStringAsFixed(2)}T';
    } else if (number >= 1e9) {
      return '${(number / 1e9).toStringAsFixed(2)}B';
    } else if (number >= 1e6) {
      return '${(number / 1e6).toStringAsFixed(2)}M';
    } else if (number >= 1e3) {
      return '${(number / 1e3).toStringAsFixed(2)}K';
    } else {
      return number.toStringAsFixed(2);
    }
  }
}
