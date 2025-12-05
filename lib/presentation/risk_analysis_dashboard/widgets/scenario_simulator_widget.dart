import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../../core/app_export.dart';

class ScenarioSimulatorWidget extends StatefulWidget {
  final Function(Map<String, double>) onAllocationChanged;

  const ScenarioSimulatorWidget({
    Key? key,
    required this.onAllocationChanged,
  }) : super(key: key);

  @override
  State<ScenarioSimulatorWidget> createState() =>
      _ScenarioSimulatorWidgetState();
}

class _ScenarioSimulatorWidgetState extends State<ScenarioSimulatorWidget> {
  double _stocksAllocation = 60.0;
  double _bondsAllocation = 25.0;
  double _cryptoAllocation = 10.0;
  double _cashAllocation = 5.0;
  int _currentRiskScore = 72;

  @override
  void initState() {
    super.initState();
    _updateRiskScore();
  }

  void _updateRiskScore() {
    // Calculate risk score based on allocation
    final riskScore = (_stocksAllocation * 0.8 +
            _bondsAllocation * 0.3 +
            _cryptoAllocation * 1.2 +
            _cashAllocation * 0.1)
        .round();

    setState(() {
      _currentRiskScore = riskScore.clamp(1, 100);
    });

    widget.onAllocationChanged({
      'stocks': _stocksAllocation,
      'bonds': _bondsAllocation,
      'crypto': _cryptoAllocation,
      'cash': _cashAllocation,
      'riskScore': _currentRiskScore.toDouble(),
    });
  }

  void _normalizeAllocations(String changedAsset, double newValue) {
    final total = 100.0;
    final remaining = total - newValue;

    switch (changedAsset) {
      case 'stocks':
        _stocksAllocation = newValue;
        final otherTotal =
            _bondsAllocation + _cryptoAllocation + _cashAllocation;
        if (otherTotal > 0) {
          final ratio = remaining / otherTotal;
          _bondsAllocation *= ratio;
          _cryptoAllocation *= ratio;
          _cashAllocation *= ratio;
        }
        break;
      case 'bonds':
        _bondsAllocation = newValue;
        final otherTotal =
            _stocksAllocation + _cryptoAllocation + _cashAllocation;
        if (otherTotal > 0) {
          final ratio = remaining / otherTotal;
          _stocksAllocation *= ratio;
          _cryptoAllocation *= ratio;
          _cashAllocation *= ratio;
        }
        break;
      case 'crypto':
        _cryptoAllocation = newValue;
        final otherTotal =
            _stocksAllocation + _bondsAllocation + _cashAllocation;
        if (otherTotal > 0) {
          final ratio = remaining / otherTotal;
          _stocksAllocation *= ratio;
          _bondsAllocation *= ratio;
          _cashAllocation *= ratio;
        }
        break;
      case 'cash':
        _cashAllocation = newValue;
        final otherTotal =
            _stocksAllocation + _bondsAllocation + _cryptoAllocation;
        if (otherTotal > 0) {
          final ratio = remaining / otherTotal;
          _stocksAllocation *= ratio;
          _bondsAllocation *= ratio;
          _cryptoAllocation *= ratio;
        }
        break;
    }

    _updateRiskScore();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 4.w),
      padding: EdgeInsets.all(4.w),
      decoration: BoxDecoration(
        color: AppTheme.darkTheme.colorScheme.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: AppTheme.chronosGold.withValues(alpha: 0.2),
        ),
        boxShadow: [
          BoxShadow(
            color: AppTheme.darkTheme.colorScheme.shadow,
            blurRadius: 8.0,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Row(
            children: [
              Container(
                padding: EdgeInsets.all(2.w),
                decoration: BoxDecoration(
                  color: AppTheme.chronosGold.withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: CustomIconWidget(
                  iconName: 'tune',
                  color: AppTheme.chronosGold,
                  size: 6.w,
                ),
              ),
              SizedBox(width: 3.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Scenario Simulator',
                      style: AppTheme.darkTheme.textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      'Adjust allocations to see risk impact',
                      style: AppTheme.darkTheme.textTheme.bodySmall?.copyWith(
                        color: AppTheme.textSecondary,
                      ),
                    ),
                  ],
                ),
              ),
              // Real-time risk score
              Container(
                padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 1.5.w),
                decoration: BoxDecoration(
                  color:
                      _getRiskColor(_currentRiskScore).withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color:
                        _getRiskColor(_currentRiskScore).withValues(alpha: 0.3),
                  ),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      '$_currentRiskScore',
                      style: AppTheme.darkTheme.textTheme.titleMedium?.copyWith(
                        color: _getRiskColor(_currentRiskScore),
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    SizedBox(width: 1.w),
                    CustomIconWidget(
                      iconName: 'speed',
                      color: _getRiskColor(_currentRiskScore),
                      size: 4.w,
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 4.h),
          // Allocation sliders
          _buildAllocationSlider(
            'Stocks',
            _stocksAllocation,
            AppTheme.errorRed,
            'trending_up',
            (value) => _normalizeAllocations('stocks', value),
          ),
          SizedBox(height: 3.h),
          _buildAllocationSlider(
            'Bonds',
            _bondsAllocation,
            AppTheme.successGreen,
            'account_balance',
            (value) => _normalizeAllocations('bonds', value),
          ),
          SizedBox(height: 3.h),
          _buildAllocationSlider(
            'Crypto',
            _cryptoAllocation,
            AppTheme.warningAmber,
            'currency_bitcoin',
            (value) => _normalizeAllocations('crypto', value),
          ),
          SizedBox(height: 3.h),
          _buildAllocationSlider(
            'Cash',
            _cashAllocation,
            AppTheme.textSecondary,
            'account_balance_wallet',
            (value) => _normalizeAllocations('cash', value),
          ),
          SizedBox(height: 3.h),
          // Total allocation check
          Container(
            padding: EdgeInsets.all(3.w),
            decoration: BoxDecoration(
              color: AppTheme.chronosGold.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: AppTheme.chronosGold.withValues(alpha: 0.2),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Total Allocation',
                  style: AppTheme.darkTheme.textTheme.titleSmall?.copyWith(
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Text(
                  '${(_stocksAllocation + _bondsAllocation + _cryptoAllocation + _cashAllocation).toStringAsFixed(1)}%',
                  style: AppTheme.darkTheme.textTheme.titleSmall?.copyWith(
                    color: AppTheme.chronosGold,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAllocationSlider(
    String title,
    double value,
    Color color,
    String iconName,
    Function(double) onChanged,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                CustomIconWidget(
                  iconName: iconName,
                  color: color,
                  size: 5.w,
                ),
                SizedBox(width: 2.w),
                Text(
                  title,
                  style: AppTheme.darkTheme.textTheme.titleSmall?.copyWith(
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
            Text(
              '${value.toStringAsFixed(1)}%',
              style: AppTheme.darkTheme.textTheme.titleSmall?.copyWith(
                color: color,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
        SizedBox(height: 1.h),
        SliderTheme(
          data: SliderTheme.of(context).copyWith(
            activeTrackColor: color,
            thumbColor: color,
            overlayColor: color.withValues(alpha: 0.2),
            inactiveTrackColor: AppTheme.dividerSubtle,
            trackHeight: 1.h,
            thumbShape: RoundSliderThumbShape(enabledThumbRadius: 2.w),
          ),
          child: Slider(
            value: value,
            min: 0.0,
            max: 100.0,
            divisions: 100,
            onChanged: onChanged,
          ),
        ),
      ],
    );
  }

  Color _getRiskColor(int score) {
    if (score <= 30) return AppTheme.successGreen;
    if (score <= 70) return AppTheme.warningAmber;
    return AppTheme.errorRed;
  }
}
