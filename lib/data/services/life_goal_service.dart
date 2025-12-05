import 'dart:math';
import '../models/life_goal_model.dart';

class LifeGoalService {
  // Mock life goal categories
  static const List<String> _goalCategories = [
    'Financial',
    'Health & Fitness',
    'Career',
    'Education',
    'Travel',
    'Relationships',
    'Personal Growth',
    'Home & Family',
    'Hobbies',
    'Community',
  ];

  // Mock goal templates
  static const Map<String, List<Map<String, dynamic>>> _goalTemplates = {
    'Financial': [
      {
        'title': 'Emergency Fund',
        'description': 'Build a 6-month emergency fund',
        'targetAmount': 15000.0,
        'timeframe': 12, // months
      },
      {
        'title': 'Vacation Fund',
        'description': 'Save for dream vacation',
        'targetAmount': 5000.0,
        'timeframe': 8,
      },
      {
        'title': 'House Down Payment',
        'description': 'Save for first home down payment',
        'targetAmount': 50000.0,
        'timeframe': 36,
      },
    ],
    'Health & Fitness': [
      {
        'title': 'Marathon Training',
        'description': 'Train for and complete a marathon',
        'targetAmount': 500.0,
        'timeframe': 6,
      },
      {
        'title': 'Gym Membership',
        'description': 'Annual gym membership and training',
        'targetAmount': 1200.0,
        'timeframe': 12,
      },
    ],
    'Education': [
      {
        'title': 'Professional Certification',
        'description': 'Obtain industry certification',
        'targetAmount': 2000.0,
        'timeframe': 6,
      },
      {
        'title': 'Online Course',
        'description': 'Complete specialized online course',
        'targetAmount': 300.0,
        'timeframe': 3,
      },
    ],
  };

  Future<List<LifeGoalModel>> getUserGoals(String userId) async {
    try {
      // Simulate API call delay
      await Future.delayed(const Duration(milliseconds: 600));

      final random = Random();
      final goals = <LifeGoalModel>[];

      // Generate mock goals
      for (int i = 0; i < 5; i++) {
        final category =
            _goalCategories[random.nextInt(_goalCategories.length)];
        final templates = _goalTemplates[category] ?? [];

        if (templates.isNotEmpty) {
          final template = templates[random.nextInt(templates.length)];
          final targetAmount = template['targetAmount'].toDouble();
          final currentAmount =
              targetAmount * (0.1 + random.nextDouble() * 0.6);

          final goal = LifeGoalModel(
            id: 'goal_${DateTime.now().millisecondsSinceEpoch}_$i',
            userId: userId,
            title: template['title'],
            description: template['description'],
            category: category,
            targetAmount: targetAmount,
            currentAmount: currentAmount,
            targetDate:
                DateTime.now().add(Duration(days: template['timeframe'] * 30)),
            createdAt:
                DateTime.now().subtract(Duration(days: random.nextInt(30))),
            updatedAt: DateTime.now(),
            status: _getGoalStatus(currentAmount, targetAmount),
            milestones: _generateMilestones(targetAmount),
          );

          goals.add(goal);
        }
      }

      return goals;
    } catch (e) {
      throw Exception('Failed to fetch user goals: ${e.toString()}');
    }
  }

  Future<LifeGoalModel> createGoal({
    required String userId,
    required String title,
    required String description,
    required String category,
    required double targetAmount,
    required DateTime targetDate,
  }) async {
    try {
      // Simulate API call delay
      await Future.delayed(const Duration(milliseconds: 800));

      final goal = LifeGoalModel(
        id: 'goal_${DateTime.now().millisecondsSinceEpoch}',
        userId: userId,
        title: title,
        description: description,
        category: category,
        targetAmount: targetAmount,
        currentAmount: 0.0,
        targetDate: targetDate,
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
        status: 'active',
        milestones: _generateMilestones(targetAmount),
      );

      return goal;
    } catch (e) {
      throw Exception('Failed to create goal: ${e.toString()}');
    }
  }

  Future<LifeGoalModel> updateGoalProgress(String goalId, double amount) async {
    try {
      // Simulate API call delay
      await Future.delayed(const Duration(milliseconds: 500));

      // Mock implementation - in production, fetch and update actual goal
      final goal = await getGoalById(goalId);
      final newAmount = goal.currentAmount + amount;

      return LifeGoalModel(
        id: goal.id,
        userId: goal.userId,
        title: goal.title,
        description: goal.description,
        category: goal.category,
        targetAmount: goal.targetAmount,
        currentAmount: newAmount,
        targetDate: goal.targetDate,
        createdAt: goal.createdAt,
        updatedAt: DateTime.now(),
        status: _getGoalStatus(newAmount, goal.targetAmount),
        milestones: goal.milestones,
      );
    } catch (e) {
      throw Exception('Failed to update goal progress: ${e.toString()}');
    }
  }

  Future<LifeGoalModel> getGoalById(String goalId) async {
    try {
      // Simulate API call delay
      await Future.delayed(const Duration(milliseconds: 400));

      final random = Random();
      final targetAmount = 15000.0;
      final currentAmount = targetAmount * (0.3 + random.nextDouble() * 0.4);

      return LifeGoalModel(
        id: goalId,
        userId: 'user_123',
        title: 'Emergency Fund',
        description: 'Build a 6-month emergency fund',
        category: 'Financial',
        targetAmount: targetAmount,
        currentAmount: currentAmount,
        targetDate: DateTime.now().add(const Duration(days: 240)),
        createdAt: DateTime.now().subtract(const Duration(days: 30)),
        updatedAt: DateTime.now(),
        status: _getGoalStatus(currentAmount, targetAmount),
        milestones: _generateMilestones(targetAmount),
      );
    } catch (e) {
      throw Exception('Failed to fetch goal: ${e.toString()}');
    }
  }

  Future<List<String>> getGoalCategories() async {
    try {
      // Simulate API call delay
      await Future.delayed(const Duration(milliseconds: 200));

      return List.from(_goalCategories);
    } catch (e) {
      throw Exception('Failed to fetch goal categories: ${e.toString()}');
    }
  }

  Future<List<Map<String, dynamic>>> getGoalTemplates(String category) async {
    try {
      // Simulate API call delay
      await Future.delayed(const Duration(milliseconds: 300));

      return _goalTemplates[category] ?? [];
    } catch (e) {
      throw Exception('Failed to fetch goal templates: ${e.toString()}');
    }
  }

  Future<Map<String, dynamic>> getGoalAnalytics(String userId) async {
    try {
      // Simulate API call delay
      await Future.delayed(const Duration(milliseconds: 500));

      final random = Random();

      return {
        'totalGoals': 5,
        'activeGoals': 3,
        'completedGoals': 2,
        'totalTargetAmount': 75000.0,
        'totalCurrentAmount': 28500.0,
        'averageProgress': 0.38,
        'categoriesProgress': {
          'Financial': 0.45,
          'Health & Fitness': 0.62,
          'Education': 0.28,
          'Travel': 0.71,
        },
        'monthlyContributions': {
          'January': 800.0,
          'February': 950.0,
          'March': 1100.0,
          'April': 875.0,
          'May': 1250.0,
          'June': 1050.0,
        },
        'projectedCompletions': [
          {
            'goalTitle': 'Vacation Fund',
            'projectedDate': '2024-09-15',
            'confidence': 0.85,
          },
          {
            'goalTitle': 'Professional Certification',
            'projectedDate': '2024-11-30',
            'confidence': 0.72,
          },
        ],
        'recommendations': [
          'Consider increasing monthly contributions by 15%',
          'Your vacation fund is ahead of schedule',
          'Emergency fund needs more attention',
        ],
      };
    } catch (e) {
      throw Exception('Failed to fetch goal analytics: ${e.toString()}');
    }
  }

  Future<Map<String, dynamic>> getLifeXServices() async {
    try {
      // Simulate API call delay
      await Future.delayed(const Duration(milliseconds: 400));

      return {
        'services': [
          {
            'id': 'financial_advisor',
            'title': 'Financial Advisor',
            'description': 'Connect with certified financial advisors',
            'category': 'Financial',
            'rating': 4.8,
            'price': 150.0,
            'imageUrl':
                'https://images.unsplash.com/photo-1560472354-b33ff0c44a43?w=400',
          },
          {
            'id': 'fitness_coach',
            'title': 'Personal Trainer',
            'description': 'Achieve your fitness goals with expert guidance',
            'category': 'Health & Fitness',
            'rating': 4.9,
            'price': 80.0,
            'imageUrl':
                'https://images.unsplash.com/photo-1571019613454-1cb2f99b2d8b?w=400',
          },
          {
            'id': 'career_coach',
            'title': 'Career Coach',
            'description': 'Advance your career with professional coaching',
            'category': 'Career',
            'rating': 4.7,
            'price': 120.0,
            'imageUrl':
                'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?w=400',
          },
          {
            'id': 'travel_planner',
            'title': 'Travel Planner',
            'description': 'Plan your dream vacation with expert help',
            'category': 'Travel',
            'rating': 4.6,
            'price': 200.0,
            'imageUrl':
                'https://images.unsplash.com/photo-1488646953014-85cb44e25828?w=400',
          },
        ],
      };
    } catch (e) {
      throw Exception('Failed to fetch LifeX services: ${e.toString()}');
    }
  }

  Future<void> deleteGoal(String goalId) async {
    try {
      // Simulate API call delay
      await Future.delayed(const Duration(milliseconds: 300));

      // Mock implementation - in production, delete from database
      return;
    } catch (e) {
      throw Exception('Failed to delete goal: ${e.toString()}');
    }
  }

  String _getGoalStatus(double currentAmount, double targetAmount) {
    final progress = currentAmount / targetAmount;

    if (progress >= 1.0) {
      return 'completed';
    } else if (progress >= 0.8) {
      return 'near_completion';
    } else if (progress >= 0.5) {
      return 'on_track';
    } else {
      return 'active';
    }
  }

  List<GoalMilestone> _generateMilestones(double targetAmount) {
    final milestones = <GoalMilestone>[];
    final milestoneAmounts = [0.25, 0.50, 0.75, 1.0];

    for (int i = 0; i < milestoneAmounts.length; i++) {
      final milestone = GoalMilestone(
        id: 'milestone_${DateTime.now().millisecondsSinceEpoch}_$i',
        title: '${(milestoneAmounts[i] * 100).toInt()}% Complete',
        amount: targetAmount * milestoneAmounts[i],
        targetDate: DateTime.now().add(Duration(days: (i + 1) * 60)),
        isCompleted: false,
      );

      milestones.add(milestone);
    }

    return milestones;
  }
}
