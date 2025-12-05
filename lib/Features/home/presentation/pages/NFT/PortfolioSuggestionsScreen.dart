import 'package:flutter/material.dart';



class PortfolioSuggestionsScreen extends StatefulWidget {
  @override
  _PortfolioSuggestionsScreenState createState() => _PortfolioSuggestionsScreenState();
}

class _PortfolioSuggestionsScreenState extends State<PortfolioSuggestionsScreen> {
  int _selectedIndex = 1; // Default to AI tab

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

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
          'BlockHub',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'AI Portfolio Suggestions',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            SizedBox(height: 20),
            _buildSuggestionCard(
              title: 'Rebalance',
              subtitle: 'Rebalance 10% from BTC > ETH',
              description:
              'This adjustment aims to optimize your portfolio\'s risk-adjusted returns by shifting assets towards a more balanced allocation.',
              color: Colors.teal[100]!,
            ),
            SizedBox(height: 16),
            _buildSuggestionCard(
              title: 'Diversify',
              subtitle: 'Add 5% SOL to your portfolio',
              description:
              'Diversifying with Solana can enhance your portfolio\'s growth potential by including a high-performance blockchain asset.',
              color: Colors.brown[200]!,
            ),
            SizedBox(height: 16),
            _buildSuggestionCard(
              title: 'Optimize',
              subtitle: 'Shift 3% from LTC to ADA',
              description:
              'This move aims to improve your portfolio\'s sustainability profile by favoring Cardano, known for its energy efficiency.',
              color: Colors.teal[200]!,
            ),
          ],
        ),
      ),
      backgroundColor: Colors.grey[100],
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home, color: Colors.teal),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.auto_awesome, color: Colors.teal),
            label: 'AI',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.view_in_ar, color: Colors.teal),
            label: 'BlockHub',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite, color: Colors.teal),
            label: 'LifeX',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.more_horiz, color: Colors.teal),
            label: 'More',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.teal,
        onTap: _onItemTapped,
        type: BottomNavigationBarType.fixed,
      ),
    );
  }

  Widget _buildSuggestionCard({
    required String title,
    required String subtitle,
    required String description,
    required Color color,
  }) {
    return Card(
      color: color,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
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
                  ),
                  Text(
                    subtitle,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    description,
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.black54,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              width: 100,
              height: 100,
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [color, Colors.white],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
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