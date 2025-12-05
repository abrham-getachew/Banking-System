import 'package:flutter/material.dart';

class RecentTransactionsWidget extends StatelessWidget {
  final List<Map<String, dynamic>> transactions;

  const RecentTransactionsWidget({
    Key? key,
    required this.transactions,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Recent Transactions',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
            ),
            TextButton(
              onPressed: () {
                // Navigate to all transactions
              },
              child: const Text('View All'),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Container(
          decoration: BoxDecoration(
            color: Theme.of(context).cardColor,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: Colors.grey.withAlpha(51),
            ),
          ),
          child: Column(
            children: transactions.asMap().entries.map((entry) {
              final int index = entry.key;
              final Map<String, dynamic> transaction = entry.value;
              final bool isLast = index == transactions.length - 1;

              return _buildTransactionItem(context, transaction, isLast);
            }).toList(),
          ),
        ),
      ],
    );
  }

  Widget _buildTransactionItem(
    BuildContext context,
    Map<String, dynamic> transaction,
    bool isLast,
  ) {
    IconData icon;
    Color iconColor;
    String amountPrefix;

    switch (transaction['type']) {
      case 'payment':
        icon = Icons.check_circle;
        iconColor = const Color(0xFF00c851);
        amountPrefix = '-';
        break;
      case 'purchase':
        icon = Icons.shopping_bag;
        iconColor = const Color(0xFF9e814e);
        amountPrefix = '-';
        break;
      default:
        icon = Icons.account_balance_wallet;
        iconColor = Colors.grey;
        amountPrefix = '';
    }

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        border: !isLast
            ? Border(
                bottom: BorderSide(
                  color: Colors.grey.withAlpha(26),
                ),
              )
            : null,
      ),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: iconColor.withAlpha(26),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(
              icon,
              color: iconColor,
              size: 20,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  transaction['merchant'],
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                ),
                Row(
                  children: [
                    Text(
                      _formatDate(transaction['date']),
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: Colors.grey[600],
                          ),
                    ),
                    const SizedBox(width: 8),
                    Container(
                      width: 4,
                      height: 4,
                      decoration: BoxDecoration(
                        color: Colors.grey[400],
                        shape: BoxShape.circle,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      transaction['paymentMethod'],
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: Colors.grey[600],
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
              Text(
                '$amountPrefix\$${transaction['amount'].toStringAsFixed(2)}',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                      color: transaction['type'] == 'payment'
                          ? const Color(0xFF00c851)
                          : null,
                    ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                decoration: BoxDecoration(
                  color: _getStatusColor(transaction['status']).withAlpha(26),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Text(
                  transaction['status'].toString().toUpperCase(),
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: _getStatusColor(transaction['status']),
                        fontWeight: FontWeight.w600,
                        fontSize: 10,
                      ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  String _formatDate(DateTime date) {
    final now = DateTime.now();
    final difference = now.difference(date).inDays;

    if (difference == 0) {
      return 'Today';
    } else if (difference == 1) {
      return 'Yesterday';
    } else if (difference < 7) {
      return '$difference days ago';
    } else {
      return '${date.month}/${date.day}/${date.year}';
    }
  }

  Color _getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'completed':
        return const Color(0xFF00c851);
      case 'pending':
        return const Color(0xFFff8800);
      case 'failed':
        return const Color(0xFFff4444);
      default:
        return Colors.grey;
    }
  }
}
