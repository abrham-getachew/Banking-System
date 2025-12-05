import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';

class VoiceTranscriptionWidget extends StatefulWidget {
  final String transcriptionText;
  final bool isVisible;
  final VoidCallback? onClose;

  const VoiceTranscriptionWidget({
    super.key,
    required this.transcriptionText,
    required this.isVisible,
    this.onClose,
  });

  @override
  State<VoiceTranscriptionWidget> createState() =>
      _VoiceTranscriptionWidgetState();
}

class _VoiceTranscriptionWidgetState extends State<VoiceTranscriptionWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _slideAnimation;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: AppTheme.standardAnimation,
      vsync: this,
    );

    _slideAnimation = Tween<double>(begin: 1.0, end: 0.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeOut),
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeIn),
    );

    if (widget.isVisible) {
      _animationController.forward();
    }
  }

  @override
  void didUpdateWidget(VoiceTranscriptionWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.isVisible != oldWidget.isVisible) {
      if (widget.isVisible) {
        _animationController.forward();
      } else {
        _animationController.reverse();
      }
    }
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!widget.isVisible && !_animationController.isAnimating) {
      return const SizedBox.shrink();
    }

    return AnimatedBuilder(
      animation: _animationController,
      builder: (context, child) {
        return Transform.translate(
          offset: Offset(0, _slideAnimation.value * 20.h),
          child: Opacity(
            opacity: _fadeAnimation.value,
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 4.w, vertical: 2.h),
              padding: EdgeInsets.all(4.w),
              decoration: BoxDecoration(
                color: AppTheme.surfaceDark,
                borderRadius: BorderRadius.circular(3.w),
                border: Border.all(
                  color: AppTheme.chronosGold.withValues(alpha: 0.3),
                  width: 1.0,
                ),
                boxShadow: [
                  BoxShadow(
                    color: AppTheme.shadowDark,
                    blurRadius: 12.0,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    children: [
                      Container(
                        padding: EdgeInsets.all(2.w),
                        decoration: BoxDecoration(
                          color: AppTheme.chronosGold.withValues(alpha: 0.2),
                          shape: BoxShape.circle,
                        ),
                        child: CustomIconWidget(
                          iconName: 'mic',
                          color: AppTheme.chronosGold,
                          size: 4.w,
                        ),
                      ),
                      SizedBox(width: 3.w),
                      Expanded(
                        child: Text(
                          'Voice Transcription',
                          style:
                              AppTheme.darkTheme.textTheme.titleSmall?.copyWith(
                            color: AppTheme.chronosGold,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      if (widget.onClose != null)
                        GestureDetector(
                          onTap: widget.onClose,
                          child: CustomIconWidget(
                            iconName: 'close',
                            color: AppTheme.textSecondary,
                            size: 5.w,
                          ),
                        ),
                    ],
                  ),
                  SizedBox(height: 2.h),
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(3.w),
                    decoration: BoxDecoration(
                      color: AppTheme.primaryCharcoal,
                      borderRadius: BorderRadius.circular(2.w),
                      border: Border.all(
                        color: AppTheme.dividerSubtle,
                        width: 1.0,
                      ),
                    ),
                    child: Text(
                      widget.transcriptionText.isEmpty
                          ? 'Listening...'
                          : widget.transcriptionText,
                      style: AppTheme.darkTheme.textTheme.bodyMedium?.copyWith(
                        color: widget.transcriptionText.isEmpty
                            ? AppTheme.textTertiary
                            : AppTheme.textPrimary,
                        height: 1.4,
                      ),
                    ),
                  ),
                  if (widget.transcriptionText.isNotEmpty) ...[
                    SizedBox(height: 2.h),
                    Row(
                      children: [
                        Expanded(
                          child: OutlinedButton(
                            onPressed: widget.onClose,
                            style: OutlinedButton.styleFrom(
                              side: BorderSide(
                                color: AppTheme.textSecondary,
                                width: 1.0,
                              ),
                              padding: EdgeInsets.symmetric(vertical: 1.5.h),
                            ),
                            child: Text(
                              'Cancel',
                              style: AppTheme.darkTheme.textTheme.labelMedium
                                  ?.copyWith(
                                color: AppTheme.textSecondary,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: 2.w),
                        Expanded(
                          child: ElevatedButton(
                            onPressed: () {
                              // Send transcribed text
                              widget.onClose?.call();
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppTheme.chronosGold,
                              padding: EdgeInsets.symmetric(vertical: 1.5.h),
                            ),
                            child: Text(
                              'Send',
                              style: AppTheme.darkTheme.textTheme.labelMedium
                                  ?.copyWith(
                                color: AppTheme.primaryCharcoal,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
