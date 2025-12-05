// lib/tailor_revolut.dart

import 'package:chronos/Features/complete_signup/presentation/pages/page_3.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';


class TailorRevolutApp extends StatelessWidget {
  const TailorRevolutApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Revolut Tailor Experience',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.light().copyWith(
        primaryColor: const Color(0xFF006AE3),
        textTheme: const TextTheme(
          titleLarge: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w600,
            color: Colors.black87,
          ),
          bodyMedium: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w400,
            color: Color(0xFF606770),
            height: 1.5,
          ),
          labelLarge: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
      ),
      home: const TailorRevolutPage(),
    );
  }
}

class TailorRevolutPage extends StatefulWidget {
  const TailorRevolutPage({super.key});

  @override
  State<TailorRevolutPage> createState() => _TailorRevolutPageState();
}

class _TailorRevolutPageState extends State<TailorRevolutPage> {
  bool _loading = false;

  Future<void> _askTrackingPermission() async {
    // 1) If we’re already gone, bail out early.
    if (!mounted) return;

    setState(() => _loading = true);

    // Log the tap
    debugPrint('User tapped Continue → requesting tracking permission');

    // Ask permission
    final status = await Permission.appTrackingTransparency.request();

    // Simulate spinner time
    await Future.delayed(const Duration(milliseconds: 500));

    // 2) Check mounted again before touching state or context
    if (!mounted) return;

    setState(() => _loading = false);

    if (status.isGranted) {
      debugPrint('Tracking permission granted');
      _goToNextPage();
    } else {
      debugPrint('Tracking permission denied');
      _showDeniedSnackbar();
    }
  }

  void _goToNextPage() {
    // Only navigate if still mounted
    if (!mounted) return;
    Navigator.of(context).push(
      MaterialPageRoute(builder: (_) => PlanSelectionPage()),
    );
  }

  void _showDeniedSnackbar() {
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Permission denied. Unable to continue.')),
    );
  }

  void _onContinuePressed() {
    if (!mounted) return;
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Enable Tracking?'),
        content: const Text(
          'Allow us to track your activity to personalise suggestions.',
        ),
        actions: [
          TextButton(
            onPressed: () {
             // if (!mounted) return;
           //   Navigator.of(context).pop();
            },
            child: const Text('Deny'),
          ),
          ElevatedButton(
            onPressed: () {
              if (!mounted) return;
             // Navigator.of(context).pop();
              _goToNextPage();
            },
            child: const Text('Allow'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Stack(
      children: [
        Scaffold(
          backgroundColor: Colors.white,
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                children: [
                  const SizedBox(height: 80),
                  Text(
                    'Tailor your Revolut experience',
                    style: theme.textTheme.titleLarge,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'See better in-app suggestions and a customised experience based on your activity.',
                    style: theme.textTheme.bodyMedium,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 8),
                  TextButton(
                    onPressed: () {/* TODO */},
                    style: TextButton.styleFrom(
                      padding: EdgeInsets.zero,
                      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    ),
                    child: const Text(
                      'Learn more',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: Color(0xFF006AE3),
                      ),
                    ),
                  ),
                  const SizedBox(height: 48),
                  Expanded(
                    child: Center(
                      child: Image.asset(
                        'assets/images/com.jpg',
                        width: 250,
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: _loading ? null : _onContinuePressed,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: theme.primaryColor,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25),
                        ),
                      ),
                      child: Text(
                        'Continue',
                        style: theme.textTheme.labelLarge,
                      ),
                    ),
                  ),
                  const SizedBox(height: 40),
                ],
              ),
            ),
          ),
        ),
        if (_loading)
          Container(
            color: Colors.black38,
            child: const Center(child: CircularProgressIndicator()),
          ),
      ],
    );
  }
}

