import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';

class QRScannerOverlayWidget extends StatefulWidget {
  final Function(String) onQRScanned;
  final VoidCallback onClose;

  const QRScannerOverlayWidget({
    super.key,
    required this.onQRScanned,
    required this.onClose,
  });

  @override
  State<QRScannerOverlayWidget> createState() => _QRScannerOverlayWidgetState();
}

class _QRScannerOverlayWidgetState extends State<QRScannerOverlayWidget>
    with TickerProviderStateMixin {
  late AnimationController _scanAnimationController;
  late Animation<double> _scanAnimation;
  bool _flashEnabled = false;
  bool _isScanning = true;

  // Mock QR codes for demonstration
  final List<String> _mockQRCodes = [
    'payment:john.doe@email.com',
    'chronos:transfer:sarah.johnson@email.com',
    'wallet:michael.chen@email.com',
    'pay:emma.rodriguez@email.com',
  ];

  @override
  void initState() {
    super.initState();
    _initializeAnimation();
    _simulateScanning();
  }

  void _initializeAnimation() {
    _scanAnimationController = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );

    _scanAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _scanAnimationController,
      curve: Curves.easeInOut,
    ));

    _scanAnimationController.repeat();
  }

  void _simulateScanning() {
    // Simulate QR code detection after 3 seconds
    Future.delayed(const Duration(seconds: 3), () {
      if (mounted && _isScanning) {
        _onQRDetected();
      }
    });
  }

  void _onQRDetected() {
    if (!_isScanning) return;

    setState(() {
      _isScanning = false;
    });

    // Haptic feedback
    HapticFeedback.mediumImpact();

    // Show success animation
    _showSuccessAnimation();

    // Return mock QR data
    final mockData =
        _mockQRCodes[DateTime.now().millisecond % _mockQRCodes.length];

    Future.delayed(const Duration(milliseconds: 500), () {
      if (mounted) {
        widget.onQRScanned(mockData);
      }
    });
  }

  void _showSuccessAnimation() {
    showDialog(
      context: context,
      barrierDismissible: false,
      barrierColor: Colors.transparent,
      builder: (context) => Center(
        child: Container(
          width: 20.w,
          height: 20.w,
          decoration: BoxDecoration(
            color: AppTheme.successGreen,
            shape: BoxShape.circle,
          ),
          child: CustomIconWidget(
            iconName: 'check',
            color: AppTheme.primaryDark,
            size: 10.w,
          ),
        ),
      ),
    );

    Future.delayed(const Duration(milliseconds: 500), () {
      if (mounted) {
        Navigator.of(context).pop();
      }
    });
  }

  void _toggleFlash() {
    setState(() {
      _flashEnabled = !_flashEnabled;
    });
    HapticFeedback.lightImpact();
  }

  @override
  void dispose() {
    _scanAnimationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.black.withValues(alpha: 0.9),
      child: Stack(
        children: [
          // Camera Preview Placeholder
          Container(
            width: double.infinity,
            height: double.infinity,
            color: Colors.black,
            child: Center(
              child: Container(
                width: 80.w,
                height: 80.w,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: AppTheme.textSecondary.withValues(alpha: 0.5),
                    width: 2,
                  ),
                ),
                child: Stack(
                  children: [
                    // Mock camera feed
                    Container(
                      width: double.infinity,
                      height: double.infinity,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [
                            AppTheme.primaryDark.withValues(alpha: 0.8),
                            AppTheme.secondaryDark.withValues(alpha: 0.6),
                          ],
                        ),
                      ),
                    ),

                    // Scanning line animation
                    if (_isScanning)
                      AnimatedBuilder(
                        animation: _scanAnimation,
                        builder: (context, child) {
                          return Positioned(
                            top: _scanAnimation.value * (80.w - 4),
                            left: 0,
                            right: 0,
                            child: Container(
                              height: 2,
                              decoration: BoxDecoration(
                                color: AppTheme.accentGold,
                                boxShadow: [
                                  BoxShadow(
                                    color: AppTheme.accentGold
                                        .withValues(alpha: 0.5),
                                    blurRadius: 4,
                                    spreadRadius: 1,
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                  ],
                ),
              ),
            ),
          ),

          // Scanning Frame Corners
          Center(
            child: SizedBox(
              width: 80.w,
              height: 80.w,
              child: Stack(
                children: [
                  // Top-left corner
                  Positioned(
                    top: 0,
                    left: 0,
                    child: Container(
                      width: 8.w,
                      height: 8.w,
                      decoration: BoxDecoration(
                        border: Border(
                          top: BorderSide(color: AppTheme.accentGold, width: 4),
                          left:
                              BorderSide(color: AppTheme.accentGold, width: 4),
                        ),
                      ),
                    ),
                  ),

                  // Top-right corner
                  Positioned(
                    top: 0,
                    right: 0,
                    child: Container(
                      width: 8.w,
                      height: 8.w,
                      decoration: BoxDecoration(
                        border: Border(
                          top: BorderSide(color: AppTheme.accentGold, width: 4),
                          right:
                              BorderSide(color: AppTheme.accentGold, width: 4),
                        ),
                      ),
                    ),
                  ),

                  // Bottom-left corner
                  Positioned(
                    bottom: 0,
                    left: 0,
                    child: Container(
                      width: 8.w,
                      height: 8.w,
                      decoration: BoxDecoration(
                        border: Border(
                          bottom:
                              BorderSide(color: AppTheme.accentGold, width: 4),
                          left:
                              BorderSide(color: AppTheme.accentGold, width: 4),
                        ),
                      ),
                    ),
                  ),

                  // Bottom-right corner
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: Container(
                      width: 8.w,
                      height: 8.w,
                      decoration: BoxDecoration(
                        border: Border(
                          bottom:
                              BorderSide(color: AppTheme.accentGold, width: 4),
                          right:
                              BorderSide(color: AppTheme.accentGold, width: 4),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Top Controls
          Positioned(
            top: MediaQuery.of(context).padding.top + 2.h,
            left: 4.w,
            right: 4.w,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Close Button
                Container(
                  decoration: BoxDecoration(
                    color: Colors.black.withValues(alpha: 0.5),
                    shape: BoxShape.circle,
                  ),
                  child: IconButton(
                    onPressed: widget.onClose,
                    icon: CustomIconWidget(
                      iconName: 'close',
                      color: AppTheme.textPrimary,
                      size: 6.w,
                    ),
                  ),
                ),

                // Flash Toggle
                Container(
                  decoration: BoxDecoration(
                    color: Colors.black.withValues(alpha: 0.5),
                    shape: BoxShape.circle,
                  ),
                  child: IconButton(
                    onPressed: _toggleFlash,
                    icon: CustomIconWidget(
                      iconName: _flashEnabled ? 'flash_on' : 'flash_off',
                      color: _flashEnabled
                          ? AppTheme.accentGold
                          : AppTheme.textPrimary,
                      size: 6.w,
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Bottom Instructions
          Positioned(
            bottom: 10.h,
            left: 4.w,
            right: 4.w,
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 4.w,
                    vertical: 2.h,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.black.withValues(alpha: 0.7),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Column(
                    children: [
                      Text(
                        _isScanning
                            ? 'Scanning for QR Code...'
                            : 'QR Code Detected!',
                        style:
                            AppTheme.darkTheme.textTheme.titleMedium?.copyWith(
                          color: _isScanning
                              ? AppTheme.textPrimary
                              : AppTheme.successGreen,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 1.h),
                      Text(
                        'Position the QR code within the frame',
                        style: AppTheme.darkTheme.textTheme.bodySmall?.copyWith(
                          color: AppTheme.textSecondary,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),

                SizedBox(height: 2.h),

                // Manual Entry Option
                TextButton(
                  onPressed: () {
                    widget.onClose();
                    // In a real app, this would open a manual entry dialog
                  },
                  child: Text(
                    'Enter details manually',
                    style: AppTheme.darkTheme.textTheme.bodyMedium?.copyWith(
                      color: AppTheme.accentGold,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Loading Indicator (when scanning)
          if (_isScanning)
            Positioned(
              bottom: 25.h,
              left: 0,
              right: 0,
              child: Center(
                child: Container(
                  padding: EdgeInsets.all(3.w),
                  decoration: BoxDecoration(
                    color: Colors.black.withValues(alpha: 0.7),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SizedBox(
                        width: 4.w,
                        height: 4.w,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          valueColor: AlwaysStoppedAnimation<Color>(
                            AppTheme.accentGold,
                          ),
                        ),
                      ),
                      SizedBox(width: 2.w),
                      Text(
                        'Scanning...',
                        style: AppTheme.darkTheme.textTheme.bodySmall?.copyWith(
                          color: AppTheme.textPrimary,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
