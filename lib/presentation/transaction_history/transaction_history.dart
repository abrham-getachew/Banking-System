import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../core/app_export.dart';
import './widgets/date_section_header_widget.dart';
import './widgets/filter_chip_widget.dart';
import './widgets/transaction_filter_modal.dart';
import './widgets/transaction_item_widget.dart';

class TransactionHistory extends StatefulWidget {
  const TransactionHistory({super.key});

  @override
  State<TransactionHistory> createState() => _TransactionHistoryState();
}

class _TransactionHistoryState extends State<TransactionHistory>
    with TickerProviderStateMixin {
  final TextEditingController _searchController = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  bool _isLoading = false;
  bool _isSearching = false;
  List<String> _activeFilters = [];
  String _searchQuery = '';

  // Mock transaction data
  final List<Map<String, dynamic>> _allTransactions = [
    {
      "id": "txn_001",
      "merchant": "Starbucks Coffee",
      "category": "Food & Dining",
      "categoryIcon": "local_cafe",
      "amount": -12.50,
      "currency": "USD",
      "timestamp": DateTime.now().subtract(Duration(hours: 2)),
      "description": "Coffee and pastry",
      "location": "123 Main St, New York",
      "status": "completed",
      "type": "expense"
    },
    {
      "id": "txn_002",
      "merchant": "Salary Deposit",
      "category": "Income",
      "categoryIcon": "account_balance_wallet",
      "amount": 3500.00,
      "currency": "USD",
      "timestamp": DateTime.now().subtract(Duration(days: 1)),
      "description": "Monthly salary payment",
      "location": "Direct Deposit",
      "status": "completed",
      "type": "income"
    },
    {
      "id": "txn_003",
      "merchant": "Amazon",
      "category": "Shopping",
      "categoryIcon": "shopping_bag",
      "amount": -89.99,
      "currency": "USD",
      "timestamp": DateTime.now().subtract(Duration(days: 1, hours: 5)),
      "description": "Electronics purchase",
      "location": "Online",
      "status": "completed",
      "type": "expense"
    },
    {
      "id": "txn_004",
      "merchant": "Uber",
      "category": "Transportation",
      "categoryIcon": "directions_car",
      "amount": -18.75,
      "currency": "USD",
      "timestamp": DateTime.now().subtract(Duration(days: 2)),
      "description": "Ride to downtown",
      "location": "456 Oak Ave, New York",
      "status": "completed",
      "type": "expense"
    },
    {
      "id": "txn_005",
      "merchant": "Netflix",
      "category": "Entertainment",
      "categoryIcon": "movie",
      "amount": -15.99,
      "currency": "USD",
      "timestamp": DateTime.now().subtract(Duration(days: 3)),
      "description": "Monthly subscription",
      "location": "Online",
      "status": "completed",
      "type": "expense"
    },
    {
      "id": "txn_006",
      "merchant": "Freelance Payment",
      "category": "Income",
      "categoryIcon": "work",
      "amount": 750.00,
      "currency": "USD",
      "timestamp": DateTime.now().subtract(Duration(days: 4)),
      "description": "Web development project",
      "location": "Bank Transfer",
      "status": "completed",
      "type": "income"
    },
    {
      "id": "txn_007",
      "merchant": "Whole Foods",
      "category": "Groceries",
      "categoryIcon": "local_grocery_store",
      "amount": -67.43,
      "currency": "USD",
      "timestamp": DateTime.now().subtract(Duration(days: 5)),
      "description": "Weekly grocery shopping",
      "location": "789 Pine St, New York",
      "status": "completed",
      "type": "expense"
    },
    {
      "id": "txn_008",
      "merchant": "Apple Store",
      "category": "Technology",
      "categoryIcon": "phone_iphone",
      "amount": -299.99,
      "currency": "USD",
      "timestamp": DateTime.now().subtract(Duration(days: 6)),
      "description": "AirPods Pro purchase",
      "location": "Apple Store 5th Ave",
      "status": "completed",
      "type": "expense"
    }
  ];

  List<Map<String, dynamic>> _filteredTransactions = [];
  Map<String, List<Map<String, dynamic>>> _groupedTransactions = {};

  @override
  void initState() {
    super.initState();
    _filteredTransactions = List.from(_allTransactions);
    _groupTransactionsByDate();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _searchController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent - 200) {
      _loadMoreTransactions();
    }
  }

  void _loadMoreTransactions() {
    if (!_isLoading) {
      setState(() {
        _isLoading = true;
      });

      // Simulate loading more transactions
      Future.delayed(Duration(seconds: 1), () {
        if (mounted) {
          setState(() {
            _isLoading = false;
          });
        }
      });
    }
  }

  void _groupTransactionsByDate() {
    _groupedTransactions.clear();

    for (var transaction in _filteredTransactions) {
      final date = transaction['timestamp'] as DateTime;
      final dateKey = _formatDateKey(date);

      if (!_groupedTransactions.containsKey(dateKey)) {
        _groupedTransactions[dateKey] = [];
      }
      _groupedTransactions[dateKey]!.add(transaction);
    }

    // Sort each group by timestamp (newest first)
    _groupedTransactions.forEach((key, transactions) {
      transactions.sort((a, b) =>
          (b['timestamp'] as DateTime).compareTo(a['timestamp'] as DateTime));
    });
  }

  String _formatDateKey(DateTime date) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final yesterday = today.subtract(Duration(days: 1));
    final transactionDate = DateTime(date.year, date.month, date.day);

    if (transactionDate == today) {
      return 'Today';
    } else if (transactionDate == yesterday) {
      return 'Yesterday';
    } else {
      return '${date.day}/${date.month}/${date.year}';
    }
  }

  void _onSearchChanged(String query) {
    setState(() {
      _searchQuery = query;
      _filterTransactions();
    });
  }

  void _filterTransactions() {
    _filteredTransactions = _allTransactions.where((transaction) {
      final merchant = (transaction['merchant'] as String).toLowerCase();
      final description = (transaction['description'] as String).toLowerCase();
      final category = (transaction['category'] as String).toLowerCase();
      final searchLower = _searchQuery.toLowerCase();

      bool matchesSearch = _searchQuery.isEmpty ||
          merchant.contains(searchLower) ||
          description.contains(searchLower) ||
          category.contains(searchLower);

      return matchesSearch;
    }).toList();

    _groupTransactionsByDate();
  }

  void _removeFilter(String filter) {
    setState(() {
      _activeFilters.remove(filter);
      _filterTransactions();
    });
  }

  void _showFilterModal() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => TransactionFilterModal(
        onFiltersApplied: (filters) {
          setState(() {
            _activeFilters = filters;
            _filterTransactions();
          });
        },
        currentFilters: _activeFilters,
      ),
    );
  }

  Future<void> _onRefresh() async {
    setState(() {
      _isLoading = true;
    });

    // Simulate refresh
    await Future.delayed(Duration(seconds: 1));

    setState(() {
      _isLoading = false;
      _filteredTransactions = List.from(_allTransactions);
      _groupTransactionsByDate();
    });
  }

  void _onTransactionTap(Map<String, dynamic> transaction) {
    // Navigate to transaction detail screen
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => _buildTransactionDetailModal(transaction),
    );
  }

  Widget _buildTransactionDetailModal(Map<String, dynamic> transaction) {
    return Container(
      height: 80.h,
      decoration: BoxDecoration(
        color: AppTheme.darkTheme.colorScheme.surface,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Column(
        children: [
          // Handle bar
          Container(
            width: 12.w,
            height: 0.5.h,
            margin: EdgeInsets.symmetric(vertical: 2.h),
            decoration: BoxDecoration(
              color: AppTheme.textSecondary,
              borderRadius: BorderRadius.circular(2),
            ),
          ),

          // Header
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 4.w),
            child: Row(
              children: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: Text(
                    'Close',
                    style: TextStyle(
                      color: AppTheme.accentGold,
                      fontSize: 14.sp,
                    ),
                  ),
                ),
                Spacer(),
                Text(
                  'Transaction Details',
                  style: TextStyle(
                    color: AppTheme.textPrimary,
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Spacer(),
                SizedBox(width: 15.w),
              ],
            ),
          ),

          Divider(color: AppTheme.borderGray),

          // Transaction details
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.all(4.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Amount and status
                  Center(
                    child: Column(
                      children: [
                        Text(
                          '${transaction['amount'] > 0 ? '+' : ''}\$${transaction['amount'].abs().toStringAsFixed(2)}',
                          style: TextStyle(
                            color: transaction['amount'] > 0
                                ? AppTheme.successGreen
                                : AppTheme.errorRed,
                            fontSize: 24.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 1.h),
                        Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: 3.w, vertical: 1.h),
                          decoration: BoxDecoration(
                            color: AppTheme.successGreen.withValues(alpha: 0.2),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Text(
                            'Completed',
                            style: TextStyle(
                              color: AppTheme.successGreen,
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  SizedBox(height: 4.h),

                  // Transaction info
                  _buildDetailRow('Merchant', transaction['merchant']),
                  _buildDetailRow('Category', transaction['category']),
                  _buildDetailRow('Description', transaction['description']),
                  _buildDetailRow('Location', transaction['location']),
                  _buildDetailRow(
                      'Date', _formatTransactionDate(transaction['timestamp'])),
                  _buildDetailRow('Transaction ID', transaction['id']),

                  SizedBox(height: 4.h),

                  // Action buttons
                  Row(
                    children: [
                      Expanded(
                        child: OutlinedButton(
                          onPressed: () {
                            // Share transaction
                          },
                          child: Text('Share'),
                        ),
                      ),
                      SizedBox(width: 4.w),
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {
                            // Dispute transaction
                          },
                          child: Text('Dispute'),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 1.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 25.w,
            child: Text(
              label,
              style: TextStyle(
                color: AppTheme.textSecondary,
                fontSize: 14.sp,
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: TextStyle(
                color: AppTheme.textPrimary,
                fontSize: 14.sp,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }

  String _formatTransactionDate(DateTime date) {
    return '${date.day}/${date.month}/${date.year} at ${date.hour.toString().padLeft(2, '0')}:${date.minute.toString().padLeft(2, '0')}';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.darkTheme.scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: AppTheme.darkTheme.scaffoldBackgroundColor,
        elevation: 0,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: CustomIconWidget(
            iconName: 'arrow_back',
            color: AppTheme.textPrimary,
            size: 24,
          ),
        ),
        title: Text(
          'Transactions',
          style: TextStyle(
            color: AppTheme.textPrimary,
            fontSize: 18.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              setState(() {
                _isSearching = !_isSearching;
                if (!_isSearching) {
                  _searchController.clear();
                  _searchQuery = '';
                  _filterTransactions();
                }
              });
            },
            icon: CustomIconWidget(
              iconName: _isSearching ? 'close' : 'search',
              color: AppTheme.textPrimary,
              size: 24,
            ),
          ),
          IconButton(
            onPressed: _showFilterModal,
            icon: CustomIconWidget(
              iconName: 'filter_list',
              color: AppTheme.accentGold,
              size: 24,
            ),
          ),
          SizedBox(width: 2.w),
        ],
      ),
      body: Column(
        children: [
          // Search bar
          if (_isSearching)
            Container(
              margin: EdgeInsets.symmetric(horizontal: 4.w, vertical: 1.h),
              child: TextField(
                controller: _searchController,
                onChanged: _onSearchChanged,
                autofocus: true,
                style: TextStyle(color: AppTheme.textPrimary),
                decoration: InputDecoration(
                  hintText: 'Search transactions...',
                  hintStyle: TextStyle(color: AppTheme.textSecondary),
                  prefixIcon: CustomIconWidget(
                    iconName: 'search',
                    color: AppTheme.textSecondary,
                    size: 20,
                  ),
                  filled: true,
                  fillColor: AppTheme.secondaryDark,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 4.w, vertical: 2.h),
                ),
              ),
            ),

          // Active filters
          if (_activeFilters.isNotEmpty)
            Container(
              height: 6.h,
              margin: EdgeInsets.symmetric(horizontal: 4.w),
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: _activeFilters.length,
                itemBuilder: (context, index) {
                  return FilterChipWidget(
                    label: _activeFilters[index],
                    onRemove: () => _removeFilter(_activeFilters[index]),
                  );
                },
              ),
            ),

          // Transaction list
          Expanded(
            child: _filteredTransactions.isEmpty
                ? _buildEmptyState()
                : RefreshIndicator(
                    onRefresh: _onRefresh,
                    color: AppTheme.accentGold,
                    backgroundColor: AppTheme.secondaryDark,
                    child: ListView.builder(
                      controller: _scrollController,
                      padding: EdgeInsets.symmetric(horizontal: 4.w),
                      itemCount: _groupedTransactions.keys.length +
                          (_isLoading ? 1 : 0),
                      itemBuilder: (context, index) {
                        if (index == _groupedTransactions.keys.length) {
                          return _buildLoadingIndicator();
                        }

                        final dateKey =
                            _groupedTransactions.keys.elementAt(index);
                        final transactions = _groupedTransactions[dateKey]!;

                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            DateSectionHeaderWidget(dateKey: dateKey),
                            ...transactions
                                .map(
                                  (transaction) => TransactionItemWidget(
                                    transaction: transaction,
                                    onTap: () => _onTransactionTap(transaction),
                                  ),
                                )
                                .toList(),
                            SizedBox(height: 2.h),
                          ],
                        );
                      },
                    ),
                  ),
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CustomIconWidget(
            iconName: 'receipt_long',
            color: AppTheme.textSecondary,
            size: 64,
          ),
          SizedBox(height: 2.h),
          Text(
            'No transactions found',
            style: TextStyle(
              color: AppTheme.textPrimary,
              fontSize: 18.sp,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: 1.h),
          Text(
            'Try adjusting your search or filters',
            style: TextStyle(
              color: AppTheme.textSecondary,
              fontSize: 14.sp,
            ),
          ),
          SizedBox(height: 3.h),
          if (_activeFilters.isNotEmpty || _searchQuery.isNotEmpty)
            TextButton(
              onPressed: () {
                setState(() {
                  _activeFilters.clear();
                  _searchQuery = '';
                  _searchController.clear();
                  _filterTransactions();
                });
              },
              child: Text(
                'Clear filters',
                style: TextStyle(
                  color: AppTheme.accentGold,
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildLoadingIndicator() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 2.h),
      child: Center(
        child: CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation<Color>(AppTheme.accentGold),
        ),
      ),
    );
  }
}
