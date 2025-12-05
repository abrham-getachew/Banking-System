import 'package:dio/dio.dart';

import '../models/user_model.dart';
import './ai_service.dart';
import './auth_service.dart';
import './crypto_service.dart';
import './life_goal_service.dart';
import './nft_service.dart';
import './transaction_service.dart';
import './wallet_service.dart';

class BackendService {
  static BackendService? _instance;
  static BackendService get instance =>
      _instance ??= BackendService._internal();

  BackendService._internal();

  // Service instances
  final AuthService _authService = AuthService();
  final WalletService _walletService = WalletService();
  final TransactionService _transactionService = TransactionService();
  final CryptoService _cryptoService = CryptoService();
  final NFTService _nftService = NFTService();
  final AIService _aiService = AIService();
  final LifeGoalService _lifeGoalService = LifeGoalService();

  // Dio instance for API calls
  final Dio _dio = Dio();

  // Base URL for API - in production, use environment variable
  static const String _baseUrl = 'https://api.chronos.app';

  // Initialize the backend service
  Future<void> initialize() async {
    try {
      // Configure Dio
      _dio.options = BaseOptions(
        baseUrl: _baseUrl,
        connectTimeout: const Duration(seconds: 30),
        receiveTimeout: const Duration(seconds: 30),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
      );

      // Add interceptors
      _dio.interceptors.add(
        InterceptorsWrapper(
          onRequest: (options, handler) async {
            // Add authentication token to requests
            final token = await _authService.getAuthToken();
            if (token != null) {
              options.headers['Authorization'] = 'Bearer $token';
            }
            handler.next(options);
          },
          onError: (error, handler) async {
            // Handle token refresh on 401
            if (error.response?.statusCode == 401) {
              final refreshed = await _authService.refreshToken();
              if (refreshed) {
                // Retry the original request
                final newToken = await _authService.getAuthToken();
                error.requestOptions.headers['Authorization'] =
                    'Bearer $newToken';

                final response = await _dio.fetch(error.requestOptions);
                handler.resolve(response);
                return;
              }
            }
            handler.next(error);
          },
        ),
      );

      // Validate environment configuration
      await _validateEnvironment();

      print('Backend service initialized successfully');
    } catch (e) {
      print('Failed to initialize backend service: ${e.toString()}');
      rethrow;
    }
  }

  // Authentication Services
  Future<UserModel?> authenticateUser(String email, String password) async {
    try {
      return await _authService.authenticateUser(email, password);
    } catch (e) {
      throw Exception('Authentication failed: ${e.toString()}');
    }
  }

  Future<bool> authenticateWithBiometrics() async {
    try {
      return await _authService.authenticateWithBiometrics();
    } catch (e) {
      throw Exception('Biometric authentication failed: ${e.toString()}');
    }
  }

  Future<UserModel?> getCurrentUser() async {
    try {
      return await _authService.getCurrentUser();
    } catch (e) {
      throw Exception('Failed to get current user: ${e.toString()}');
    }
  }

  Future<void> logout() async {
    try {
      await _authService.logout();
    } catch (e) {
      throw Exception('Logout failed: ${e.toString()}');
    }
  }

  // Wallet Services
  Future<List<dynamic>> getUserWallets(String userId) async {
    try {
      return await _walletService.getUserWallets(userId);
    } catch (e) {
      throw Exception('Failed to fetch wallets: ${e.toString()}');
    }
  }

  Future<Map<String, double>> getExchangeRates() async {
    try {
      return await _walletService.getExchangeRates();
    } catch (e) {
      throw Exception('Failed to fetch exchange rates: ${e.toString()}');
    }
  }

  Future<double> convertCurrency(double amount, String from, String to) async {
    try {
      return await _walletService.convertCurrency(amount, from, to);
    } catch (e) {
      throw Exception('Currency conversion failed: ${e.toString()}');
    }
  }

  // Transaction Services
  Future<List<dynamic>> getUserTransactions(String userId) async {
    try {
      return await _transactionService.getUserTransactions(userId);
    } catch (e) {
      throw Exception('Failed to fetch transactions: ${e.toString()}');
    }
  }

  Future<dynamic> createTransaction(
      Map<String, dynamic> transactionData) async {
    try {
      return await _transactionService.createTransaction(
        userId: transactionData['userId'],
        walletId: transactionData['walletId'],
        type: transactionData['type'],
        amount: transactionData['amount'],
        currencyCode: transactionData['currencyCode'],
        description: transactionData['description'],
        recipientId: transactionData['recipientId'],
        recipientName: transactionData['recipientName'],
        recipientAccountNumber: transactionData['recipientAccountNumber'],
      );
    } catch (e) {
      throw Exception('Failed to create transaction: ${e.toString()}');
    }
  }

  Future<dynamic> processP2PTransfer(Map<String, dynamic> transferData) async {
    try {
      return await _transactionService.processP2PTransfer(
        senderId: transferData['senderId'],
        receiverId: transferData['receiverId'],
        amount: transferData['amount'],
        currencyCode: transferData['currencyCode'],
        description: transferData['description'],
      );
    } catch (e) {
      throw Exception('P2P transfer failed: ${e.toString()}');
    }
  }

  Future<dynamic> processInternationalTransfer(
      Map<String, dynamic> transferData) async {
    try {
      return await _transactionService.processInternationalTransfer(
        senderId: transferData['senderId'],
        receiverAccountNumber: transferData['receiverAccountNumber'],
        receiverBankCode: transferData['receiverBankCode'],
        amount: transferData['amount'],
        fromCurrency: transferData['fromCurrency'],
        toCurrency: transferData['toCurrency'],
        description: transferData['description'],
      );
    } catch (e) {
      throw Exception('International transfer failed: ${e.toString()}');
    }
  }

  // Cryptocurrency Services
  Future<List<dynamic>> getCryptoMarketData() async {
    try {
      return await _cryptoService.getCryptoMarketData();
    } catch (e) {
      throw Exception('Failed to fetch crypto market data: ${e.toString()}');
    }
  }

  Future<List<dynamic>> getUserCryptoPortfolio(String userId) async {
    try {
      return await _cryptoService.getUserCryptoPortfolio(userId);
    } catch (e) {
      throw Exception('Failed to fetch crypto portfolio: ${e.toString()}');
    }
  }

  Future<Map<String, dynamic>> buyCrypto(Map<String, dynamic> buyData) async {
    try {
      return await _cryptoService.buyCrypto(
        userId: buyData['userId'],
        cryptoId: buyData['cryptoId'],
        amount: buyData['amount'],
        currencyCode: buyData['currencyCode'],
      );
    } catch (e) {
      throw Exception('Failed to buy crypto: ${e.toString()}');
    }
  }

  Future<Map<String, dynamic>> sellCrypto(Map<String, dynamic> sellData) async {
    try {
      return await _cryptoService.sellCrypto(
        userId: sellData['userId'],
        cryptoId: sellData['cryptoId'],
        quantity: sellData['quantity'],
        currencyCode: sellData['currencyCode'],
      );
    } catch (e) {
      throw Exception('Failed to sell crypto: ${e.toString()}');
    }
  }

  // NFT Services
  Future<List<dynamic>> getFeaturedNFTs() async {
    try {
      return await _nftService.getFeaturedNFTs();
    } catch (e) {
      throw Exception('Failed to fetch featured NFTs: ${e.toString()}');
    }
  }

  Future<List<dynamic>> getUserNFTs(String userId) async {
    try {
      return await _nftService.getUserNFTs(userId);
    } catch (e) {
      throw Exception('Failed to fetch user NFTs: ${e.toString()}');
    }
  }

  Future<Map<String, dynamic>> purchaseNFT(
      Map<String, dynamic> purchaseData) async {
    try {
      return await _nftService.purchaseNFT(
        userId: purchaseData['userId'],
        nftId: purchaseData['nftId'],
        price: purchaseData['price'],
        currency: purchaseData['currency'],
      );
    } catch (e) {
      throw Exception('Failed to purchase NFT: ${e.toString()}');
    }
  }

  // AI Services
  Future<List<dynamic>> getPersonalizedRecommendations(String userId) async {
    try {
      return await _aiService.getPersonalizedRecommendations(userId);
    } catch (e) {
      throw Exception('Failed to fetch AI recommendations: ${e.toString()}');
    }
  }

  Future<dynamic> analyzeSpendingPatterns(String userId) async {
    try {
      return await _aiService.analyzeSpendingPatterns(userId);
    } catch (e) {
      throw Exception('Failed to analyze spending patterns: ${e.toString()}');
    }
  }

  Future<Map<String, dynamic>> generateInvestmentSuggestions(
      String userId) async {
    try {
      return await _aiService.generateInvestmentSuggestions(userId);
    } catch (e) {
      throw Exception(
          'Failed to generate investment suggestions: ${e.toString()}');
    }
  }

  Future<Map<String, dynamic>> predictFinancialForecast(String userId) async {
    try {
      return await _aiService.predictFinancialForecast(userId);
    } catch (e) {
      throw Exception('Failed to predict financial forecast: ${e.toString()}');
    }
  }

  // Life Goal Services
  Future<List<dynamic>> getUserGoals(String userId) async {
    try {
      return await _lifeGoalService.getUserGoals(userId);
    } catch (e) {
      throw Exception('Failed to fetch user goals: ${e.toString()}');
    }
  }

  Future<dynamic> createGoal(Map<String, dynamic> goalData) async {
    try {
      return await _lifeGoalService.createGoal(
        userId: goalData['userId'],
        title: goalData['title'],
        description: goalData['description'],
        category: goalData['category'],
        targetAmount: goalData['targetAmount'],
        targetDate: DateTime.parse(goalData['targetDate']),
      );
    } catch (e) {
      throw Exception('Failed to create goal: ${e.toString()}');
    }
  }

  Future<dynamic> updateGoalProgress(String goalId, double amount) async {
    try {
      return await _lifeGoalService.updateGoalProgress(goalId, amount);
    } catch (e) {
      throw Exception('Failed to update goal progress: ${e.toString()}');
    }
  }

  Future<Map<String, dynamic>> getLifeXServices() async {
    try {
      return await _lifeGoalService.getLifeXServices();
    } catch (e) {
      throw Exception('Failed to fetch LifeX services: ${e.toString()}');
    }
  }

  // Utility Methods
  Future<bool> isOnline() async {
    try {
      final response = await _dio.get('/health');
      return response.statusCode == 200;
    } catch (e) {
      return false;
    }
  }

  Future<Map<String, dynamic>> getSystemStatus() async {
    try {
      // Mock system status - in production, implement actual health checks
      return {
        'status': 'healthy',
        'version': '1.0.0',
        'timestamp': DateTime.now().toIso8601String(),
        'services': {
          'authentication': 'online',
          'wallet': 'online',
          'transactions': 'online',
          'crypto': 'online',
          'nft': 'online',
          'ai': 'online',
          'life_goals': 'online',
        },
      };
    } catch (e) {
      throw Exception('Failed to get system status: ${e.toString()}');
    }
  }

  Future<void> _validateEnvironment() async {
    try {
      // Validate required environment variables
      final requiredVars = ['API_BASE_URL', 'API_KEY'];

      for (final varName in requiredVars) {
        final String value = String.fromEnvironment(varName);
        if (value.isEmpty) {
          throw Exception('$varName is not configured in environment');
        }
      }

      print('Environment validation passed');
    } catch (e) {
      print('Environment validation failed: ${e.toString()}');
      // Continue with mock data for demo purposes
    }
  }

  // Cleanup resources
  void dispose() {
    _dio.close();
  }
}