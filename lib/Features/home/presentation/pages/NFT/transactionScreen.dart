import 'package:flutter/material.dart';



class TransactionScreen extends StatelessWidget {
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
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'All Transactions',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                Row(
                  children: [
                    _buildFilterChip('Buy'),
                    _buildFilterChip('Sell'),
                    _buildFilterChip('Deposit'),
                    _buildFilterChip('Withdraw'),
                  ],
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView(
              children: [
                _buildTransactionItem(Icons.diamond, 'Buy', '0.001 ETH', '2024-01-15'),
                _buildTransactionItem(Icons.currency_bitcoin, 'Sell', '0.002 BTC', '2024-01-14'),
                _buildTransactionItem(Icons.diamond, 'Deposit', '0.003 ETH', '2024-01-13'),
                _buildTransactionItem(Icons.currency_bitcoin, 'Withdraw', '0.004 BTC', '2024-01-12'),
                _buildTransactionItem(Icons.image, 'Mint', 'NFT #1234', '2024-01-11'),
              ],
            ),
          ),
          BottomNavigationBar(
            items: [
              BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
              BottomNavigationBarItem(icon: Icon(Icons.star), label: 'AI'),
              BottomNavigationBarItem(icon: Icon(Icons.home), label: 'BlockHub'),
              BottomNavigationBarItem(icon: Icon(Icons.favorite), label: 'LifeX'),
              BottomNavigationBarItem(icon: Icon(Icons.more_horiz), label: 'More'),
            ],
            currentIndex: 2,
            selectedItemColor: Colors.teal,
            unselectedItemColor: Colors.grey,
            onTap: (index) {},
            type: BottomNavigationBarType.fixed,
          ),
        ],
      ),
    );
  }

  Widget _buildFilterChip(String label) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4.0),
      child: Chip(
        label: Text(label),
        backgroundColor: Colors.teal[50],
        labelStyle: TextStyle(color: Colors.teal),
      ),
    );
  }

  Widget _buildTransactionItem(IconData icon, String type, String amount, String date) {
    return ListTile(
      leading: Icon(icon, color: Colors.teal),
      title: Text(type),
      subtitle: Text(amount),
      trailing: Text(date),
    );
  }
}