
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../core/app_export.dart';
import './widgets/empty_state_widget.dart';
import './widgets/export_options_bottom_sheet.dart';
import './widgets/loading_skeleton_widget.dart';
import './widgets/search_bar_widget.dart';
import './widgets/transaction_card.dart';
import './widgets/transaction_filter_bottom_sheet.dart';

class CryptoTransactionHistory extends StatefulWidget {
  const CryptoTransactionHistory({super.key});

  @override
  State<CryptoTransactionHistory> createState() =>
      _CryptoTransactionHistoryState();
}

class _CryptoTransactionHistoryState extends State<CryptoTransactionHistory> {
  final ScrollController _scrollController = ScrollController();
  final TextEditingController _searchController = TextEditingController();

  List<Map<String, dynamic>> _allTransactions = [];
  List<Map<String, dynamic>> _filteredTransactions = [];
  Map<String, dynamic> _currentFilters = {
    'transactionType': 'All',
    'status': 'All',
    'token': 'All',
    'dateRange': null,
  };

  String _searchQuery = '';
  bool _isLoading = true;
  bool _isLoadingMore = false;
  bool _hasMoreData = true;
  bool _isOffline = false;

  @override
  void initState() {
    super.initState();
    _initializeData();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  void _initializeData() {
    // Mock transaction data
    _allTransactions = [
      {
        "id": 1,
        "type": "buy",
        "tokenSymbol": "BTC",
        "amount": 0.025000,
        "status": "confirmed",
        "timestamp": DateTime.now().subtract(const Duration(hours: 2)),
        "hash":
            "0x1a2b3c4d5e6f7890abcdef1234567890abcdef1234567890abcdef1234567890",
        "gasFee": 15.50,
        "blockNumber": 18456789,
        "network": "Bitcoin",
        "usdValue": 1250.00,
      },
      {
        "id": 2,
        "type": "sell",
        "tokenSymbol": "ETH",
        "amount": 1.500000,
        "status": "pending",
        "timestamp": DateTime.now().subtract(const Duration(hours: 5)),
        "hash":
            "0x2b3c4d5e6f7890abcdef1234567890abcdef1234567890abcdef1234567890ab",
        "gasFee": 8.25,
        "blockNumber": 18456788,
        "network": "Ethereum",
        "usdValue": 3750.00,
      },
      {
        "id": 3,
        "type": "exchange",
        "tokenSymbol": "ADA",
        "amount": 500.000000,
        "status": "confirmed",
        "timestamp": DateTime.now().subtract(const Duration(days: 1)),
        "hash":
            "0x3c4d5e6f7890abcdef1234567890abcdef1234567890abcdef1234567890abcd",
        "gasFee": 2.10,
        "blockNumber": 18456787,
        "network": "Cardano",
        "usdValue": 200.00,
      },
      {
        "id": 4,
        "type": "withdraw",
        "tokenSymbol": "SOL",
        "amount": 10.000000,
        "status": "failed",
        "timestamp": DateTime.now().subtract(const Duration(days: 2)),
        "hash":
            "0x4d5e6f7890abcdef1234567890abcdef1234567890abcdef1234567890abcdef",
        "gasFee": 0.50,
        "blockNumber": 18456786,
        "network": "Solana",
        "usdValue": 800.00,
      },
      {
        "id": 5,
        "type": "buy",
        "tokenSymbol": "MATIC",
        "amount": 1000.000000,
        "status": "confirmed",
        "timestamp": DateTime.now().subtract(const Duration(days: 3)),
        "hash":
            "0x5e6f7890abcdef1234567890abcdef1234567890abcdef1234567890abcdef12",
        "gasFee": 1.25,
        "blockNumber": 18456785,
        "network": "Polygon",
        "usdValue": 750.00,
      },
      {
        "id": 6,
        "type": "sell",
        "tokenSymbol": "BTC",
        "amount": 0.010000,
        "status": "confirmed",
        "timestamp": DateTime.now().subtract(const Duration(days: 4)),
        "hash":
            "0x6f7890abcdef1234567890abcdef1234567890abcdef1234567890abcdef1234",
        "gasFee": 12.75,
        "blockNumber": 18456784,
        "network": "Bitcoin",
        "usdValue": 500.00,
      },
      {
        "id": 7,
        "type": "exchange",
        "tokenSymbol": "ETH",
        "amount": 0.750000,
        "status": "pending",
        "timestamp": DateTime.now().subtract(const Duration(days: 5)),
        "hash":
            "0x7890abcdef1234567890abcdef1234567890abcdef1234567890abcdef123456",
        "gasFee": 6.80,
        "blockNumber": 18456783,
        "network": "Ethereum",
        "usdValue": 1875.00,
      },
      {
        "id": 8,
        "type": "buy",
        "tokenSymbol": "ADA",
        "amount": 250.000000,
        "status": "confirmed",
        "timestamp": DateTime.now().subtract(const Duration(days: 6)),
        "hash":
            "0x890abcdef1234567890abcdef1234567890abcdef1234567890abcdef1234567",
        "gasFee": 1.50,
        "blockNumber": 18456782,
        "network": "Cardano",
        "usdValue": 100.00,
      },
    ];

    // Simulate loading delay
    Future.delayed(const Duration(seconds: 2), () {
      if (mounted) {
        setState(() {
          _isLoading = false;
          _filteredTransactions = List.from(_allTransactions);
        });
      }
    });
  }

  void _onScroll() {
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent - 200) {
      if (!_isLoadingMore && _hasMoreData) {
        _loadMoreTransactions();
      }
    }
  }

  Future<void> _loadMoreTransactions() async {
    setState(() {
      _isLoadingMore = true;
    });

    // Simulate loading more data
    await Future.delayed(const Duration(seconds: 1));

    if (mounted) {
      setState(() {
        _isLoadingMore = false;
        // For demo purposes, we'll just mark as no more data
        _hasMoreData = false;
      });
    }
  }

  Future<void> _refreshTransactions() async {
    setState(() {
      _isLoading = true;
    });

    // Simulate refresh
    await Future.delayed(const Duration(seconds: 1));

    if (mounted) {
      setState(() {
        _isLoading = false;
        _hasMoreData = true;
      });
    }
  }

  void _onSearchChanged(String query) {
    setState(() {
      _searchQuery = query;
      _applyFilters();
    });
  }

  void _onFiltersApplied(Map<String, dynamic> filters) {
    setState(() {
      _currentFilters = filters;
      _applyFilters();
    });
  }

  void _applyFilters() {
    List<Map<String, dynamic>> filtered = List.from(_allTransactions);

    // Apply search filter
    if (_searchQuery.isNotEmpty) {
      filtered = filtered.where((transaction) {
        final searchLower = _searchQuery.toLowerCase();
        return transaction['tokenSymbol']
                .toString()
                .toLowerCase()
                .contains(searchLower) ||
            transaction['type']
                .toString()
                .toLowerCase()
                .contains(searchLower) ||
            transaction['hash']
                .toString()
                .toLowerCase()
                .contains(searchLower) ||
            transaction['amount'].toString().contains(searchLower);
      }).toList();
    }

    // Apply transaction type filter
    if (_currentFilters['transactionType'] != 'All') {
      filtered = filtered
          .where((transaction) =>
              transaction['type'].toString().toLowerCase() ==
              _currentFilters['transactionType'].toString().toLowerCase())
          .toList();
    }

    // Apply status filter
    if (_currentFilters['status'] != 'All') {
      filtered = filtered
          .where((transaction) =>
              transaction['status'].toString().toLowerCase() ==
              _currentFilters['status'].toString().toLowerCase())
          .toList();
    }

    // Apply token filter
    if (_currentFilters['token'] != 'All') {
      filtered = filtered
          .where((transaction) =>
              transaction['tokenSymbol'].toString() == _currentFilters['token'])
          .toList();
    }

    // Apply date range filter
    if (_currentFilters['dateRange'] != null) {
      final DateTimeRange dateRange =
          _currentFilters['dateRange'] as DateTimeRange;
      filtered = filtered.where((transaction) {
        final timestamp = transaction['timestamp'] as DateTime;
        return timestamp.isAfter(dateRange.start) &&
            timestamp.isBefore(dateRange.end.add(const Duration(days: 1)));
      }).toList();
    }

    setState(() {
      _filteredTransactions = filtered;
    });
  }

  void _showFilterBottomSheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => TransactionFilterBottomSheet(
        onFiltersApplied: _onFiltersApplied,
        currentFilters: _currentFilters,
      ),
    );
  }

  void _showExportBottomSheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => ExportOptionsBottomSheet(
        transactions: _filteredTransactions,
        dateRange: _currentFilters['dateRange'] as DateTimeRange?,
      ),
    );
  }

  void _onTransactionShare(String transactionId) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Sharing transaction $transactionId'),
        backgroundColor: AppTheme.infoBlue,
      ),
    );
  }

  void _onTransactionExport(String transactionId) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Exporting transaction $transactionId'),
        backgroundColor: AppTheme.successGreen,
      ),
    );
  }

  void _onAddNote(String transactionId) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Adding note to transaction $transactionId'),
        backgroundColor: AppTheme.primaryGold,
      ),
    );
  }

  void _onReportIssue(String transactionId) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Reporting issue for transaction $transactionId'),
        backgroundColor: AppTheme.errorRed,
      ),
    );
  }

  void _onStartTrading() {
    Navigator.pushNamed(context, '/crypto-trading-dashboard');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.darkTheme.scaffoldBackgroundColor,
      body: SafeArea(
        child: Column(
          children: [
            _buildStickyHeader(),
            Expanded(
              child: _buildBody(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStickyHeader() {
    return Container(
      decoration: BoxDecoration(
        color: AppTheme.darkTheme.scaffoldBackgroundColor,
        boxShadow: [
          BoxShadow(
            color: AppTheme.darkTheme.colorScheme.shadow,
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          _buildAppBar(),
          SearchBarWidget(
            onSearchChanged: _onSearchChanged,
            onFilterTap: _showFilterBottomSheet,
            hintText: 'Search by token, amount, or hash...',
          ),
          if (_isOffline) _buildOfflineIndicator(),
        ],
      ),
    );
  }

  Widget _buildAppBar() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 2.h),
      child: Row(
        children: [
          GestureDetector(
            onTap: () => Navigator.pop(context),
            child: Container(
              width: 10.w,
              height: 10.w,
              decoration: BoxDecoration(
                color: AppTheme.darkTheme.colorScheme.surface
                    .withValues(alpha: 0.3),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Center(
                child: CustomIconWidget(
                  iconName: 'arrow_back',
                  color: AppTheme.darkTheme.colorScheme.onSurface,
                  size: 20,
                ),
              ),
            ),
          ),
          SizedBox(width: 4.w),
          Expanded(
            child: Text(
              'Transaction History',
              style: AppTheme.darkTheme.textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          GestureDetector(
            onTap: _showExportBottomSheet,
            child: Container(
              width: 10.w,
              height: 10.w,
              decoration: BoxDecoration(
                color: AppTheme.primaryGold.withValues(alpha: 0.2),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Center(
                child: CustomIconWidget(
                  iconName: 'file_download',
                  color: AppTheme.primaryGold,
                  size: 20,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildOfflineIndicator() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(vertical: 1.h),
      color: AppTheme.warningAmber.withValues(alpha: 0.2),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CustomIconWidget(
            iconName: 'wifi_off',
            color: AppTheme.warningAmber,
            size: 16,
          ),
          SizedBox(width: 2.w),
          Text(
            'Offline - Showing cached transactions',
            style: AppTheme.darkTheme.textTheme.bodySmall?.copyWith(
              color: AppTheme.warningAmber,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBody() {
    if (_isLoading) {
      return const LoadingSkeletonWidget();
    }

    if (_filteredTransactions.isEmpty) {
      return EmptyStateWidget(
        onStartTrading: _onStartTrading,
      );
    }

    return RefreshIndicator(
      onRefresh: _refreshTransactions,
      color: AppTheme.primaryGold,
      backgroundColor: AppTheme.darkTheme.colorScheme.surface,
      child: ListView.builder(
        controller: _scrollController,
        padding: EdgeInsets.symmetric(vertical: 2.h),
        itemCount: _filteredTransactions.length + (_isLoadingMore ? 1 : 0),
        itemBuilder: (context, index) {
          if (index == _filteredTransactions.length) {
            return _buildLoadingMoreIndicator();
          }

          final transaction = _filteredTransactions[index];
          return TransactionCard(
            transaction: transaction,
            onShare: _onTransactionShare,
            onExport: _onTransactionExport,
            onAddNote: _onAddNote,
            onReportIssue: _onReportIssue,
          );
        },
      ),
    );
  }

  Widget _buildLoadingMoreIndicator() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 2.h),
      child: Center(
        child: CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation<Color>(AppTheme.primaryGold),
        ),
      ),
    );
  }
}
