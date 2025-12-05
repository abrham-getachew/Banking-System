import 'package:flutter/material.dart';

import '../../nav_page.dart';

class InvestmentAdviceScreen extends StatefulWidget {
  @override
  _InvestmentAdviceScreenState createState() => _InvestmentAdviceScreenState();
}

class _InvestmentAdviceScreenState extends State<InvestmentAdviceScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.teal),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          'Personalized Investment Advice',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 18),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Container(
        color: Colors.grey[100],
        // Use a single ListView to make the entire page scrollable
        child: ListView(
          // Set padding to zero to allow the top image to be full-width
          padding: EdgeInsets.zero,
          children: [
            // 1. Full-width top image container (now part of the scroll)
            Container(
              height: 200,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/financial image3.png'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            // 2. Wrap the rest of the content in a Padding widget
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: 150, // Reduced height for better balance
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [Colors.teal[800]!, Colors.teal[200]!],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Center(
                      child: Text(
                        'AI Budgeting Insights Here',
                        style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  SizedBox(height: 24),
                  Text(
                    'Recommended Assets',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.teal),
                  ),
                  SizedBox(height: 16),
                  // 3. Horizontally scrolling asset cards
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        _buildAssetCard('Stocks', 'assets/images/financial image3.png'),
                        SizedBox(width: 16), // Padding between cards
                        _buildAssetCard('ETFs', 'assets/images/financial image4.png'),
                        SizedBox(width: 16), // Padding between cards
                        _buildAssetCard('Crypto', 'assets/images/financial image1.png'),
                        SizedBox(width: 16), // Padding between cards
                        _buildAssetCard('Bonds', 'assets/images/financial image2.png'), // Example of another card
                      ],
                    ),
                  ),
                  SizedBox(height: 24), // Increased spacing
                  Row(
                    children: [
                      Text('Risk Level', style: TextStyle(fontSize: 16, color: Colors.teal)),
                      Expanded(
                        child: Slider(
                          value: 0.5, // Medium risk level
                          min: 0.0,
                          max: 1.0,
                          divisions: 4,
                          label: 'Medium',
                          activeColor: Colors.teal,
                          inactiveColor: Colors.teal[100],
                          onChanged: (value) {
                            // Handle risk level change if needed
                          },
                        ),
                      ),
                      Text('Medium', style: TextStyle(color: Colors.teal)),
                    ],
                  ),
                  SizedBox(height: 16),
                  Center(
                    child: ElevatedButton(
                      onPressed: () {
                        // Handle invest now action
                      },
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.white,
                        backgroundColor: Colors.teal,
                        padding: EdgeInsets.symmetric(horizontal: 48, vertical: 16),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                      ),
                      child: Text('Invest Now'),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: MainScreen(selectedIndex: 3),
    );
  }

  // Updated asset card to be larger and enable scrolling
  Widget _buildAssetCard(String title, String imageUrl) {
    return Column(
      children: [
        Container(
          width: 180, // Increased size to force horizontal scroll
          height: 180,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            image: DecorationImage(
              image: AssetImage(imageUrl),
              fit: BoxFit.cover,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 8,
                offset: Offset(0, 4),
              ),
            ],
          ),
        ),
        SizedBox(height: 8),
        Text(
          title,
          style: TextStyle(color: Colors.teal, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}