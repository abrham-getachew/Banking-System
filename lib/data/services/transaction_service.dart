import 'dart:math';
import '../models/transaction_model.dart';

class TransactionService {
  // Mock transaction data
  static const List<Map<String, dynamic>> _mockTransactions = [
    {
      'type': 'transfer',
      'amount': 150.0,
      'description': 'Coffee with Sarah',
      'recipient': 'Sarah Johnson',
    },
    {
      'type': 'payment',
      'amount': 89.99,
      'description': 'Spotify Premium',
      'recipient': 'Spotify',
    },
    {
      'type': 'deposit',
      'amount': 2500.0,
      'description': 'Salary deposit',
      'recipient': 'Tech Corp Inc',
    },
    {
      'type': 'withdrawal',
      'amount': 200.0,
      'description': 'ATM withdrawal',
      'recipient': 'Chase ATM',
    },
    {
      'type': 'transfer',
      'amount': 75.0,
      'description': 'Dinner split',
      'recipient': 'Mike Wilson',
    },
  ];

  Future<List<TransactionModel>> getUserTransactions(String userId) async {
    try {
      // Simulate API call delay
      await Future.delayed(const Duration(milliseconds: 600));

      final random = Random();
      final transactions = <TransactionModel>[];

      for (int i = 0; i < 20; i++) {
        final mockData =
            _mockTransactions[random.nextInt(_mockTransactions.length)];

        final transaction = TransactionModel(
          id: 'txn_${DateTime.now().millisecondsSinceEpoch}_$i',
          userId: userId,
          walletId: 'wallet_primary',
          type: mockData['type'],
          amount: mockData['amount'].toDouble(),
          currencyCode: 'USD',
          recipientName: mockData['recipient'],
          description: mockData['description'],
          status: _getRandomStatus(),
          createdAt:
              DateTime.now().subtract(Duration(days: random.nextInt(30))),
          completedAt:
              DateTime.now().subtract(Duration(days: random.nextInt(30))),
        );

        transactions.add(transaction);
      }

      // Sort by date (newest first)
      transactions.sort((a, b) => b.createdAt.compareTo(a.createdAt));

      return transactions;
    } catch (e) {
      throw Exception('Failed to fetch transactions: ${e.toString()}');
    }
  }

  Future<TransactionModel> createTransaction({
    required String userId,
    required String walletId,
    required String type,
    required double amount,
    required String currencyCode,
    required String description,
    String? recipientId,
    String? recipientName,
    String? recipientAccountNumber,
  }) async {
    try {
      // Simulate API call delay
      await Future.delayed(const Duration(milliseconds: 800));

      final transaction = TransactionModel(
        id: 'txn_${DateTime.now().millisecondsSinceEpoch}',
        userId: userId,
        walletId: walletId,
        type: type,
        amount: amount,
        currencyCode: currencyCode,
        recipientId: recipientId,
        recipientName: recipientName,
        recipientAccountNumber: recipientAccountNumber,
        description: description,
        status: 'pending',
        createdAt: DateTime.now(),
      );

      return transaction;
    } catch (e) {
      throw Exception('Failed to create transaction: ${e.toString()}');
    }
  }

  Future<TransactionModel> processP2PTransfer({
    required String senderId,
    required String receiverId,
    required double amount,
    required String currencyCode,
    required String description,
  }) async {
    try {
      // Simulate API call delay
      await Future.delayed(const Duration(milliseconds: 1000));

      final transaction = TransactionModel(
        id: 'p2p_${DateTime.now().millisecondsSinceEpoch}',
        userId: senderId,
        walletId: 'wallet_primary',
        type: 'p2p_transfer',
        amount: amount,
        currencyCode: currencyCode,
        recipientId: receiverId,
        recipientName: _getRecipientName(receiverId),
        description: description,
        status: 'completed',
        createdAt: DateTime.now(),
        completedAt: DateTime.now(),
      );

      return transaction;
    } catch (e) {
      throw Exception('P2P transfer failed: ${e.toString()}');
    }
  }

  Future<TransactionModel> processInternationalTransfer({
    required String senderId,
    required String receiverAccountNumber,
    required String receiverBankCode,
    required double amount,
    required String fromCurrency,
    required String toCurrency,
    required String description,
  }) async {
    try {
      // Simulate API call delay
      await Future.delayed(const Duration(milliseconds: 1200));

      final transaction = TransactionModel(
        id: 'intl_${DateTime.now().millisecondsSinceEpoch}',
        userId: senderId,
        walletId: 'wallet_primary',
        type: 'international_transfer',
        amount: amount,
        currencyCode: fromCurrency,
        recipientAccountNumber: receiverAccountNumber,
        description: description,
        status: 'processing',
        createdAt: DateTime.now(),
        metadata: {
          'receiverBankCode': receiverBankCode,
          'targetCurrency': toCurrency,
          'exchangeRate': _getExchangeRate(fromCurrency, toCurrency),
        },
      );

      return transaction;
    } catch (e) {
      throw Exception('International transfer failed: ${e.toString()}');
    }
  }

  Future<TransactionModel> getTransactionById(String transactionId) async {
    try {
      // Simulate API call delay
      await Future.delayed(const Duration(milliseconds: 400));

      return TransactionModel(
        id: transactionId,
        userId: 'user_123',
        walletId: 'wallet_primary',
        type: 'transfer',
        amount: 150.0,
        currencyCode: 'USD',
        recipientName: 'Sarah Johnson',
        description: 'Coffee meeting',
        status: 'completed',
        createdAt: DateTime.now().subtract(const Duration(hours: 2)),
        completedAt: DateTime.now().subtract(const Duration(hours: 2)),
      );
    } catch (e) {
      throw Exception('Failed to fetch transaction: ${e.toString()}');
    }
  }

  Future<Map<String, dynamic>> getTransactionStats(String userId) async {
    try {
      // Simulate API call delay
      await Future.delayed(const Duration(milliseconds: 500));

      final random = Random();

      return {
        'totalTransactions': 156,
        'totalSpent': 12450.75,
        'totalReceived': 15200.30,
        'averageTransactionAmount': 89.65,
        'monthlySpending': {
          'January': 1200.0 + random.nextDouble() * 800,
          'February': 1100.0 + random.nextDouble() * 800,
          'March': 1400.0 + random.nextDouble() * 800,
          'April': 1350.0 + random.nextDouble() * 800,
          'May': 1250.0 + random.nextDouble() * 800,
          'June': 1500.0 + random.nextDouble() * 800,
        },
        'categoryBreakdown': {
          'Food & Dining': 3200.0,
          'Shopping': 2800.0,
          'Transportation': 1200.0,
          'Entertainment': 800.0,
          'Bills & Utilities': 1500.0,
          'Healthcare': 600.0,
          'Other': 1350.75,
        },
      };
    } catch (e) {
      throw Exception('Failed to fetch transaction stats: ${e.toString()}');
    }
  }

  String _getRandomStatus() {
    final statuses = ['completed', 'pending', 'processing', 'failed'];
    final random = Random();
    return statuses[random.nextInt(statuses.length)];
  }

  String _getRecipientName(String recipientId) {
    final names = [
      'Sarah Johnson',
      'Mike Wilson',
      'Emily Davis',
      'James Brown',
      'Lisa Garcia',
      'David Miller',
      'Anna Taylor',
      'Chris Anderson',
    ];
    final random = Random();
    return names[random.nextInt(names.length)];
  }

  double _getExchangeRate(String fromCurrency, String toCurrency) {
    final rates = {
      'USD_EUR': 0.85,
      'USD_GBP': 0.73,
      'USD_JPY': 110.0,
      'EUR_USD': 1.18,
      'GBP_USD': 1.37,
      'JPY_USD': 0.009,
    };

    return rates['${fromCurrency}_$toCurrency'] ?? 1.0;
  }
}
