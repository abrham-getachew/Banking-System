class TransactionModel {
  final String id;
  final String userId;
  final String walletId;
  final String type;
  final double amount;
  final String currencyCode;
  final String? recipientId;
  final String? recipientName;
  final String? recipientAccountNumber;
  final String description;
  final String status;
  final DateTime createdAt;
  final DateTime? completedAt;
  final Map<String, dynamic>? metadata;

  TransactionModel({
    required this.id,
    required this.userId,
    required this.walletId,
    required this.type,
    required this.amount,
    required this.currencyCode,
    this.recipientId,
    this.recipientName,
    this.recipientAccountNumber,
    required this.description,
    required this.status,
    required this.createdAt,
    this.completedAt,
    this.metadata,
  });

  factory TransactionModel.fromJson(Map<String, dynamic> json) {
    return TransactionModel(
      id: json['id'],
      userId: json['userId'],
      walletId: json['walletId'],
      type: json['type'],
      amount: json['amount'].toDouble(),
      currencyCode: json['currencyCode'],
      recipientId: json['recipientId'],
      recipientName: json['recipientName'],
      recipientAccountNumber: json['recipientAccountNumber'],
      description: json['description'],
      status: json['status'],
      createdAt: DateTime.parse(json['createdAt']),
      completedAt: json['completedAt'] != null
          ? DateTime.parse(json['completedAt'])
          : null,
      metadata: json['metadata'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userId': userId,
      'walletId': walletId,
      'type': type,
      'amount': amount,
      'currencyCode': currencyCode,
      'recipientId': recipientId,
      'recipientName': recipientName,
      'recipientAccountNumber': recipientAccountNumber,
      'description': description,
      'status': status,
      'createdAt': createdAt.toIso8601String(),
      'completedAt': completedAt?.toIso8601String(),
      'metadata': metadata,
    };
  }
}
