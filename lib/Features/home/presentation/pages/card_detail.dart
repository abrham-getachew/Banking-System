import 'package:flutter/material.dart';

import 'card_settings.dart';

class CardDetailsScreen extends StatefulWidget {
  @override
  _CardDetailsScreenState createState() => _CardDetailsScreenState();
}

class _CardDetailsScreenState extends State<CardDetailsScreen> {
  bool _isFreezeCardActive = false; // Initial state for Freeze Card toggle

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: Center(
          child: Text(
            'Card Details',
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 22),
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.settings),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => CardSettingsScreen(),
                ),
              );},
          ),
        ],
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Hero Card Image Section
              Container(
                height: 200,
                width: double.infinity,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/images/image 7.png'), // Replace with actual asset
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              SizedBox(height: 24),
              // Card Name and Number
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Crypto Card',
                        style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.black87),
                      ),
                      Text(
                        '...4321',
                        style: TextStyle(fontSize: 18, color: Colors.grey[600]),
                      ),
                    ],
                  ),
                  IconButton(
                    icon: Icon(Icons.more_vert, color: Colors.grey[600], size: 24),
                    onPressed: () {
                      _showMoreOptions(context);
                    },
                  ),
                ],
              ),
              SizedBox(height: 32),
              // Balance Section
              Text(
                'Balance',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.black),
              ),
              SizedBox(height: 8),
              Text(
                '0.00000000 BTC',
                style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: Colors.black45),
              ),
              Text(
                '\$0.00 USD',
                style: TextStyle(fontSize: 16, color: Colors.grey[600]),
              ),
              SizedBox(height: 32),
              // Recent Transactions Section
              Text(
                'Recent Transactions',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black87),
              ),
              SizedBox(height: 16),
              _buildTransactionItem('Transfer from Bank', '+0.00000000 BTC', '2024-01-20'),
              _buildTransactionItem('Purchase', '-0.00000000 BTC', '2024-01-15'),
              _buildTransactionItem('Transfer to Bank', '-0.00000000 BTC', '2024-01-10'),
              _buildTransactionItem('Purchase', '-0.00000000 BTC', '2024-01-05'),
              _buildTransactionItem('Transfer from Bank', '+0.00000000 BTC', '2024-01-01'),
              SizedBox(height: 32),
              // Controls Section
              Text(
                'Controls',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black87),
              ),
              SizedBox(height: 16),
              _buildControlItem(
                'Freeze Card',
                _isFreezeCardActive,
                Icons.toggle_off_outlined,
                    () {
                  setState(() {
                    _isFreezeCardActive = !_isFreezeCardActive;
                  });
                },
                isSwitch: true,
              ),
              _buildControlItem('Change PIN', true, Icons.arrow_forward_ios, () {
                _navigateToScreen(context, 'Change PIN');
              }),
              _buildControlItem('Spending Limit', true, Icons.arrow_forward_ios, () {
                _navigateToScreen(context, 'Spending Limit');
              }),
              _buildControlItem('Add to Digital Wallet', true, Icons.arrow_forward_ios, () {
                _navigateToScreen(context, 'Add to Digital Wallet');
              }),
              SizedBox(height: 24),
              // Action Buttons
              ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.teal,
                  foregroundColor: Colors.white,
                  minimumSize: Size(double.infinity, 50),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                ),
                child: Text('Top Up Card', style: TextStyle(fontSize: 16)),
              ),
              SizedBox(height: 16),
              OutlinedButton(
                onPressed: () {},
                style: OutlinedButton.styleFrom(
                  foregroundColor: Colors.grey[600],
                  side: BorderSide(color: Colors.grey[400]!),
                  minimumSize: Size(double.infinity, 50),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                ),
                child: Text('Withdraw to Bank', style: TextStyle(fontSize: 16)),
              ),
              SizedBox(height: 16),
              OutlinedButton(
                onPressed: () {},
                style: OutlinedButton.styleFrom(
                  foregroundColor: Colors.red,
                  side: BorderSide(color: Colors.red),
                  minimumSize: Size(double.infinity, 50),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                ),
                child: Text('Close Card', style: TextStyle(fontSize: 16)),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.star), label: 'AI'),
          BottomNavigationBarItem(icon: Icon(Icons.view_module), label: 'BlockHub'),
          BottomNavigationBarItem(icon: Icon(Icons.favorite), label: 'LifeX'),
          BottomNavigationBarItem(icon: Icon(Icons.more_horiz), label: 'More'),
        ],
        selectedItemColor: Colors.teal,
        unselectedItemColor: Colors.grey,
        showSelectedLabels: true,
        showUnselectedLabels: true,
        type: BottomNavigationBarType.fixed,
      ),
    );
  }

  Widget _buildTransactionItem(String description, String amount, String date) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(description, style: TextStyle(fontSize: 16, color: Colors.black87)),
                Text(date, style: TextStyle(fontSize: 14, color: Colors.grey[600])),
              ],
            ),
          ),
          Text(
            amount,
            style: TextStyle(
              fontSize: 16,
              color: amount.startsWith('+') ? Colors.green[600] : Colors.red[600],
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildControlItem(String title, bool isActive, IconData icon, VoidCallback onTap, {bool isSwitch = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: GestureDetector(
        onTap: onTap,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(title, style: TextStyle(fontSize: 16, color: Colors.black87)),
            if (isSwitch)
              Switch(
                value: isActive,
                onChanged: (value) {
                  onTap(); // Call the provided onTap to update state
                },
                activeColor: Colors.teal,
                activeTrackColor: Colors.teal[200],
                inactiveThumbColor: Colors.grey[400],
                inactiveTrackColor: Colors.grey[300],
              )
            else
              Icon(icon, color: Colors.grey[600], size: isActive ? 16 : 24), // Adjust size based on active state if needed
          ],
        ),
      ),
    );
  }

  void _navigateToScreen(BuildContext context, String screenName) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Navigating to $screenName')),
    );
  }

  void _showMoreOptions(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) => Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ListTile(
            leading: Icon(Icons.edit),
            title: Text('Edit Card'),
            onTap: () {
              Navigator.pop(context);
              _navigateToScreen(context, 'Edit Card');
            },
          ),
          ListTile(
            leading: Icon(Icons.delete),
            title: Text('Delete Card'),
            onTap: () {
              Navigator.pop(context);
              _navigateToScreen(context, 'Delete Card');
            },
          ),
        ],
      ),
    );
  }
}