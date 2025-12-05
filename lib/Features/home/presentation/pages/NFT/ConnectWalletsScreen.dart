import 'package:flutter/material.dart';


class ConnectWalletsScreen extends StatefulWidget {
  @override
  _ConnectWalletsScreenState createState() => _ConnectWalletsScreenState();
}

class _ConnectWalletsScreenState extends State<ConnectWalletsScreen> {
  List<Map<String, String>> linkedWallets = [
    {'name': 'Wallet 1', 'address': '0x123...456'},
    {'name': 'Wallet 2', 'address': '0x789...012'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {},
        ),
        title: Text('Connect Wallets'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Connect a Wallet',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            WalletButton(
              title: 'MetaMask',
              subtitle: 'Connect your MetaMask wallet',
              icon: Icons.shield,
              onPressed: () {},
            ),
            SizedBox(height: 10),
            WalletButton(
              title: 'Ledger',
              subtitle: 'Connect your Ledger hardware wallet',
              icon: Icons.security,
              onPressed: () {},
            ),
            SizedBox(height: 10),
            WalletButton(
              title: 'WalletConnect',
              subtitle: 'Connect with WalletConnect',
              icon: Icons.link,
              onPressed: () {},
            ),
            SizedBox(height: 20),
            Text(
              'Linked Wallets',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Expanded(
              child: ListView.builder(
                itemCount: linkedWallets.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    leading: Icon(Icons.account_balance_wallet, color: Colors.teal),
                    title: Text(linkedWallets[index]['name']!),
                    subtitle: Text(linkedWallets[index]['address']!),
                    trailing: Icon(Icons.edit, color: Colors.teal),
                    onTap: () {},
                  );
                },
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.auto_awesome), label: 'AI'),
          BottomNavigationBarItem(icon: Icon(Icons.block), label: 'BlockHub'),
          BottomNavigationBarItem(icon: Icon(Icons.favorite), label: 'LifeX'),
          BottomNavigationBarItem(icon: Icon(Icons.more_horiz), label: 'More'),
        ],
        type: BottomNavigationBarType.fixed,
      ),
    );
  }
}

class WalletButton extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData icon;
  final VoidCallback onPressed;

  WalletButton({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        foregroundColor: Colors.white, backgroundColor: Colors.teal[400],
        minimumSize: Size(double.infinity, 60),
       // shape: RoundedRectangleCorner(12.0),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 24),
          SizedBox(width: 10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              Text(subtitle, style: TextStyle(fontSize: 12, color: Colors.white70)),
            ],
          ),
        ],
      ),
    );
  }
}