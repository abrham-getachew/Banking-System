import 'package:flutter/material.dart';



class ConfirmOrderScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {},
        ),
        title: Text(
          'Confirm Order',
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
              'Order Summary',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
          _buildOrderItem(Icons.currency_bitcoin, 'Buy Bitcoin', '0.0001 BTC'),
          _buildOrderItem(Icons.attach_money, 'Fees', '\$2.65'),
          _buildOrderItem(Icons.attach_money, 'Total', '\$6.500'),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              'Payment Method',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
          ListTile(
            leading: Icon(Icons.credit_card, color: Colors.teal[100]),
            title: Text('Visa'),
            subtitle: Text('Ending in 4242'),
            contentPadding: EdgeInsets.symmetric(horizontal: 16.0),
          ),
          Expanded(child: SizedBox()),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.teal[500],
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                  padding: EdgeInsets.symmetric(vertical: 16),
                ),
                onPressed: () {},
                child: Text(
                  'Confirm with Biometrics',
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
              ),
            ),
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

  Widget _buildOrderItem(IconData icon, String title, String value) {
    return ListTile(
      leading: Icon(icon, color: Colors.teal[100]),
      title: Text(title),
      trailing: Text(value),
      contentPadding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 4.0),
    );
  }
}