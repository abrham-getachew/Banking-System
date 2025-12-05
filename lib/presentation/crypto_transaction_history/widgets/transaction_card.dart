import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sizer/sizer.dart';
import 'dart:ui';

import '../../../../core/app_export.dart';
import '../../../theme/app_theme.dart';
import '../../../widgets/custom_icon_widget.dart';

class TransactionCard extends StatefulWidget {
  final Map<String, dynamic> transaction;
  final VoidCallback? onTap;
  final Function(String)? onShare;
  final Function(String)? onExport;
  final Function(String)? onAddNote;
  final Function(String)? onReportIssue;

  const TransactionCard({
    super.key,
    required this.transaction,
    this.onTap,
    this.onShare,
    this.onExport,
    this.onAddNote,
    this.onReportIssue,
  });

  @override
  State<TransactionCard> createState() => _TransactionCardState();
}

class _TransactionCardState extends State<TransactionCard>
    with SingleTickerProviderStateMixin {
  bool _isExpanded = false;
  late AnimationController _animationController;
  late Animation<double> _expandAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    _expandAnimation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 4.w, vertical: 1.h),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
          child: Container(
            decoration: AppTheme.glassmorphicDecoration(borderRadius: 16),
            child: Column(
              children: [
                _buildMainContent(),
                AnimatedBuilder(
                  animation: _expandAnimation,
                  builder: (context, child) {
                    return SizeTransition(
                      sizeFactor: _expandAnimation,
                      child: child,
                    );
                  },
                  child: _buildExpandedContent(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildMainContent() {
    return GestureDetector(
      onTap: _toggleExpanded,
      child: Dismissible(
        key: Key(widget.transaction['id'].toString()),
        background: _buildSwipeBackground(isLeft: true),
        secondaryBackground: _buildSwipeBackground(isLeft: false),
        onDismissed: (direction) {
          if (direction == DismissDirection.startToEnd) {
            widget.onShare?.call(widget.transaction['id'].toString());
          } else {
            widget.onExport?.call(widget.transaction['id'].toString());
          }
        },
        child: Container(
          padding: EdgeInsets.all(4.w),
          child: Row(
            children: [
              _buildTransactionIcon(),
              SizedBox(width: 3.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildTransactionHeader(),
                    SizedBox(height: 0.5.h),
                    _buildTransactionDetails(),
                  ],
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  _buildAmount(),
                  SizedBox(height: 0.5.h),
                  _buildStatusBadge(),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSwipeBackground({required bool isLeft}) {
    return Container(
      color: isLeft
          ? AppTheme.infoBlue.withValues(alpha: 0.2)
          : AppTheme.successGreen.withValues(alpha: 0.2),
      child: Align(
        alignment: isLeft ? Alignment.centerLeft : Alignment.centerRight,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 6.w),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CustomIconWidget(
                iconName: isLeft ? 'share' : 'file_download',
                color: isLeft ? AppTheme.infoBlue : AppTheme.successGreen,
                size: 24,
              ),
              SizedBox(height: 0.5.h),
              Text(
                isLeft ? 'Share' : 'Export',
                style: AppTheme.darkTheme.textTheme.bodySmall?.copyWith(
                  color: isLeft ? AppTheme.infoBlue : AppTheme.successGreen,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTransactionIcon() {
    String iconName;
    Color iconColor;

    switch (widget.transaction['type'].toString().toLowerCase()) {
      case 'buy':
        iconName = 'trending_up';
        iconColor = AppTheme.successGreen;
        break;
      case 'sell':
        iconName = 'trending_down';
        iconColor = AppTheme.errorRed;
        break;
      case 'exchange':
        iconName = 'swap_horiz';
        iconColor = AppTheme.infoBlue;
        break;
      case 'withdraw':
        iconName = 'call_made';
        iconColor = AppTheme.warningAmber;
        break;
      default:
        iconName = 'account_balance_wallet';
        iconColor = AppTheme.primaryGold;
    }

    return Container(
      width: 12.w,
      height: 12.w,
      decoration: BoxDecoration(
        color: iconColor.withValues(alpha: 0.2),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Center(
        child: CustomIconWidget(
          iconName: iconName,
          color: iconColor,
          size: 24,
        ),
      ),
    );
  }

  Widget _buildTransactionHeader() {
    return Row(
      children: [
        Text(
          widget.transaction['type'].toString().toUpperCase(),
          style: AppTheme.darkTheme.textTheme.titleSmall?.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
        SizedBox(width: 2.w),
        Text(
          widget.transaction['tokenSymbol'] ?? '',
          style: AppTheme.darkTheme.textTheme.bodyMedium?.copyWith(
            color: AppTheme.primaryGold,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }

  Widget _buildTransactionDetails() {
    final DateTime timestamp = widget.transaction['timestamp'] as DateTime;
    final String timeAgo = _getTimeAgo(timestamp);

    return Text(
      timeAgo,
      style: AppTheme.darkTheme.textTheme.bodySmall?.copyWith(
        color: AppTheme.darkTheme.colorScheme.onSurface.withValues(alpha: 0.7),
      ),
    );
  }

  Widget _buildAmount() {
    final double amount = widget.transaction['amount'] as double;
    final String symbol = widget.transaction['tokenSymbol'] ?? '';
    final bool isPositive = widget.transaction['type'] == 'buy';

    return Text(
      '${isPositive ? '+' : '-'}${amount.toStringAsFixed(6)} $symbol',
      style: AppTheme.darkTheme.textTheme.titleSmall?.copyWith(
        color: isPositive ? AppTheme.successGreen : AppTheme.errorRed,
        fontWeight: FontWeight.w600,
      ),
    );
  }

  Widget _buildStatusBadge() {
    final String status = widget.transaction['status'] ?? 'pending';
    Color statusColor;

    switch (status.toLowerCase()) {
      case 'confirmed':
        statusColor = AppTheme.successGreen;
        break;
      case 'failed':
        statusColor = AppTheme.errorRed;
        break;
      case 'pending':
      default:
        statusColor = AppTheme.warningAmber;
    }

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 2.w, vertical: 0.5.h),
      decoration: BoxDecoration(
        color: statusColor.withValues(alpha: 0.2),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        status.toUpperCase(),
        style: AppTheme.darkTheme.textTheme.labelSmall?.copyWith(
          color: statusColor,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  Widget _buildExpandedContent() {
    return Container(
      padding: EdgeInsets.all(4.w),
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(
            color:
                AppTheme.darkTheme.colorScheme.outline.withValues(alpha: 0.2),
            width: 1,
          ),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildDetailRow(
              'Transaction Hash', widget.transaction['hash'] ?? 'N/A',
              showCopy: true),
          SizedBox(height: 2.h),
          _buildDetailRow('Gas Fee',
              '\$${(widget.transaction['gasFee'] ?? 0.0).toStringAsFixed(2)}'),
          SizedBox(height: 2.h),
          _buildDetailRow('Block Number',
              widget.transaction['blockNumber']?.toString() ?? 'N/A'),
          SizedBox(height: 2.h),
          _buildDetailRow(
              'Network', widget.transaction['network'] ?? 'Ethereum'),
          SizedBox(height: 3.h),
          _buildActionButtons(),
        ],
      ),
    );
  }

  Widget _buildDetailRow(String label, String value, {bool showCopy = false}) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 30.w,
          child: Text(
            label,
            style: AppTheme.darkTheme.textTheme.bodySmall?.copyWith(
              color: AppTheme.darkTheme.colorScheme.onSurface
                  .withValues(alpha: 0.7),
            ),
          ),
        ),
        Expanded(
          child: Row(
            children: [
              Expanded(
                child: Text(
                  value,
                  style: AppTheme.darkTheme.textTheme.bodySmall?.copyWith(
                    fontFamily: 'monospace',
                  ),
                ),
              ),
              if (showCopy) ...[
                SizedBox(width: 2.w),
                GestureDetector(
                  onTap: () => _copyToClipboard(value),
                  child: CustomIconWidget(
                    iconName: 'content_copy',
                    color: AppTheme.primaryGold,
                    size: 16,
                  ),
                ),
              ],
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildActionButtons() {
    return Row(
      children: [
        Expanded(
          child: TextButton.icon(
            onPressed: () =>
                widget.onAddNote?.call(widget.transaction['id'].toString()),
            icon: CustomIconWidget(
              iconName: 'note_add',
              color: AppTheme.primaryGold,
              size: 16,
            ),
            label: const Text('Add Note'),
          ),
        ),
        Expanded(
          child: TextButton.icon(
            onPressed: () =>
                widget.onReportIssue?.call(widget.transaction['id'].toString()),
            icon: CustomIconWidget(
              iconName: 'report_problem',
              color: AppTheme.errorRed,
              size: 16,
            ),
            label: Text(
              'Report',
              style: TextStyle(color: AppTheme.errorRed),
            ),
          ),
        ),
      ],
    );
  }

  void _toggleExpanded() {
    setState(() {
      _isExpanded = !_isExpanded;
      if (_isExpanded) {
        _animationController.forward();
      } else {
        _animationController.reverse();
      }
    });
  }

  void _copyToClipboard(String text) {
    Clipboard.setData(ClipboardData(text: text));
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text('Copied to clipboard'),
        backgroundColor: AppTheme.darkTheme.colorScheme.surface,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  String _getTimeAgo(DateTime timestamp) {
    final now = DateTime.now();
    final difference = now.difference(timestamp);

    if (difference.inDays > 0) {
      return '${difference.inDays}d ago';
    } else if (difference.inHours > 0) {
      return '${difference.inHours}h ago';
    } else if (difference.inMinutes > 0) {
      return '${difference.inMinutes}m ago';
    } else {
      return 'Just now';
    }
  }
}