import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../../core/app_export.dart';

class RecentTransactionsFeed extends StatefulWidget {
  const RecentTransactionsFeed({super.key});

  @override
  State<RecentTransactionsFeed> createState() => _RecentTransactionsFeedState();
}

class _RecentTransactionsFeedState extends State<RecentTransactionsFeed> {
  bool _isExpanded = false;

  final List<Map<String, dynamic>> transactions = [
    {
      "id": 1,
      "type": "buy",
      "symbol": "BTC",
      "name": "Bitcoin",
      "amount": "0.0234",
      "value": "\$1,573.45",
      "timestamp": "2 hours ago",
      "status": "completed",
      "gasUsed": "\$12.34",
      "hash": "0x1a2b3c4d5e6f...",
    },
    {
      "id": 2,
      "type": "sell",
      "symbol": "ETH",
      "name": "Ethereum",
      "amount": "1.2345",
      "value": "\$4,267.89",
      "timestamp": "5 hours ago",
      "status": "completed",
      "gasUsed": "\$8.76",
      "hash": "0x9f8e7d6c5b4a...",
    },
    {
      "id": 3,
      "type": "exchange",
      "symbol": "BNB",
      "name": "Binance Coin",
      "amount": "12.5678",
      "value": "\$6,789.12",
      "timestamp": "1 day ago",
      "status": "pending",
      "gasUsed": "\$5.43",
      "hash": "0x3c4d5e6f7a8b...",
    },
    {
      "id": 4,
      "type": "receive",
      "symbol": "ADA",
      "name": "Cardano",
      "amount": "2,345.67",
      "value": "\$1,061.36",
      "timestamp": "2 days ago",
      "status": "completed",
      "gasUsed": "\$2.10",
      "hash": "0x7a8b9c0d1e2f...",
    },
    {
      "id": 5,
      "type": "send",
      "symbol": "SOL",
      "name": "Solana",
      "amount": "45.678",
      "value": "\$4,509.87",
      "timestamp": "3 days ago",
      "status": "failed",
      "gasUsed": "\$15.67",
      "hash": "0x5e6f7a8b9c0d...",
    },
  ];

  @override
  Widget build(BuildContext context) {
    final displayTransactions =
        _isExpanded ? transactions : transactions.take(3).toList();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 4.w),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Recent Transactions',
                style: AppTheme.darkTheme.textTheme.titleLarge?.copyWith(
                  color: AppTheme.textPrimary,
                  fontWeight: FontWeight.w600,
                ),
              ),
              TextButton(
                onPressed: () =>
                    Navigator.pushNamed(context, '/crypto-transaction-history'),
                child: Text(
                  'View All',
                  style: AppTheme.darkTheme.textTheme.bodyMedium?.copyWith(
                    color: AppTheme.primaryGold,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 2.h),
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          padding: EdgeInsets.symmetric(horizontal: 4.w),
          itemCount: displayTransactions.length,
          itemBuilder: (context, index) {
            final transaction = displayTransactions[index];
            return _buildTransactionCard(transaction);
          },
        ),
        if (transactions.length > 3)
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 2.h),
            child: Center(
              child: TextButton(
                onPressed: () {
                  setState(() {
                    _isExpanded = !_isExpanded;
                  });
                },
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      _isExpanded ? 'Show Less' : 'Show More',
                      style: AppTheme.darkTheme.textTheme.bodyMedium?.copyWith(
                        color: AppTheme.primaryGold,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(width: 1.w),
                    CustomIconWidget(
                      iconName: _isExpanded ? 'expand_less' : 'expand_more',
                      color: AppTheme.primaryGold,
                      size: 4.w,
                    ),
                  ],
                ),
              ),
            ),
          ),
      ],
    );
  }

  Widget _buildTransactionCard(Map<String, dynamic> transaction) {
    return Container(
      margin: EdgeInsets.only(bottom: 2.h),
      child: ExpansionTile(
        tilePadding: EdgeInsets.all(4.w),
        childrenPadding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 2.h),
        backgroundColor: AppTheme.elevatedSurface.withValues(alpha: 0.8),
        collapsedBackgroundColor:
            AppTheme.elevatedSurface.withValues(alpha: 0.8),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(4.w),
          side: BorderSide(
            color: AppTheme.textPrimary.withValues(alpha: 0.1),
            width: 1,
          ),
        ),
        collapsedShape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(4.w),
          side: BorderSide(
            color: AppTheme.textPrimary.withValues(alpha: 0.1),
            width: 1,
          ),
        ),
        iconColor: AppTheme.primaryGold,
        collapsedIconColor: AppTheme.textSecondary,
        title: Row(
          children: [
            Container(
              width: 10.w,
              height: 10.w,
              decoration: BoxDecoration(
                color: _getTransactionTypeColor(transaction["type"] as String)
                    .withValues(alpha: 0.2),
                borderRadius: BorderRadius.circular(2.5.w),
              ),
              child: Center(
                child: CustomIconWidget(
                  iconName:
                      _getTransactionTypeIcon(transaction["type"] as String),
                  color:
                      _getTransactionTypeColor(transaction["type"] as String),
                  size: 5.w,
                ),
              ),
            ),
            SizedBox(width: 3.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '${_getTransactionTypeLabel(transaction["type"] as String)} ${transaction["symbol"]}',
                        style:
                            AppTheme.darkTheme.textTheme.titleSmall?.copyWith(
                          color: AppTheme.textPrimary,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Text(
                        transaction["value"] as String,
                        style:
                            AppTheme.darkTheme.textTheme.titleSmall?.copyWith(
                          color: AppTheme.textPrimary,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 0.5.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '${transaction["amount"]} ${transaction["symbol"]}',
                        style: AppTheme.darkTheme.textTheme.bodySmall?.copyWith(
                          color: AppTheme.textSecondary,
                        ),
                      ),
                      Row(
                        children: [
                          Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 2.w, vertical: 0.5.h),
                            decoration: BoxDecoration(
                              color: AppTheme.getStatusColor(
                                      transaction["status"] as String)
                                  .withValues(alpha: 0.2),
                              borderRadius: BorderRadius.circular(1.w),
                            ),
                            child: Text(
                              (transaction["status"] as String).toUpperCase(),
                              style: AppTheme.darkTheme.textTheme.labelSmall
                                  ?.copyWith(
                                color: AppTheme.getStatusColor(
                                    transaction["status"] as String),
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
        subtitle: Padding(
          padding: EdgeInsets.only(top: 1.h),
          child: Text(
            transaction["timestamp"] as String,
            style: AppTheme.darkTheme.textTheme.bodySmall?.copyWith(
              color: AppTheme.textSecondary,
            ),
          ),
        ),
        children: [
          Container(
            padding: EdgeInsets.all(3.w),
            decoration: BoxDecoration(
              color: AppTheme.deepCharcoal.withValues(alpha: 0.5),
              borderRadius: BorderRadius.circular(3.w),
            ),
            child: Column(
              children: [
                _buildDetailRow(
                    'Transaction Hash', transaction["hash"] as String),
                SizedBox(height: 1.h),
                _buildDetailRow('Gas Used', transaction["gasUsed"] as String),
                SizedBox(height: 1.h),
                _buildDetailRow('Network', 'Ethereum Mainnet'),
                SizedBox(height: 2.h),
                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton(
                        onPressed: () {},
                        style: OutlinedButton.styleFrom(
                          foregroundColor: AppTheme.infoBlue,
                          side: BorderSide(
                              color: AppTheme.infoBlue.withValues(alpha: 0.6)),
                          padding: EdgeInsets.symmetric(vertical: 2.h),
                        ),
                        child: Text(
                          'View on Explorer',
                          style:
                              AppTheme.darkTheme.textTheme.bodySmall?.copyWith(
                            color: AppTheme.infoBlue,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 3.w),
                    Expanded(
                      child: OutlinedButton(
                        onPressed: () {},
                        style: OutlinedButton.styleFrom(
                          foregroundColor: AppTheme.primaryGold,
                          side: BorderSide(
                              color:
                                  AppTheme.primaryGold.withValues(alpha: 0.6)),
                          padding: EdgeInsets.symmetric(vertical: 2.h),
                        ),
                        child: Text(
                          'Share Receipt',
                          style:
                              AppTheme.darkTheme.textTheme.bodySmall?.copyWith(
                            color: AppTheme.primaryGold,
                            fontWeight: FontWeight.w500,
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
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: AppTheme.darkTheme.textTheme.bodySmall?.copyWith(
            color: AppTheme.textSecondary,
          ),
        ),
        Expanded(
          child: Text(
            value,
            style: AppTheme.darkTheme.textTheme.bodySmall?.copyWith(
              color: AppTheme.textPrimary,
              fontWeight: FontWeight.w500,
            ),
            textAlign: TextAlign.end,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }

  String _getTransactionTypeIcon(String type) {
    switch (type) {
      case 'buy':
        return 'add_circle';
      case 'sell':
        return 'remove_circle';
      case 'exchange':
        return 'swap_horiz';
      case 'receive':
        return 'call_received';
      case 'send':
        return 'call_made';
      default:
        return 'account_balance_wallet';
    }
  }

  String _getTransactionTypeLabel(String type) {
    switch (type) {
      case 'buy':
        return 'Bought';
      case 'sell':
        return 'Sold';
      case 'exchange':
        return 'Exchanged';
      case 'receive':
        return 'Received';
      case 'send':
        return 'Sent';
      default:
        return 'Transaction';
    }
  }

  Color _getTransactionTypeColor(String type) {
    switch (type) {
      case 'buy':
      case 'receive':
        return AppTheme.successGreen;
      case 'sell':
      case 'send':
        return AppTheme.errorRed;
      case 'exchange':
        return AppTheme.primaryGold;
      default:
        return AppTheme.infoBlue;
    }
  }
}
