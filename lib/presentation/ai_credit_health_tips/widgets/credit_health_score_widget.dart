import 'package:flutter/material.dart';

class CreditHealthScoreWidget extends StatefulWidget {
  final int creditScore;
  final int previousScore;
  final String trend;

  const CreditHealthScoreWidget({
    Key? key,
    required this.creditScore,
    required this.previousScore,
    required this.trend,
  }) : super(key: key);

  @override
  State<CreditHealthScoreWidget> createState() =>
      _CreditHealthScoreWidgetState();
}

class _CreditHealthScoreWidgetState extends State<CreditHealthScoreWidget>
    with TickerProviderStateMixin {
  late AnimationController _progressController;
  late AnimationController _scoreController;
  late Animation<double> _progressAnimation;
  late Animation<int> _scoreAnimation;

  @override
  void initState() {
    super.initState();

    _progressController = AnimationController(
      duration: const Duration(milliseconds: 2000),
      vsync: this,
    );

    _scoreController = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    );

    final double normalizedScore = (widget.creditScore - 300) / 550;
    _progressAnimation = Tween<double>(
      begin: 0,
      end: normalizedScore,
    ).animate(CurvedAnimation(
      parent: _progressController,
      curve: Curves.easeOutCubic,
    ));

    _scoreAnimation = IntTween(
      begin: 300,
      end: widget.creditScore,
    ).animate(CurvedAnimation(
      parent: _scoreController,
      curve: Curves.easeOutCubic,
    ));

    // Start animations
    Future.delayed(const Duration(milliseconds: 500), () {
      _progressController.forward();
      _scoreController.forward();
    });
  }

  @override
  void dispose() {
    _progressController.dispose();
    _scoreController.dispose();
    super.dispose();
  }

  Color _getScoreColor(int score) {
    if (score >= 750) return const Color(0xFF00c851);
    if (score >= 650) return const Color(0xFF4285f4);
    if (score >= 550) return const Color(0xFFff8800);
    return const Color(0xFFff4444);
  }

  String _getScoreCategory(int score) {
    if (score >= 750) return 'Excellent';
    if (score >= 650) return 'Good';
    if (score >= 550) return 'Fair';
    return 'Poor';
  }

  @override
  Widget build(BuildContext context) {
    final scoreColor = _getScoreColor(widget.creditScore);
    final scoreCategory = _getScoreCategory(widget.creditScore);
    final scoreDifference = widget.creditScore - widget.previousScore;

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha(26),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          // Header
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Credit Health Score',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: scoreColor.withAlpha(26),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  scoreCategory,
                  style: TextStyle(
                    color: scoreColor,
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 30),

          // Animated circular progress
          Stack(
            alignment: Alignment.center,
            children: [
              SizedBox(
                width: 160,
                height: 160,
                child: AnimatedBuilder(
                  animation: _progressAnimation,
                  builder: (context, child) {
                    return CircularProgressIndicator(
                      value: _progressAnimation.value,
                      strokeWidth: 12,
                      backgroundColor: Colors.grey.withAlpha(51),
                      valueColor: AlwaysStoppedAnimation<Color>(scoreColor),
                      strokeCap: StrokeCap.round,
                    );
                  },
                ),
              ),
              Column(
                children: [
                  AnimatedBuilder(
                    animation: _scoreAnimation,
                    builder: (context, child) {
                      return Text(
                        _scoreAnimation.value.toString(),
                        style: TextStyle(
                          fontSize: 36,
                          fontWeight: FontWeight.bold,
                          color: scoreColor,
                        ),
                      );
                    },
                  ),
                  Text(
                    'out of 850',
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                ],
              ),
            ],
          ),

          const SizedBox(height: 30),

          // Trend comparison
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: scoreDifference >= 0
                  ? const Color(0xFF00c851).withAlpha(26)
                  : const Color(0xFFff4444).withAlpha(26),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  scoreDifference >= 0
                      ? Icons.trending_up
                      : Icons.trending_down,
                  color: scoreDifference >= 0
                      ? const Color(0xFF00c851)
                      : const Color(0xFFff4444),
                  size: 20,
                ),
                const SizedBox(width: 8),
                Text(
                  '${scoreDifference >= 0 ? '+' : ''}$scoreDifference points',
                  style: TextStyle(
                    color: scoreDifference >= 0
                        ? const Color(0xFF00c851)
                        : const Color(0xFFff4444),
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  ' from last ${widget.trend}',
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
