import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import './widgets/active_plans_widget.dart';
import './widgets/credit_overview_widget.dart';
import './widgets/quick_actions_widget.dart';
import './widgets/recent_transactions_widget.dart';
import './widgets/spending_insights_widget.dart';

class TickPayDashboard extends StatefulWidget {
  const TickPayDashboard({Key? key}) : super(key: key);

  @override
  State<TickPayDashboard> createState() => _TickPayDashboardState();
}

class _TickPayDashboardState extends State<TickPayDashboard>
    with TickerProviderStateMixin {
  late AnimationController _refreshController;
  late AnimationController _fabController;

  // Mock data
  final double _totalCreditLimit = 5000.0;
  final double _usedCredit = 2350.0;
  final int _creditScore = 742;

  final List<Map<String, dynamic>> _activePlans = [
    {
      'id': 'tp_001',
      'merchant': 'TechMart Electronics',
      'merchantIcon': Icons.computer,
      'purchaseAmount': 1299.99,
      'remainingBalance': 866.66,
      'nextPaymentDate': DateTime.now().add(const Duration(days: 15)),
      'totalInstallments': 3,
      'completedInstallments': 1,
      'status': 'active',
    },
    {
      'id': 'tp_002',
      'merchant': 'Fashion Forward',
      'merchantIcon': Icons.shopping_bag,
      'purchaseAmount': 450.00,
      'remainingBalance': 225.00,
      'nextPaymentDate': DateTime.now().add(const Duration(days: 8)),
      'totalInstallments': 4,
      'completedInstallments': 2,
      'status': 'active',
    },
    {
      'id': 'tp_003',
      'merchant': 'Home & Garden Plus',
      'merchantIcon': Icons.home,
      'purchaseAmount': 750.00,
      'remainingBalance': 250.00,
      'nextPaymentDate': DateTime.now().add(const Duration(days: 22)),
      'totalInstallments': 3,
      'completedInstallments': 2,
      'status': 'active',
    },
  ];

  final List<Map<String, dynamic>> _recentTransactions = [
    {
      'id': 'txn_001',
      'type': 'payment',
      'merchant': 'TechMart Electronics',
      'amount': 433.33,
      'date': DateTime.now().subtract(const Duration(days: 2)),
      'status': 'completed',
      'paymentMethod': 'TickPay Card',
    },
    {
      'id': 'txn_002',
      'type': 'purchase',
      'merchant': 'Coffee Central',
      'amount': 24.50,
      'date': DateTime.now().subtract(const Duration(days: 4)),
      'status': 'completed',
      'paymentMethod': 'Virtual Card',
    },
    {
      'id': 'txn_003',
      'type': 'payment',
      'merchant': 'Fashion Forward',
      'amount': 112.50,
      'date': DateTime.now().subtract(const Duration(days: 6)),
      'status': 'completed',
      'paymentMethod': 'Bank Transfer',
    },
  ];

  @override
  void initState() {
    super.initState();
    _refreshController = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    );
    _fabController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    )..forward();
  }

  @override
  void dispose() {
    _refreshController.dispose();
    _fabController.dispose();
    super.dispose();
  }

  Future<void> _refreshDashboard() async {
    HapticFeedback.lightImpact();
    _refreshController.forward();

    // Simulate data refresh
    await Future.delayed(const Duration(seconds: 2));

    _refreshController.reset();

    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('Dashboard updated'),
          backgroundColor: const Color(0xFF9e814e),
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
      );
    }
  }

  void _makePayment() {
    HapticFeedback.mediumImpact();

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => _buildPaymentBottomSheet(),
    );
  }

  Widget _buildPaymentBottomSheet() {
    return Container(
      height: MediaQuery.of(context).size.height * 0.7,
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      child: Column(
        children: [
          Container(
            width: 40,
            height: 4,
            margin: const EdgeInsets.only(top: 12),
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Make Payment',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const SizedBox(height: 20),
                Text(
                  'Select Plan to Pay',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              itemCount: _activePlans.length,
              itemBuilder: (context, index) {
                final plan = _activePlans[index];
                return Container(
                  margin: const EdgeInsets.only(bottom: 12),
                  decoration: BoxDecoration(
                    color: Theme.of(context).cardColor,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: ListTile(
                    leading: Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        color: const Color(0xFF9e814e).withAlpha(26),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Icon(
                        plan['merchantIcon'],
                        color: const Color(0xFF9e814e),
                        size: 20,
                      ),
                    ),
                    title: Text(plan['merchant']),
                    subtitle: Text(
                        'Next payment: \$${plan['remainingBalance'] / (plan['totalInstallments'] - plan['completedInstallments'])}'),
                    trailing: ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                        _processPayment(plan);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF9e814e),
                        foregroundColor: Colors.white,
                        minimumSize: const Size(80, 36),
                      ),
                      child: const Text('Pay'),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  void _processPayment(Map<String, dynamic> plan) {
    HapticFeedback.heavyImpact();

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => Dialog(
        backgroundColor: Colors.transparent,
        child: Container(
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: Theme.of(context).cardColor,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: const Color(0xFF9e814e),
              width: 2,
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 60,
                height: 60,
                decoration: const BoxDecoration(
                  color: Color(0xFF00c851),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.check,
                  color: Colors.white,
                  size: 30,
                ),
              ),
              const SizedBox(height: 16),
              Text(
                'Payment Successful!',
                style: Theme.of(context).textTheme.titleLarge,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8),
              Text(
                'Payment processed for ${plan['merchant']}',
                style: Theme.of(context).textTheme.bodyMedium,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: () => Navigator.of(context).pop(),
                child: const Text('Done'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final double creditUtilization = (_usedCredit / _totalCreditLimit) * 100;

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.arrow_back_ios),
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'TickPay Dashboard',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            Text(
              'Manage your BNPL activity',
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: Colors.grey[600],
                  ),
            ),
          ],
        ),
        actions: [
          Stack(
            children: [
              IconButton(
                onPressed: () {},
                icon: const Icon(Icons.notifications_outlined),
              ),
              Positioned(
                right: 8,
                top: 8,
                child: Container(
                  width: 8,
                  height: 8,
                  decoration: const BoxDecoration(
                    color: Colors.red,
                    shape: BoxShape.circle,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: _refreshDashboard,
        color: const Color(0xFF9e814e),
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Credit Overview
              CreditOverviewWidget(
                totalCreditLimit: _totalCreditLimit,
                usedCredit: _usedCredit,
                creditScore: _creditScore,
                creditUtilization: creditUtilization,
              ),

              const SizedBox(height: 24),

              // Quick Actions
              const QuickActionsWidget(),

              const SizedBox(height: 24),

              // Active Plans
              ActivePlansWidget(
                activePlans: _activePlans,
                onPlanTap: (plan) {
                  // Navigate to plan details
                },
              ),

              const SizedBox(height: 24),

              // Spending Insights
              const SpendingInsightsWidget(),

              const SizedBox(height: 24),

              // Recent Transactions
              RecentTransactionsWidget(
                transactions: _recentTransactions,
              ),

              const SizedBox(height: 100), // Bottom padding for FAB
            ],
          ),
        ),
      ),
      floatingActionButton: ScaleTransition(
        scale: _fabController,
        child: FloatingActionButton.extended(
          onPressed: _makePayment,
          backgroundColor: const Color(0xFF9e814e),
          foregroundColor: Colors.white,
          elevation: 6,
          icon: const Icon(Icons.payment),
          label: const Text(
            'Make Payment',
            style: TextStyle(fontWeight: FontWeight.w600),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
