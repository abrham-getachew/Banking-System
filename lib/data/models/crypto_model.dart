class CryptoModel {
  final String id;
  final String symbol;
  final String name;
  final double currentPrice;
  final double marketCap;
  final double volume24h;
  final double priceChange24h;
  final double priceChangePercentage24h;
  final String image;
  final DateTime lastUpdated;

  CryptoModel({
    required this.id,
    required this.symbol,
    required this.name,
    required this.currentPrice,
    required this.marketCap,
    required this.volume24h,
    required this.priceChange24h,
    required this.priceChangePercentage24h,
    required this.image,
    required this.lastUpdated,
  });

  factory CryptoModel.fromJson(Map<String, dynamic> json) {
    return CryptoModel(
      id: json['id'],
      symbol: json['symbol'],
      name: json['name'],
      currentPrice: json['current_price'].toDouble(),
      marketCap: json['market_cap'].toDouble(),
      volume24h: json['total_volume'].toDouble(),
      priceChange24h: json['price_change_24h'].toDouble(),
      priceChangePercentage24h: json['price_change_percentage_24h'].toDouble(),
      image: json['image'],
      lastUpdated: DateTime.parse(json['last_updated']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'symbol': symbol,
      'name': name,
      'current_price': currentPrice,
      'market_cap': marketCap,
      'total_volume': volume24h,
      'price_change_24h': priceChange24h,
      'price_change_percentage_24h': priceChangePercentage24h,
      'image': image,
      'last_updated': lastUpdated.toIso8601String(),
    };
  }
}

class CryptoPortfolioModel {
  final String id;
  final String userId;
  final String cryptoId;
  final String symbol;
  final double quantity;
  final double averagePurchasePrice;
  final double currentValue;
  final double profitLoss;
  final double profitLossPercentage;
  final DateTime lastUpdated;

  CryptoPortfolioModel({
    required this.id,
    required this.userId,
    required this.cryptoId,
    required this.symbol,
    required this.quantity,
    required this.averagePurchasePrice,
    required this.currentValue,
    required this.profitLoss,
    required this.profitLossPercentage,
    required this.lastUpdated,
  });

  factory CryptoPortfolioModel.fromJson(Map<String, dynamic> json) {
    return CryptoPortfolioModel(
      id: json['id'],
      userId: json['userId'],
      cryptoId: json['cryptoId'],
      symbol: json['symbol'],
      quantity: json['quantity'].toDouble(),
      averagePurchasePrice: json['averagePurchasePrice'].toDouble(),
      currentValue: json['currentValue'].toDouble(),
      profitLoss: json['profitLoss'].toDouble(),
      profitLossPercentage: json['profitLossPercentage'].toDouble(),
      lastUpdated: DateTime.parse(json['lastUpdated']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userId': userId,
      'cryptoId': cryptoId,
      'symbol': symbol,
      'quantity': quantity,
      'averagePurchasePrice': averagePurchasePrice,
      'currentValue': currentValue,
      'profitLoss': profitLoss,
      'profitLossPercentage': profitLossPercentage,
      'lastUpdated': lastUpdated.toIso8601String(),
    };
  }
}
