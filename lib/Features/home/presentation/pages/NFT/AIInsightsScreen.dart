import 'package:flutter/material.dart';



class AIInsightsScreen extends StatefulWidget {
  @override
  _AIInsightsScreenState createState() => _AIInsightsScreenState();
}

class _AIInsightsScreenState extends State<AIInsightsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {},
        ),
        title: Text(
          'BlockHub',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.settings, color: Colors.black),
            onPressed: () {},
          ),
        ],
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              'AI Insights',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
          _buildInsightItem(
            'Trending Token',
            'Ethereum\nETH',
            'https://via.placeholder.com/100?text=Ethereum', // Placeholder image URL
          ),
          _buildInsightItem(
            'Trending NFT',
            'CryptoPunks\nPunk #7804',
            'https://via.placeholder.com/100?text=CryptoPunks', // Placeholder image URL
          ),
          _buildInsightItem(
            'AI Rating',
            'Bitcoin\nBTC',
            'https://via.placeholder.com/100?text=Bitcoin', // Placeholder image URL
          ),
          _buildInsightItem(
            'AI Prediction',
            'Solana\nSOL',
            'https://via.placeholder.com/100?text=Solana', // Placeholder image URL
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.star), label: 'AI'),
          BottomNavigationBarItem(icon: Icon(Icons.home_max), label: 'BlockHub'),
          BottomNavigationBarItem(icon: Icon(Icons.favorite), label: 'LifeX'),
          BottomNavigationBarItem(icon: Icon(Icons.more_horiz), label: 'More'),
        ],
        currentIndex: 2,
        selectedItemColor: Colors.teal,
        unselectedItemColor: Colors.grey,
        onTap: (index) {},
        type: BottomNavigationBarType.fixed,
      ),
    );
  }

  Widget _buildInsightItem(String category, String title, String imageUrl) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  category,
                  style: TextStyle(color: Colors.teal, fontSize: 12),
                ),
                Text(
                  title,
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          Container(
            width: 100,
            height: 100,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              image: DecorationImage(
                image: NetworkImage(imageUrl),
                fit: BoxFit.cover,
              ),
            ),
          ),
        ],
      ),
    );
  }
}