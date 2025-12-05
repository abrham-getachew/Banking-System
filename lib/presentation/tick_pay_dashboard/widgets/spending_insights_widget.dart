import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class SpendingInsightsWidget extends StatelessWidget {
  const SpendingInsightsWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Spending Insights',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
            ),
            Row(
              children: [
                const Icon(
                  Icons.auto_awesome,
                  color: Color(0xFF9e814e),
                  size: 16,
                ),
                const SizedBox(width: 4),
                Text(
                  'AI Powered',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: const Color(0xFF9e814e),
                        fontWeight: FontWeight.w500,
                      ),
                ),
              ],
            ),
          ],
        ),
        const SizedBox(height: 12),
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Theme.of(context).cardColor,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: Colors.grey.withAlpha(51),
            ),
          ),
          child: Column(
            children: [
              // Monthly trends
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'This Month',
                    style: Theme.of(context).textTheme.titleSmall?.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                  ),
                  Row(
                    children: [
                      const Icon(
                        Icons.trending_down,
                        color: Color(0xFF00c851),
                        size: 16,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        '12% vs last month',
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                              color: const Color(0xFF00c851),
                              fontWeight: FontWeight.w500,
                            ),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 16),

              // Chart
              SizedBox(
                height: 120,
                child: LineChart(
                  LineChartData(
                    gridData: FlGridData(show: false),
                    titlesData: FlTitlesData(show: false),
                    borderData: FlBorderData(show: false),
                    lineBarsData: [
                      LineChartBarData(
                        spots: [
                          const FlSpot(0, 3),
                          const FlSpot(1, 2),
                          const FlSpot(2, 4),
                          const FlSpot(3, 1.5),
                          const FlSpot(4, 3.5),
                          const FlSpot(5, 2.5),
                          const FlSpot(6, 4.5),
                        ],
                        isCurved: true,
                        color: const Color(0xFF9e814e),
                        barWidth: 3,
                        isStrokeCapRound: true,
                        belowBarData: BarAreaData(
                          show: true,
                          color: const Color(0xFF9e814e).withAlpha(26),
                        ),
                        dotData: FlDotData(show: false),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 16),

              // Category breakdown
              Row(
                children: [
                  Expanded(
                    child: _buildCategoryItem(
                      context,
                      'Electronics',
                      65.2,
                      const Color(0xFF9e814e),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: _buildCategoryItem(
                      context,
                      'Fashion',
                      23.8,
                      const Color(0xFF2563eb),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: _buildCategoryItem(
                      context,
                      'Home',
                      11.0,
                      const Color(0xFF059669),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 16),

              // AI insight
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: const Color(0xFF9e814e).withAlpha(26),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  children: [
                    Container(
                      width: 32,
                      height: 32,
                      decoration: const BoxDecoration(
                        color: Color(0xFF9e814e),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.lightbulb,
                        color: Colors.white,
                        size: 16,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'AI Insight',
                            style: Theme.of(context)
                                .textTheme
                                .labelMedium
                                ?.copyWith(
                                  color: const Color(0xFF9e814e),
                                  fontWeight: FontWeight.w600,
                                ),
                          ),
                          Text(
                            'You\'re spending 23% less on electronics this month. Great job staying within your budget!',
                            style:
                                Theme.of(context).textTheme.bodySmall?.copyWith(
                                      color: const Color(0xFF9e814e),
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
        ),
      ],
    );
  }

  Widget _buildCategoryItem(
    BuildContext context,
    String category,
    double percentage,
    Color color,
  ) {
    return Column(
      children: [
        Container(
          width: 8,
          height: 8,
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          '${percentage.toStringAsFixed(1)}%',
          style: Theme.of(context).textTheme.labelSmall?.copyWith(
                fontWeight: FontWeight.w600,
              ),
        ),
        Text(
          category,
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: Colors.grey[600],
              ),
        ),
      ],
    );
  }
}
