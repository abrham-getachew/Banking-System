import 'dart:async';
import 'package:chronos/Features/signup/presentation/pages/page_3.dart';
import 'package:chronos/Features/signup/presentation/pages/signup_page.dart';
import 'package:flutter/material.dart';
 // import your login page

class OtpPage extends StatefulWidget {
  const OtpPage({super.key});

  @override
  State<OtpPage> createState() => _OtpPageState();
}

class _OtpPageState extends State<OtpPage> {
  final List<TextEditingController> _controllers =
  List.generate(6, (_) => TextEditingController());
  final List<FocusNode> _focusNodes = List.generate(6, (_) => FocusNode());
  int _secondsRemaining = 30;
  Timer? _timer;
  bool _isButtonEnabled = false;

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  void _startTimer() {
    _secondsRemaining = 30;
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_secondsRemaining > 0) {
        setState(() => _secondsRemaining--);
      } else {
        timer.cancel();
      }
    });
  }

  void _onOtpChanged(int index, String value) {
    if (value.isNotEmpty && index < 5) {
      _focusNodes[index + 1].requestFocus();
    }
    if (value.isEmpty && index > 0) {
      _focusNodes[index - 1].requestFocus();
    }
    _checkIfComplete();
  }

  void _checkIfComplete() {
    final allFilled = _controllers.every((c) => c.text.isNotEmpty);
    setState(() => _isButtonEnabled = allFilled);
  }

  @override
  void dispose() {
    _timer?.cancel();
    for (var c in _controllers) {
      c.dispose();
    }
    for (var f in _focusNodes) {
      f.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final sw = MediaQuery.of(context).size.width;
    final sh = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (_) => const SignupPage()),
                  (route) => false,
            );
          },
        ),
        title: const Text("Verify OTP"),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: sw * 0.06),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: sh * 0.05),
              Text(
                "Enter the 6-digit code",
                style: TextStyle(
                  fontSize: sw * 0.08,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: sh * 0.015),
              Text(
                "We’ve sent a confirmation code to your phone number.",
                style: TextStyle(fontSize: sw * 0.045, color: Colors.grey[600]),
              ),
              SizedBox(height: sh * 0.05),

              // OTP boxes
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: List.generate(6, (index) {
                  return Container(
                    width: sw * 0.12,
                    height: sw * 0.15,
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: TextField(
                      controller: _controllers[index],
                      focusNode: _focusNodes[index],
                      keyboardType: TextInputType.number,
                      textAlign: TextAlign.center,
                      maxLength: 1,
                      style: TextStyle(fontSize: sw * 0.06),
                      decoration: const InputDecoration(
                        counterText: '',
                        border: InputBorder.none,
                      ),
                      onChanged: (value) => _onOtpChanged(index, value),
                    ),
                  );
                }),
              ),

              SizedBox(height: sh * 0.03),

              // Resend code + timer
              Row(
                children: [
                  GestureDetector(
                    onTap: _secondsRemaining == 0
                        ? () {
                      _startTimer();
                      // TODO: trigger resend logic here
                    }
                        : null,
                    child: Text(
                      "Resend code",
                      style: TextStyle(
                        fontSize: sw * 0.045,
                        color: _secondsRemaining == 0
                            ? Colors.blue
                            : Colors.grey,
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Text(
                    _secondsRemaining > 0
                        ? "in $_secondsRemaining s"
                        : "",
                    style: TextStyle(
                      fontSize: sw * 0.045,
                      color: Colors.grey[600],
                    ),
                  ),
                ],
              ),

              const Spacer(),

              SizedBox(
                width: double.infinity,
                height: sh * 0.07,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor:
                    _isButtonEnabled ? Colors.blue : Colors.grey,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  onPressed: _isButtonEnabled
                      ? () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => const CareForPage()),
                    );
                  }
                      : null,

                  child: Text(
                    "Continue",
                    style: TextStyle(fontSize: sw * 0.05),
                  ),
                ),
              ),

              SizedBox(height: sh * 0.03),
            ],
          ),
        ),
      ),
    );
  }
}
