class WalletModel {
  final String id;
  final String userId;
  final String accountNumber;
  final String routingNumber;
  final String walletType;
  final List<CurrencyBalance> balances;
  final bool isActive;
  final DateTime createdAt;
  final DateTime updatedAt;

  WalletModel({
    required this.id,
    required this.userId,
    required this.accountNumber,
    required this.routingNumber,
    required this.walletType,
    required this.balances,
    required this.isActive,
    required this.createdAt,
    required this.updatedAt,
  });

  factory WalletModel.fromJson(Map<String, dynamic> json) {
    return WalletModel(
      id: json['id'],
      userId: json['userId'],
      accountNumber: json['accountNumber'],
      routingNumber: json['routingNumber'],
      walletType: json['walletType'],
      balances: (json['balances'] as List)
          .map((balance) => CurrencyBalance.fromJson(balance))
          .toList(),
      isActive: json['isActive'] ?? true,
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userId': userId,
      'accountNumber': accountNumber,
      'routingNumber': routingNumber,
      'walletType': walletType,
      'balances': balances.map((balance) => balance.toJson()).toList(),
      'isActive': isActive,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
    };
  }
}

class CurrencyBalance {
  final String currencyCode;
  final double amount;
  final double availableAmount;
  final double pendingAmount;
  final DateTime lastUpdated;

  CurrencyBalance({
    required this.currencyCode,
    required this.amount,
    required this.availableAmount,
    required this.pendingAmount,
    required this.lastUpdated,
  });

  factory CurrencyBalance.fromJson(Map<String, dynamic> json) {
    return CurrencyBalance(
      currencyCode: json['currencyCode'],
      amount: json['amount'].toDouble(),
      availableAmount: json['availableAmount'].toDouble(),
      pendingAmount: json['pendingAmount'].toDouble(),
      lastUpdated: DateTime.parse(json['lastUpdated']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'currencyCode': currencyCode,
      'amount': amount,
      'availableAmount': availableAmount,
      'pendingAmount': pendingAmount,
      'lastUpdated': lastUpdated.toIso8601String(),
    };
  }
}
