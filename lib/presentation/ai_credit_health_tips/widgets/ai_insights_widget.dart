import 'package:flutter/material.dart';

class AiInsightsWidget extends StatelessWidget {
  final List<Map<String, dynamic>> insights;
  final Function(Map<String, dynamic>) onApplySuggestion;

  const AiInsightsWidget({
    Key? key,
    required this.insights,
    required this.onApplySuggestion,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            const Icon(
              Icons.lightbulb_outlined,
              color: Color(0xFF9e814e),
              size: 24,
            ),
            const SizedBox(width: 8),
            Text(
              'AI-Powered Insights',
              style: Theme.of(context).textTheme.titleLarge,
            ),
          ],
        ),
        const SizedBox(height: 4),
        Text(
          'Personalized recommendations to improve your credit profile',
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: Colors.grey[600],
              ),
        ),
        const SizedBox(height: 16),
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: insights.length,
          itemBuilder: (context, index) {
            final insight = insights[index];
            return _buildInsightCard(context, insight);
          },
        ),
      ],
    );
  }

  Widget _buildInsightCard(BuildContext context, Map<String, dynamic> insight) {
    final impactColor = _getImpactColor(insight['impact']);

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: impactColor.withAlpha(77),
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha(13),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header with icon and impact
            Row(
              children: [
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: impactColor.withAlpha(26),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(
                    _getInsightIcon(insight['type']),
                    color: impactColor,
                    size: 20,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        insight['title'],
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      const SizedBox(height: 2),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 2,
                        ),
                        decoration: BoxDecoration(
                          color: impactColor.withAlpha(26),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          '${insight['impact']} Impact',
                          style: TextStyle(
                            color: impactColor,
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),

            const SizedBox(height: 12),

            // Description
            Text(
              insight['description'],
              style: Theme.of(context).textTheme.bodyMedium,
            ),

            const SizedBox(height: 12),

            // Potential impact section
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: impactColor.withAlpha(13),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(
                  color: impactColor.withAlpha(51),
                  width: 1,
                ),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.trending_up,
                    color: impactColor,
                    size: 16,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    'Potential Score Improvement: ',
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                  Text(
                    '+${insight['scoreImprovement']} points',
                    style: TextStyle(
                      color: impactColor,
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 16),

            // Action button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: () => onApplySuggestion(insight),
                style: ElevatedButton.styleFrom(
                  backgroundColor: impactColor,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                icon: const Icon(Icons.arrow_forward, size: 16),
                label: const Text(
                  'Apply Suggestion',
                  style: TextStyle(fontWeight: FontWeight.w600),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Color _getImpactColor(String impact) {
    switch (impact.toLowerCase()) {
      case 'high':
        return const Color(0xFF00c851);
      case 'medium':
        return const Color(0xFF4285f4);
      case 'low':
        return const Color(0xFFff8800);
      default:
        return const Color(0xFF9e814e);
    }
  }

  IconData _getInsightIcon(String type) {
    switch (type.toLowerCase()) {
      case 'payment':
        return Icons.payment;
      case 'utilization':
        return Icons.pie_chart;
      case 'spending':
        return Icons.trending_down;
      case 'credit_mix':
        return Icons.account_balance;
      default:
        return Icons.insights;
    }
  }
}
