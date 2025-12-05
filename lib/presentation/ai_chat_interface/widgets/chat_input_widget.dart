import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';

class ChatInputWidget extends StatefulWidget {
  final TextEditingController textController;
  final VoidCallback onSendPressed;
  final VoidCallback onMicPressed;
  final bool isRecording;
  final bool isTyping;

  const ChatInputWidget({
    super.key,
    required this.textController,
    required this.onSendPressed,
    required this.onMicPressed,
    this.isRecording = false,
    this.isTyping = false,
  });

  @override
  State<ChatInputWidget> createState() => _ChatInputWidgetState();
}

class _ChatInputWidgetState extends State<ChatInputWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _pulseController;
  late Animation<double> _pulseAnimation;
  bool _hasText = false;

  @override
  void initState() {
    super.initState();
    _pulseController = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    );
    _pulseAnimation = Tween<double>(begin: 1.0, end: 1.2).animate(
      CurvedAnimation(parent: _pulseController, curve: Curves.easeInOut),
    );

    widget.textController.addListener(_onTextChanged);

    if (widget.isRecording) {
      _pulseController.repeat(reverse: true);
    }
  }

  @override
  void didUpdateWidget(ChatInputWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.isRecording != oldWidget.isRecording) {
      if (widget.isRecording) {
        _pulseController.repeat(reverse: true);
      } else {
        _pulseController.stop();
        _pulseController.reset();
      }
    }
  }

  void _onTextChanged() {
    final hasText = widget.textController.text.trim().isNotEmpty;
    if (hasText != _hasText) {
      setState(() {
        _hasText = hasText;
      });
    }
  }

  @override
  void dispose() {
    _pulseController.dispose();
    widget.textController.removeListener(_onTextChanged);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(4.w),
      decoration: BoxDecoration(
        color: AppTheme.surfaceDark,
        border: Border(
          top: BorderSide(
            color: AppTheme.dividerSubtle,
            width: 1.0,
          ),
        ),
      ),
      child: SafeArea(
        child: Row(
          children: [
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: AppTheme.primaryCharcoal,
                  borderRadius: BorderRadius.circular(6.w),
                  border: Border.all(
                    color: AppTheme.dividerSubtle,
                    width: 1.0,
                  ),
                ),
                child: TextField(
                  controller: widget.textController,
                  style: AppTheme.darkTheme.textTheme.bodyMedium?.copyWith(
                    color: AppTheme.textPrimary,
                  ),
                  decoration: InputDecoration(
                    hintText: widget.isRecording
                        ? 'Recording...'
                        : 'Ask me anything about your wealth...',
                    hintStyle:
                        AppTheme.darkTheme.textTheme.bodyMedium?.copyWith(
                      color: AppTheme.textTertiary,
                    ),
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: 4.w,
                      vertical: 2.h,
                    ),
                    suffixIcon: widget.isRecording
                        ? AnimatedBuilder(
                            animation: _pulseAnimation,
                            builder: (context, child) {
                              return Transform.scale(
                                scale: _pulseAnimation.value,
                                child: Container(
                                  margin: EdgeInsets.all(2.w),
                                  decoration: BoxDecoration(
                                    color: AppTheme.errorRed,
                                    shape: BoxShape.circle,
                                  ),
                                  child: CustomIconWidget(
                                    iconName: 'mic',
                                    color: AppTheme.textPrimary,
                                    size: 5.w,
                                  ),
                                ),
                              );
                            },
                          )
                        : GestureDetector(
                            onTap: widget.onMicPressed,
                            child: Container(
                              margin: EdgeInsets.all(2.w),
                              decoration: BoxDecoration(
                                color:
                                    AppTheme.chronosGold.withValues(alpha: 0.2),
                                shape: BoxShape.circle,
                              ),
                              child: CustomIconWidget(
                                iconName: 'mic',
                                color: AppTheme.chronosGold,
                                size: 5.w,
                              ),
                            ),
                          ),
                  ),
                  maxLines: 4,
                  minLines: 1,
                  textCapitalization: TextCapitalization.sentences,
                  enabled: !widget.isRecording,
                ),
              ),
            ),
            SizedBox(width: 2.w),
            GestureDetector(
              onTap:
                  _hasText && !widget.isRecording ? widget.onSendPressed : null,
              child: AnimatedContainer(
                duration: AppTheme.fastAnimation,
                width: 12.w,
                height: 12.w,
                decoration: BoxDecoration(
                  color: _hasText && !widget.isRecording
                      ? AppTheme.chronosGold
                      : AppTheme.textTertiary,
                  shape: BoxShape.circle,
                  boxShadow: _hasText && !widget.isRecording
                      ? [
                          BoxShadow(
                            color: AppTheme.chronosGold.withValues(alpha: 0.3),
                            blurRadius: 8.0,
                            offset: const Offset(0, 2),
                          ),
                        ]
                      : null,
                ),
                child: CustomIconWidget(
                  iconName: widget.isTyping ? 'hourglass_empty' : 'send',
                  color: _hasText && !widget.isRecording
                      ? AppTheme.primaryCharcoal
                      : AppTheme.surfaceDark,
                  size: 5.w,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
