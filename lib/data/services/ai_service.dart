import 'dart:math';
import '../models/ai_recommendation_model.dart';

class AIService {
  // Mock AI recommendations - in production, integrate with ML models
  static const List<Map<String, dynamic>> _mockRecommendations = [
    {
      'type': 'savings',
      'title': 'Increase Your Emergency Fund',
      'description':
          'Based on your spending patterns, consider increasing your emergency fund by \$500',
      'confidence': 0.85,
      'priority': 'high',
      'data': {
        'targetAmount': 500.0,
        'currentAmount': 2000.0,
        'recommendedAmount': 2500.0,
        'timeframe': '3 months',
      },
    },
    {
      'type': 'investment',
      'title': 'Consider Index Fund Investment',
      'description':
          'Your risk profile suggests allocating 20% to low-cost index funds',
      'confidence': 0.78,
      'priority': 'medium',
      'data': {
        'recommendedAllocation': 0.2,
        'fundType': 'S&P 500 Index',
        'expectedReturn': 0.07,
        'riskLevel': 'moderate',
      },
    },
    {
      'type': 'spending',
      'title': 'Reduce Dining Out Expenses',
      'description':
          'You\'ve spent 15% more on dining out this month. Consider meal planning.',
      'confidence': 0.92,
      'priority': 'medium',
      'data': {
        'currentSpending': 450.0,
        'averageSpending': 325.0,
        'potentialSavings': 125.0,
        'category': 'food_dining',
      },
    },
    {
      'type': 'goal',
      'title': 'Vacation Fund Progress',
      'description':
          'You\'re on track to reach your vacation goal 2 months early!',
      'confidence': 0.95,
      'priority': 'low',
      'data': {
        'goalId': 'vacation_2024',
        'currentProgress': 0.75,
        'projectedCompletion': '2024-08-15',
        'originalTarget': '2024-10-15',
      },
    },
  ];

  Future<List<AIRecommendationModel>> getPersonalizedRecommendations(
      String userId) async {
    try {
      // Simulate AI processing delay
      await Future.delayed(const Duration(milliseconds: 1000));

      final random = Random();
      final recommendations = <AIRecommendationModel>[];

      for (final data in _mockRecommendations) {
        final recommendation = AIRecommendationModel(
          id: 'ai_rec_${DateTime.now().millisecondsSinceEpoch}_${random.nextInt(1000)}',
          userId: userId,
          type: data['type'],
          title: data['title'],
          description: data['description'],
          confidence: data['confidence'].toDouble(),
          data: data['data'],
          createdAt: DateTime.now(),
          expiresAt: DateTime.now().add(const Duration(days: 7)),
          isRead: false,
          priority: data['priority'],
        );

        recommendations.add(recommendation);
      }

      return recommendations;
    } catch (e) {
      throw Exception('Failed to fetch AI recommendations: ${e.toString()}');
    }
  }

  Future<SpendingAnalysisModel> analyzeSpendingPatterns(String userId) async {
    try {
      // Simulate AI analysis delay
      await Future.delayed(const Duration(milliseconds: 1200));

      final random = Random();

      final categoryBreakdown = {
        'food_dining': CategorySpending(
          category: 'Food & Dining',
          amount: 850.0 + random.nextDouble() * 200,
          percentage: 35.0 + random.nextDouble() * 5,
          changeFromPrevious: -5.0 + random.nextDouble() * 10,
        ),
        'shopping': CategorySpending(
          category: 'Shopping',
          amount: 450.0 + random.nextDouble() * 150,
          percentage: 18.0 + random.nextDouble() * 3,
          changeFromPrevious: 2.0 + random.nextDouble() * 8,
        ),
        'transportation': CategorySpending(
          category: 'Transportation',
          amount: 320.0 + random.nextDouble() * 80,
          percentage: 13.0 + random.nextDouble() * 2,
          changeFromPrevious: -2.0 + random.nextDouble() * 6,
        ),
        'entertainment': CategorySpending(
          category: 'Entertainment',
          amount: 280.0 + random.nextDouble() * 120,
          percentage: 12.0 + random.nextDouble() * 3,
          changeFromPrevious: 8.0 + random.nextDouble() * 10,
        ),
        'utilities': CategorySpending(
          category: 'Bills & Utilities',
          amount: 220.0 + random.nextDouble() * 50,
          percentage: 9.0 + random.nextDouble() * 2,
          changeFromPrevious: 1.0 + random.nextDouble() * 3,
        ),
      };

      final trends = [
        SpendingTrend(period: 'January', amount: 2100.0, change: 5.2),
        SpendingTrend(period: 'February', amount: 1950.0, change: -7.1),
        SpendingTrend(period: 'March', amount: 2250.0, change: 15.4),
        SpendingTrend(period: 'April', amount: 2080.0, change: -7.6),
        SpendingTrend(period: 'May', amount: 2320.0, change: 11.5),
        SpendingTrend(period: 'June', amount: 2150.0, change: -7.3),
      ];

      return SpendingAnalysisModel(
        id: 'analysis_${DateTime.now().millisecondsSinceEpoch}',
        userId: userId,
        period: 'monthly',
        totalSpent: 2150.0 + random.nextDouble() * 300,
        totalIncome: 4500.0 + random.nextDouble() * 500,
        savingsRate: 0.48 + random.nextDouble() * 0.1,
        categoryBreakdown: categoryBreakdown,
        trends: trends,
        generatedAt: DateTime.now(),
      );
    } catch (e) {
      throw Exception('Failed to analyze spending patterns: ${e.toString()}');
    }
  }

  Future<Map<String, dynamic>> generateInvestmentSuggestions(
      String userId) async {
    try {
      // Simulate AI processing delay
      await Future.delayed(const Duration(milliseconds: 900));

      final random = Random();

      final suggestions = [
        {
          'type': 'stocks',
          'title': 'Technology Sector ETF',
          'description': 'Diversified tech exposure with low fees',
          'symbol': 'QQQ',
          'expectedReturn': 0.08 + random.nextDouble() * 0.04,
          'riskLevel': 'moderate',
          'confidence': 0.75 + random.nextDouble() * 0.2,
          'recommendedAllocation': 0.25,
        },
        {
          'type': 'bonds',
          'title': 'Government Bond Index',
          'description': 'Stable income with low volatility',
          'symbol': 'AGG',
          'expectedReturn': 0.03 + random.nextDouble() * 0.02,
          'riskLevel': 'low',
          'confidence': 0.85 + random.nextDouble() * 0.1,
          'recommendedAllocation': 0.30,
        },
        {
          'type': 'crypto',
          'title': 'Bitcoin Allocation',
          'description': 'Small allocation to digital assets',
          'symbol': 'BTC',
          'expectedReturn': 0.12 + random.nextDouble() * 0.08,
          'riskLevel': 'high',
          'confidence': 0.60 + random.nextDouble() * 0.2,
          'recommendedAllocation': 0.05,
        },
      ];

      return {
        'suggestions': suggestions,
        'riskProfile': 'moderate',
        'timeHorizon': '5-10 years',
        'totalRecommendedAllocation': 0.60,
        'remainingCash': 0.40,
        'generatedAt': DateTime.now().toIso8601String(),
      };
    } catch (e) {
      throw Exception(
          'Failed to generate investment suggestions: ${e.toString()}');
    }
  }

  Future<Map<String, dynamic>> predictFinancialForecast(String userId) async {
    try {
      // Simulate AI prediction delay
      await Future.delayed(const Duration(milliseconds: 1100));

      final random = Random();
      final currentBalance = 15000.0 + random.nextDouble() * 10000;

      final forecast = <String, dynamic>{
        'currentBalance': currentBalance,
        'projectedBalances': {
          '3_months': currentBalance + (500 + random.nextDouble() * 200) * 3,
          '6_months': currentBalance + (500 + random.nextDouble() * 200) * 6,
          '1_year': currentBalance + (500 + random.nextDouble() * 200) * 12,
        },
        'savingsGoalProgress': {
          'emergency_fund': {
            'target': 10000.0,
            'current': 7500.0,
            'projectedCompletion': '2024-12-15',
          },
          'vacation': {
            'target': 5000.0,
            'current': 3200.0,
            'projectedCompletion': '2024-09-30',
          },
          'house_down_payment': {
            'target': 50000.0,
            'current': 12000.0,
            'projectedCompletion': '2027-03-15',
          },
        },
        'riskFactors': [
          {
            'factor': 'Variable income',
            'impact': 'medium',
            'probability': 0.3,
          },
          {
            'factor': 'Market volatility',
            'impact': 'low',
            'probability': 0.2,
          },
          {
            'factor': 'Inflation',
            'impact': 'medium',
            'probability': 0.6,
          },
        ],
        'recommendations': [
          'Increase emergency fund allocation',
          'Consider inflation-protected investments',
          'Review and adjust monthly budget',
        ],
        'confidence': 0.82,
        'generatedAt': DateTime.now().toIso8601String(),
      };

      return forecast;
    } catch (e) {
      throw Exception('Failed to generate financial forecast: ${e.toString()}');
    }
  }

  Future<Map<String, dynamic>> optimizeSavingsPlan(String userId) async {
    try {
      // Simulate AI optimization delay
      await Future.delayed(const Duration(milliseconds: 800));

      final random = Random();

      final optimizedPlan = {
        'currentSavingsRate': 0.25 + random.nextDouble() * 0.15,
        'recommendedSavingsRate': 0.30 + random.nextDouble() * 0.10,
        'monthlyIncome': 4500.0 + random.nextDouble() * 1000,
        'monthlyExpenses': 3200.0 + random.nextDouble() * 500,
        'potentialSavings': 350.0 + random.nextDouble() * 200,
        'optimizations': [
          {
            'category': 'subscriptions',
            'currentAmount': 89.99,
            'recommendedAmount': 45.99,
            'savings': 44.0,
            'difficulty': 'easy',
          },
          {
            'category': 'dining_out',
            'currentAmount': 450.0,
            'recommendedAmount': 300.0,
            'savings': 150.0,
            'difficulty': 'moderate',
          },
          {
            'category': 'transportation',
            'currentAmount': 320.0,
            'recommendedAmount': 270.0,
            'savings': 50.0,
            'difficulty': 'easy',
          },
        ],
        'automationSuggestions': [
          'Set up automatic transfer to savings',
          'Use spending alerts for categories',
          'Schedule monthly budget reviews',
        ],
        'goalAlignment': {
          'emergency_fund': 'on_track',
          'vacation': 'ahead',
          'retirement': 'behind',
        },
        'confidence': 0.88,
        'generatedAt': DateTime.now().toIso8601String(),
      };

      return optimizedPlan;
    } catch (e) {
      throw Exception('Failed to optimize savings plan: ${e.toString()}');
    }
  }

  Future<void> markRecommendationAsRead(String recommendationId) async {
    try {
      // Simulate API call delay
      await Future.delayed(const Duration(milliseconds: 200));

      // Mock implementation - in production, update database
      return;
    } catch (e) {
      throw Exception('Failed to mark recommendation as read: ${e.toString()}');
    }
  }

  Future<Map<String, dynamic>> getAIInsights(String userId) async {
    try {
      // Simulate AI processing delay
      await Future.delayed(const Duration(milliseconds: 700));

      final random = Random();

      return {
        'spendingScore': 75 + random.nextInt(20),
        'savingsScore': 68 + random.nextInt(25),
        'investmentScore': 82 + random.nextInt(15),
        'overallScore': 75 + random.nextInt(20),
        'insights': [
          'Your spending has decreased by 8% this month',
          'Emergency fund is well-funded',
          'Consider increasing retirement contributions',
        ],
        'nextActions': [
          'Review subscription services',
          'Rebalance investment portfolio',
          'Update financial goals',
        ],
        'trendDirection': 'positive',
        'lastUpdated': DateTime.now().toIso8601String(),
      };
    } catch (e) {
      throw Exception('Failed to fetch AI insights: ${e.toString()}');
    }
  }
}
