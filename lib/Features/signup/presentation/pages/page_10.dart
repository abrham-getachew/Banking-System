import 'package:chronos/Features/signup/presentation/pages/page_11.dart';
import 'package:chronos/Features/signup/presentation/pages/page_12.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

class PageTen extends StatelessWidget {
  const PageTen({super.key});

  Future<void> _handleContinue(BuildContext context) async {
    final status = await Permission.camera.request();
    if (status.isGranted) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => PasscodePage()),
      );
    } else if (status.isPermanentlyDenied) {
      openAppSettings();
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Camera permission is required to continue."),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final sw = size.width;
    final sh = size.height;

    final titleFs = sw * 0.058;
    final bodyFs = sw * 0.041;
    final dotFs = sw * 0.06;
    final hPadding = sw * 0.06;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            // Top bar
            Padding(
              padding: EdgeInsets.only(
                left: hPadding,
                right: hPadding,
                top: sh * 0.01,
                bottom: sh * 0.005,
              ),
              child: SizedBox(
                height: sw * 0.12,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.close, color: Colors.black),
                      onPressed: () => Navigator.pop(context),
                    ),
                  ],
                ),
              ),
            ),

            // Scrollable content
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: hPadding),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(height: sh * 0.005),
                    Text(
                      "Verify your identity with a quick photo",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: titleFs,
                        fontWeight: FontWeight.w700,
                        color: Colors.black,
                        height: 1.25,
                      ),
                    ),
                    SizedBox(height: sh * 0.05),
                    Container(
                      width: sw * 0.52,
                      height: sw * 0.52,
                      decoration: BoxDecoration(
                        color: const Color(0xFFF3F4F6),
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: const Color(0xFFE5E7EB),
                          width: 2,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.03),
                            blurRadius: 8,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Icon(
                        Icons.person,
                        size: sw * 0.35,
                        color: const Color(0xFF9CA3AF),
                      ),
                    ),
                    SizedBox(height: sh * 0.05),
                    _BulletLine(
                      dotSize: dotFs,
                      text: "It won't be your profile picture",
                      fontSize: bodyFs,
                    ),
                    SizedBox(height: sh * 0.012),
                    _BulletLine(
                      dotSize: dotFs,
                      text:
                      "Your photo is secure and used for verification needs only",
                      fontSize: bodyFs,
                    ),
                    SizedBox(height: sh * 0.12),
                  ],
                ),
              ),
            ),

            // Sticky Continue button
            Padding(
              padding: EdgeInsets.fromLTRB(hPadding, 0, hPadding, sh * 0.03),
              child: SizedBox(
                width: double.infinity,
                height: sh * 0.07,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF2563EB),
                    foregroundColor: Colors.white,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(28),
                    ),
                  ),
                  onPressed: () => _handleContinue(context),
                  child: Text(
                    "Continue",
                    style: TextStyle(
                      fontSize: sw * 0.05,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _BulletLine extends StatelessWidget {
  final String text;
  final double dotSize;
  final double fontSize;

  const _BulletLine({
    required this.text,
    required this.dotSize,
    required this.fontSize,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 2),
          child: Text(
            "•",
            style: TextStyle(
              fontSize: dotSize,
              height: 1.0,
              color: Colors.black87,
            ),
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            text,
            style: TextStyle(
              fontSize: fontSize,
              color: const Color(0xFF374151),
              height: 1.35,
            ),
          ),
        ),
      ],
    );
  }
}
