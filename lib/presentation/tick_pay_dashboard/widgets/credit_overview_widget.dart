import 'package:flutter/material.dart';

class CreditOverviewWidget extends StatelessWidget {
  final double totalCreditLimit;
  final double usedCredit;
  final int creditScore;
  final double creditUtilization;

  const CreditOverviewWidget({
    Key? key,
    required this.totalCreditLimit,
    required this.usedCredit,
    required this.creditScore,
    required this.creditUtilization,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double availableCredit = totalCreditLimit - usedCredit;
    Color utilizationColor;
    String utilizationStatus;

    if (creditUtilization <= 30) {
      utilizationColor = const Color(0xFF00c851);
      utilizationStatus = 'Healthy';
    } else if (creditUtilization <= 70) {
      utilizationColor = const Color(0xFFff8800);
      utilizationStatus = 'Moderate';
    } else {
      utilizationColor = const Color(0xFFff4444);
      utilizationStatus = 'High Usage';
    }

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            const Color(0xFF9e814e),
            const Color(0xFF9e814e).withAlpha(204),
          ],
        ),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF9e814e).withAlpha(77),
            blurRadius: 12,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        children: [
          // Header
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Available Credit',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.white.withAlpha(51),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      width: 8,
                      height: 8,
                      decoration: BoxDecoration(
                        color: utilizationColor,
                        shape: BoxShape.circle,
                      ),
                    ),
                    const SizedBox(width: 6),
                    Text(
                      utilizationStatus,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),

          const SizedBox(height: 20),

          // Credit utilization circle
          Stack(
            alignment: Alignment.center,
            children: [
              SizedBox(
                width: 120,
                height: 120,
                child: CircularProgressIndicator(
                  value: creditUtilization / 100,
                  strokeWidth: 8,
                  backgroundColor: Colors.white.withAlpha(51),
                  valueColor: AlwaysStoppedAnimation<Color>(utilizationColor),
                ),
              ),
              Column(
                children: [
                  Text(
                    '\$${availableCredit.toStringAsFixed(0)}',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    'of \$${totalCreditLimit.toStringAsFixed(0)}',
                    style: TextStyle(
                      color: Colors.white.withAlpha(204),
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ],
          ),

          const SizedBox(height: 20),

          // Stats row
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildStatItem(
                'Used',
                '\$${usedCredit.toStringAsFixed(0)}',
                Icons.trending_up,
              ),
              Container(
                width: 1,
                height: 40,
                color: Colors.white.withAlpha(77),
              ),
              _buildStatItem(
                'Utilization',
                '${creditUtilization.toStringAsFixed(0)}%',
                Icons.pie_chart,
              ),
              Container(
                width: 1,
                height: 40,
                color: Colors.white.withAlpha(77),
              ),
              _buildStatItem(
                'Credit Score',
                creditScore.toString(),
                Icons.score,
                showTrend: true,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStatItem(
    String label,
    String value,
    IconData icon, {
    bool showTrend = false,
  }) {
    return Column(
      children: [
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              color: Colors.white.withAlpha(204),
              size: 16,
            ),
            if (showTrend) ...[
              const SizedBox(width: 4),
              const Icon(
                Icons.trending_up,
                color: Colors.green,
                size: 16,
              ),
            ],
          ],
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          label,
          style: TextStyle(
            color: Colors.white.withAlpha(204),
            fontSize: 12,
          ),
        ),
      ],
    );
  }
}
