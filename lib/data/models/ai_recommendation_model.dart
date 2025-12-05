class AIRecommendationModel {
  final String id;
  final String userId;
  final String type;
  final String title;
  final String description;
  final double confidence;
  final Map<String, dynamic> data;
  final DateTime createdAt;
  final DateTime? expiresAt;
  final bool isRead;
  final String priority;

  AIRecommendationModel({
    required this.id,
    required this.userId,
    required this.type,
    required this.title,
    required this.description,
    required this.confidence,
    required this.data,
    required this.createdAt,
    this.expiresAt,
    required this.isRead,
    required this.priority,
  });

  factory AIRecommendationModel.fromJson(Map<String, dynamic> json) {
    return AIRecommendationModel(
      id: json['id'],
      userId: json['userId'],
      type: json['type'],
      title: json['title'],
      description: json['description'],
      confidence: json['confidence'].toDouble(),
      data: json['data'],
      createdAt: DateTime.parse(json['createdAt']),
      expiresAt:
          json['expiresAt'] != null ? DateTime.parse(json['expiresAt']) : null,
      isRead: json['isRead'] ?? false,
      priority: json['priority'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userId': userId,
      'type': type,
      'title': title,
      'description': description,
      'confidence': confidence,
      'data': data,
      'createdAt': createdAt.toIso8601String(),
      'expiresAt': expiresAt?.toIso8601String(),
      'isRead': isRead,
      'priority': priority,
    };
  }
}

class SpendingAnalysisModel {
  final String id;
  final String userId;
  final String period;
  final double totalSpent;
  final double totalIncome;
  final double savingsRate;
  final Map<String, CategorySpending> categoryBreakdown;
  final List<SpendingTrend> trends;
  final DateTime generatedAt;

  SpendingAnalysisModel({
    required this.id,
    required this.userId,
    required this.period,
    required this.totalSpent,
    required this.totalIncome,
    required this.savingsRate,
    required this.categoryBreakdown,
    required this.trends,
    required this.generatedAt,
  });

  factory SpendingAnalysisModel.fromJson(Map<String, dynamic> json) {
    return SpendingAnalysisModel(
      id: json['id'],
      userId: json['userId'],
      period: json['period'],
      totalSpent: json['totalSpent'].toDouble(),
      totalIncome: json['totalIncome'].toDouble(),
      savingsRate: json['savingsRate'].toDouble(),
      categoryBreakdown: (json['categoryBreakdown'] as Map<String, dynamic>)
          .map((key, value) => MapEntry(key, CategorySpending.fromJson(value))),
      trends: (json['trends'] as List)
          .map((trend) => SpendingTrend.fromJson(trend))
          .toList(),
      generatedAt: DateTime.parse(json['generatedAt']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userId': userId,
      'period': period,
      'totalSpent': totalSpent,
      'totalIncome': totalIncome,
      'savingsRate': savingsRate,
      'categoryBreakdown':
          categoryBreakdown.map((key, value) => MapEntry(key, value.toJson())),
      'trends': trends.map((trend) => trend.toJson()).toList(),
      'generatedAt': generatedAt.toIso8601String(),
    };
  }
}

class CategorySpending {
  final String category;
  final double amount;
  final double percentage;
  final double changeFromPrevious;

  CategorySpending({
    required this.category,
    required this.amount,
    required this.percentage,
    required this.changeFromPrevious,
  });

  factory CategorySpending.fromJson(Map<String, dynamic> json) {
    return CategorySpending(
      category: json['category'],
      amount: json['amount'].toDouble(),
      percentage: json['percentage'].toDouble(),
      changeFromPrevious: json['changeFromPrevious'].toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'category': category,
      'amount': amount,
      'percentage': percentage,
      'changeFromPrevious': changeFromPrevious,
    };
  }
}

class SpendingTrend {
  final String period;
  final double amount;
  final double change;

  SpendingTrend({
    required this.period,
    required this.amount,
    required this.change,
  });

  factory SpendingTrend.fromJson(Map<String, dynamic> json) {
    return SpendingTrend(
      period: json['period'],
      amount: json['amount'].toDouble(),
      change: json['change'].toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'period': period,
      'amount': amount,
      'change': change,
    };
  }
}
