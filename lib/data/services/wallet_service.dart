import 'dart:math';
import 'package:dio/dio.dart';
import '../models/wallet_model.dart';

class WalletService {
  final Dio _dio = Dio();

  // Mock exchange rates - in production, use actual forex APIs
  static const Map<String, double> _exchangeRates = {
    'USD': 1.0,
    'EUR': 0.85,
    'GBP': 0.73,
    'JPY': 110.0,
    'CAD': 1.25,
    'AUD': 1.35,
    'CHF': 0.92,
    'CNY': 6.45,
    'INR': 74.5,
    'BRL': 5.2,
  };

  Future<WalletModel> createWallet(String userId, String walletType) async {
    try {
      // Simulate API call delay
      await Future.delayed(const Duration(milliseconds: 800));

      final wallet = WalletModel(
        id: 'wallet_${DateTime.now().millisecondsSinceEpoch}',
        userId: userId,
        accountNumber: _generateAccountNumber(),
        routingNumber: _generateRoutingNumber(),
        walletType: walletType,
        balances: _generateInitialBalances(),
        isActive: true,
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      );

      return wallet;
    } catch (e) {
      throw Exception('Failed to create wallet: ${e.toString()}');
    }
  }

  Future<List<WalletModel>> getUserWallets(String userId) async {
    try {
      // Simulate API call delay
      await Future.delayed(const Duration(milliseconds: 600));

      // Mock wallets data
      final wallets = [
        WalletModel(
          id: 'wallet_primary',
          userId: userId,
          accountNumber: _generateAccountNumber(),
          routingNumber: _generateRoutingNumber(),
          walletType: 'primary',
          balances: _generateMockBalances(),
          isActive: true,
          createdAt: DateTime.now().subtract(const Duration(days: 30)),
          updatedAt: DateTime.now(),
        ),
        WalletModel(
          id: 'wallet_savings',
          userId: userId,
          accountNumber: _generateAccountNumber(),
          routingNumber: _generateRoutingNumber(),
          walletType: 'savings',
          balances: _generateSavingsBalances(),
          isActive: true,
          createdAt: DateTime.now().subtract(const Duration(days: 20)),
          updatedAt: DateTime.now(),
        ),
      ];

      return wallets;
    } catch (e) {
      throw Exception('Failed to fetch wallets: ${e.toString()}');
    }
  }

  Future<WalletModel> getWalletById(String walletId) async {
    try {
      // Simulate API call delay
      await Future.delayed(const Duration(milliseconds: 400));

      return WalletModel(
        id: walletId,
        userId: 'user_123',
        accountNumber: _generateAccountNumber(),
        routingNumber: _generateRoutingNumber(),
        walletType: 'primary',
        balances: _generateMockBalances(),
        isActive: true,
        createdAt: DateTime.now().subtract(const Duration(days: 15)),
        updatedAt: DateTime.now(),
      );
    } catch (e) {
      throw Exception('Failed to fetch wallet: ${e.toString()}');
    }
  }

  Future<Map<String, double>> getExchangeRates() async {
    try {
      // Simulate API call delay
      await Future.delayed(const Duration(milliseconds: 300));

      // Add some variation to mock rates
      final random = Random();
      final rates = <String, double>{};

      _exchangeRates.forEach((currency, rate) {
        final variation = (random.nextDouble() - 0.5) * 0.02; // ±1% variation
        rates[currency] = rate * (1 + variation);
      });

      return rates;
    } catch (e) {
      throw Exception('Failed to fetch exchange rates: ${e.toString()}');
    }
  }

  Future<double> convertCurrency(
    double amount,
    String fromCurrency,
    String toCurrency,
  ) async {
    try {
      final rates = await getExchangeRates();

      if (!rates.containsKey(fromCurrency) || !rates.containsKey(toCurrency)) {
        throw Exception('Currency not supported');
      }

      final fromRate = rates[fromCurrency]!;
      final toRate = rates[toCurrency]!;

      // Convert to USD first, then to target currency
      final usdAmount = amount / fromRate;
      final convertedAmount = usdAmount * toRate;

      return convertedAmount;
    } catch (e) {
      throw Exception('Currency conversion failed: ${e.toString()}');
    }
  }

  Future<WalletModel> updateWalletBalance(
    String walletId,
    String currencyCode,
    double amount,
  ) async {
    try {
      // Simulate API call delay
      await Future.delayed(const Duration(milliseconds: 500));

      final wallet = await getWalletById(walletId);

      // Update balance
      final updatedBalances = wallet.balances.map((balance) {
        if (balance.currencyCode == currencyCode) {
          return CurrencyBalance(
            currencyCode: currencyCode,
            amount: balance.amount + amount,
            availableAmount: balance.availableAmount + amount,
            pendingAmount: balance.pendingAmount,
            lastUpdated: DateTime.now(),
          );
        }
        return balance;
      }).toList();

      return WalletModel(
        id: wallet.id,
        userId: wallet.userId,
        accountNumber: wallet.accountNumber,
        routingNumber: wallet.routingNumber,
        walletType: wallet.walletType,
        balances: updatedBalances,
        isActive: wallet.isActive,
        createdAt: wallet.createdAt,
        updatedAt: DateTime.now(),
      );
    } catch (e) {
      throw Exception('Failed to update wallet balance: ${e.toString()}');
    }
  }

  String _generateAccountNumber() {
    final random = Random();
    return (100000000 + random.nextInt(900000000)).toString();
  }

  String _generateRoutingNumber() {
    final random = Random();
    return (100000000 + random.nextInt(900000000)).toString();
  }

  List<CurrencyBalance> _generateInitialBalances() {
    return [
      CurrencyBalance(
        currencyCode: 'USD',
        amount: 1000.0,
        availableAmount: 1000.0,
        pendingAmount: 0.0,
        lastUpdated: DateTime.now(),
      ),
    ];
  }

  List<CurrencyBalance> _generateMockBalances() {
    final random = Random();
    return [
      CurrencyBalance(
        currencyCode: 'USD',
        amount: 5000.0 + random.nextDouble() * 10000,
        availableAmount: 4800.0 + random.nextDouble() * 9800,
        pendingAmount: 200.0 + random.nextDouble() * 200,
        lastUpdated: DateTime.now(),
      ),
      CurrencyBalance(
        currencyCode: 'EUR',
        amount: 2000.0 + random.nextDouble() * 5000,
        availableAmount: 1900.0 + random.nextDouble() * 4900,
        pendingAmount: 100.0 + random.nextDouble() * 100,
        lastUpdated: DateTime.now(),
      ),
      CurrencyBalance(
        currencyCode: 'GBP',
        amount: 1500.0 + random.nextDouble() * 3000,
        availableAmount: 1450.0 + random.nextDouble() * 2950,
        pendingAmount: 50.0 + random.nextDouble() * 50,
        lastUpdated: DateTime.now(),
      ),
    ];
  }

  List<CurrencyBalance> _generateSavingsBalances() {
    final random = Random();
    return [
      CurrencyBalance(
        currencyCode: 'USD',
        amount: 25000.0 + random.nextDouble() * 50000,
        availableAmount: 25000.0 + random.nextDouble() * 50000,
        pendingAmount: 0.0,
        lastUpdated: DateTime.now(),
      ),
    ];
  }
}
