import 'package:chronos/Features/signup/presentation/pages/page_4.dart';
import 'package:flutter/material.dart';
import 'otp_page.dart'; // Import your OTP page

class CareForPage extends StatelessWidget {
  const CareForPage({super.key});

  @override
  Widget build(BuildContext context) {
    final sw = MediaQuery.of(context).size.width;
    final sh = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (_) => const OtpPage()),
            );
          },
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: sw * 0.06),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [


              // Title (left aligned)
              Text(
                "Don't miss a beat",
                style: TextStyle(
                  fontSize: sw * 0.08,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),

              SizedBox(height: sh * 0.02),

              // Subtitle
              Text(
                "Get notified about spending, security, wealth, market movements, discounts and deals, so you're always in the know.",
                style: TextStyle(
                  fontSize: sw * 0.045,
                  color: Colors.grey[700],
                  height: 1.4,
                ),
              ),

              SizedBox(height: sh * 0.06),

              // Illustration placeholder
              Expanded(
                child: Center(
                  child: Image.asset(
                    'assets/images/notification_illustration.png',
                    width: sw * 0.7,
                    fit: BoxFit.contain,
                  ),
                ),
              ),

              SizedBox(height: sh * 0.06),

              // Primary button
              SizedBox(
                width: double.infinity,
                height: sh * 0.07,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  onPressed: () {
                    {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => const CountrySelectionPage()),
                      );
                    }
                  },
                  child: Text(
                    "Enable push notifications",
                    style: TextStyle(fontSize: sw * 0.05),
                  ),
                ),
              ),

              SizedBox(height: sh * 0.02),

              // Secondary button
              SizedBox(
                width: double.infinity,
                height: sh * 0.07,
                child: OutlinedButton(
                  style: OutlinedButton.styleFrom(
                    backgroundColor: const Color(0xFFEFFAF9), // very light blue-green
                    foregroundColor: Colors.black,
                    side: const BorderSide(
                      color: Color(0xFFB2DFDB), // soft teal border
                      width: 1.2,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),

                  onPressed: () {
                    // TODO: Handle "Not now"
                  },
                  child: Text(
                    "Not now",
                    style: TextStyle(fontSize: sw * 0.05),
                  ),
                ),
              ),

              SizedBox(height: sh * 0.04),
            ],
          ),
        ),
      ),
    );
  }
}
