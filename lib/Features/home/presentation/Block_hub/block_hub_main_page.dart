import 'package:flutter/material.dart';

class BlockHubMainPage extends StatefulWidget {
  const BlockHubMainPage({super.key});

  @override
  State<BlockHubMainPage> createState() => _BlockHubMainPageState();
}

class _BlockHubMainPageState extends State<BlockHubMainPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('BlockHub'),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Welcome back, Nahom 👋',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),
              const Text(
                '€24,562.13',
                style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),
              _buildBalanceCard(
                title: 'Total Balance',
                balance: '€24,562.13',
                color: Colors.green.withOpacity(0.2),
              ),
              const SizedBox(height: 10),
              _buildBalanceCard(
                title: 'Crypto Wallet',
                balance: 'BTC, ETH, XRP',
                color: Colors.green.withOpacity(0.2),
              ),
              const SizedBox(height: 10),
              _buildBalanceCard(
                title: 'NFT Assets',
                balance: '3 collectibles',
                color: Colors.brown.withOpacity(0.2),
              ),
              const SizedBox(height: 10),
              _buildBalanceCard(
                title: 'AI Portfolio (Kevin.AI)',
                balance: 'Optimized by AI',
                color: Colors.cyan.withOpacity(0.2),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: const Icon(Icons.add),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(
              icon: Icon(Icons.monetization_on), label: 'Trade'),
          BottomNavigationBarItem(icon: Icon(Icons.all_inbox), label: 'AI'),
          BottomNavigationBarItem(icon: Icon(Icons.image), label: 'NFTs'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
      ),
    );
  }

  Widget _buildBalanceCard(
      {required String title,
      required String balance,
      required Color color}) {
    return Card(
      color: color,
      child: ListTile(
        title: Text(title),
        subtitle: Text(balance),
        trailing: Container(
          width: 60,
          height: 60,
          decoration: BoxDecoration(
            color: Colors.black.withOpacity(0.1),
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ),
    );
  }
}
