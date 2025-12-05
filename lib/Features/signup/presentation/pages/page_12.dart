import 'package:chronos/Features/signup/presentation/pages/page_13.dart';
import 'package:flutter/material.dart';

class PasscodePage extends StatefulWidget {
  @override
  _PasscodePageState createState() => _PasscodePageState();
}

class _PasscodePageState extends State<PasscodePage> {
  static const int minLength = 6;
  static const int maxLength = 12;
  String _passcode = '';

  void _addDigit(String digit) {
    if (_passcode.length < maxLength) {
      setState(() => _passcode += digit);
    }
  }

  void _removeDigit() {
    if (_passcode.isNotEmpty) {
      setState(() => _passcode = _passcode.substring(0, _passcode.length - 1));
    }
  }

  @override
  Widget build(BuildContext context) {
    final bool canProceed = _passcode.length >= minLength;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 32.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Step Indicator
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _buildStepDot(active: true),
                  const SizedBox(width: 8),
                  _buildStepDot(active: false),
                ],
              ),

              const SizedBox(height: 32),

              // Title & Instruction
              Text(
                'Create passcode',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),

              const SizedBox(height: 8),

              Text(
                'The passcode should be 6 to 12 digits long.',
                style: TextStyle(fontSize: 16, color: Colors.grey[700]),
              ),

              const SizedBox(height: 100),

              // Password Dots
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                  _passcode.length,
                      (i) => Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 4.0),
                    child: Container(
                      width: 12,
                      height: 12,
                      decoration: BoxDecoration(
                        color: Colors.black,
                        shape: BoxShape.circle,
                      ),
                    ),
                  ),
                ),
              ),

              Spacer(),

              // Numeric Keypad
              _buildNumberPad(canProceed),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStepDot({required bool active}) {
    return Container(
      width: 10,
      height: 10,
      decoration: BoxDecoration(
        color: active ? Colors.black : Colors.grey[300],
        shape: BoxShape.circle,
      ),
    );
  }

  Widget _buildNumberPad(bool canProceed) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        for (var row in [
          ['1', '2', '3'],
          ['4', '5', '6'],
          ['7', '8', '9'],
        ])
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: row
                .map((d) => _buildNumKey(label: d, onTap: () => _addDigit(d)))
                .toList(),
          ),

        // Bottom row: Backspace, 0, Next
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _buildIconKey(
              icon: Icons.backspace,
              onTap: _removeDigit,
            ),
            _buildNumKey(label: '0', onTap: () => _addDigit('0')),
            _buildIconKey(
              icon: Icons.arrow_forward,
              color: canProceed ? Colors.blue : Colors.grey[300],
              onTap: canProceed
                  ? () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => ConfirmPasscodePage(originalPasscode: '$_passcode',)),
                );// Handle passcode submission
                print('Passcode set: $_passcode');
              }
                  : null,
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildNumKey({
    required String label,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Container(
        width: 80,
        height: 80,
        alignment: Alignment.center,
        child: Text(
          label,
          style: TextStyle(fontSize: 28, fontWeight: FontWeight.w500),
        ),
      ),
    );
  }

  Widget _buildIconKey({
    required IconData icon,
    required VoidCallback? onTap,
    Color? color,
  }) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Container(
        width: 80,
        height: 80,
        alignment: Alignment.center,
        child: Icon(icon, size: 28, color: color ?? Colors.black),
      ),
    );
  }
}
