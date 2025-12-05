import 'package:chronos/Features/complete_signup/presentation/pages/page_5.dart';
import 'package:flutter/material.dart';

class GetCardScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Back arrow
              Icon(Icons.arrow_back, color: Colors.black, size: 24),
              SizedBox(height: 24),

              // Title
              Text(
                'Get a card',
                style: TextStyle(
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              SizedBox(height: 32),

              // Physical debit card option
              CardOption(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) =>   CreatePinPage()),
                  );   // handle tap
                  print('Physical card tapped');
                },
                icon: Icons.credit_card_rounded,
                title: 'Physical debit card',
                description:
                'Choose your card design or personalise it, and get it delivered',

                frontCardImage: 'assets/images/notification_illustration.png',
                backgroundColor: Color(0xFFF5F5F5),
              ),
              SizedBox(height: 16),

              // Virtual debit card option
              CardOption(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) =>  CreatePinPage()),
                  );   // handle tap
                  print('Virtual card tapped');
                },
                icon: Icons.credit_card_rounded,
                title: 'Virtual debit card',
                description:
                'Get free virtual cards instantly, and try disposable for extra security online',

                frontCardImage: 'assets/images/notification_illustration.png',
                backgroundColor: Color(0xFFF5F5F5),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CardOption extends StatelessWidget {
  final VoidCallback onTap;
  final IconData icon;
  final String title;
  final String description;

  final String frontCardImage;
  final Color backgroundColor;

  const CardOption({
    Key? key,
    required this.onTap,
    required this.icon,
    required this.title,
    required this.description,
    required this.frontCardImage,
    required this.backgroundColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Container(
        height: 200,
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(16),
        ),
        padding: EdgeInsets.all(16),
        // Stack lets us position the images behind the text
        child: Center(
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              // 1) Card images in the bottom-right of the card
              Positioned(
                right: 10,
                top: 60,
                bottom: 0,
                child: SizedBox(
                  width: 70,
                  height: 25,
                  child: Stack(
                    clipBehavior: Clip.none,
                    children: [
                      // back card

                      // front card overlaps
                      Positioned(
                        left: 20,
                        child: Image.asset(
                          frontCardImage,
                          width: 70,
                          fit: BoxFit.fitWidth,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              // 2) Icon + text sit on top of the images
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // icon circle
                  Container(

                    padding: EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Color(0xFFE1F5FE),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(icon, color: Color(0xFF0288D1), size: 40),
                  ),
                  SizedBox(height: 36),

                  // title + description can flow over the right‐side images
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          title,
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                          // allow overlap—no ellipsis here
                          softWrap: true,
                        ),
                        SizedBox(height: 4),
                        Text(
                          description,
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey[600],
                          ),
                          softWrap: true,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
