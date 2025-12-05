import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../../core/app_export.dart';

class CryptoNftToggle extends StatefulWidget {
  final Function(int) onTabChanged;
  final int initialIndex;

  const CryptoNftToggle({
    super.key,
    required this.onTabChanged,
    this.initialIndex = 0,
  });

  @override
  State<CryptoNftToggle> createState() => _CryptoNftToggleState();
}

class _CryptoNftToggleState extends State<CryptoNftToggle>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _slideAnimation;
  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    _selectedIndex = widget.initialIndex;
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    _slideAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    ));

    if (_selectedIndex == 1) {
      _animationController.value = 1.0;
    }
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _onTabTapped(int index) {
    if (_selectedIndex == index) return;

    setState(() {
      _selectedIndex = index;
    });

    if (index == 0) {
      _animationController.reverse();
    } else {
      _animationController.forward();
    }

    widget.onTabChanged(index);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 4.w, vertical: 2.h),
      padding: EdgeInsets.all(1.w),
      decoration: BoxDecoration(
        color: AppTheme.deepCharcoal.withValues(alpha: 0.8),
        borderRadius: BorderRadius.circular(8.w),
        border: Border.all(
          color: AppTheme.textPrimary.withValues(alpha: 0.1),
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: AppTheme.shadowDark,
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Stack(
        children: [
          AnimatedBuilder(
            animation: _slideAnimation,
            builder: (context, child) {
              return Positioned(
                left: _slideAnimation.value * (50.w - 2.w),
                top: 0,
                bottom: 0,
                child: Container(
                  width: 50.w - 2.w,
                  decoration: BoxDecoration(
                    color: AppTheme.primaryGold.withValues(alpha: 0.2),
                    borderRadius: BorderRadius.circular(7.w),
                    border: Border.all(
                      color: AppTheme.primaryGold.withValues(alpha: 0.4),
                      width: 1,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: AppTheme.primaryGold.withValues(alpha: 0.3),
                        blurRadius: 8,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
          Row(
            children: [
              Expanded(
                child: _buildTabButton(
                  'Crypto',
                  'currency_bitcoin',
                  0,
                ),
              ),
              Expanded(
                child: _buildTabButton(
                  'NFT',
                  'image',
                  1,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTabButton(String title, String iconName, int index) {
    final bool isSelected = _selectedIndex == index;

    return GestureDetector(
      onTap: () => _onTabTapped(index),
      child: Container(
        height: 12.h,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CustomIconWidget(
                iconName: iconName,
                color:
                    isSelected ? AppTheme.primaryGold : AppTheme.textSecondary,
                size: 6.w,
              ),
              SizedBox(height: 1.h),
              Text(
                title,
                style: AppTheme.darkTheme.textTheme.titleSmall?.copyWith(
                  color: isSelected
                      ? AppTheme.primaryGold
                      : AppTheme.textSecondary,
                  fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
