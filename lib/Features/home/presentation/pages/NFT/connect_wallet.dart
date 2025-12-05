import 'package:flutter/material.dart';



class connectWalletScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {},
        ),
        title: Text(
          'Connect Wallets',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              'Connect a Wallet',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
          _buildWalletOption(
            'MetaMask',
            'Connect your MetaMask wallet',
            Icon(Icons.shield, color: Colors.white),
            Colors.teal[600]!,
          ),
          _buildWalletOption(
            'Ledger',
            'Connect your Ledger hardware wallet',
            Text('Lgr', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
            Colors.teal[700]!,
          ),
          _buildWalletOption(
            'WalletConnect',
            'Connect with WalletConnect',
            Image.network(
              'https://walletconnect.com/apple-touch-icon.png', // Placeholder, replace with actual logo URL
              width: 24,
              height: 24,
              color: null,
            ),
            Colors.teal[800]!,
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              'Linked Wallets',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
          _buildLinkedWallet('Wallet 1', '0x123...456', Icons.edit),
          _buildLinkedWallet('Wallet 2', '0x789...012', Icons.edit),
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

  Widget _buildWalletOption(String title, String subtitle, Widget icon, Color color) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: color,
          minimumSize: Size(double.infinity, 60),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        ),
        onPressed: () {},
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                Text(subtitle, style: TextStyle(color: Colors.white70)),
              ],
            ),
            icon,
          ],
        ),
      ),
    );
  }

  Widget _buildLinkedWallet(String name, String address, IconData editIcon) {
    return ListTile(
      leading: Icon(Icons.account_balance_wallet, color: Colors.teal[100]),
      title: Text(name),
      subtitle: Text(address),
      trailing: Icon(editIcon, color: Colors.grey),
    );
  }
}