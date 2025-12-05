import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';

class GoalCreationDialog extends StatefulWidget {
  final Function(Map<String, dynamic>) onGoalCreated;

  const GoalCreationDialog({
    Key? key,
    required this.onGoalCreated,
  }) : super(key: key);

  @override
  State<GoalCreationDialog> createState() => _GoalCreationDialogState();
}

class _GoalCreationDialogState extends State<GoalCreationDialog>
    with TickerProviderStateMixin {
  final PageController _pageController = PageController();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _amountController = TextEditingController();

  int _currentStep = 0;
  String _selectedCategory = "";
  double _targetAmount = 0;
  double _timelineMonths = 12;
  double _monthlyContribution = 0;

  late AnimationController _slideAnimationController;
  late Animation<Offset> _slideAnimation;

  final List<Map<String, dynamic>> _goalCategories = [
    {
      "name": "Vacation",
      "icon": "flight_takeoff",
      "color": Color(0xFF4CAF50),
      "image":
          "https://images.unsplash.com/photo-1488646953014-85cb44e25828?w=400&h=300&fit=crop",
    },
    {
      "name": "Home",
      "icon": "home",
      "color": Color(0xFF2196F3),
      "image":
          "https://images.unsplash.com/photo-1570129477492-45c003edd2be?w=400&h=300&fit=crop",
    },
    {
      "name": "Education",
      "icon": "school",
      "color": Color(0xFFFF9800),
      "image":
          "https://images.unsplash.com/photo-1523050854058-8df90110c9f1?w=400&h=300&fit=crop",
    },
    {
      "name": "Car",
      "icon": "directions_car",
      "color": Color(0xFF9C27B0),
      "image":
          "https://images.unsplash.com/photo-1494976688153-ca3ce29d8df4?w=400&h=300&fit=crop",
    },
    {
      "name": "Emergency Fund",
      "icon": "security",
      "color": Color(0xFFF44336),
      "image":
          "https://images.unsplash.com/photo-1579621970563-ebec7560ff3e?w=400&h=300&fit=crop",
    },
    {
      "name": "Investment",
      "icon": "trending_up",
      "color": Color(0xFF607D8B),
      "image":
          "https://images.unsplash.com/photo-1611974789855-9c2a0a7236a3?w=400&h=300&fit=crop",
    },
  ];

  @override
  void initState() {
    super.initState();
    _slideAnimationController = AnimationController(
      duration: AppTheme.standardAnimation,
      vsync: this,
    );
    _slideAnimation = Tween<Offset>(
      begin: const Offset(1.0, 0.0),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _slideAnimationController,
      curve: Curves.easeInOut,
    ));

    _slideAnimationController.forward();
  }

  @override
  void dispose() {
    _pageController.dispose();
    _titleController.dispose();
    _amountController.dispose();
    _slideAnimationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: EdgeInsets.all(4.w),
      child: SlideTransition(
        position: _slideAnimation,
        child: Container(
          height: 80.h,
          decoration: BoxDecoration(
            color: AppTheme.surfaceDark,
            borderRadius: BorderRadius.circular(20.0),
          ),
          child: Column(
            children: [
              _buildHeader(),
              Expanded(
                child: PageView(
                  controller: _pageController,
                  physics: NeverScrollableScrollPhysics(),
                  children: [
                    _buildCategorySelection(),
                    _buildGoalDetails(),
                    _buildTimelineSettings(),
                  ],
                ),
              ),
              _buildNavigationButtons(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: EdgeInsets.all(4.w),
      decoration: BoxDecoration(
        color: AppTheme.chronosGold.withValues(alpha: 0.1),
        borderRadius: BorderRadius.vertical(top: Radius.circular(20.0)),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Create New Goal",
                style: AppTheme.darkTheme.textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.w600,
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
          SizedBox(height: 2.h),
          _buildProgressIndicator(),
        ],
      ),
    );
  }

  Widget _buildProgressIndicator() {
    return Row(
      children: List.generate(3, (index) {
        return Expanded(
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: 1.w),
            height: 0.5.h,
            decoration: BoxDecoration(
              color: index <= _currentStep
                  ? AppTheme.chronosGold
                  : AppTheme.dividerSubtle,
              borderRadius: BorderRadius.circular(2.0),
            ),
          ),
        );
      }),
    );
  }

  Widget _buildCategorySelection() {
    return Container(
      padding: EdgeInsets.all(4.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "What's your goal?",
            style: AppTheme.darkTheme.textTheme.headlineSmall?.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: 1.h),
          Text(
            "Choose a category that best describes your savings goal",
            style: AppTheme.darkTheme.textTheme.bodyMedium?.copyWith(
              color: AppTheme.textSecondary,
            ),
          ),
          SizedBox(height: 3.h),
          Expanded(
            child: GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 3.w,
                mainAxisSpacing: 2.h,
                childAspectRatio: 1.2,
              ),
              itemCount: _goalCategories.length,
              itemBuilder: (context, index) {
                final category = _goalCategories[index];
                final isSelected = _selectedCategory == category["name"];

                return GestureDetector(
                  onTap: () {
                    setState(() {
                      _selectedCategory = category["name"] as String;
                    });
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16.0),
                      border: Border.all(
                        color: isSelected
                            ? AppTheme.chronosGold
                            : AppTheme.dividerSubtle,
                        width: isSelected ? 2 : 1,
                      ),
                      image: DecorationImage(
                        image: NetworkImage(category["image"] as String),
                        fit: BoxFit.cover,
                        colorFilter: ColorFilter.mode(
                          Colors.black.withValues(alpha: 0.4),
                          BlendMode.darken,
                        ),
                      ),
                    ),
                    child: Container(
                      padding: EdgeInsets.all(3.w),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16.0),
                        gradient: LinearGradient(
                          colors: [
                            Colors.transparent,
                            Colors.black.withValues(alpha: 0.7),
                          ],
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                        ),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          CustomIconWidget(
                            iconName: category["icon"] as String,
                            color: isSelected
                                ? AppTheme.chronosGold
                                : AppTheme.textPrimary,
                            size: 28,
                          ),
                          SizedBox(height: 1.h),
                          Text(
                            category["name"] as String,
                            style: AppTheme.darkTheme.textTheme.titleSmall
                                ?.copyWith(
                              color: isSelected
                                  ? AppTheme.chronosGold
                                  : AppTheme.textPrimary,
                              fontWeight: FontWeight.w600,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildGoalDetails() {
    return Container(
      padding: EdgeInsets.all(4.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Goal Details",
            style: AppTheme.darkTheme.textTheme.headlineSmall?.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: 1.h),
          Text(
            "Give your goal a name and set your target amount",
            style: AppTheme.darkTheme.textTheme.bodyMedium?.copyWith(
              color: AppTheme.textSecondary,
            ),
          ),
          SizedBox(height: 4.h),
          TextField(
            controller: _titleController,
            decoration: InputDecoration(
              labelText: "Goal Name",
              hintText: "e.g., Dream Vacation to Japan",
              prefixIcon: Padding(
                padding: EdgeInsets.all(3.w),
                child: CustomIconWidget(
                  iconName: 'edit',
                  color: AppTheme.chronosGold,
                  size: 20,
                ),
              ),
            ),
          ),
          SizedBox(height: 3.h),
          TextField(
            controller: _amountController,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              labelText: "Target Amount",
              hintText: "0.00",
              prefixIcon: Padding(
                padding: EdgeInsets.all(3.w),
                child: CustomIconWidget(
                  iconName: 'attach_money',
                  color: AppTheme.chronosGold,
                  size: 20,
                ),
              ),
            ),
            onChanged: (value) {
              setState(() {
                _targetAmount = double.tryParse(value) ?? 0;
                _calculateMonthlyContribution();
              });
            },
          ),
          SizedBox(height: 4.h),
          if (_targetAmount > 0) _buildQuickAmountSuggestions(),
        ],
      ),
    );
  }

  Widget _buildQuickAmountSuggestions() {
    final suggestions = [
      _targetAmount * 0.8,
      _targetAmount,
      _targetAmount * 1.2,
      _targetAmount * 1.5,
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Quick Suggestions",
          style: AppTheme.darkTheme.textTheme.titleSmall?.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
        SizedBox(height: 2.h),
        Wrap(
          spacing: 2.w,
          runSpacing: 1.h,
          children: suggestions.map((amount) {
            return GestureDetector(
              onTap: () {
                setState(() {
                  _targetAmount = amount;
                  _amountController.text = amount.toStringAsFixed(0);
                  _calculateMonthlyContribution();
                });
              },
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 1.h),
                decoration: BoxDecoration(
                  color: AppTheme.chronosGold.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(20.0),
                  border: Border.all(
                    color: AppTheme.chronosGold.withValues(alpha: 0.3),
                    width: 1,
                  ),
                ),
                child: Text(
                  "\$${amount.toStringAsFixed(0)}",
                  style: AppTheme.darkTheme.textTheme.bodySmall?.copyWith(
                    color: AppTheme.chronosGold,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildTimelineSettings() {
    return Container(
      padding: EdgeInsets.all(4.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Timeline & Savings",
            style: AppTheme.darkTheme.textTheme.headlineSmall?.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: 1.h),
          Text(
            "Adjust your timeline to see how it affects your monthly savings",
            style: AppTheme.darkTheme.textTheme.bodyMedium?.copyWith(
              color: AppTheme.textSecondary,
            ),
          ),
          SizedBox(height: 4.h),
          _buildTimelineSlider(),
          SizedBox(height: 4.h),
          _buildSavingsBreakdown(),
          SizedBox(height: 4.h),
          _buildAIRecommendation(),
        ],
      ),
    );
  }

  Widget _buildTimelineSlider() {
    return Container(
      padding: EdgeInsets.all(4.w),
      decoration: BoxDecoration(
        color: AppTheme.surfaceDark.withValues(alpha: 0.5),
        borderRadius: BorderRadius.circular(16.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Timeline",
                style: AppTheme.darkTheme.textTheme.titleSmall?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
              Text(
                "${_timelineMonths.toInt()} months",
                style: AppTheme.darkTheme.textTheme.titleSmall?.copyWith(
                  color: AppTheme.chronosGold,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          SizedBox(height: 2.h),
          SliderTheme(
            data: SliderTheme.of(context).copyWith(
              trackHeight: 6.0,
              thumbShape: RoundSliderThumbShape(enabledThumbRadius: 12.0),
              overlayShape: RoundSliderOverlayShape(overlayRadius: 20.0),
            ),
            child: Slider(
              value: _timelineMonths,
              min: 3,
              max: 60,
              divisions: 57,
              onChanged: (value) {
                setState(() {
                  _timelineMonths = value;
                  _calculateMonthlyContribution();
                });
              },
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "3 months",
                style: AppTheme.darkTheme.textTheme.bodySmall?.copyWith(
                  color: AppTheme.textTertiary,
                ),
              ),
              Text(
                "5 years",
                style: AppTheme.darkTheme.textTheme.bodySmall?.copyWith(
                  color: AppTheme.textTertiary,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSavingsBreakdown() {
    return Container(
      padding: EdgeInsets.all(4.w),
      decoration: BoxDecoration(
        color: AppTheme.chronosGold.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(16.0),
        border: Border.all(
          color: AppTheme.chronosGold.withValues(alpha: 0.3),
          width: 1,
        ),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Monthly Savings",
                style: AppTheme.darkTheme.textTheme.titleSmall?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
              Text(
                "\$${_monthlyContribution.toStringAsFixed(0)}",
                style: AppTheme.financialDataMedium.copyWith(
                  color: AppTheme.chronosGold,
                ),
              ),
            ],
          ),
          SizedBox(height: 2.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Weekly Savings",
                style: AppTheme.darkTheme.textTheme.bodyMedium?.copyWith(
                  color: AppTheme.textSecondary,
                ),
              ),
              Text(
                "\$${(_monthlyContribution / 4).toStringAsFixed(0)}",
                style: AppTheme.darkTheme.textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
          SizedBox(height: 1.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Daily Savings",
                style: AppTheme.darkTheme.textTheme.bodyMedium?.copyWith(
                  color: AppTheme.textSecondary,
                ),
              ),
              Text(
                "\$${(_monthlyContribution / 30).toStringAsFixed(0)}",
                style: AppTheme.darkTheme.textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildAIRecommendation() {
    String recommendation = "";
    Color recommendationColor = AppTheme.successGreen;

    if (_monthlyContribution > 1000) {
      recommendation =
          "This is an ambitious goal! Consider breaking it into smaller milestones.";
      recommendationColor = AppTheme.warningAmber;
    } else if (_monthlyContribution > 500) {
      recommendation =
          "Great goal! This savings rate will build strong financial habits.";
      recommendationColor = AppTheme.successGreen;
    } else {
      recommendation = "Perfect! This is a very achievable savings target.";
      recommendationColor = AppTheme.chronosGold;
    }

    return Container(
      padding: EdgeInsets.all(4.w),
      decoration: BoxDecoration(
        color: recommendationColor.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(16.0),
        border: Border.all(
          color: recommendationColor.withValues(alpha: 0.3),
          width: 1,
        ),
      ),
      child: Row(
        children: [
          CustomIconWidget(
            iconName: 'auto_awesome',
            color: recommendationColor,
            size: 24,
          ),
          SizedBox(width: 3.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "AI Recommendation",
                  style: AppTheme.darkTheme.textTheme.titleSmall?.copyWith(
                    color: recommendationColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: 0.5.h),
                Text(
                  recommendation,
                  style: AppTheme.darkTheme.textTheme.bodySmall?.copyWith(
                    color: AppTheme.textSecondary,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNavigationButtons() {
    return Container(
      padding: EdgeInsets.all(4.w),
      child: Row(
        children: [
          if (_currentStep > 0)
            Expanded(
              child: OutlinedButton(
                onPressed: _previousStep,
                child: Text("Back"),
              ),
            ),
          if (_currentStep > 0) SizedBox(width: 3.w),
          Expanded(
            child: ElevatedButton(
              onPressed: _currentStep == 2 ? _createGoal : _nextStep,
              child: Text(_currentStep == 2 ? "Create Goal" : "Next"),
            ),
          ),
        ],
      ),
    );
  }

  void _nextStep() {
    if (_currentStep == 0 && _selectedCategory.isEmpty) return;
    if (_currentStep == 1 &&
        (_titleController.text.isEmpty || _targetAmount <= 0)) return;

    if (_currentStep < 2) {
      setState(() {
        _currentStep++;
      });
      _pageController.nextPage(
        duration: AppTheme.standardAnimation,
        curve: Curves.easeInOut,
      );
    }
  }

  void _previousStep() {
    if (_currentStep > 0) {
      setState(() {
        _currentStep--;
      });
      _pageController.previousPage(
        duration: AppTheme.standardAnimation,
        curve: Curves.easeInOut,
      );
    }
  }

  void _calculateMonthlyContribution() {
    if (_targetAmount > 0 && _timelineMonths > 0) {
      setState(() {
        _monthlyContribution = _targetAmount / _timelineMonths;
      });
    }
  }

  void _createGoal() {
    final selectedCategoryData = _goalCategories.firstWhere(
      (category) => category["name"] == _selectedCategory,
    );

    final newGoal = {
      "id": DateTime.now().millisecondsSinceEpoch,
      "title": _titleController.text,
      "category": _selectedCategory,
      "targetAmount": _targetAmount,
      "currentAmount": 0.0,
      "monthlyContribution": _monthlyContribution,
      "timelineMonths": _timelineMonths.toInt(),
      "status": "Active",
      "image": selectedCategoryData["image"],
      "estimatedCompletion": DateTime.now()
          .add(Duration(days: (_timelineMonths * 30).toInt()))
          .toString()
          .split(' ')[0],
      "aiSuggestion": "Start with automatic transfers to build consistency",
    };

    widget.onGoalCreated(newGoal);
    Navigator.pop(context);
  }
}
