import 'dart:ui';
import 'package:flutter/material.dart';
import 'otp_page.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final TextEditingController _phoneController = TextEditingController();
  String _selectedCountryCode = '+251';
  bool _isValid = false;
  bool _isLoading = false;

  final List<Map<String, String>> countries = [
    {'flag': '🇪🇹', 'code': '+251'}, // Ethiopia
    {'flag': '🇬🇧', 'code': '+44'},  // UK
    {'flag': '🇺🇸', 'code': '+1'},   // USA
  ];

  void _validatePhone(String value) {
    final isValid = RegExp(r'^[97]\d{8}$').hasMatch(value);
    setState(() {
      _isValid = isValid;
    });
  }

  void _onContinue() {
    setState(() => _isLoading = true);
    Future.delayed(const Duration(seconds: 2), () {
      setState(() => _isLoading = false);
      Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => const OtpPage()),
      );

    });
  }

  @override
  Widget build(BuildContext context) {
    final sw = MediaQuery.of(context).size.width;
    final sh = MediaQuery.of(context).size.height;

    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            // Main content
            Padding(
              padding: EdgeInsets.symmetric(horizontal: sw * 0.06),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: sh * 0.05),

                  Text(
                    "Let's get started!",
                    style: TextStyle(
                      fontSize: sw * 0.1, // 2x size
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),

                  SizedBox(height: sh * 0.015),

                  Text(
                    "Enter your phone number. We will send you a confirmation code there",
                    style: TextStyle(
                      fontSize: sw * 0.05,
                      color: Colors.grey[600],
                    ),
                  ),

                  SizedBox(height: sh * 0.05),

                  // Country + phone field with rounded background
                  Row(
                    children: [
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: sw * 0.02),
                        decoration: BoxDecoration(
                          color: Colors.grey[200],
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: DropdownButton<String>(
                          value: _selectedCountryCode,
                          underline: const SizedBox(),
                          items: countries.map((country) {
                            return DropdownMenuItem<String>(
                              value: country['code'],
                              child: Row(
                                children: [
                                  Text(country['flag']!,
                                      style: TextStyle(fontSize: sw * 0.08)),
                                  SizedBox(width: sw * 0.02),
                                  Text(country['code']!,
                                      style: TextStyle(fontSize: sw * 0.05)),
                                ],
                              ),
                            );
                          }).toList(),
                          onChanged: (value) {
                            setState(() => _selectedCountryCode = value!);
                          },
                        ),
                      ),
                      SizedBox(width: sw * 0.02),
                      Expanded(
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal: sw * 0.03),
                          decoration: BoxDecoration(
                            color: Colors.grey[200],
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: TextField(
                            controller: _phoneController,
                            keyboardType: TextInputType.number,
                            maxLength: 9,
                            onChanged: _validatePhone,
                            style: TextStyle(fontSize: sw * 0.05),
                            decoration: InputDecoration(
                              counterText: '',
                              hintText: 'Mobile number',
                              hintStyle: TextStyle(color: Colors.grey[500]),
                              border: InputBorder.none,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),

                  SizedBox(height: sh * 0.015),

                  GestureDetector(
                    onTap: () {
                      // Navigate to login
                    },
                    child: Text(
                      "Already have an account? Login",
                      style: TextStyle(
                        fontSize: sw * 0.045,
                        color: Colors.blue,
                      ),
                    ),
                  ),

                  const Spacer(),

                  SizedBox(
                    width: double.infinity,
                    height: sh * 0.07,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      onPressed: _isValid ? _onContinue : null,
                      child: Text(
                        "Sign Up",
                        style: TextStyle(fontSize: sw * 0.05),
                      ),
                    ),
                  ),

                  SizedBox(height: sh * 0.03),
                ],
              ),
            ),

            // Blur overlay when loading
            if (_isLoading)
              Positioned.fill(
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 3, sigmaY: 3),
                  child: Container(
                    color: Colors.white.withOpacity(0.4),
                    child: const Center(
                      child: CircularProgressIndicator(color: Colors.blue),
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
