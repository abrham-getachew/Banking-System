import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import './widgets/ai_assistant_header_widget.dart';
import './widgets/ai_insights_widget.dart';
import './widgets/credit_health_score_widget.dart';

class AiCreditHealthTips extends StatefulWidget {
  const AiCreditHealthTips({Key? key}) : super(key: key);

  @override
  State<AiCreditHealthTips> createState() => _AiCreditHealthTipsState();
}

class _AiCreditHealthTipsState extends State<AiCreditHealthTips>
    with TickerProviderStateMixin {
  late AnimationController _fabController;
  late TabController _tabController;

  // Mock data
  final int _currentCreditScore = 742;
  final int _previousCreditScore = 718;
  final String _trend = 'month';

  final List<Map<String, dynamic>> _aiInsights = [
    {
      'id': 'insight_001',
      'type': 'utilization',
      'title': 'Optimize Credit Utilization',
      'description':
          'Your credit utilization is at 47%. Reducing it to below 30% could significantly boost your score.',
      'impact': 'High',
      'scoreImprovement': 25,
      'actionType': 'payment_plan',
    },
    {
      'id': 'insight_002',
      'type': 'payment',
      'title': 'Early Payment Strategy',
      'description':
          'Making payments before the statement date can help reduce reported balances and improve your utilization ratio.',
      'impact': 'Medium',
      'scoreImprovement': 15,
      'actionType': 'payment_timing',
    },
    {
      'id': 'insight_003',
      'type': 'spending',
      'title': 'Spending Pattern Analysis',
      'description':
          'Your highest spending categories are dining and shopping. Consider budgeting to reduce credit reliance.',
      'impact': 'Medium',
      'scoreImprovement': 12,
      'actionType': 'budget_plan',
    },
  ];

  final List<Map<String, dynamic>> _educationalModules = [
    {
      'id': 'edu_001',
      'title': 'Understanding Credit Scores',
      'description':
          'Learn how credit scores are calculated and what factors affect them',
      'duration': '5 min read',
      'progress': 0.7,
      'category': 'basics',
      'icon': Icons.school,
    },
    {
      'id': 'edu_002',
      'title': 'BNPL Impact on Credit',
      'description':
          'How Buy Now Pay Later services can affect your credit profile',
      'duration': '3 min read',
      'progress': 0.3,
      'category': 'bnpl',
      'icon': Icons.credit_card,
    },
    {
      'id': 'edu_003',
      'title': 'Responsible Borrowing',
      'description': 'Best practices for managing multiple credit accounts',
      'duration': '7 min read',
      'progress': 0.0,
      'category': 'advanced',
      'icon': Icons.trending_up,
    },
  ];

  final List<Map<String, dynamic>> _achievements = [
    {
      'id': 'ach_001',
      'title': 'Score Improver',
      'description': 'Increased credit score by 20+ points',
      'icon': Icons.star,
      'earned': true,
      'earnedDate': DateTime.now().subtract(const Duration(days: 15)),
    },
    {
      'id': 'ach_002',
      'title': 'Payment Pro',
      'description': 'Made 5 consecutive on-time payments',
      'icon': Icons.schedule,
      'earned': true,
      'earnedDate': DateTime.now().subtract(const Duration(days: 7)),
    },
    {
      'id': 'ach_003',
      'title': 'Utilization Master',
      'description': 'Keep credit utilization below 30% for 3 months',
      'icon': Icons.pie_chart,
      'earned': false,
      'progress': 0.6,
    },
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _fabController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    )..forward();
  }

  @override
  void dispose() {
    _tabController.dispose();
    _fabController.dispose();
    super.dispose();
  }

  void _onApplySuggestion(Map<String, dynamic> insight) {
    HapticFeedback.mediumImpact();

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => _buildSuggestionBottomSheet(insight),
    );
  }

  Widget _buildSuggestionBottomSheet(Map<String, dynamic> insight) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.6,
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      child: Column(
        children: [
          Container(
            width: 40,
            height: 4,
            margin: const EdgeInsets.only(top: 12),
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        color: const Color(0xFF9e814e).withAlpha(26),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Icon(
                        Icons.lightbulb,
                        color: Color(0xFF9e814e),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        insight['title'],
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Text(
                  'Implementation Guide',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const SizedBox(height: 12),
                _buildImplementationSteps(insight['actionType']),
                const SizedBox(height: 20),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                      _setImprovementGoal(insight);
                    },
                    child: const Text('Set as Goal'),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildImplementationSteps(String actionType) {
    List<String> steps;

    switch (actionType) {
      case 'payment_plan':
        steps = [
          'Review your current balances across all credit accounts',
          'Calculate 30% of your total credit limit',
          'Create a payment plan to reach this target',
          'Set up automatic payments to maintain low balances',
        ];
        break;
      case 'payment_timing':
        steps = [
          'Note your statement closing dates for each card',
          'Schedule payments 2-3 days before statement dates',
          'Use multiple small payments throughout the month',
          'Monitor your credit utilization weekly',
        ];
        break;
      case 'budget_plan':
        steps = [
          'Track your spending for the next 2 weeks',
          'Identify your top 3 spending categories',
          'Set monthly limits for each category',
          'Use cash or debit for discretionary purchases',
        ];
        break;
      default:
        steps = ['Contact support for personalized guidance'];
    }

    return Column(
      children: steps.asMap().entries.map((entry) {
        return Padding(
          padding: const EdgeInsets.only(bottom: 8),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 24,
                height: 24,
                decoration: const BoxDecoration(
                  color: Color(0xFF9e814e),
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: Text(
                    '${entry.key + 1}',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  entry.value,
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ),
            ],
          ),
        );
      }).toList(),
    );
  }

  void _setImprovementGoal(Map<String, dynamic> insight) {
    HapticFeedback.lightImpact();

    showDialog(
      context: context,
      builder: (context) => Dialog(
        backgroundColor: Colors.transparent,
        child: Container(
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: Theme.of(context).cardColor,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(
                Icons.flag,
                color: Color(0xFF00c851),
                size: 48,
              ),
              const SizedBox(height: 16),
              Text(
                'Goal Set Successfully!',
                style: Theme.of(context).textTheme.titleLarge,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8),
              Text(
                'We\'ll track your progress and send reminders',
                style: Theme.of(context).textTheme.bodyMedium,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: () => Navigator.of(context).pop(),
                child: const Text('Got it!'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildEducationalContent() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Financial Education',
          style: Theme.of(context).textTheme.titleLarge,
        ),
        const SizedBox(height: 4),
        Text(
          'Bite-sized lessons to boost your financial knowledge',
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: Colors.grey[600],
              ),
        ),
        const SizedBox(height: 16),
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: _educationalModules.length,
          itemBuilder: (context, index) {
            final module = _educationalModules[index];
            return _buildEducationalCard(module);
          },
        ),
      ],
    );
  }

  Widget _buildEducationalCard(Map<String, dynamic> module) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha(13),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: const Color(0xFF4285f4).withAlpha(26),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(
                    module['icon'],
                    color: const Color(0xFF4285f4),
                    size: 20,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        module['title'],
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      Text(
                        module['duration'],
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Text(
              module['description'],
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const SizedBox(height: 12),
            if (module['progress'] > 0) ...[
              Row(
                children: [
                  Expanded(
                    child: LinearProgressIndicator(
                      value: module['progress'],
                      backgroundColor: Colors.grey.withAlpha(51),
                      valueColor: const AlwaysStoppedAnimation<Color>(
                        Color(0xFF4285f4),
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    '${(module['progress'] * 100).toInt()}%',
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                ],
              ),
              const SizedBox(height: 8),
            ],
            TextButton(
              onPressed: () {
                // Open educational content
              },
              child: Text(
                module['progress'] > 0 ? 'Continue' : 'Start Learning',
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAchievements() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Achievements',
          style: Theme.of(context).textTheme.titleLarge,
        ),
        const SizedBox(height: 4),
        Text(
          'Track your credit improvement milestones',
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: Colors.grey[600],
              ),
        ),
        const SizedBox(height: 16),
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
            childAspectRatio: 1.2,
          ),
          itemCount: _achievements.length,
          itemBuilder: (context, index) {
            final achievement = _achievements[index];
            return _buildAchievementCard(achievement);
          },
        ),
      ],
    );
  }

  Widget _buildAchievementCard(Map<String, dynamic> achievement) {
    final isEarned = achievement['earned'] ?? false;
    final progress = achievement['progress'] ?? 0.0;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isEarned
            ? const Color(0xFF00c851).withAlpha(26)
            : Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: isEarned
              ? const Color(0xFF00c851).withAlpha(77)
              : Colors.grey.withAlpha(51),
          width: 1,
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            achievement['icon'],
            color: isEarned ? const Color(0xFF00c851) : Colors.grey,
            size: 32,
          ),
          const SizedBox(height: 8),
          Text(
            achievement['title'],
            style: Theme.of(context).textTheme.titleSmall?.copyWith(
                  color: isEarned ? const Color(0xFF00c851) : null,
                ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 4),
          Text(
            achievement['description'],
            style: Theme.of(context).textTheme.bodySmall,
            textAlign: TextAlign.center,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          if (!isEarned && progress > 0) ...[
            const SizedBox(height: 8),
            LinearProgressIndicator(
              value: progress,
              backgroundColor: Colors.grey.withAlpha(51),
              valueColor: const AlwaysStoppedAnimation<Color>(
                Color(0xFF9e814e),
              ),
            ),
          ],
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.arrow_back_ios),
        ),
        title: const Text('AI Credit Health Tips'),
        actions: [
          IconButton(
            onPressed: () {
              // Navigate to notification settings
            },
            icon: const Icon(Icons.notifications_outlined),
          ),
          IconButton(
            onPressed: () {
              // Share progress
            },
            icon: const Icon(Icons.share_outlined),
          ),
        ],
      ),
      body: Column(
        children: [
          // AI Assistant Header
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: AiAssistantHeaderWidget(),
          ),

          const SizedBox(height: 20),

          // Tab Bar
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 16),
            decoration: BoxDecoration(
              color: Theme.of(context).cardColor,
              borderRadius: BorderRadius.circular(12),
            ),
            child: TabBar(
              controller: _tabController,
              indicator: BoxDecoration(
                color: const Color(0xFF9e814e),
                borderRadius: BorderRadius.circular(8),
              ),
              labelColor: Colors.white,
              unselectedLabelColor: Colors.grey[600],
              tabs: const [
                Tab(text: 'Insights'),
                Tab(text: 'Learn'),
                Tab(text: 'Progress'),
              ],
            ),
          ),

          const SizedBox(height: 20),

          // Tab Content
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                // Insights Tab
                SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                    children: [
                      CreditHealthScoreWidget(
                        creditScore: _currentCreditScore,
                        previousScore: _previousCreditScore,
                        trend: _trend,
                      ),
                      const SizedBox(height: 24),
                      AiInsightsWidget(
                        insights: _aiInsights,
                        onApplySuggestion: _onApplySuggestion,
                      ),
                      const SizedBox(height: 100),
                    ],
                  ),
                ),

                // Educational Content Tab
                SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                    children: [
                      _buildEducationalContent(),
                      const SizedBox(height: 100),
                    ],
                  ),
                ),

                // Achievements Tab
                SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                    children: [
                      _buildAchievements(),
                      const SizedBox(height: 100),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      floatingActionButton: ScaleTransition(
        scale: _fabController,
        child: FloatingActionButton.extended(
          onPressed: () {
            // Navigate to goal setting
            _setImprovementGoal({'title': 'Credit Improvement Goal'});
          },
          backgroundColor: const Color(0xFF9e814e),
          foregroundColor: Colors.white,
          elevation: 6,
          icon: const Icon(Icons.flag),
          label: const Text(
            'Set Goal',
            style: TextStyle(fontWeight: FontWeight.w600),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
