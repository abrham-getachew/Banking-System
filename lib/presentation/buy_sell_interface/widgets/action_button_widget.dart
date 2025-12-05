import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';

enum ButtonState { enabled, loading, success, error }

class ActionButtonWidget extends StatefulWidget {
  final bool isBuyMode;
  final bool isEnabled;
  final VoidCallback? onPressed;
  final ButtonState buttonState;

  const ActionButtonWidget({
    Key? key,
    required this.isBuyMode,
    required this.isEnabled,
    this.onPressed,
    this.buttonState = ButtonState.enabled,
  }) : super(key: key);

  @override
  State<ActionButtonWidget> createState() => _ActionButtonWidgetState();
}

class _ActionButtonWidgetState extends State<ActionButtonWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 150),
      vsync: this,
    );
    _scaleAnimation = Tween<double>(
      begin: 1.0,
      end: 0.95,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    ));
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  Color get _buttonColor {
    if (!widget.isEnabled) return AppTheme.textSecondary.withValues(alpha: 0.3);

    switch (widget.buttonState) {
      case ButtonState.loading:
        return AppTheme.primaryGold.withValues(alpha: 0.7);
      case ButtonState.success:
        return AppTheme.successGreen;
      case ButtonState.error:
        return AppTheme.errorRed;
      case ButtonState.enabled:
      default:
        return widget.isBuyMode ? AppTheme.successGreen : AppTheme.errorRed;
    }
  }

  String get _buttonText {
    switch (widget.buttonState) {
      case ButtonState.loading:
        return 'Processing...';
      case ButtonState.success:
        return 'Success!';
      case ButtonState.error:
        return 'Try Again';
      case ButtonState.enabled:
      default:
        return widget.isBuyMode ? 'Buy Now' : 'Sell Now';
    }
  }

  Widget get _buttonIcon {
    switch (widget.buttonState) {
      case ButtonState.loading:
        return SizedBox(
          width: 20,
          height: 20,
          child: CircularProgressIndicator(
            strokeWidth: 2,
            valueColor: AlwaysStoppedAnimation<Color>(AppTheme.textPrimary),
          ),
        );
      case ButtonState.success:
        return CustomIconWidget(
          iconName: 'check_circle',
          color: AppTheme.textPrimary,
          size: 20,
        );
      case ButtonState.error:
        return CustomIconWidget(
          iconName: 'error',
          color: AppTheme.textPrimary,
          size: 20,
        );
      case ButtonState.enabled:
      default:
        return CustomIconWidget(
          iconName: widget.isBuyMode ? 'trending_up' : 'trending_down',
          color: AppTheme.textPrimary,
          size: 20,
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _scaleAnimation,
      builder: (context, child) {
        return Transform.scale(
          scale: _scaleAnimation.value,
          child: GestureDetector(
            onTapDown: (_) {
              if (widget.isEnabled &&
                  widget.buttonState != ButtonState.loading) {
                _animationController.forward();
              }
            },
            onTapUp: (_) {
              _animationController.reverse();
            },
            onTapCancel: () {
              _animationController.reverse();
            },
            onTap: widget.isEnabled && widget.buttonState != ButtonState.loading
                ? widget.onPressed
                : null,
            child: Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(vertical: 2.5.h),
              decoration: BoxDecoration(
                color: _buttonColor,
                borderRadius: BorderRadius.circular(16),
                boxShadow: widget.isEnabled &&
                        widget.buttonState != ButtonState.loading
                    ? [
                        BoxShadow(
                          color: _buttonColor.withValues(alpha: 0.3),
                          blurRadius: 8,
                          offset: const Offset(0, 4),
                        ),
                      ]
                    : null,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _buttonIcon,
                  SizedBox(width: 3.w),
                  Text(
                    _buttonText,
                    style: AppTheme.darkTheme.textTheme.titleMedium?.copyWith(
                      color: AppTheme.textPrimary,
                      fontWeight: FontWeight.w700,
                      letterSpacing: 0.5,
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
