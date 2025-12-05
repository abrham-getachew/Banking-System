class LifeGoalModel {
  final String id;
  final String userId;
  final String title;
  final String description;
  final String category;
  final double targetAmount;
  final double currentAmount;
  final DateTime targetDate;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String status;
  final List<GoalMilestone> milestones;
  final Map<String, dynamic>? metadata;

  LifeGoalModel({
    required this.id,
    required this.userId,
    required this.title,
    required this.description,
    required this.category,
    required this.targetAmount,
    required this.currentAmount,
    required this.targetDate,
    required this.createdAt,
    required this.updatedAt,
    required this.status,
    required this.milestones,
    this.metadata,
  });

  factory LifeGoalModel.fromJson(Map<String, dynamic> json) {
    return LifeGoalModel(
      id: json['id'],
      userId: json['userId'],
      title: json['title'],
      description: json['description'],
      category: json['category'],
      targetAmount: json['targetAmount'].toDouble(),
      currentAmount: json['currentAmount'].toDouble(),
      targetDate: DateTime.parse(json['targetDate']),
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
      status: json['status'],
      milestones: (json['milestones'] as List)
          .map((milestone) => GoalMilestone.fromJson(milestone))
          .toList(),
      metadata: json['metadata'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userId': userId,
      'title': title,
      'description': description,
      'category': category,
      'targetAmount': targetAmount,
      'currentAmount': currentAmount,
      'targetDate': targetDate.toIso8601String(),
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
      'status': status,
      'milestones': milestones.map((milestone) => milestone.toJson()).toList(),
      'metadata': metadata,
    };
  }

  double get progressPercentage {
    if (targetAmount == 0) return 0.0;
    return (currentAmount / targetAmount * 100).clamp(0.0, 100.0);
  }
}

class GoalMilestone {
  final String id;
  final String title;
  final double amount;
  final DateTime targetDate;
  final bool isCompleted;
  final DateTime? completedAt;

  GoalMilestone({
    required this.id,
    required this.title,
    required this.amount,
    required this.targetDate,
    required this.isCompleted,
    this.completedAt,
  });

  factory GoalMilestone.fromJson(Map<String, dynamic> json) {
    return GoalMilestone(
      id: json['id'],
      title: json['title'],
      amount: json['amount'].toDouble(),
      targetDate: DateTime.parse(json['targetDate']),
      isCompleted: json['isCompleted'] ?? false,
      completedAt: json['completedAt'] != null
          ? DateTime.parse(json['completedAt'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'amount': amount,
      'targetDate': targetDate.toIso8601String(),
      'isCompleted': isCompleted,
      'completedAt': completedAt?.toIso8601String(),
    };
  }
}
