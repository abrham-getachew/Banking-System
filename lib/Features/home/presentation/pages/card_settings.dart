import 'package:flutter/material.dart';


class CardSettingsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {},
        ),
        title: Text('Card Settings'),
      ),
      body: ListView(
        padding: EdgeInsets.all(16.0),
        children: [
          Text(
            'Payments',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 16),
          SwitchListTile(
            title: Text('Online Payments'),
            subtitle: Text('Allow online transactions'),
            value: false,
            onChanged: (bool value) {},
          ),
          SwitchListTile(
            title: Text('International'),
            subtitle: Text('Enable international transactions'),
            value: false,
            onChanged: (bool value) {},
          ),
          SwitchListTile(
            title: Text('Contactless'),
            subtitle: Text('Enable contactless payments'),
            value: false,
            onChanged: (bool value) {},
          ),
          SizedBox(height: 16),
          Text(
            'Spending Limit',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 16),
          ListTile(
            title: Text('Daily Limit'),
            trailing: Text('\$1000'),
            subtitle: Slider(
              value: 1000,
              min: 0,
              max: 5000,
              divisions: 50,
              label: '1000',
              onChanged: (double value) {},

              activeColor: Colors.teal,
              inactiveColor: Colors.teal[100],
            ),
          ),
          ListTile(
            title: Text('Monthly Limit'),
            trailing: Text('\$5000'),
            subtitle: Slider(
              value: 5000,
              min: 0,
              max: 10000,
              divisions: 100,
              label: '5000',
              onChanged: (double value) {},
              activeColor: Colors.teal,
              inactiveColor: Colors.teal[100],
            ),
          ),
          SizedBox(height: 16),
          Text(
            'Security',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 16),
          SwitchListTile(
            title: Text('Enable Biometric'),
            subtitle: Text('Use fingerprint or face ID'),
            value: false,
            onChanged: (bool value) {},
          ),
          SwitchListTile(
            title: Text('Enable 2FA'),
            subtitle: Text('Two-factor authentication'),
            value: false,
            onChanged: (bool value) {},
          ),
          SwitchListTile(
            title: Text('Enable Location Lock'),
            subtitle: Text('Lock card to current location'),
            value: false,
            onChanged: (bool value) {},
          ),
          SizedBox(height: 16),
          Text(
            'Emergency',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 16),
          ListTile(
            title: Text('Replace Card'),
            trailing: Icon(Icons.arrow_forward_ios),
            onTap: () {},
          ),
          ListTile(
            title: Text('Delete Card'),
            trailing: Icon(Icons.arrow_forward_ios),
            onTap: () {},
          ),
          ListTile(
            title: Text('Report Lost'),
            trailing: Icon(Icons.arrow_forward_ios),
            onTap: () {},
          ),
          SizedBox(height: 16),

        ],
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
}