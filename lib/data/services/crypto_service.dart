import 'dart:math';
import 'package:dio/dio.dart';
import '../models/crypto_model.dart';

class CryptoService {
  final Dio _dio = Dio();

  // Mock crypto data - in production, use CoinGecko API or similar
  static const List<Map<String, dynamic>> _mockCryptoData = [
    {
      'id': 'bitcoin',
      'symbol': 'btc',
      'name': 'Bitcoin',
      'current_price': 45000.0,
      'market_cap': 850000000000.0,
      'total_volume': 25000000000.0,
      'price_change_24h': 1250.0,
      'price_change_percentage_24h': 2.85,
      'image': 'https://assets.coingecko.com/coins/images/1/large/bitcoin.png',
    },
    {
      'id': 'ethereum',
      'symbol': 'eth',
      'name': 'Ethereum',
      'current_price': 3200.0,
      'market_cap': 385000000000.0,
      'total_volume': 15000000000.0,
      'price_change_24h': -80.0,
      'price_change_percentage_24h': -2.44,
      'image':
          'https://assets.coingecko.com/coins/images/279/large/ethereum.png',
    },
    {
      'id': 'binancecoin',
      'symbol': 'bnb',
      'name': 'BNB',
      'current_price': 420.0,
      'market_cap': 70000000000.0,
      'total_volume': 1800000000.0,
      'price_change_24h': 12.5,
      'price_change_percentage_24h': 3.07,
      'image':
          'https://assets.coingecko.com/coins/images/825/large/bnb-icon2_2x.png',
    },
    {
      'id': 'cardano',
      'symbol': 'ada',
      'name': 'Cardano',
      'current_price': 1.25,
      'market_cap': 42000000000.0,
      'total_volume': 2500000000.0,
      'price_change_24h': 0.08,
      'price_change_percentage_24h': 6.84,
      'image':
          'https://assets.coingecko.com/coins/images/975/large/cardano.png',
    },
    {
      'id': 'solana',
      'symbol': 'sol',
      'name': 'Solana',
      'current_price': 95.0,
      'market_cap': 30000000000.0,
      'total_volume': 1200000000.0,
      'price_change_24h': -3.2,
      'price_change_percentage_24h': -3.26,
      'image':
          'https://assets.coingecko.com/coins/images/4128/large/solana.png',
    },
  ];

  Future<List<CryptoModel>> getCryptoMarketData() async {
    try {
      // Simulate API call delay
      await Future.delayed(const Duration(milliseconds: 800));

      final random = Random();
      final cryptos = <CryptoModel>[];

      for (final data in _mockCryptoData) {
        // Add some price variation
        final priceVariation =
            (random.nextDouble() - 0.5) * 0.05; // ±2.5% variation
        final currentPrice =
            data['current_price'].toDouble() * (1 + priceVariation);

        final crypto = CryptoModel(
          id: data['id'],
          symbol: data['symbol'],
          name: data['name'],
          currentPrice: currentPrice,
          marketCap: data['market_cap'].toDouble(),
          volume24h: data['total_volume'].toDouble(),
          priceChange24h: data['price_change_24h'].toDouble(),
          priceChangePercentage24h:
              data['price_change_percentage_24h'].toDouble(),
          image: data['image'],
          lastUpdated: DateTime.now(),
        );

        cryptos.add(crypto);
      }

      return cryptos;
    } catch (e) {
      throw Exception('Failed to fetch crypto market data: ${e.toString()}');
    }
  }

  Future<CryptoModel> getCryptoById(String cryptoId) async {
    try {
      // Simulate API call delay
      await Future.delayed(const Duration(milliseconds: 400));

      final data = _mockCryptoData.firstWhere(
        (crypto) => crypto['id'] == cryptoId,
        orElse: () => _mockCryptoData.first,
      );

      final random = Random();
      final priceVariation = (random.nextDouble() - 0.5) * 0.05;
      final currentPrice =
          data['current_price'].toDouble() * (1 + priceVariation);

      return CryptoModel(
        id: data['id'],
        symbol: data['symbol'],
        name: data['name'],
        currentPrice: currentPrice,
        marketCap: data['market_cap'].toDouble(),
        volume24h: data['total_volume'].toDouble(),
        priceChange24h: data['price_change_24h'].toDouble(),
        priceChangePercentage24h:
            data['price_change_percentage_24h'].toDouble(),
        image: data['image'],
        lastUpdated: DateTime.now(),
      );
    } catch (e) {
      throw Exception('Failed to fetch crypto data: ${e.toString()}');
    }
  }

  Future<List<CryptoPortfolioModel>> getUserCryptoPortfolio(
      String userId) async {
    try {
      // Simulate API call delay
      await Future.delayed(const Duration(milliseconds: 600));

      final random = Random();
      final portfolio = <CryptoPortfolioModel>[];

      // Generate mock portfolio data
      for (int i = 0; i < 3; i++) {
        final cryptoData = _mockCryptoData[i];
        final quantity = 0.5 + random.nextDouble() * 5;
        final avgPrice = cryptoData['current_price'].toDouble() *
            (0.8 + random.nextDouble() * 0.4);
        final currentPrice = cryptoData['current_price'].toDouble();
        final currentValue = quantity * currentPrice;
        final profitLoss = currentValue - (quantity * avgPrice);

        final portfolioItem = CryptoPortfolioModel(
          id: 'portfolio_${cryptoData['id']}',
          userId: userId,
          cryptoId: cryptoData['id'],
          symbol: cryptoData['symbol'],
          quantity: quantity,
          averagePurchasePrice: avgPrice,
          currentValue: currentValue,
          profitLoss: profitLoss,
          profitLossPercentage: (profitLoss / (quantity * avgPrice)) * 100,
          lastUpdated: DateTime.now(),
        );

        portfolio.add(portfolioItem);
      }

      return portfolio;
    } catch (e) {
      throw Exception('Failed to fetch crypto portfolio: ${e.toString()}');
    }
  }

  Future<Map<String, dynamic>> buyCrypto({
    required String userId,
    required String cryptoId,
    required double amount,
    required String currencyCode,
  }) async {
    try {
      // Simulate API call delay
      await Future.delayed(const Duration(milliseconds: 1000));

      final crypto = await getCryptoById(cryptoId);
      final quantity = amount / crypto.currentPrice;

      return {
        'transactionId': 'buy_${DateTime.now().millisecondsSinceEpoch}',
        'cryptoId': cryptoId,
        'quantity': quantity,
        'price': crypto.currentPrice,
        'totalAmount': amount,
        'currencyCode': currencyCode,
        'status': 'completed',
        'timestamp': DateTime.now().toIso8601String(),
      };
    } catch (e) {
      throw Exception('Failed to buy crypto: ${e.toString()}');
    }
  }

  Future<Map<String, dynamic>> sellCrypto({
    required String userId,
    required String cryptoId,
    required double quantity,
    required String currencyCode,
  }) async {
    try {
      // Simulate API call delay
      await Future.delayed(const Duration(milliseconds: 1000));

      final crypto = await getCryptoById(cryptoId);
      final totalAmount = quantity * crypto.currentPrice;

      return {
        'transactionId': 'sell_${DateTime.now().millisecondsSinceEpoch}',
        'cryptoId': cryptoId,
        'quantity': quantity,
        'price': crypto.currentPrice,
        'totalAmount': totalAmount,
        'currencyCode': currencyCode,
        'status': 'completed',
        'timestamp': DateTime.now().toIso8601String(),
      };
    } catch (e) {
      throw Exception('Failed to sell crypto: ${e.toString()}');
    }
  }

  Future<List<Map<String, dynamic>>> getCryptoNews() async {
    try {
      // Simulate API call delay
      await Future.delayed(const Duration(milliseconds: 500));

      final news = [
        {
          'title': 'Bitcoin Reaches New All-Time High',
          'description':
              'Bitcoin price surges past \$50,000 as institutional adoption continues.',
          'source': 'CryptoNews',
          'publishedAt': DateTime.now()
              .subtract(const Duration(hours: 2))
              .toIso8601String(),
          'imageUrl':
              'https://images.unsplash.com/photo-1518544866330-4ec3de9bacc4?w=400',
        },
        {
          'title': 'Ethereum 2.0 Upgrade Shows Promising Results',
          'description':
              'The latest Ethereum upgrade demonstrates improved scalability and reduced gas fees.',
          'source': 'BlockchainToday',
          'publishedAt': DateTime.now()
              .subtract(const Duration(hours: 5))
              .toIso8601String(),
          'imageUrl':
              'https://images.unsplash.com/photo-1639762681485-074b7f938ba0?w=400',
        },
        {
          'title': 'DeFi Market Continues to Grow',
          'description':
              'Decentralized Finance protocols see increased adoption and total value locked.',
          'source': 'DeFiPulse',
          'publishedAt': DateTime.now()
              .subtract(const Duration(hours: 8))
              .toIso8601String(),
          'imageUrl':
              'https://images.unsplash.com/photo-1633158829875-e5316a358c6f?w=400',
        },
      ];

      return news;
    } catch (e) {
      throw Exception('Failed to fetch crypto news: ${e.toString()}');
    }
  }

  Future<Map<String, dynamic>> getCryptoTrendingData() async {
    try {
      // Simulate API call delay
      await Future.delayed(const Duration(milliseconds: 400));

      final random = Random();

      return {
        'trending': [
          {'name': 'Bitcoin', 'symbol': 'BTC', 'rank': 1},
          {'name': 'Ethereum', 'symbol': 'ETH', 'rank': 2},
          {'name': 'Cardano', 'symbol': 'ADA', 'rank': 3},
        ],
        'gainers': [
          {'name': 'Solana', 'symbol': 'SOL', 'change': 12.5},
          {'name': 'Cardano', 'symbol': 'ADA', 'change': 8.2},
          {'name': 'BNB', 'symbol': 'BNB', 'change': 6.7},
        ],
        'losers': [
          {'name': 'Ethereum', 'symbol': 'ETH', 'change': -3.2},
          {'name': 'Polkadot', 'symbol': 'DOT', 'change': -5.1},
          {'name': 'Chainlink', 'symbol': 'LINK', 'change': -2.8},
        ],
        'marketCap': 2.1e12 + random.nextDouble() * 1e11,
        'volume24h': 8.5e10 + random.nextDouble() * 2e10,
        'btcDominance': 40.5 + random.nextDouble() * 5,
      };
    } catch (e) {
      throw Exception('Failed to fetch trending data: ${e.toString()}');
    }
  }
}
