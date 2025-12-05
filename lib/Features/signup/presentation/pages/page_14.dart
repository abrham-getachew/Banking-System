import 'package:chronos/Features/signup/presentation/pages/page_15.dart';
import 'package:flutter/material.dart';


class AreYouCitizenPage extends StatelessWidget {
  const AreYouCitizenPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Define text styles to match the design
    final questionStyle = TextStyle(
      fontSize: 24,
      fontWeight: FontWeight.w600,
      color: Colors.black87,
    );
    final subtitleStyle = TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w400,
      color: Colors.grey[600],
    );

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            children: [
              const SizedBox(height: 80),

              // Question
              Text(
                'Are you a citizen of the United Kingdom?',
                style: questionStyle,
                textAlign: TextAlign.center,
              ),

              const SizedBox(height: 16),

              // Subtitle / explanatory text
              Text(
                'We need this information to comply with local regulations.',
                style: subtitleStyle,
                textAlign: TextAlign.center,
              ),

              const SizedBox(height: 150),

              // Circular flag icon
              Container(
                width: 180,
                height: 180,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                    image: AssetImage('assets/images/uk.png'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),

              // Push buttons to bottom
              const Spacer(),

              // Action buttons row
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () {
                        // TODO: handle "No"
                      },
                      style: OutlinedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        side: BorderSide(color: Colors.grey[400]!),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25),
                        ),
                      ),
                      child: const Text(
                        'No',
                        style: TextStyle(fontSize: 16, color: Colors.black87),
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (_) => DocumentSelectPage()),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        backgroundColor: Colors.blue[600],
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25),
                        ),
                      ),
                      child: const Text(
                        'Yes',
                        style: TextStyle(fontSize: 16, color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }
}
