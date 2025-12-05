import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../core/app_export.dart';
import './widgets/achievement_badge_widget.dart';
import './widgets/dimension_card_widget.dart';
import './widgets/progress_analytics_widget.dart';
import './widgets/service_marketplace_widget.dart';

class LifeXEcosystem extends StatefulWidget {
  const LifeXEcosystem({Key? key}) : super(key: key);

  @override
  State<LifeXEcosystem> createState() => _LifeXEcosystemState();
}

class _LifeXEcosystemState extends State<LifeXEcosystem>
    with TickerProviderStateMixin {
  late TabController _tabController;
  int _selectedBottomIndex = 4; // LifeX tab active

  final List<Map<String, dynamic>> lifeDimensions = [
    {
      "id": 1,
      "name": "Health",
      "icon": "health_and_safety",
      "progress": 0.75,
      "budget": "\$2,500",
      "spent": "\$1,875",
      "color": Color(0xFF4ade80),
      "activities": [
        {"type": "Medical Checkup", "amount": "\$350", "date": "2025-07-08"},
        {"type": "Gym Membership", "amount": "\$89", "date": "2025-07-05"},
        {"type": "Supplements", "amount": "\$125", "date": "2025-07-03"}
      ],
      "goals": [
        "Annual Health Screening",
        "Fitness Tracker Purchase",
        "Nutrition Plan"
      ],
      "status": "on_track"
    },
    {
      "id": 2,
      "name": "Fitness",
      "icon": "fitness_center",
      "progress": 0.60,
      "budget": "\$1,800",
      "spent": "\$1,080",
      "color": Color(0xFFf59e0b),
      "activities": [
        {"type": "Personal Training", "amount": "\$400", "date": "2025-07-07"},
        {"type": "Workout Gear", "amount": "\$280", "date": "2025-07-04"},
        {"type": "Protein Powder", "amount": "\$65", "date": "2025-07-02"}
      ],
      "goals": ["Marathon Training", "Home Gym Setup", "Yoga Classes"],
      "status": "needs_attention"
    },
    {
      "id": 3,
      "name": "Education",
      "icon": "school",
      "progress": 0.85,
      "budget": "\$5,000",
      "spent": "\$4,250",
      "color": Color(0xFF3b82f6),
      "activities": [
        {"type": "Online Course", "amount": "\$299", "date": "2025-07-06"},
        {"type": "Books & Materials", "amount": "\$180", "date": "2025-07-04"},
        {"type": "Certification Exam", "amount": "\$450", "date": "2025-07-01"}
      ],
      "goals": ["AWS Certification", "MBA Program", "Language Learning"],
      "status": "excellent"
    },
    {
      "id": 4,
      "name": "Family",
      "icon": "family_restroom",
      "progress": 0.45,
      "budget": "\$3,200",
      "spent": "\$1,440",
      "color": Color(0xFFec4899),
      "activities": [
        {"type": "Child Savings", "amount": "\$500", "date": "2025-07-08"},
        {"type": "Family Insurance", "amount": "\$320", "date": "2025-07-05"},
        {
          "type": "Family Vacation Fund",
          "amount": "\$200",
          "date": "2025-07-03"
        }
      ],
      "goals": ["College Fund", "Family Emergency Fund", "Life Insurance"],
      "status": "behind"
    },
    {
      "id": 5,
      "name": "Spiritual",
      "icon": "self_improvement",
      "progress": 0.70,
      "budget": "\$1,200",
      "spent": "\$840",
      "color": Color(0xFF8b5cf6),
      "activities": [
        {"type": "Meditation App", "amount": "\$120", "date": "2025-07-07"},
        {"type": "Spiritual Coaching", "amount": "\$200", "date": "2025-07-05"},
        {
          "type": "Retreat Registration",
          "amount": "\$350",
          "date": "2025-07-02"
        }
      ],
      "goals": ["Mindfulness Practice", "Spiritual Retreat", "Life Coaching"],
      "status": "on_track"
    },
    {
      "id": 6,
      "name": "Vision",
      "icon": "visibility",
      "progress": 0.90,
      "budget": "\$4,500",
      "spent": "\$4,050",
      "color": Color(0xFF06b6d4),
      "activities": [
        {"type": "Vision Board Tools", "amount": "\$150", "date": "2025-07-08"},
        {
          "type": "Goal Setting Workshop",
          "amount": "\$300",
          "date": "2025-07-06"
        },
        {"type": "Investment Planning", "amount": "\$500", "date": "2025-07-04"}
      ],
      "goals": ["5-Year Plan", "Investment Portfolio", "Dream Home Fund"],
      "status": "excellent"
    },
    {
      "id": 7,
      "name": "Social",
      "icon": "groups",
      "progress": 0.55,
      "budget": "\$2,000",
      "spent": "\$1,100",
      "color": Color(0xFFf97316),
      "activities": [
        {"type": "Community Events", "amount": "\$180", "date": "2025-07-07"},
        {
          "type": "Group Savings Challenge",
          "amount": "\$250",
          "date": "2025-07-05"
        },
        {"type": "Networking Events", "amount": "\$120", "date": "2025-07-03"}
      ],
      "goals": [
        "Community Involvement",
        "Social Impact Fund",
        "Networking Growth"
      ],
      "status": "needs_attention"
    }
  ];

  final List<Map<String, dynamic>> serviceMarketplace = [
    {
      "id": 1,
      "name": "HealthFirst Medical",
      "category": "Health",
      "rating": 4.8,
      "discount": "15% off",
      "image":
          "https://images.unsplash.com/photo-1559757148-5c350d0d3c56?w=400&h=300&fit=crop",
      "description": "Comprehensive health checkups and preventive care"
    },
    {
      "id": 2,
      "name": "FitLife Gym Network",
      "category": "Fitness",
      "rating": 4.6,
      "discount": "20% off",
      "image":
          "https://images.unsplash.com/photo-1534438327276-14e5300c3a48?w=400&h=300&fit=crop",
      "description": "Premium fitness centers with personal training"
    },
    {
      "id": 3,
      "name": "EduTech Academy",
      "category": "Education",
      "rating": 4.9,
      "discount": "25% off",
      "image":
          "https://images.unsplash.com/photo-1522202176988-66273c2fd55f?w=400&h=300&fit=crop",
      "description": "Online courses and professional certifications"
    },
    {
      "id": 4,
      "name": "Family Care Plus",
      "category": "Family",
      "rating": 4.7,
      "discount": "10% off",
      "image":
          "https://images.unsplash.com/photo-1511895426328-dc8714191300?w=400&h=300&fit=crop",
      "description": "Family insurance and financial planning services"
    }
  ];

  final List<Map<String, dynamic>> achievements = [
    {
      "id": 1,
      "title": "Health Champion",
      "description": "Completed 30-day wellness challenge",
      "icon": "emoji_events",
      "earned": true,
      "date": "2025-07-01"
    },
    {
      "id": 2,
      "title": "Learning Streak",
      "description": "7 days of continuous learning",
      "icon": "school",
      "earned": true,
      "date": "2025-07-05"
    },
    {
      "id": 3,
      "title": "Savings Master",
      "description": "Reached monthly savings goal",
      "icon": "savings",
      "earned": false,
      "date": null
    },
    {
      "id": 4,
      "title": "Community Leader",
      "description": "Organized group savings challenge",
      "icon": "groups",
      "earned": true,
      "date": "2025-07-03"
    }
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.primaryDark,
      body: SafeArea(
        child: Column(
          children: [
            _buildHeader(),
            _buildTabBar(),
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: [
                  _buildDashboardTab(),
                  _buildAnalyticsTab(),
                  _buildMarketplaceTab(),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: _buildBottomNavigationBar(),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 2.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'LifeX Ecosystem',
                style: AppTheme.darkTheme.textTheme.headlineSmall?.copyWith(
                  color: AppTheme.textPrimary,
                  fontWeight: FontWeight.w700,
                ),
              ),
              SizedBox(height: 0.5.h),
              Text(
                'Holistic Life Management',
                style: AppTheme.darkTheme.textTheme.bodyMedium?.copyWith(
                  color: AppTheme.textSecondary,
                ),
              ),
            ],
          ),
          Container(
            padding: EdgeInsets.all(2.w),
            decoration: BoxDecoration(
              color: AppTheme.secondaryDark,
              borderRadius: BorderRadius.circular(12),
            ),
            child: CustomIconWidget(
              iconName: 'notifications',
              color: AppTheme.accentGold,
              size: 24,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTabBar() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 4.w),
      child: TabBar(
        controller: _tabController,
        tabs: [
          Tab(text: 'Dashboard'),
          Tab(text: 'Analytics'),
          Tab(text: 'Marketplace'),
        ],
      ),
    );
  }

  Widget _buildDashboardTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(4.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildOverallProgress(),
          SizedBox(height: 3.h),
          _buildDimensionsGrid(),
          SizedBox(height: 3.h),
          _buildAchievements(),
        ],
      ),
    );
  }

  Widget _buildAnalyticsTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(4.w),
      child: Column(
        children: [
          ProgressAnalyticsWidget(dimensions: lifeDimensions),
        ],
      ),
    );
  }

  Widget _buildMarketplaceTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(4.w),
      child: Column(
        children: [
          ServiceMarketplaceWidget(services: serviceMarketplace),
        ],
      ),
    );
  }

  Widget _buildOverallProgress() {
    double overallProgress = lifeDimensions.fold(
            0.0, (sum, dimension) => sum + (dimension['progress'] as double)) /
        lifeDimensions.length;

    return Container(
      padding: EdgeInsets.all(4.w),
      decoration: BoxDecoration(
        color: AppTheme.secondaryDark,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppTheme.accentGold.withValues(alpha: 0.3)),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Overall Progress',
                style: AppTheme.darkTheme.textTheme.titleMedium?.copyWith(
                  color: AppTheme.textPrimary,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Text(
                '${(overallProgress * 100).toInt()}%',
                style: AppTheme.darkTheme.textTheme.titleMedium?.copyWith(
                  color: AppTheme.accentGold,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
          SizedBox(height: 2.h),
          Stack(
            children: [
              Container(
                height: 8,
                decoration: BoxDecoration(
                  color: AppTheme.borderGray,
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
              Container(
                height: 8,
                width: 80.w * overallProgress,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [AppTheme.accentGold, AppTheme.successGreen],
                  ),
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
            ],
          ),
          SizedBox(height: 2.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Total Budget: \$20,200',
                style: AppTheme.darkTheme.textTheme.bodySmall?.copyWith(
                  color: AppTheme.textSecondary,
                ),
              ),
              Text(
                'Spent: \$14,635',
                style: AppTheme.darkTheme.textTheme.bodySmall?.copyWith(
                  color: AppTheme.textSecondary,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildDimensionsGrid() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Life Dimensions',
          style: AppTheme.darkTheme.textTheme.titleLarge?.copyWith(
            color: AppTheme.textPrimary,
            fontWeight: FontWeight.w600,
          ),
        ),
        SizedBox(height: 2.h),
        GridView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 3.w,
            mainAxisSpacing: 2.h,
            childAspectRatio: 0.85,
          ),
          itemCount: lifeDimensions.length,
          itemBuilder: (context, index) {
            return DimensionCardWidget(
              dimension: lifeDimensions[index],
              onTap: () => _showDimensionDetails(lifeDimensions[index]),
            );
          },
        ),
      ],
    );
  }

  Widget _buildAchievements() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Recent Achievements',
              style: AppTheme.darkTheme.textTheme.titleLarge?.copyWith(
                color: AppTheme.textPrimary,
                fontWeight: FontWeight.w600,
              ),
            ),
            TextButton(
              onPressed: () => _showAllAchievements(),
              child: Text('View All'),
            ),
          ],
        ),
        SizedBox(height: 2.h),
        SizedBox(
          height: 12.h,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: achievements.where((a) => a['earned'] == true).length,
            itemBuilder: (context, index) {
              final earnedAchievements =
                  achievements.where((a) => a['earned'] == true).toList();
              return AchievementBadgeWidget(
                achievement: earnedAchievements[index],
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildBottomNavigationBar() {
    return Container(
      decoration: BoxDecoration(
        color: AppTheme.secondaryDark,
        border: Border(
          top: BorderSide(color: AppTheme.borderGray, width: 0.5),
        ),
      ),
      child: BottomNavigationBar(
        currentIndex: _selectedBottomIndex,
        onTap: (index) {
          setState(() {
            _selectedBottomIndex = index;
          });
          _navigateToTab(index);
        },
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.transparent,
        elevation: 0,
        selectedItemColor: AppTheme.accentGold,
        unselectedItemColor: AppTheme.textSecondary,
        items: [
          BottomNavigationBarItem(
            icon: CustomIconWidget(
              iconName: 'account_balance_wallet',
              color: _selectedBottomIndex == 0
                  ? AppTheme.accentGold
                  : AppTheme.textSecondary,
              size: 24,
            ),
            label: 'Wallet',
          ),
          BottomNavigationBarItem(
            icon: CustomIconWidget(
              iconName: 'send',
              color: _selectedBottomIndex == 1
                  ? AppTheme.accentGold
                  : AppTheme.textSecondary,
              size: 24,
            ),
            label: 'Transfer',
          ),
          BottomNavigationBarItem(
            icon: CustomIconWidget(
              iconName: 'history',
              color: _selectedBottomIndex == 2
                  ? AppTheme.accentGold
                  : AppTheme.textSecondary,
              size: 24,
            ),
            label: 'History',
          ),
          BottomNavigationBarItem(
            icon: CustomIconWidget(
              iconName: 'currency_bitcoin',
              color: _selectedBottomIndex == 3
                  ? AppTheme.accentGold
                  : AppTheme.textSecondary,
              size: 24,
            ),
            label: 'Crypto',
          ),
          BottomNavigationBarItem(
            icon: CustomIconWidget(
              iconName: 'palette',
              color: _selectedBottomIndex == 4
                  ? AppTheme.accentGold
                  : AppTheme.textSecondary,
              size: 24,
            ),
            label: 'LifeX',
          ),
          BottomNavigationBarItem(
            icon: CustomIconWidget(
              iconName: 'image',
              color: _selectedBottomIndex == 5
                  ? AppTheme.accentGold
                  : AppTheme.textSecondary,
              size: 24,
            ),
            label: 'NFT',
          ),
        ],
      ),
    );
  }

  void _navigateToTab(int index) {
    final routes = [
      '/digital-wallet',
      '/money-transfer',
      '/transaction-history',
      '/cryptocurrency-trading',
      '/life-x-ecosystem',
      '/nft-marketplace',
    ];

    if (index != 4) {
      Navigator.pushNamed(context, routes[index]);
    }
  }

  void _showDimensionDetails(Map<String, dynamic> dimension) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => _buildDimensionDetailsModal(dimension),
    );
  }

  Widget _buildDimensionDetailsModal(Map<String, dynamic> dimension) {
    return Container(
      height: 80.h,
      decoration: BoxDecoration(
        color: AppTheme.surfaceModal,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.all(4.w),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  dimension['name'],
                  style: AppTheme.darkTheme.textTheme.headlineSmall?.copyWith(
                    color: AppTheme.textPrimary,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: CustomIconWidget(
                    iconName: 'close',
                    color: AppTheme.textSecondary,
                    size: 24,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.all(4.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildProgressCircle(dimension),
                  SizedBox(height: 3.h),
                  _buildBudgetInfo(dimension),
                  SizedBox(height: 3.h),
                  _buildRecentActivities(dimension),
                  SizedBox(height: 3.h),
                  _buildGoals(dimension),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProgressCircle(Map<String, dynamic> dimension) {
    return Center(
      child: Container(
        width: 40.w,
        height: 40.w,
        child: Stack(
          alignment: Alignment.center,
          children: [
            SizedBox(
              width: 40.w,
              height: 40.w,
              child: CircularProgressIndicator(
                value: dimension['progress'],
                strokeWidth: 8,
                backgroundColor: AppTheme.borderGray,
                valueColor: AlwaysStoppedAnimation<Color>(dimension['color']),
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CustomIconWidget(
                  iconName: dimension['icon'],
                  color: dimension['color'],
                  size: 32,
                ),
                SizedBox(height: 1.h),
                Text(
                  '${(dimension['progress'] * 100).toInt()}%',
                  style: AppTheme.darkTheme.textTheme.titleLarge?.copyWith(
                    color: AppTheme.textPrimary,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBudgetInfo(Map<String, dynamic> dimension) {
    return Container(
      padding: EdgeInsets.all(4.w),
      decoration: BoxDecoration(
        color: AppTheme.secondaryDark,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Budget',
                style: AppTheme.darkTheme.textTheme.bodySmall?.copyWith(
                  color: AppTheme.textSecondary,
                ),
              ),
              Text(
                dimension['budget'],
                style: AppTheme.darkTheme.textTheme.titleMedium?.copyWith(
                  color: AppTheme.textPrimary,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                'Spent',
                style: AppTheme.darkTheme.textTheme.bodySmall?.copyWith(
                  color: AppTheme.textSecondary,
                ),
              ),
              Text(
                dimension['spent'],
                style: AppTheme.darkTheme.textTheme.titleMedium?.copyWith(
                  color: dimension['color'],
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildRecentActivities(Map<String, dynamic> dimension) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Recent Activities',
          style: AppTheme.darkTheme.textTheme.titleMedium?.copyWith(
            color: AppTheme.textPrimary,
            fontWeight: FontWeight.w600,
          ),
        ),
        SizedBox(height: 2.h),
        ...(dimension['activities'] as List)
            .map((activity) => Container(
                  margin: EdgeInsets.only(bottom: 2.h),
                  padding: EdgeInsets.all(3.w),
                  decoration: BoxDecoration(
                    color: AppTheme.secondaryDark,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              activity['type'],
                              style: AppTheme.darkTheme.textTheme.bodyMedium
                                  ?.copyWith(
                                color: AppTheme.textPrimary,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            Text(
                              activity['date'],
                              style: AppTheme.darkTheme.textTheme.bodySmall
                                  ?.copyWith(
                                color: AppTheme.textSecondary,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Text(
                        activity['amount'],
                        style:
                            AppTheme.darkTheme.textTheme.bodyMedium?.copyWith(
                          color: dimension['color'],
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ))
            .toList(),
      ],
    );
  }

  Widget _buildGoals(Map<String, dynamic> dimension) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Goals',
          style: AppTheme.darkTheme.textTheme.titleMedium?.copyWith(
            color: AppTheme.textPrimary,
            fontWeight: FontWeight.w600,
          ),
        ),
        SizedBox(height: 2.h),
        ...(dimension['goals'] as List)
            .map((goal) => Container(
                  margin: EdgeInsets.only(bottom: 1.h),
                  padding: EdgeInsets.all(3.w),
                  decoration: BoxDecoration(
                    color: AppTheme.secondaryDark,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    children: [
                      CustomIconWidget(
                        iconName: 'radio_button_unchecked',
                        color: dimension['color'],
                        size: 20,
                      ),
                      SizedBox(width: 3.w),
                      Expanded(
                        child: Text(
                          goal,
                          style:
                              AppTheme.darkTheme.textTheme.bodyMedium?.copyWith(
                            color: AppTheme.textPrimary,
                          ),
                        ),
                      ),
                    ],
                  ),
                ))
            .toList(),
      ],
    );
  }

  void _showAllAchievements() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        height: 70.h,
        decoration: BoxDecoration(
          color: AppTheme.surfaceModal,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.all(4.w),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'All Achievements',
                    style: AppTheme.darkTheme.textTheme.headlineSmall?.copyWith(
                      color: AppTheme.textPrimary,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: CustomIconWidget(
                      iconName: 'close',
                      color: AppTheme.textSecondary,
                      size: 24,
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: ListView.builder(
                padding: EdgeInsets.all(4.w),
                itemCount: achievements.length,
                itemBuilder: (context, index) {
                  return AchievementBadgeWidget(
                    achievement: achievements[index],
                    isExpanded: true,
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
