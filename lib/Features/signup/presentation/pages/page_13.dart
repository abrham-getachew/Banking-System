import 'package:chronos/Features/signup/presentation/pages/page_14.dart';
import 'package:flutter/material.dart';

class ConfirmPasscodePage extends StatefulWidget {
  /// The passcode the user entered in the CreatePasscodePage.
  /// Must be 6–12 digits long.
  final String originalPasscode;

  const ConfirmPasscodePage({
    Key? key,
    required this.originalPasscode,
  })  : assert(originalPasscode.length >= 6 &&
      originalPasscode.length <= 12,
  'Original passcode must be 6–12 digits'),
        super(key: key);

  @override
  _ConfirmPasscodePageState createState() => _ConfirmPasscodePageState();
}

class _ConfirmPasscodePageState extends State<ConfirmPasscodePage> {
  String _confirmInput = '';
  String? _errorText;

  // Maximum number of digits to enter equals the original passcode length
  int get _maxLength => 12;

  void _addDigit(String d) {
    if (_confirmInput.length < _maxLength) {
      setState(() {
        _confirmInput += d;
        _errorText = null;
      });
    }
  }

  void _removeDigit() {
    if (_confirmInput.isNotEmpty) {
      setState(() {
        _confirmInput = _confirmInput.substring(0, _confirmInput.length - 1);
        _errorText = null;
      });
    }
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

  void _validate() {
    if (_confirmInput == widget.originalPasscode) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => AreYouCitizenPage()),
      );
    } else {
      setState(() {
        _errorText = 'Passcodes do not match. Try again.';
        _confirmInput = '';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final bool readyToSubmit = _confirmInput.length >= 6;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _buildStepDot(active: true),
                  const SizedBox(width: 8),
                  _buildStepDot(active: true),
                ],
              ),
              const SizedBox(height: 32),
              // Title & Instruction

              Text(
                'Confirm passcode',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),

              const SizedBox(height: 8),

              Text(
                'Re-enter your passcode.',
                style: TextStyle(fontSize: 16, color: Colors.grey[700]),
              ),

              const SizedBox(height: 100),

              // Dynamic Dots: one per entered digit
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                  _confirmInput.length,
                      (_) => Padding(
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

              if (_errorText != null) ...[
                const SizedBox(height: 12),
                Text(
                  _errorText!,
                  style: TextStyle(color: Colors.red, fontSize: 14),
                ),
              ],

              Spacer(),

              // Numeric Keypad
              _NumberPad(
                onDigit: _addDigit,
                onBackspace: _removeDigit,
                onSubmit: readyToSubmit ? _validate : null,
                submitEnabled: readyToSubmit,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _NumberPad extends StatelessWidget {
  final ValueChanged<String> onDigit;
  final VoidCallback onBackspace;
  final VoidCallback? onSubmit;
  final bool submitEnabled;

  const _NumberPad({
    required this.onDigit,
    required this.onBackspace,
    required this.onSubmit,
    required this.submitEnabled,
  });

  @override
  Widget build(BuildContext context) {
    Widget _buildKey({Widget
    ,child, VoidCallback? action}) {

      return GestureDetector(
        onTap: action,
        behavior: HitTestBehavior.opaque,
        child: Container(
          width: 80,
          height: 80,
          alignment: Alignment.center,
          child: child,
        ),
      );
    }

    Widget _digitKey(String digit) =>
        _buildKey(child: Text(digit, style: TextStyle(fontSize: 28)), action: () => onDigit(digit));

    Widget _iconKey(IconData icon, {VoidCallback? action, Color? color}) =>
        _buildKey(child: Icon(icon, size: 28, color: color ?? Colors.black), action: action);

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
            children: row.map(_digitKey).toList(),
          ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _iconKey(Icons.backspace, action: onBackspace),
            _digitKey('0'),
            _iconKey(
              Icons.arrow_forward,
              action: onSubmit,
              color: submitEnabled ? Colors.blue : Colors.grey[300],
            ),
          ],
        )
      ],
    );
  }
}
