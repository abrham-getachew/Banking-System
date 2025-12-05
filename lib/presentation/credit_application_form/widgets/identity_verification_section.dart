import 'package:camera/camera.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';

class IdentityVerificationSection extends StatefulWidget {
  final Map<String, dynamic> verificationData;
  final Function(String, dynamic) onFieldChanged;

  const IdentityVerificationSection({
    super.key,
    required this.verificationData,
    required this.onFieldChanged,
  });

  @override
  State<IdentityVerificationSection> createState() =>
      _IdentityVerificationSectionState();
}

class _IdentityVerificationSectionState
    extends State<IdentityVerificationSection> {
  CameraController? _cameraController;
  List<CameraDescription> _cameras = [];
  bool _isCameraInitialized = false;
  bool _isCapturing = false;
  XFile? _capturedImage;
  String _selectedVerificationMethod = 'face_scan';

  @override
  void initState() {
    super.initState();
    _initializeCamera();
  }

  @override
  void dispose() {
    _cameraController?.dispose();
    super.dispose();
  }

  Future<bool> _requestCameraPermission() async {
    if (kIsWeb) return true;
    return (await Permission.camera.request()).isGranted;
  }

  Future<void> _initializeCamera() async {
    if (!await _requestCameraPermission()) return;

    try {
      _cameras = await availableCameras();
      if (_cameras.isEmpty) return;

      final camera = kIsWeb
          ? _cameras.firstWhere(
              (c) => c.lensDirection == CameraLensDirection.front,
              orElse: () => _cameras.first)
          : _cameras.firstWhere(
              (c) => c.lensDirection == CameraLensDirection.back,
              orElse: () => _cameras.first);

      _cameraController = CameraController(
          camera, kIsWeb ? ResolutionPreset.medium : ResolutionPreset.high);

      await _cameraController!.initialize();
      await _applySettings();

      if (mounted) {
        setState(() {
          _isCameraInitialized = true;
        });
      }
    } catch (e) {
      debugPrint('Camera initialization error: $e');
    }
  }

  Future<void> _applySettings() async {
    if (_cameraController == null) return;

    try {
      await _cameraController!.setFocusMode(FocusMode.auto);
    } catch (e) {
      debugPrint('Focus mode error: $e');
    }

    if (!kIsWeb) {
      try {
        await _cameraController!.setFlashMode(FlashMode.auto);
      } catch (e) {
        debugPrint('Flash mode error: $e');
      }
    }
  }

  Future<void> _capturePhoto() async {
    if (_cameraController == null || !_cameraController!.value.isInitialized)
      return;

    setState(() {
      _isCapturing = true;
    });

    try {
      final XFile photo = await _cameraController!.takePicture();
      setState(() {
        _capturedImage = photo;
      });
      widget.onFieldChanged('capturedImage', photo);
      widget.onFieldChanged('verificationMethod', _selectedVerificationMethod);
    } catch (e) {
      debugPrint('Photo capture error: $e');
    } finally {
      setState(() {
        _isCapturing = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 4.w, vertical: 1.h),
      child: Padding(
        padding: EdgeInsets.all(4.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CustomIconWidget(
                  iconName: 'verified_user',
                  color: AppTheme.primaryGold,
                  size: 20,
                ),
                SizedBox(width: 2.w),
                Text(
                  'Identity Verification',
                  style: AppTheme.darkTheme.textTheme.titleMedium?.copyWith(
                    color: AppTheme.primaryGold,
                  ),
                ),
              ],
            ),
            SizedBox(height: 2.h),
            Text(
              'Choose your verification method:',
              style: AppTheme.darkTheme.textTheme.bodyMedium?.copyWith(
                color: AppTheme.textSecondary,
              ),
            ),
            SizedBox(height: 2.h),
            _buildVerificationMethodSelector(),
            SizedBox(height: 3.h),
            _selectedVerificationMethod == 'face_scan'
                ? _buildFaceScanSection()
                : _buildIdCardScanSection(),
          ],
        ),
      ),
    );
  }

  Widget _buildVerificationMethodSelector() {
    return Row(
      children: [
        Expanded(
          child: _buildMethodCard(
            'face_scan',
            'Face Scan',
            'camera_alt',
            'Quick & secure facial recognition',
          ),
        ),
        SizedBox(width: 3.w),
        Expanded(
          child: _buildMethodCard(
            'id_card',
            'ID Card',
            'credit_card',
            'Scan your government ID',
          ),
        ),
      ],
    );
  }

  Widget _buildMethodCard(
      String method, String title, String icon, String description) {
    bool isSelected = _selectedVerificationMethod == method;

    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedVerificationMethod = method;
          _capturedImage = null;
        });
      },
      child: Container(
        padding: EdgeInsets.all(3.w),
        decoration: BoxDecoration(
          color: isSelected
              ? AppTheme.primaryGold.withValues(alpha: 0.1)
              : AppTheme.surfaceDark,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isSelected
                ? AppTheme.primaryGold
                : AppTheme.primaryGold.withValues(alpha: 0.2),
            width: isSelected ? 2 : 1,
          ),
        ),
        child: Column(
          children: [
            CustomIconWidget(
              iconName: icon,
              color: isSelected ? AppTheme.primaryGold : AppTheme.textSecondary,
              size: 32,
            ),
            SizedBox(height: 1.h),
            Text(
              title,
              style: AppTheme.darkTheme.textTheme.titleSmall?.copyWith(
                color: isSelected ? AppTheme.primaryGold : AppTheme.textPrimary,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
              ),
            ),
            SizedBox(height: 0.5.h),
            Text(
              description,
              textAlign: TextAlign.center,
              style: AppTheme.darkTheme.textTheme.bodySmall?.copyWith(
                color: AppTheme.textSecondary,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFaceScanSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Face Verification',
          style: AppTheme.darkTheme.textTheme.titleSmall?.copyWith(
            color: AppTheme.textPrimary,
          ),
        ),
        SizedBox(height: 1.h),
        Text(
          'Position your face within the frame and tap capture when ready.',
          style: AppTheme.darkTheme.textTheme.bodySmall?.copyWith(
            color: AppTheme.textSecondary,
          ),
        ),
        SizedBox(height: 2.h),
        _buildCameraPreview(),
        SizedBox(height: 2.h),
        _buildCaptureButton(),
      ],
    );
  }

  Widget _buildIdCardScanSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'ID Card Verification',
          style: AppTheme.darkTheme.textTheme.titleSmall?.copyWith(
            color: AppTheme.textPrimary,
          ),
        ),
        SizedBox(height: 1.h),
        Text(
          'Place your government-issued ID within the frame and capture.',
          style: AppTheme.darkTheme.textTheme.bodySmall?.copyWith(
            color: AppTheme.textSecondary,
          ),
        ),
        SizedBox(height: 2.h),
        _buildCameraPreview(),
        SizedBox(height: 2.h),
        _buildCaptureButton(),
      ],
    );
  }

  Widget _buildCameraPreview() {
    if (_capturedImage != null) {
      return _buildCapturedImagePreview();
    }

    if (!_isCameraInitialized || _cameraController == null) {
      return Container(
        height: 30.h,
        width: double.infinity,
        decoration: BoxDecoration(
          color: AppTheme.surfaceDark,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: AppTheme.primaryGold.withValues(alpha: 0.2),
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CustomIconWidget(
              iconName: 'camera_alt',
              color: AppTheme.textSecondary,
              size: 48,
            ),
            SizedBox(height: 2.h),
            Text(
              'Initializing camera...',
              style: AppTheme.darkTheme.textTheme.bodyMedium?.copyWith(
                color: AppTheme.textSecondary,
              ),
            ),
          ],
        ),
      );
    }

    return Container(
      height: 30.h,
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: AppTheme.primaryGold.withValues(alpha: 0.3),
          width: 2,
        ),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Stack(
          children: [
            CameraPreview(_cameraController!),
            _buildOverlayFrame(),
          ],
        ),
      ),
    );
  }

  Widget _buildOverlayFrame() {
    return Container(
      width: double.infinity,
      height: double.infinity,
      child: CustomPaint(
        painter: _selectedVerificationMethod == 'face_scan'
            ? FaceOverlayPainter()
            : CardOverlayPainter(),
      ),
    );
  }

  Widget _buildCapturedImagePreview() {
    return Container(
      height: 30.h,
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: AppTheme.successGreen,
          width: 2,
        ),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Stack(
          children: [
            kIsWeb
                ? Image.network(
                    _capturedImage!.path,
                    width: double.infinity,
                    height: double.infinity,
                    fit: BoxFit.cover,
                  )
                : Image.asset(
                    _capturedImage!.path,
                    width: double.infinity,
                    height: double.infinity,
                    fit: BoxFit.cover,
                  ),
            Positioned(
              top: 2.w,
              right: 2.w,
              child: Container(
                padding: EdgeInsets.all(1.w),
                decoration: BoxDecoration(
                  color: AppTheme.successGreen,
                  shape: BoxShape.circle,
                ),
                child: CustomIconWidget(
                  iconName: 'check',
                  color: AppTheme.backgroundDark,
                  size: 16,
                ),
              ),
            ),
            Positioned(
              bottom: 2.w,
              left: 2.w,
              child: ElevatedButton.icon(
                onPressed: () {
                  setState(() {
                    _capturedImage = null;
                  });
                  widget.onFieldChanged('capturedImage', null);
                },
                icon: CustomIconWidget(
                  iconName: 'refresh',
                  color: AppTheme.backgroundDark,
                  size: 16,
                ),
                label: Text('Retake'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppTheme.primaryGold,
                  foregroundColor: AppTheme.backgroundDark,
                  padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 1.h),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCaptureButton() {
    if (_capturedImage != null) {
      return Container(
        width: double.infinity,
        padding: EdgeInsets.all(3.w),
        decoration: BoxDecoration(
          color: AppTheme.successGreen.withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: AppTheme.successGreen.withValues(alpha: 0.3),
          ),
        ),
        child: Row(
          children: [
            CustomIconWidget(
              iconName: 'check_circle',
              color: AppTheme.successGreen,
              size: 24,
            ),
            SizedBox(width: 3.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Verification Complete',
                    style: AppTheme.darkTheme.textTheme.titleSmall?.copyWith(
                      color: AppTheme.successGreen,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    'Your ${_selectedVerificationMethod == 'face_scan' ? 'face' : 'ID'} has been successfully captured.',
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

    return SizedBox(
      width: double.infinity,
      height: 6.h,
      child: ElevatedButton.icon(
        onPressed: _isCameraInitialized && !_isCapturing ? _capturePhoto : null,
        icon: _isCapturing
            ? SizedBox(
                width: 20,
                height: 20,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  valueColor:
                      AlwaysStoppedAnimation<Color>(AppTheme.backgroundDark),
                ),
              )
            : CustomIconWidget(
                iconName: 'camera_alt',
                color: AppTheme.backgroundDark,
                size: 20,
              ),
        label: Text(
          _isCapturing
              ? 'Capturing...'
              : 'Capture ${_selectedVerificationMethod == 'face_scan' ? 'Face' : 'ID'}',
        ),
        style: ElevatedButton.styleFrom(
          backgroundColor: _isCameraInitialized
              ? AppTheme.primaryGold
              : AppTheme.neutralGray,
          foregroundColor: AppTheme.backgroundDark,
        ),
      ),
    );
  }
}

class FaceOverlayPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = AppTheme.primaryGold.withValues(alpha: 0.8)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3;

    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width * 0.3;

    canvas.drawCircle(center, radius, paint);

    // Draw corner indicators
    final cornerPaint = Paint()
      ..color = AppTheme.primaryGold
      ..style = PaintingStyle.stroke
      ..strokeWidth = 4;

    final cornerLength = 20.0;
    final corners = [
      Offset(center.dx - radius, center.dy - radius),
      Offset(center.dx + radius, center.dy - radius),
      Offset(center.dx - radius, center.dy + radius),
      Offset(center.dx + radius, center.dy + radius),
    ];

    for (final corner in corners) {
      canvas.drawLine(
          corner, Offset(corner.dx + cornerLength, corner.dy), cornerPaint);
      canvas.drawLine(
          corner, Offset(corner.dx, corner.dy + cornerLength), cornerPaint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class CardOverlayPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = AppTheme.primaryGold.withValues(alpha: 0.8)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3;

    final rect = Rect.fromCenter(
      center: Offset(size.width / 2, size.height / 2),
      width: size.width * 0.8,
      height: size.height * 0.5,
    );

    final rrect = RRect.fromRectAndRadius(rect, Radius.circular(12));
    canvas.drawRRect(rrect, paint);

    // Draw corner indicators
    final cornerPaint = Paint()
      ..color = AppTheme.primaryGold
      ..style = PaintingStyle.stroke
      ..strokeWidth = 4;

    final cornerLength = 20.0;
    final corners = [
      Offset(rect.left, rect.top),
      Offset(rect.right, rect.top),
      Offset(rect.left, rect.bottom),
      Offset(rect.right, rect.bottom),
    ];

    for (final corner in corners) {
      canvas.drawLine(
          corner, Offset(corner.dx + cornerLength, corner.dy), cornerPaint);
      canvas.drawLine(
          corner, Offset(corner.dx, corner.dy + cornerLength), cornerPaint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
